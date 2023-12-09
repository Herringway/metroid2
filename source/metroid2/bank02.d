module metroid2.bank02;

import metroid2.bank00;
import metroid2.bank01;
import metroid2.bank03;
import metroid2.bank08;
import metroid2.defs;
import metroid2.globals;
import metroid2.external;

import librehome.gameboy;

import std.logger;

void enemyHandler() {
	unusedROMBankPlusOne = cast(ubyte)(currentLevelBank + 1);
	const started = justStartedTransition;
	if (justStartedTransition) {
		larvaBombState = 0;
		larvaLatchState = 0;
		justStartedTransition = 0;
		enSprCollision.weaponType = CollisionType.nothing;
		enSprCollision.enemy = null;
		enSprCollision.weaponDir = 0xFF;
		collision.weaponType = CollisionType.nothing;
		collision.enemy = null;
		collision.weaponDir = 0xFF;
	}
	static void handleEnemies() {
		enemySolidityIndex = enemySolidityIndexCanon;
		if (saveLoadSpawnFlagsRequest) {
			ingameSaveAndLoadEnemySaveFlags();
			saveLoadSpawnFlagsRequest = 0;
		}
		if (gb.LY >= 0x70) {
			return;
		}
		if (!loadSpawnFlagsRequest) {
			ingameLoadEnemySaveFlags();
			loadSpawnFlagsRequest = 1;
		}
		scrollEnemies();
		processEnemies();
		updateScrollHistory();
		if (gb.LY < 0x70) {
			drawEnemies();
		}
	}
	static void restoreMusic() {
		if (metroidCountReal) {
			songRequest = cast(Song)(currentRoomSong + Song.noIntroStart);
		}
		metroidPostDeathTimer = 0;
		metroidState = 0;
		metroidFightActive = 0;
		handleEnemies();
	}
	static void metroidJustDied() {
		if (metroidPostDeathTimer != 0x90) {
			if (!(frameCounter & 1)) {
				metroidPostDeathTimer++;
			}
			return handleEnemies();
		} else {
			return restoreMusic();
		}
	}
	switch (metroidFightActive) {
		case 0:
			return handleEnemies();
		case 2:
			return metroidJustDied();
		default:
			if (started) {
				return handleEnemies();
			}
			return restoreMusic();
	}
}

void processEnemies() {
	if (enemySameEnemyFrameFlag == 0) {
		enemyFrameCounter++;
		enemiesLeftToProcess = numEnemies.total;
	}
	static void allEnemiesDone() {
		enemyFirstEnemy = enemyDataSlots[];
		enemySameEnemyFrameFlag = !enemySameEnemyFrameFlag;
	}
	if (enemiesLeftToProcess) {
		for (int i = 0; i < enemyDataSlots.length; i++) {
			if ((enemyDataSlots[i].status & 0xF) == 0) {
				if (!enemyMoveFromWRAMtoHRAM(&enemyDataSlots[i]) && !enemyGetDamagedOrGiveDrop() && !deactivateOffscreenEnemy()) {
					enemyCommonAI();
				}
			} else if ((enemyDataSlots[i].status & 0xF) == 1) {
				if (!enemyMoveFromWRAMtoHRAM(&enemyDataSlots[i]) && !deleteOffscreenEnemy() && !reactivateOffscreenEnemy()) {}
			} else {
				continue;
			}
			enemyMoveFromHRAMtoWRAM();
			if (--enemiesLeftToProcess == 0) {
				allEnemiesDone();
				break;
			}
			//we don't need to restore the enemy address.
			if (gb.LY >= 88) {
				enemyFirstEnemy = enemyDataSlots[i .. $];
				enemySameEnemyFrameFlag++;
				break;
			}
		}
	} else {
		allEnemiesDone();
	}
	if (gb.LY >= 108) {
		return;
	}
	handleEnemyLoading();
}

void ingameLoadEnemySaveFlags() {
	previousLevelBank = currentLevelBank;
	infof("Loading spawn flag set %02X", currentLevelBank - 9);
	enemySpawnFlagsSaved[] = saveBuf.enemySpawnFlags[currentLevelBank - 9][];
	enemyFirstEnemy = enemyDataSlots[];
	metroidState = 0;
	metroidFightActive = 0;
	cutsceneActive = 0;
	numEnemies.total = 0;
	numEnemies.active = 0;
	numEnemies.offscreen = 0;
	enemySameEnemyFrameFlag = 0;
	enSprCollision.weaponType = CollisionType.nothing;
	enSprCollision.enemy = null;
	enemyWeaponType = CollisionType.nothing;
	scrollHistoryB.y[] = scrollY;
	scrollHistoryB.x[] = scrollX;
	blobThrowerLoadSprite();
}

void ingameSaveAndLoadEnemySaveFlags() {
	enemySpawnFlagsUnsaved[] = 0xFF;
	if (previousLevelBank) {
		for (int i = 0; i < saveBuf.enemySpawnFlags[currentLevelBank - 9].length; i++) {
			ubyte value = enemySpawnFlagsSaved[i];
			switch (value) {
				case 4:
				case 5:
					value = 0xFE;
					goto case;
				case 2:
				case 0xFE:
					saveBuf.enemySpawnFlags[currentLevelBank - 9][i] = value;
					break;
				default: break;
			}
		}
	}
	previousLevelBank = currentLevelBank;
	enemySpawnFlagsSaved[] = saveBuf.enemySpawnFlags[currentLevelBank - 9][];
	enemyFirstEnemy = enemyDataSlots[];
	enemiesLeftToProcess = 0;
	enemySameEnemyFrameFlag = 0;
	enSprCollision.weaponType = CollisionType.nothing;
	enSprCollision.enemy = null;
	scrollHistoryB.y[] = scrollY;
	scrollHistoryB.x[] = scrollX;
	deactivateAllEnemies();
}
void deactivateAllEnemies() {
	for (int i = 0; i < enemyDataSlots.length; i++) {
		enemyDataSlots[i].status = 0xFF;
	}
	enemyWorking = EnemyWorking.init;
	numEnemies = NumEnemies.init;
}

bool enemyGetDamagedOrGiveDrop() {
	static bool transferCollisionResults() {
		enSprCollision.weaponType = collision.weaponType;
		enSprCollision.enemy = collision.enemy;
		enSprCollision.weaponDir = collision.weaponDir;
		collision = EnSprCollision.init;
		return false;
	}
	static bool prepareDrop(ubyte v) {
		if ((enemyWorking.spawnFlag == 6) || ((enemyWorking.spawnFlag & 0xF) == 0)) {
			v |= 1 << 0; // small health
		} else if ((enemyWorking.maxHealth == 0xFD) || (enemyWorking.maxHealth == 0xFE)) {
			// nothing
		} else if ((enemyWorking.maxHealth & 1) == 0) {
			v |= 1 << 2; // missile drop
		} else if (enemyWorking.maxHealth < 10) {
			v |= 1 << 0; // small health
		} else {
			v |= 1 << 1; // large health
		}
		enemyWorking.explosionFlag = v;
		enemyWorking.counter = 0;
		sfxRequestNoise = NoiseSFX.u02;
		transferCollisionResults();
		return true;
	}
	static void giveHealth(ubyte amount) {
		samusCurHealth += amount;
		if (samusCurHealth / 100 >= samusEnergyTanks) {
			samusCurHealth = cast(ushort)(((samusEnergyTanks + 1) * 100) - 1);
		}
	}
	if (collision.weaponType == CollisionType.nothing) {
		return false;
	}
	if (enemyWRAMAddr != collision.enemy) {
		return false;
	}
	if (enemyWorking.explosionFlag) {
		 return transferCollisionResults();
	}
	if (!enemyWorking.dropType) {
		if ((enemyWorking.spriteType >= Actor.metroid1) && (enemyWorking.spriteType <= Actor.metroid3)) {
			return transferCollisionResults();
		}
		if (collision.weaponType == CollisionType.screwAttack) {
			if (enemyWorking.health != 0xFF) {
				return prepareDrop(0x20);
			}
			sfxRequestSquare1 = Square1SFX.beamDink;
			 return transferCollisionResults();
		} else if (collision.weaponType > CollisionType.screwAttack) {
			return transferCollisionResults();
		}
		if (collision.weaponType != 1) {
			if (enemyCheckDirectionalShields()) {
				return true;
			}
			if (enemyWorking.health >= 0xFE) {
				sfxRequestSquare1 = Square1SFX.beamDink;
				return transferCollisionResults();
			}
			const overkill = enemyWorking.health < weaponDamageTable[collision.weaponType];
			enemyWorking.health -= weaponDamageTable[collision.weaponType];
			if ((enemyWorking.health == 0) || overkill) {
				return prepareDrop(0x10);
			}
			sfxRequestNoise = NoiseSFX.u01;
			transferCollisionResults();
			enemyWorking.stunCounter = 17;
			return true;
		} else {
			if (enemyWorking.health == 0) {
				return prepareDrop(0x10);
			} else if (enemyWorking.health == 0xFF) {
				sfxRequestSquare1 = Square1SFX.beamDink;
				return transferCollisionResults();
			} else if (enemyWorking.health == 0xFE) {
				sfxRequestSquare1 = Square1SFX.beamDink;
			} else {
				if (enemyCheckDirectionalShields()) {
					return true;
				}
				enemyWorking.health--;
				if (enemyWorking.health) {
					enemyWorking.health--;
				}
				sfxRequestNoise = NoiseSFX.u01;
			}
			enemyWorking.stunCounter = 0x10;
			enemyWorking.iceCounter = 0x1;
			return transferCollisionResults();
		}
	}
	if (collision.weaponType < CollisionType.screwAttack) {
		return transferCollisionResults();
	}
	switch (enemyWorking.dropType) {
		case 1:
			sfxRequestSquare1 = Square1SFX.pickedUpSmallEnergyDrop;
			giveHealth(5);
			break;
		case 2:
			sfxRequestSquare1 = Square1SFX.pickedUpLargeEnergyDrop;
			giveHealth(20);
			break;
		default:
			sfxRequestSquare1 = Square1SFX.pickedUpMissileDrop;
			samusCurMissiles += 5;
			if (samusCurMissiles > samusMaxMissiles) {
				samusCurMissiles = samusMaxMissiles;
			}
			break;
	}
	enemyDeleteSelf();
	enemyWorking.spawnFlag = 2;
	transferCollisionResults();
	collision = enSprCollision.init;
	return true;
}

bool enemyCheckDirectionalShields() {
	if (collision.weaponType == CollisionType.waveBeam) {
		return false;
	}
	if (!(enemyWorking.directionFlags & 0xF0)) {
		return false;
	}
	if (((enemyWorking.directionFlags & 0xF0) >> 4) & collision.weaponDir) {
		sfxRequestSquare1 = Square1SFX.beamDink;
		enSprCollision.weaponType = collision.weaponType;
		enSprCollision.enemy = collision.enemy;
		enSprCollision.weaponDir = collision.weaponDir;
		collision = EnSprCollision.init;
		return true;
	}
	return false;
}


immutable ubyte[] weaponDamageTable = [
	CollisionType.powerBeam: 1,
	CollisionType.iceBeam: 2,
	CollisionType.waveBeam: 4,
	CollisionType.spazer: 8,
	CollisionType.plasmaBeam: 30,
	CollisionType.unk5: 0,
	CollisionType.unk6: 0,
	CollisionType.bombs: 2,
	CollisionType.missiles: 20,
	CollisionType.bombExplosion: 10,
];

bool enemyMoveFromWRAMtoHRAM(EnemySlot* enemy) {
	enemyWRAMAddr = enemy;
	enemyWorking.status = enemy.status;
	enemyWorking.y = enemy.y;
	enemyWorking.x = enemy.x;
	enemyWorking.spriteType = enemy.spriteType;
	enemyWorking.baseSpriteAttributes = enemy.baseSpriteAttributes;
	enemyWorking.spriteAttributes = enemy.spriteAttributes;
	enemyWorking.stunCounter = enemy.stunCounter;
	enemyWorking.misc = enemy.misc;
	enemyWorking.directionFlags = enemy.directionFlags;
	enemyWorking.counter = enemy.counter;
	enemyWorking.state = enemy.state;
	enemyWorking.iceCounter = enemy.iceCounter;
	enemyWorking.health = enemy.health;
	enemyWorking.dropType = enemy.dropType;
	enemyWorking.explosionFlag = enemy.explosionFlag;
	enemyWorking.yScreen = enemy.yScreen;
	enemyWorking.xScreen = enemy.xScreen;
	enemyWorking.maxHealth = enemy.maxHealth;
	enemyWorking.spawnFlag = enemy.spawnFlag;
	enemyWorking.spawnNumber = enemy.spawnNumber;
	enemyWorking.ai = enemy.ai;
	enemyYPosMirror = enemy.y;
	enemyXPosMirror = enemy.x;
	if (enemyWorking.stunCounter < 17) {
		return false;
	}
	if (++enemyWorking.stunCounter != 20) {
		return true;
	} else if (enemyWorking.iceCounter == 0) {
		enemyWorking.stunCounter = 0;
	} else {
		enemyWorking.stunCounter = 16;
	}
	return false;
}

void enemyMoveFromHRAMtoWRAM() {
	enemyWRAMAddr.status = enemyWorking.status;
	enemyWRAMAddr.y = enemyWorking.y;
	enemyWRAMAddr.x = enemyWorking.x;
	enemyWRAMAddr.spriteType = enemyWorking.spriteType;
	enemyWRAMAddr.baseSpriteAttributes = enemyWorking.baseSpriteAttributes;
	enemyWRAMAddr.spriteAttributes = enemyWorking.spriteAttributes;
	enemyWRAMAddr.stunCounter = enemyWorking.stunCounter;
	enemyWRAMAddr.misc = enemyWorking.misc;
	enemyWRAMAddr.directionFlags = enemyWorking.directionFlags;
	enemyWRAMAddr.counter = enemyWorking.counter;
	enemyWRAMAddr.state = enemyWorking.state;
	enemyWRAMAddr.iceCounter = enemyWorking.iceCounter;
	enemyWRAMAddr.health = enemyWorking.health;
	enemyWRAMAddr.dropType = enemyWorking.dropType;
	enemyWRAMAddr.explosionFlag = enemyWorking.explosionFlag;
	enemyWRAMAddr.spawnFlag = enemyWorking.spawnFlag;
	enemyWRAMAddr.spawnNumber = enemyWorking.spawnNumber;
	enemyWRAMAddr.yScreen = enemyWorking.yScreen;
	enemyWRAMAddr.xScreen = enemyWorking.xScreen;
	enemyWRAMAddr.ai = enemyWorking.ai;
	enemySpawnFlags[enemyWorking.spawnNumber] = enemyWorking.spawnFlag;
	if (enemyWRAMAddr.status != 0xFF) {
		return;
	}
	infof("Was deleted");
	enemyWRAMAddr.spawnFlag = 0xFF;
	enemyWRAMAddr.spawnNumber = 0xFF;
}

bool deleteOffscreenEnemy() {
	if ((enemyWorking.yScreen != 0xFE) && (enemyWorking.yScreen != 3) && (enemyWorking.xScreen != 0xFE) && (enemyWorking.xScreen != 3)) {
		return false;
	}
	(cast(ubyte*)&enemyWorking)[0 .. 15] = 0xFF;
	if (enemyWorking.spawnFlag != 2) {
		if (enemyWorking.spawnFlag == 4) {
			enemyWorking.spawnFlag = 0xFE;
		} else {
			enemyWorking.spawnFlag = 0xFF;
		}
	}
	enemyWorking.ai = null;
	enemyWorking.yScreen = 0xFF;
	enemyWorking.xScreen = 0xFF;
	numEnemies.total--;
	numEnemies.offscreen--;
	if (enSprCollision.enemy == enemyWRAMAddr) {
		enSprCollision = EnSprCollision.init;
	}
	return true;
}

bool reactivateOffscreenEnemy() {
	if (enemyWorking.yScreen == 0xFF) {
		if (enemyWorking.y >= 240) {
			enemyWorking.yScreen++;
		}
	} else if (enemyWorking.yScreen == 0) {
		if ((enemyWorking.y >= 192) && (enemyWorking.y < 216)) {
			enemyWorking.yScreen++;
		} else if ((enemyWorking.y >= 216) && (enemyWorking.y < 240)) {
			enemyWorking.yScreen--;
		}
	} else if (enemyWorking.yScreen == 1) {
		if (enemyWorking.y < 192) {
			enemyWorking.yScreen--;
		}
	}
	if (enemyWorking.xScreen == 0xFF) {
		if (enemyWorking.x >= 240) {
			enemyWorking.xScreen++;
		}
	} else if (enemyWorking.xScreen == 0) {
		if ((enemyWorking.x >= 192) && (enemyWorking.x < 216)) {
			enemyWorking.xScreen++;
		} else if ((enemyWorking.x >= 216) && (enemyWorking.x < 240)) {
			enemyWorking.xScreen--;
		}
	} else if (enemyWorking.xScreen == 1) {
		if (enemyWorking.x < 192) {
			enemyWorking.xScreen--;
		}
	}
	if (enemyWorking.yScreen | enemyWorking.xScreen) {
		return false;
	}
	enemyWorking.status = 0;
	numEnemies.active++;
	numEnemies.offscreen--;
	return true;
}

bool deactivateOffscreenEnemy() {
	hasMovedOffscreen = 0;
	if ((enemyWorking.y >= 0xC0) && (enemyWorking.y < 0xD8)) {
		enemyWorking.yScreen = 1;
		hasMovedOffscreen = 1;
	} else if ((enemyWorking.y >= 0xD8) && (enemyWorking.y < 0xF0)) {
		enemyWorking.yScreen = 0xFF;
		hasMovedOffscreen = 1;
	}
	if ((enemyWorking.x >= 0xC0) && (enemyWorking.x < 0xD8)) {
		enemyWorking.xScreen = 1;
		hasMovedOffscreen = 1;
	} else if ((enemyWorking.x >= 0xD8) && (enemyWorking.x < 0xF0)) {
		enemyWorking.xScreen = 0xFF;
		hasMovedOffscreen = 1;
	}
	if (!hasMovedOffscreen) {
		return false;
	}
	enemyWorking.status = 1;
	if (enemyWorking.spawnFlag == 2) {
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 2;
	} else if ((enemyWorking.spawnFlag == 6) || ((enemyWorking.spawnFlag & 0xF) == 0)) {
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 0xFF;
	} else {
		numEnemies.active--;
		if (enemyWorking.spawnFlag == 3) {
			enemyWorking.spawnFlag = 1;
		} else if ((enemyWorking.spawnFlag == 4) || (enemyWorking.spawnFlag == 5)) {
			enemyWorking.spawnFlag = 4;
			metroidPostDeathTimer = 0;
			metroidState = 0;
		}
	}
	return true;
}

void updateScrollHistory() {
	scrollHistoryA[0].y = scrollHistoryA[1].y;
	scrollHistoryA[0].x = scrollHistoryA[1].x;
	scrollHistoryA[1].y = scrollHistoryA[2].y;
	scrollHistoryA[1].x = scrollHistoryA[2].x;
	scrollHistoryA[2].y = scrollY;
	scrollHistoryA[2].x = scrollX;
}

void unusedGetSamusDirection() {
	assert(0); // TODO
}

void unusedSetXFlip() {
	assert(0); // TODO
}

void enCollisionRightNearSmall() {
	enBGCollisionResult = 0b00010001;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 3);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightMidSmall() {
	enBGCollisionResult = 0b00010001;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightMidMedium() {
	enBGCollisionResult = 0b00010001;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 6);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 7);
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightFarMedium() {
	enBGCollisionResult = 0b00010001;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightMidWide() {
	enBGCollisionResult = 0b00010001;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightFarWide() {
	enBGCollisionResult = 0b00010001;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightCrawlA() {
	enBGCollisionResult = 0b00010001;
	// check upper right
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 8);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check lower right
	enemyTestPointYPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionRightCrawlB() {
	enBGCollisionResult = 0b00010001;
	// check upper right
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x + 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check lower right
	enemyTestPointYPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000001;
}

void enCollisionLeftNearSmall() {
	enBGCollisionResult = 0b01000100;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 3);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftMidSmall() {
	enBGCollisionResult = 0b01000100;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftMidMedium() {
	enBGCollisionResult = 0b01000100;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 6);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftFarMedium() {
	enBGCollisionResult = 0b01000100;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftMidWide() {
	enBGCollisionResult = 0b01000100;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftFarWide() {
	enBGCollisionResult = 0b01000100;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointYPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftCrawlA() {
	enBGCollisionResult = 0b01000100;
	// check upper left
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 9);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check lower left
	enemyTestPointYPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionLeftCrawlB() {
	enBGCollisionResult = 0b01000100;
	// check upper left
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 8);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 9);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check lower left
	enemyTestPointYPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000100;
}

void enCollisionDownNearSmall() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 3);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownNearMedium() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownMidMedium() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 6);
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownMidWide() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownOnePoint() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 11);
	enemyTestPointXPos = enemyWorking.x;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownFarMedium() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownFarWide() {
	enBGCollisionResult = 0b00100010;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownCrawlA() {
	enBGCollisionResult = 0b00100010;
	// check lower left
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 8);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 8);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check lower right
	enemyTestPointXPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionDownCrawlB() {
	enBGCollisionResult = 0b00100010;
	// check lower left
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y + 8);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 9);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check lower right
	enemyTestPointXPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00000010;
}

void enCollisionUpNearSmall() {
	enBGCollisionResult = 0b10001000;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 3);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpNearMedium() {
	enBGCollisionResult = 0b10001000;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 3);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpMidMedium() {
	enBGCollisionResult = 0b10001000;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 6);
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	metroidBabyTouchingTile = getTileIndexEnemy();
	if (metroidBabyTouchingTile < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpMidWide() {
	enBGCollisionResult = 0b10001000;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 7);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpFarMedium() {
	enBGCollisionResult = 0b10001000;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 7);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 7;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpFarWide() {
	enBGCollisionResult = 0b10001000;
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 11);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 11);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 6;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enemyTestPointXPos += 8;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpCrawlA() {
	enBGCollisionResult = 0b10001000;
	// check upper left
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 8);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 9);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check upper right
	enemyTestPointXPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void enCollisionUpCrawlB() {
	enBGCollisionResult = 0b10001000;
	// check upper left
	enemyTestPointYPos = cast(ubyte)(enemyWorking.y - 8);
	enemyTestPointXPos = cast(ubyte)(enemyWorking.x - 8);
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	// check upper right
	enemyTestPointXPos += 15;
	if (getTileIndexEnemy() < enemySolidityIndex) {
		return;
	}
	enBGCollisionResult &= ~0b00001000;
}

void blobThrowerLoadSprite() {
	enSpriteBlobThrower[] = enAIBlobThrowerSprite[];
	hitboxC360 = enAIBlobThrowerHitbox;
	blobThrowerActionTimer = 0;
}

void enAIItemOrb() {
	if (enemyWorking.spriteType & 1) { //not orb
		if ((frameCounter & 6) == 0) {
			enemyWorking.stunCounter ^= 0x10;
		}
	}
	enemyGetSamusCollisionResults();
	if (enemyWeaponType == CollisionType.nothing) {
		return;
	}
	itemOrbCollisionType = enemyWeaponType;
	itemOrbEnemyWRAM = enemyWRAMAddr;
	if (!(enemyWorking.spriteType & 1)) { //is orb
		if ((enemyWeaponType == CollisionType.bombExplosion) || (enemyWeaponType == CollisionType.screwAttack) || (enemyWeaponType == CollisionType.contact)) {
			return;
		}
		sfxRequestSquare1 = Square1SFX.nothing;
		sfxRequestNoise = NoiseSFX.u02;
		enemyWorking.spriteType++;
		return;
	} else {
		if (enemyWeaponType != CollisionType.contact) {
			if (enemyWeaponType != CollisionType.screwAttack) {
				return;
			}
			sfxRequestSquare1 = Square1SFX.clear;
		}
		if (itemCollectionFlag != 0) {
			itemCollected = 0;
			if (itemCollectionFlag == 0xFF) {
				return;
			}
			itemCollected = 0;
			itemCollectionFlag = 0;
			if (tempSpriteType == Actor.energyRefill) {
				return;
			}
			if (tempSpriteType == Actor.missileRefill) {
				return;
			}
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 2;
			return;
		}
		if (enemyWorking.spriteType != Actor.energyRefill) {
			if (enemyWorking.spriteType == Actor.missileRefill) {
				if (samusCurMissiles == samusMaxMissiles) {
					return;
				}
			}
		} else if (samusCurHealth == ((samusEnergyTanks + 1) * 100) - 1) {
			return;
		}
	}
	tempSpriteType = enemyWorking.spriteType;
	const itemType = cast(ubyte)(((enemyWorking.spriteType - Actor.itemBaseID) / 2) + 1);
	itemCollected = itemType;
	unusedItemOrbYPos = enemyWorking.y;
	unusedItemOrbXPos = enemyWorking.x;
	itemCollectionFlag = 0xFF;
}

enum BlobThrowerState {
	extending,
	readyToSpew,
	spewing,
	doneSpewing,
}

void enAIBlobThrower() {
	static void moveSprites(ref OAMEntry* enemy, const(ubyte)* speedTable, ubyte a) {
		while (true) {
			if (speedTable[blobThrowerActionTimer] != 0x80) {
				while (a-- > 0) {
					enemy.y += speedTable[blobThrowerActionTimer];
					enemy++;
				}
				break;
			}
			blobThrowerWaitTimer = 0x30;
			blobThrowerActionTimer = 0;
		}
	}
	static void spewBlob(const(EnemyHeader)* header) {
		const slot = loadEnemyGetFirstEmptySlot();
		enemyDataSlots[slot].status = 0;
		enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y - 32);
		enemyDataSlots[slot].x = enemyWorking.x;
		enemyTempSpawnFlag = 6;
		enemySpawnObjectLongHeader(header, &enemyDataSlots[slot]);
		enemyDataSlots[slot].misc = cast(ubyte)(enemyWorking.y + 64);
	}
	static immutable ubyte[] speedTableTop = [
		0x00, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFD, 0xFF,
	    0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x00,
	    0x02, 0x01, 0x01, 0x01, 0x01, 0x02, 0x00, 0x00, 0x01, 0x01, 0x01, 0x02, 0x01, 0x00, 0x02, 0x00,
	    0x00, 0x80,
    ];
	static immutable ubyte[] speedTableMiddle = [
		0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFE, 0xFF, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x02, 0x00, 0x02, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
		0x00, 0x80,
	];
	static immutable ubyte[] speedTableBottom = [
		0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01,
		0x00, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x00,
		0x00, 0x80,
	];
	// counters were pointers before, now are indices
	static immutable blobHeaderA = EnemyHeader(Actor.blob, 0x00, 0x00, 0x00, 0x00, 0x00, 0, 0, 0x00, 0x02, 0x02, &enAIBlobProjectile);
	static immutable blobHeaderB = EnemyHeader(Actor.blob, 0x00, 0x00, 0x00, 0x00, 0x00, 1, 0, 0x00, 0x02, 0x03, &enAIBlobProjectile);
	static immutable blobHeaderC = EnemyHeader(Actor.blob, 0x00, 0x00, 0x00, 0x00, 0x00, 2, 0, 0x00, 0x02, 0x04, &enAIBlobProjectile);
	static immutable blobHeaderD = EnemyHeader(Actor.blob, 0x00, 0x00, 0x00, 0x00, 0x00, 3, 0, 0x00, 0x02, 0x05, &enAIBlobProjectile);
	if (!(frameCounter & 14)) {
		for (int i = 4; i < 7; i++) {
			enSpriteBlobThrower[i].tile ^= 7;
		}
		enSpriteBlobThrower[8].tile ^= 13;
		enSpriteBlobThrower[11].tile ^= 13;
	}
	if (blobThrowerWaitTimer) {
		blobThrowerWaitTimer--;
	} else {
		final switch (cast(BlobThrowerState)blobThrowerState) {
			case BlobThrowerState.extending:
				OAMEntry* enemy = &enSpriteBlobThrower[0];
				moveSprites(enemy, &speedTableTop[0], 4);
				moveSprites(enemy, &speedTableTop[0], 1);
				moveSprites(enemy, &speedTableMiddle[0], 1);
				moveSprites(enemy, &speedTableBottom[0], 1);
				hitboxC360.top += speedTableTop[blobThrowerActionTimer];
				if (++blobThrowerActionTimer != 21) {
					return;
				}
				enSpriteBlobThrower[0].tile = 0xDF;
				enSpriteBlobThrower[1].tile = 0xDF;
				enSpriteBlobThrower[2].tile = 0xE1;
				enSpriteBlobThrower[3].tile = 0xE1;
				enSpriteBlobThrower[13].y = 0xE8;
				blobThrowerWaitTimer = 4;
				blobThrowerState = BlobThrowerState.readyToSpew;
				break;
			case BlobThrowerState.readyToSpew:
				enSpriteBlobThrower[0].tile = 0xE2;
				enSpriteBlobThrower[1].tile = 0xE2;
				blobThrowerWaitTimer = 4;
				blobThrowerState = BlobThrowerState.spewing;
				break;
			case BlobThrowerState.spewing:
				enSpriteBlobThrower[0].tile = 0xE3;
				enSpriteBlobThrower[1].tile = 0xE3;
				blobThrowerWaitTimer = 64;
				blobThrowerState = BlobThrowerState.doneSpewing;
				getFacingDirection();
				spewBlob(&blobHeaderA);
				spewBlob(&blobHeaderB);
				spewBlob(&blobHeaderC);
				spewBlob(&blobHeaderD);
				break;
			case BlobThrowerState.doneSpewing:
				enSpriteBlobThrower[0].tile = 0xDD;
				enSpriteBlobThrower[1].tile = 0xDD;
				enSpriteBlobThrower[2].tile = 0xDE;
				enSpriteBlobThrower[3].tile = 0xDE;
				enSpriteBlobThrower[13].y = 0xFF; // don't render the rest of the tiles
				blobThrowerState = BlobThrowerState.extending;
				break;
		}
	}
}
void getFacingDirection() {
	blobThrowerFacingDirection = 0;
	if (enemyWorking.x >= samusOnScreenXPos) {
		blobThrowerFacingDirection = 1;
	}
}
immutable OAMEntry[] enAIBlobThrowerSprite = [
    OAMEntry(-8, 0x00, 0xDD, 0x20),
    OAMEntry(-8, -8, 0xDD, 0x00),
    OAMEntry(0x00, 0x00, 0xDE, 0x20),
    OAMEntry(0x00, -8, 0xDE, 0x00),
    OAMEntry(0x08, -4, 0xDB, 0x00),
    OAMEntry(0x08, -4, 0xDB, 0x00),
    OAMEntry(0x08, -4, 0xDB, 0x00),
    OAMEntry(0x08, -12, 0xD6, 0x00),
    OAMEntry(0x08, -4, 0xDA, 0x00),
    OAMEntry(0x08, 0x04, 0xD8, 0x00),
    OAMEntry(0x10, -12, 0xD3, 0x00),
    OAMEntry(0x10, -4, 0xD9, 0x00),
    OAMEntry(0x10, 0x04, 0xD5, 0x00),
    OAMEntry(cast(byte)metaSpriteEnd, -16, 0xE0, 0x00),
    OAMEntry(-24, 0x08, 0xE0, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable Rectangle enAIBlobThrowerHitbox = Rectangle(-4, 0x18, -8, 0x08);

void enAIArachnus() {
	assert(0); // TODO
}

void enAIBlobProjectile() {
	static immutable ubyte[][] blobMovementTable = [
		[
			0x19, 0x1A, 0x1A, 0x29, 0x28, 0x31, 0x32, 0x32, 0x33, 0x34, 0x34, 0x25, 0x89, 0x9B, 0x9B, 0xA9,
			0xA8, 0xB1, 0xB2, 0xC2, 0xC3, 0xD4, 0xD4, 0xC5, 0x09, 0x1B, 0x1B, 0x29, 0x28, 0x31, 0x32, 0x42,
			0x43, 0x54, 0x54, 0x45, 0x89, 0x9B, 0x9B, 0xA9, 0xA8, 0xB1, 0xB2, 0xC2, 0xC3, 0xD4, 0xD4, 0xC5,
			0x80,
		], [
			0x09, 0x1A, 0x1A, 0x2A, 0x3A, 0x3A, 0x4A, 0x49, 0x58, 0x51, 0x89, 0x9B, 0x9B, 0xA9, 0xA8, 0xB1,
			0xB2, 0xC2, 0xC3, 0xD4, 0xD4, 0xC5, 0x09, 0x1B, 0x1B, 0x29, 0x28, 0x31, 0x32, 0x42, 0x43, 0x54,
			0x54, 0x45, 0x89, 0x9B, 0x9B, 0xA9, 0xA8, 0xB1, 0xB2, 0xC2, 0xC3, 0xD4, 0xD4, 0xC5, 0x80,
		], [
			0x19, 0x1A, 0x2B, 0x4B, 0x4A, 0x5A, 0x59, 0x09, 0x1B, 0x1B, 0x29, 0x28, 0x31, 0x32, 0x42, 0x43,
			0x54, 0x54, 0x45, 0x89, 0x9B, 0x9B, 0xA9, 0xA8, 0xB1, 0xB2, 0xC2, 0xC3, 0xD4, 0xD4, 0xC5, 0x09,
			0x1B, 0x1B, 0x29, 0x28, 0x31, 0x32, 0x42, 0x43, 0x54, 0x54, 0x45, 0x80,
		], [
			0x29, 0x39, 0x3A, 0x4A, 0x4B, 0x5B, 0x58, 0x6B, 0x09, 0x1B, 0x1B, 0x29, 0x28, 0x31, 0x32, 0x42,
			0x43, 0x54, 0x54, 0x45, 0x89, 0x9B, 0x9B, 0xA9, 0xA8, 0xB1, 0xB2, 0xC2, 0xC3, 0xD4, 0xD4, 0xC5,
			0x09, 0x1B, 0x1B, 0x29, 0x28, 0x31, 0x32, 0x42, 0x43, 0x54, 0x54, 0x45, 0xEB, 0xFA, 0xFA, 0xE9,
			0xE9, 0xD8, 0xD8, 0xC1, 0xC1, 0xB2, 0xB2, 0xA3, 0xA3, 0x94, 0x94, 0x85, 0x85, 0x80,
		]
	];
	static void done() {
		blobThrowerBlobUnknownVar = 0;
		if (enemyWorking.y < enemyWorking.misc) {
			enemyWorking.y += 2;
		} else {
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 0xFF;
		}
	}
	if (enemyFrameCounter & 1) {
		return;
	}
	if (!(enemyFrameCounter & 1)) {
		enemyWorking.spriteType ^= Actor.blob ^ Actor.blob2;
	}
	const movement = blobMovementTable[enemyWorking.counter][enemyWorking.state];
	if (movement == 0x80) {
		return done();
	}
	byte h = movement >> 4;
	if (h & 0x8) {
		h = cast(byte)-(h & 7);
	}
	if (blobThrowerFacingDirection != 0) {
		h = cast(byte)-h;
	}
	enemyWorking.x += h;
	byte v = movement & 0xF;
	if (v & 0x8) {
		v = cast(byte)-(v & 7);
	}
	enemyWorking.y += v;
	enemyWorking.state++;
}

void enAIGlowFly() {
	assert(0); // TODO
}

enum RockIcicleState {
	state0 = 0,
	state1 = 1,
	state2 = 2,
	state3 = 3,
	state4 = 4,
	state5 = 5,
}

void enAIRockIcicle() {
	static void animate() {
		if (enemyFrameCounter & 1) {
			return;
		}
		if (enemyWorking.spriteType == Actor.rockIcicleMoving1) {
			enemyWorking.spriteType = Actor.rockIcicleMoving2;
			return;
		}
		if (enemyWorking.spriteType == Actor.rockIcicleMoving2) {
			enemyWorking.spriteType = Actor.rockIcicleMoving1;
			return;
		}
		enemyWorking.spriteType = Actor.rockIcicleMoving1;
	}
	final switch (cast(RockIcicleState)enemyWorking.state) {
		case RockIcicleState.state0:
			enemyWorking.spriteType = Actor.rockIcicleIdle1;
			if (++enemyWorking.counter < 11) {
				return;
			}
			enemyWorking.state = RockIcicleState.state1;
			enemyWorking.spriteType = Actor.rockIcicleIdle2;
			enemyWorking.counter = 0;
			break;
		case RockIcicleState.state1:
			if (++enemyWorking.counter < 7) {
				return;
			}
			enemyWorking.state = RockIcicleState.state2;
			enemyWorking.counter = 0;
			break;
		case RockIcicleState.state2:
			if (enemyFrameCounter & 3) {
				return;
			}
			animate();
			enemyWorking.y++;
			if (++enemyWorking.misc != 4) {
				return;
			}
			enemyWorking.spriteType = Actor.rockIcicleMoving1;
			enemyWorking.state = RockIcicleState.state3;
			break;
		case RockIcicleState.state3:
			animate();
			if (enemyFrameCounter != 5) {
				return;
			}
			enemyWorking.state = RockIcicleState.state4;
			break;
		case RockIcicleState.state4:
			animate();
			if (++enemyWorking.counter != 16) {
				return;
			}
			enemyWorking.counter = 0;
			enemyWorking.state = RockIcicleState.state5;
			break;
		case RockIcicleState.state5:
			animate();
			enemyWorking.y += 4;
			enemyWorking.misc += 4;
			enCollisionDownNearSmall();
			if (!(enBGCollisionResult & 2)) {
				if (enemyWorking.y < 160) {
					return;
				}
			}
			sfxRequestNoise = NoiseSFX.u11;
			enemyWorking.y -= enemyWorking.misc;
			enemyWorking.misc = 0;
			enemyWorking.state = RockIcicleState.state0;
			enemyWorking.spriteType = Actor.rockIcicleIdle1;
			break;
	}
}

void enemyCommonAI() {
	if (enemyWorking.dropType) {
		return enemyAnimateDrop();
	}
	if (enemyWorking.explosionFlag) {
		return enemyAnimateExplosion(enemyWorking.explosionFlag);
	}
	if (enemyWorking.iceCounter) {
		return enemyAnimateIce();
	}
	if (metroidState == 0x80) {
		return enemyMetroidExplosion();
	}
	enemyWorking.ai();
}

void enAINULL() {}

void enemyAnimateIce() {
	if ((enemyWorking.spriteType == Actor.metroid1) || (enemyWorking.spriteType == Actor.metroid) || (enemyWorking.spriteType == Actor.metroid3)) {
		return enemyWorking.ai();
	}
	enemyAnimateIceCall();
}
void enemyAnimateIceCall() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyWorking.iceCounter += 2;
	if (enemyWorking.iceCounter < 198) {
		return;
	}
	if (enemyWorking.iceCounter < 208) {
		enemyWorking.status ^= 0x80;
	} else {
		enemyWorking.iceCounter = 0;
		if (enemyWorking.health != 0) {
			enemyWorking.stunCounter = 0;
			enemyWorking.status = 0;
		} else {
			sfxRequestNoise = NoiseSFX.u02;
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 2;
		}
	}
}

void enemyAnimateDrop() {
	if (++enemyWorking.counter != 176) {
		if (enemyWorking.counter < 128) {
			if (enemyFrameCounter & 3) {
				return;
			}
		} else {
			if (enemyFrameCounter & 1) {
				return;
			}
		}
		enemyWorking.spriteType ^= 1;
	} else {
		enemyWorking.dropType = 0;
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 2;
	}
}

void enemyAnimateExplosion(ubyte type) {
	if (type & (1 << 5)) {
		if (++enemyWorking.counter != Actor.screwExplosionEnd - Actor.screwExplosionStart + 1) {
			enemyWorking.spriteType = cast(Actor)(enemyWorking.counter + Actor.screwExplosionStart);
			return;
		}
	} else {
		if (type != 0x11) {
			type++;
		}
		if (++enemyWorking.counter != Actor.normalExplosionEnd - Actor.normalExplosionStart + 1) {
			enemyWorking.spriteType = cast(Actor)(Actor.normalExplosionStart + enemyWorking.counter);
			return;
		}
	}
	if (enemyWorking.maxHealth == 0xFD) {
		enemyWorking.stunCounter = 0;
		enemyWorking.iceCounter = 0;
		enemyWorking.explosionFlag = 0;
		enemyWorking.counter++;
		return;
	}
	static void dropNothing() {
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 2;
	}
	if (gb.DIV & 1) {
		return dropNothing();
	}
	ushort drop;
	if ((enemyWorking.explosionFlag & 0xF) == 0) {
		return dropNothing();
	} else if ((enemyWorking.explosionFlag & 0xF) == 1) {
		drop = (1 << 8) | Actor.smallHealth;
	} else if ((enemyWorking.explosionFlag & 0xF) == 2) {
		drop = (2 << 8) | Actor.bigHealth;
	} else {
		drop = (4 << 8) | Actor.missileDrop;
	}
	enemyWorking.dropType = (drop >> 8);
	enemyWorking.spriteType = cast(Actor)(drop & 0xFF);
	enemyWorking.stunCounter = 0;
	enemyWorking.iceCounter = 0;
	enemyWorking.counter = 0;
	enemyWorking.explosionFlag = 0;
}

void enemyMetroidExplosion() {
	static void deleteProjectile() {
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 0xFF;
	}
	static void forceOnscreen() {
		if (enemyWorking.y >= 0xF0) {
			enemyWorking.y = 24;
		} else if (enemyWorking.y >= 0xA0) {
			enemyWorking.y = 152;
		} else if (enemyWorking.y < 0x0A) {
			enemyWorking.y = 24;
		}
		if (enemyWorking.x >= 0xF0) {
			enemyWorking.x = 24;
		} else if (enemyWorking.x >= 0xA0) {
			enemyWorking.x = 152;
		} else if (enemyWorking.x < 0x0A) {
			enemyWorking.x = 24;
		}
	}
	if (enemyWorking.spawnFlag == 6) {
		return deleteProjectile();
	}
	if ((enemyWorking.spriteType < Actor.screwExplosionStart) || (enemyWorking.spriteType > Actor.screwExplosionEnd)) {
		return enemyWorking.ai();
	}
	if (cutsceneActive) {
		cutsceneActive = 1;
		forceOnscreen();
	}
	if (enemyWorking.counter != 6) {
		enemyWorking.spriteType = cast(Actor)(Actor.screwExplosionStart + enemyWorking.counter);
		enemyWorking.counter++;
	} else {
		enemyWorking.counter = 0;
		switch (++enemyWorking.state) {
			case 1:
				enemyWorking.x -= 16;
				forceOnscreen();
				break;
			case 2:
				enemyWorking.y -= 16;
				enemyWorking.x -= 16;
				forceOnscreen();
				break;
			case 3:
				enemyWorking.y += 16;
				enemyWorking.x -= 16;
				forceOnscreen();
				break;
			default:
			case 4:
				enSprCollision = EnSprCollision.init;
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 2;
				metroidState = 0;
				cutsceneActive = 0;
				break;
		}
	}
}

// AI for enemies that stick to a surface and move along it (clockwise)
void enAICrawlerA() {
	switch (enemyWorking.directionFlags) {
		case 0: //right
			enCollisionDownCrawlA();
			if (enBGCollisionResult & 0b0010) {
				break; //concave
			}
			crawlerTurnDown();
			return;
		case 1: //down
			enCollisionLeftCrawlA();
			if (enBGCollisionResult & 0b0100) {
				break; //concave
			}
			crawlerTurnLeft();
			return;
		case 2: //left
			enCollisionUpCrawlA();
			if (enBGCollisionResult & 0b1000) {
				break; //concave
			}
			crawlerTurnUp();
			return;
		case 3: //up
		default:
			enCollisionRightCrawlA();
			if (enBGCollisionResult & 0b0001) {
				break; //concave
			}
			crawlerTurnRight();
			return;
	}
	enemyWorking.counter = 0xFF;
	static void moveAndAnimate() {
		crawlerMove();
		if (enemyFrameCounter & 1) {
			return;
		}
		enemyFlipSpriteIDNow();
	}
	switch (enemyWorking.directionFlags) {
		case 0: //right
			enCollisionRightCrawlA();
			if (!(enBGCollisionResult & 0b0001)) {
				return moveAndAnimate();
			}
			crawlerTurnUp();
			break;
		case 1: //down
			enCollisionDownCrawlA();
			if (!(enBGCollisionResult & 0b0010)) {
				return moveAndAnimate();
			}
			crawlerTurnRight();
			break;
		case 2: //left
			enCollisionLeftCrawlA();
			if (!(enBGCollisionResult & 0b0100)) {
				return moveAndAnimate();
			}
			crawlerTurnDown();
			break;
		case 3: //up
		default:
			enCollisionUpCrawlA();
			if (!(enBGCollisionResult & 0b1000)) {
				return moveAndAnimate();
			}
			crawlerTurnLeft();
			break;
	}
}

void crawlerMove() {
	switch (enemyWorking.directionFlags) {
		case 0:
			enemyWorking.x++;
			break;
		case 1:
			enemyWorking.y++;
			break;
		default:
		case 2:
			enemyWorking.x--;
			break;
		case 3:
			enemyWorking.y--;
			break;
	}
}

void crawlerTurnRight() {
	enemyWorking.directionFlags &= 0xF0;
	enemyWorking.directionFlags |= 0x00;
	enemyWorking.spriteType &= 0xF0;
	enemyWorking.spriteAttributes = OAMFlags.xFlip;
}

void crawlerTurnDown() {
	enemyWorking.directionFlags &= 0xF0;
	enemyWorking.directionFlags |= 0x01;
	enemyWorking.spriteType = cast(Actor)((enemyWorking.spriteType & 0xF0) + 2);
	enemyWorking.spriteAttributes = OAMFlags.xFlip;
}
void crawlerTurnLeft() {
	enemyWorking.directionFlags &= 0xF0;
	enemyWorking.directionFlags |= 0x02;
	enemyWorking.spriteType = cast(Actor)((enemyWorking.spriteType & 0xF0));
	enemyWorking.spriteAttributes = OAMFlags.yFlip;
}
void crawlerTurnUp() {
	enemyWorking.directionFlags &= 0xF0;
	enemyWorking.directionFlags |= 0x03;
	enemyWorking.spriteType = cast(Actor)((enemyWorking.spriteType & 0xF0) + 2);
	enemyWorking.spriteAttributes = OAMFlags.yFlip;
}

// AI for enemies that stick to a surface and move along it (counter-clockwise)
void enAICrawlerB() {
	switch (enemyWorking.directionFlags) {
		case 0: //right
			enCollisionUpCrawlB();
			if (enBGCollisionResult & 0b1000) {
				break; //concave
			}
			crawlerTurnUp();
			enemyWorking.spriteAttributes |= OAMFlags.xFlip;
			return;
		case 1: //down
			enCollisionRightCrawlB();
			if (enBGCollisionResult & 0b0001) {
				break; //concave
			}
			crawlerTurnRight();
			enemyWorking.spriteAttributes |= OAMFlags.yFlip;
			return;
		case 2: //left
			enCollisionDownCrawlB();
			if (enBGCollisionResult & 0b0010) {
				break; //concave
			}
			crawlerTurnDown();
			enemyWorking.spriteAttributes &= ~OAMFlags.xFlip;
			return;
		case 3: //up
		default:
			enCollisionLeftCrawlB();
			if (enBGCollisionResult & 0b0100) {
				break; //concave
			}
			crawlerTurnLeft();
			enemyWorking.spriteAttributes &= ~OAMFlags.yFlip;
			return;
	}
	enemyWorking.counter = 0xFF;
	static void moveAndAnimate() {
		crawlerMove();
		if (enemyFrameCounter & 1) {
			return;
		}
		enemyFlipSpriteIDNow();
	}
	switch (enemyWorking.directionFlags) {
		case 0: //right
			enCollisionRightCrawlB();
			if (!(enBGCollisionResult & 0b0001)) {
				return moveAndAnimate();
			}
			crawlerTurnDown();
			enemyWorking.spriteAttributes &= ~OAMFlags.xFlip;
			break;
		case 1: //down
			enCollisionDownCrawlB();
			if (!(enBGCollisionResult & 0b0010)) {
				return moveAndAnimate();
			}
			crawlerTurnLeft();
			enemyWorking.spriteAttributes &= ~OAMFlags.yFlip;
			break;
		case 2: //left
			enCollisionLeftCrawlB();
			if (!(enBGCollisionResult & 0b0100)) {
				return moveAndAnimate();
			}
			crawlerTurnUp();
			enemyWorking.spriteAttributes |= OAMFlags.xFlip;
			break;
		case 3: //up
		default:
			enCollisionUpCrawlB();
			if (!(enBGCollisionResult & 0b1000)) {
				return moveAndAnimate();
			}
			crawlerTurnRight();
			enemyWorking.spriteAttributes |= OAMFlags.yFlip;
			break;
	}
}

void skreekProjectileCode() {
	if (--enemyWorking.counter != 0) {
		if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
			enemyWorking.x -= 2;
		} else {
			enemyWorking.x += 2;
		}
	} else {
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 0xFF;
	}
}

void enAISkreek() {
	assert(0); // TODO
}

void enAISmallBug() {
	enemyFlipSpriteIDNow();
	if (++enemyWorking.counter == 0x40) {
		enemyWorking.counter = 0;
		enemyFlipHorizontalNow();
		return;
	}
	if (enemyWorking.spriteAttributes & OAMFlags.xFlip) {
		enemyWorking.x++;
	} else {
		enemyWorking.x--;
	}
}

void enAIDrivel() {
	assert(0); // TODO
}

void enAIDrivelSpit() {
	assert(0); // TODO
}

enum SenjooShirkState {
	downLeft,
	downRight,
	upRight,
	upLeft,
}

void enAISenjooShirk() {
	static void animate() {
		if (enemyFrameCounter & 1) {
			return;
		}
		if (enemyWorking.spriteType < Actor.shirk) {
			enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
		} else {
			enemyWorking.spriteType ^= Actor.shirk ^ Actor.shirk2;
		}
	}
	animate();
	auto distance = cast(byte)(enemyWorking.x - samusOnScreenXPos);
	if (distance < 0) {
		distance = cast(byte)-distance;
	}
	if (distance < 80) {
		final switch (cast(SenjooShirkState)enemyWorking.state) {
			case SenjooShirkState.downLeft:
				if (enemyWorking.counter == 16) {
					enemyWorking.counter = 0;
					enemyWorking.state = SenjooShirkState.downRight;
					break;
				}
				enemyWorking.counter++;
				enemyWorking.y += 2;
				enemyWorking.x -= 2;
				break;
			case SenjooShirkState.downRight:
				if (enemyWorking.counter == 16) {
					enemyWorking.counter = 0;
					enemyWorking.state = SenjooShirkState.upRight;
					break;
				}
				enemyWorking.counter++;
				enemyWorking.y += 2;
				enemyWorking.x += 2;
				break;
			case SenjooShirkState.upRight:
				if (enemyWorking.counter == 16) {
					enemyWorking.counter = 0;
					enemyWorking.state = SenjooShirkState.upLeft;
					break;
				}
				enemyWorking.counter++;
				enemyWorking.y -= 2;
				enemyWorking.x += 2;
				break;
			case SenjooShirkState.upLeft:
				if (enemyWorking.counter == 16) {
					enemyWorking.counter = 0;
					enemyWorking.state = SenjooShirkState.downLeft;
					break;
				}
				enemyWorking.counter++;
				enemyWorking.y -= 2;
				enemyWorking.x -= 2;
				break;
		}
	} else {
		if (!(enemyFrameCounter & 1)) {
			if (enemyWorking.misc != 12) {
				if (enemyWorking.misc < 8) {
					enemyWorking.misc++;
					enemyWorking.y += 2;
				} else {
					enemyWorking.misc++;
					enemyWorking.y -= 4;
				}
			} else {
				if (!(enemyFrameCounter & 3)) {
					enemyWorking.misc = 0;
				}
			}
		}
	}
}

void enAIGullugg() {
	static immutable ubyte[][2] ySpeedTable = [
	    [ // not used
	        0x01, 0x00, 0x01, 0x02, 0x01, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x03, 0x04,
	        0x04, 0x04, 0x03, 0x03, 0x04, 0x03, 0x02, 0x03, 0x02, 0x01, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00,
	        0xFF, 0xFE, 0xFF, 0xFE, 0xFD, 0xFE, 0xFD, 0xFC, 0xFD, 0xFD, 0xFC, 0xFC, 0xFC, 0xFD, 0xFC, 0xFC,
	        0xFD, 0xFC, 0xFD, 0xFD, 0xFE, 0xFD, 0xFE, 0xFF, 0xFE, 0xFF, 0x00, 0xFF, 0x80,
	    ], [
	        0x01, 0x00, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x03, 0x03, 0x03, 0x03, 0x02, 0x03,
	        0x03, 0x03, 0x03, 0x02, 0x03, 0x02, 0x02, 0x02, 0x02, 0x01, 0x01, 0x01, 0x00, 0x00, 0x00, 0x00,
	        0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFD, 0xFE, 0xFD, 0xFD, 0xFD, 0xFD, 0xFE, 0xFD, 0xFD,
	        0xFD, 0xFD, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0x00, 0xFF, 0x80,
	    ]
	];
	static immutable ubyte[][2] xSpeedTable = [
	    [ // not used
	        0xFD, 0xFC, 0xFC, 0xFD, 0xFC, 0xFD, 0xFD, 0xFE, 0xFD, 0xFE, 0xFF, 0xFE, 0xFF, 0x00, 0xFF, 0x01,
	        0x00, 0x01, 0x02, 0x01, 0x02, 0x03, 0x02, 0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x03, 0x04, 0x04,
	        0x04, 0x03, 0x03, 0x04, 0x03, 0x02, 0x03, 0x02, 0x01, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0xFF,
	        0xFE, 0xFF, 0xFE, 0xFD, 0xFE, 0xFD, 0xFC, 0xFD, 0xFD, 0xFC, 0xFC, 0xFC,
	    ], [
	        0x02, 0x03, 0x03, 0x03, 0x03, 0x02, 0x02, 0x02, 0x02, 0x02, 0x01, 0x01, 0x01, 0x00, 0x01, 0xFF,
	        0x00, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFD, 0xFD, 0xFD, 0xFD, 0xFE, 0xFD, 0xFD,
	        0xFD, 0xFD, 0xFE, 0xFD, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x01,
	        0x01, 0x01, 0x02, 0x02, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x03, 0x03,
	    ]
	];
	static void animate() {
		if (enemyWorking.spriteType < Actor.gullugg3) {
			enemyWorking.spriteType++;
		} else {
			enemyWorking.spriteType = Actor.gullugg;
		}
	}
	animate();
	ubyte y;
	while (true) {
		y = ySpeedTable[1][enemyWorking.counter];
		if (y != 0x80) {
			break;
		}
		enemyWorking.counter = 0;
	}
	enemyWorking.y += y;
	enemyWorking.x += xSpeedTable[1][enemyWorking.counter];
	enemyWorking.counter++;
}

enum ChuteLeechState {
	resting = 0,
	ascending = 1,
	descending = 2,
}
void enAIChuteLeech() {
	static immutable ubyte[] xSpeedTable = [
	    0xFF, 0xFF, 0xFE, 0xFE, 0xFF, 0xFF, 0x02, 0x02, 0x02, 0x02, 0x03, 0x03, 0x02, 0x04, 0x02, 0x02,
	    0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFD, 0xFC, 0xFD, 0xFD, 0xFE, 0x02,
	    0x03, 0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x04, 0x03, 0x04,
	    0x03, 0x02, 0xFE, 0xFD, 0xFD, 0xFD, 0xFD, 0xFC, 0xFC, 0xFC, 0xFC, 0xFD, 0xFB, 0xFD, 0xFC, 0xFB,
	    0xFC, 0xFC, 0xFD, 0xFD, 0x03, 0x03, 0x03, 0x02, 0x04, 0x03, 0x03, 0x03, 0x04, 0x02, 0x02, 0x80,
	];
	static immutable ubyte[] ySpeedTable = [
	    0x02, 0x02, 0x02, 0x01, 0x01, 0x00, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x00, 0x00,
	    0x02, 0x02, 0x01, 0x02, 0x01, 0x02, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x02,
	    0x01, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01,
	    0x00, 0x00, 0x02, 0x03, 0x02, 0x02, 0x01, 0x02, 0x02, 0x01, 0x01, 0x02, 0x02, 0x01, 0x01, 0x00,
	    0x01, 0x01, 0x00, 0x00, 0x03, 0x02, 0x02, 0x01, 0x02, 0x02, 0x01, 0x01, 0x01, 0x01, 0x00,
	];
	final switch (cast(ChuteLeechState)enemyWorking.state) {
		case ChuteLeechState.ascending:
			if (enemyWorking.spriteType >= Actor.octroll1) {
				enemyFlipSpriteIDTwoFrame();
			}
			if (enemyWorking.counter == 22) { //peak of ascent
				enemyWorking.counter = 0;
				enemyWorking.state = ChuteLeechState.descending;
				if (enemyWorking.spriteType < Actor.octroll1) {
					enemyWorking.spriteType = Actor.chuteLeech3;
				} else {
					enemyWorking.spriteType = Actor.octroll;
				}
			} else {
				enemyWorking.y -= 4;
				enemyWorking.counter++;
			}
			break;
		case ChuteLeechState.descending:
			if (xSpeedTable[enemyWorking.counter] == 0x80) {
				enemyWorking.counter = 0;
				enemyWorking.state = ChuteLeechState.resting;
				if (enemyWorking.spriteType < Actor.octroll1) {
					enemyWorking.spriteType = Actor.chuteLeech;
				}
			} else {
				if (enemyWorking.spriteAttributes == 0) {
					if (!(xSpeedTable[enemyWorking.counter] & 0x80)) {
						if (++enemyWorking.misc == 4) {
							enemyWorking.misc = 0;
							enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
						}
					}
				} else {
					if (xSpeedTable[enemyWorking.counter] & 0x80) {
						if (++enemyWorking.misc == 4) {
							enemyWorking.misc = 0;
							enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
						}
					}
				}
				enemyWorking.x += xSpeedTable[enemyWorking.counter];
				enemyWorking.y += ySpeedTable[enemyWorking.counter];
				enemyWorking.counter++;
			}
			break;
		case ChuteLeechState.resting:
			auto distance = cast(byte)(enemyWorking.x - samusOnScreenXPos);
			if (distance < 0) {
				distance = cast(byte)-distance;
			}
			if (distance >= 80) { //don't activate until samus is near
				return;
			}
			enemyWorking.state = ChuteLeechState.ascending;
			enemyWorking.spriteAttributes = 0;
			if (enemyWorking.spriteType < Actor.octroll1) {
				enemyWorking.spriteType = Actor.chuteLeech2;
			} else {
				enemyWorking.spriteType = Actor.octroll1;
			}
			break;
	}
}

enum PipeBugState {
	waiting = 0,
	rising = 1,
	movingForward = 2,
}

void enAIPipeBug() {
	static void animate() {
		if (enemyWorking.spriteType < Actor.yumee1) {
			enemyWorking.spriteType ^= 0xF;
		} else {
			enemyWorking.spriteType ^= 0x1;
		}
	}
	if (enemyWorking.spawnFlag == 3) { // bug spawned
		return;
	}
	if (enemyWorking.spawnFlag != 1) { // I am bug
		animate();
		final switch (cast(PipeBugState)enemyWorking.state) {
			case PipeBugState.waiting:
				ubyte bugDirection = 2;
				auto distance = cast(byte)(enemyWorking.x - samusOnScreenXPos);
				if (distance < 0) {
					distance = cast(byte)-distance;
					bugDirection = 0;
				}
				if (distance >= 0x50) {
					return;
				}
				enemyWorking.directionFlags = bugDirection;
				if (bugDirection) {
					enemyWorking.spriteAttributes = 0;
				} else {
					enemyWorking.spriteAttributes = OAMFlags.xFlip;
				}
				enemyWorking.state = PipeBugState.rising;
				goto case;
			case PipeBugState.rising:
				enemyWorking.y -= 4;
				if (samusOnScreenYPos + 5 < enemyWorking.y) {
					return; // not aligned with samus vertically yet
				}
				enemyWorking.state = PipeBugState.movingForward;
				if (enemyWorking.spriteType >= Actor.yumee1) {
					enemyWorking.spriteType = Actor.yumee3;
				}
				break;
			case PipeBugState.movingForward:
				if (enemyWorking.x < 168) {
					if (enemyWorking.directionFlags) {
						enemyWorking.x -= 2;
						enemyAccelBackwards(enemyWorking.x);
					} else {
						enemyWorking.x += 2;
						enemyAccelForwards(enemyWorking.x);
					}
				} else {
					if (enemyDataSlots[enemyWorking.spawnFlag >> 4].status == 3) {
						enemyDataSlots[enemyWorking.spawnFlag >> 4].status = 1; //reactivate parent
						enemySpawnFlags[enemyWorking.spawnNumber] = 1;
					}
					enemyDeleteSelf();
					enemyWorking.spawnFlag = 0xFF;
				}
				break;
		}
	} else { // I am pipe, no bug spawned
		if (++enemyWorking.counter < 24) {
			return;
		}
		enemyWorking.counter = 0;
		if (enemyWorking.misc >= 10) {
			enemyDeleteSelf();
			sfxRequestSquare1 = Square1SFX.u14;
			enemyWorking.spawnFlag = 2;
		}
		enemyWorking.misc++;
		const slot = loadEnemyGetFirstEmptySlot();
		enemyDataSlots[slot].status = 0;
		enemyDataSlots[slot].y = enemyWorking.y;
		enemyDataSlots[slot].x = enemyWorking.x;
		if (enemyWorking.spriteType < Actor.yumeeSpawner) {
			enemyDataSlots[slot].spriteType = Actor.gawron;
		} else {
			enemyDataSlots[slot].spriteType = Actor.yumee1;
		}
		enemyDataSlots[slot].baseSpriteAttributes = 0x80;
		enemyDataSlots[slot].spriteAttributes = 0;
		enemyDataSlots[slot].stunCounter = 0;
		enemyDataSlots[slot].misc = 0;
		enemyDataSlots[slot].directionFlags = 0;
		enemyDataSlots[slot].counter = 0;
		enemyDataSlots[slot].state = 0;
		enemyDataSlots[slot].iceCounter = 0;
		enemyDataSlots[slot].health = 1;
		enemyDataSlots[slot].dropType = 0;
		enemyDataSlots[slot].explosionFlag = 0;
		enemyDataSlots[slot].yScreen = 0;
		enemyDataSlots[slot].xScreen = 0;
		enemyDataSlots[slot].maxHealth = enemyDataSlots[slot].health;
		enemyDataSlots[slot].spawnFlag = cast(ubyte)((enemyWRAMAddr - &enemyDataSlots[0]) / EnemySlot.sizeof);
		enemyTempSpawnFlag = enemyDataSlots[slot].spawnFlag;
		enemyDataSlots[slot].spawnNumber = enemyWorking.spriteType & 1;
		enemyDataSlots[slot].ai = &enAIPipeBug;
		enemySpawnFlags[enemyDataSlots[slot].spawnNumber] = enemyTempSpawnFlag;
		numEnemies.total++;
		numEnemies.active++;
		enemyWorking.spawnFlag = 3;
	}
}

void enAISkorpVert() {
	assert(0); // TODO
}

void enAISkorpHori() {
	assert(0); // TODO
}

void enAIAutrack() {
	assert(0); // TODO
}


enum HopperState {
	jumping = 0,
	falling = 1,
	attemptTurnAround = 2,
}
void enAIHopper() {
	static immutable ubyte[] jumpYSpeedTable = [0x04, 0x03, 0x04, 0x03, 0x03, 0x02, 0x03, 0x02, 0x02, 0x02, 0x01, 0x01, 0x01, 0x01, 0x00, 0x00];
	static immutable ubyte[] jumpXSpeedTable = [0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01];
	final switch (cast(HopperState)enemyWorking.state) {
		case HopperState.falling:
			if (enemyWorking.counter == 16) { // fall speed maxed out
				enCollisionDownMidMedium();
				if (enBGCollisionResult & 2) { // found ground, start jumping again
					enemyWorking.counter = 0;
					enemyWorking.state = HopperState.jumping;
					if (++enemyWorking.misc == 3) {
						enemyFlipHorizontalNow();
						enemyWorking.misc = 0;
					}
					return;
				} else { // no collision, keep falling
					enemyWorking.counter = 15;
				}
			}
			enemyWorking.y += jumpYSpeedTable[$ - 1 - enemyWorking.counter];
			enCollisionDownMidMedium();
			if (enBGCollisionResult & 2) { // found ground, start jumping again
				enemyWorking.counter = 0;
				enemyWorking.state = HopperState.jumping;
				if (++enemyWorking.misc == 3) {
					enemyFlipHorizontalNow();
					enemyWorking.misc = 0;
				}
			} else { // no ground, keep falling
				if (enemyWorking.spriteAttributes) { // falling to the right
					enemyWorking.x += jumpXSpeedTable[$ - 1 - enemyWorking.counter];
				} else { // falling to the left
					enemyWorking.x -= jumpXSpeedTable[$ - 1 - enemyWorking.counter];
				}
				enemyWorking.counter++;
			}
			break;
		case HopperState.attemptTurnAround:
			if (enemyWorking.x < 200) {
				enemyFlipHorizontalNow();
			}
			enemyWorking.state = HopperState.jumping;
			break;
		case HopperState.jumping:
			if (enemyWorking.counter != 16) {
				enemyWorking.y -= jumpYSpeedTable[enemyWorking.counter];
				if (enemyWorking.spriteAttributes) {
					enemyWorking.x += jumpXSpeedTable[enemyWorking.counter];
				} else {
					enemyWorking.x -= jumpXSpeedTable[enemyWorking.counter];
				}
				if ((++enemyWorking.counter == 5) && (++enemyWorking.spriteType == Actor.autoad2)) {
					sfxRequestNoise = NoiseSFX.u1A;
				}
			} else {
				enemyWorking.counter = 0;
				enemyWorking.state = HopperState.falling;
				enemyWorking.spriteType--;
			}
			break;
	}
}

void enAIWallfire() {
	static immutable fireballHeader = ShortEnemyHeader(0, 0, 0, 0, 0, 0, 254, 1, &enAIWallfire);
	if (enemyWorking.spriteType == Actor.wallfireFlipped) {
		enemyWorking.spriteType = Actor.wallfire;
	}
	enemyGetSamusCollisionResults();
	if (enemyWorking.spawnFlag == 6) {
		if (enemyWorking.spriteType >= Actor.wallfireShot3) {
			if (enemyWorking.spriteType != Actor.wallfireShot4) {
				enemyWorking.spriteType++;
			} else {
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 0xFF;
			}
			return;
		}
		enemyFlipSpriteIDTwoFrame();
		static void startExploding() {
			enemyWorking.spriteType = Actor.wallfireShot3;
			sfxRequestNoise = NoiseSFX.u03;
		}
		if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
			enemyWorking.x += 4;
			enCollisionRightNearSmall();
			if (enBGCollisionResult & 0b0001) {
				return startExploding();
			}
		} else {
			enemyWorking.x -= 4;
			enCollisionLeftNearSmall();
			if (enBGCollisionResult & 0b0100) {
				return startExploding();
			}
		}
		return;
	}
	if (enemyWorking.spriteType == Actor.wallfireDead) {
		return;
	}
	if (enemyWeaponType >= CollisionType.contact) {
		if (enemyWorking.spriteType == Actor.wallfire2) {
			if (++enemyWorking.counter != 8) {
				return;
			}
			enemyWorking.counter = 0;
			enemyWorking.spriteType = Actor.wallfire;
			return;
		}
		if (++enemyWorking.counter != 80) {
			return;
		}
		enemyWorking.counter = 0;
		const newSlot = loadEnemyGetFirstEmptySlot();
		enemyDataSlots[newSlot].status = 0;
		enemyDataSlots[newSlot].y = cast(ubyte)(enemyWorking.y - 4);
		enemyDataSlots[newSlot].x = cast(ubyte)(enemyWorking.x + (enemyWorking.spriteAttributes & OAMFlags.xFlip) ? -8 : 8);
		enemyDataSlots[newSlot].spriteType = Actor.wallfireShot1;
		enemyDataSlots[newSlot].baseSpriteAttributes = 0;
		enemyDataSlots[newSlot].spriteAttributes = enemyWorking.spriteAttributes;
		enemyTempSpawnFlag = 6;
		enemySpawnObjectShortHeader(&fireballHeader, &enemyDataSlots[newSlot]);
		enemyWorking.spriteType = Actor.wallfire2;
		sfxRequestNoise = NoiseSFX.u12;
		return;
	}
	enemyWorking.spriteType = Actor.wallfireDead;
	sfxRequestSquare1 = Square1SFX.clear;
	sfxRequestNoise = NoiseSFX.u02;
}

void enAIGunzoo() {
	assert(0); // TODO
}

void enAIAutom() {
	assert(0); // TODO
}

void enAIProboscum() {
	assert(0); // TODO
}

void enAIMissileBlock() {
	assert(0); // TODO
}

void enAIMoto() {
	assert(0); // TODO
}

void enAIHalzyn() {
	assert(0); // TODO
}

void enAISeptogg() {
	enemyFlipSpriteID2BitsTwoFrame();
	enemyGetSamusCollisionResults();
	if ((enemyWeaponType != CollisionType.contact) || !samusOnSolidSprite) {
		if (!enemyWorking.counter16) {
			return;
		}
		enemyWorking.y--;
		enemyWorking.counter16--;
	} else {
		enemyWorking.y += 3;
		enCollisionDownFarMedium();
		if (enBGCollisionResult & 0b0010) {
			enemyWorking.y = enemyYPosMirror;
		} else {
			enemyWorking.counter16 += 3;
		}
		samusOnScreenYPos += 3;
		samusY += 3;
	}
}

void enAIFlittVanishing() {
	assert(0); // TODO
}

void enAIFlittMoving() {
	assert(0); // TODO
}

void enAIGravitt() {
	assert(0); // TODO
}

void enAIMissileDoor() {
	enemyGetSamusCollisionResults();
	if (enemyWorking.spriteType != Actor.missileDoor) {
		if (enemyWorking.spriteType == Actor.screwExplosionEnd) {
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 2;
		} else {
			enemyWorking.spriteType++;
		}
		return;
	}
	if (enemyWeaponType >= CollisionType.contact) {
		return;
	}
	sfxRequestSquare1 = Square1SFX.beamDink;
	if (enemyWeaponType != CollisionType.missiles) {
		return;
	}
	sfxRequestSquare1 = Square1SFX.clear;
	sfxRequestNoise = NoiseSFX.u08;
	enemyWorking.stunCounter = 19;
	if (++enemyWorking.counter != 5) {
		return;
	}
	enemyWorking.counter = 0;
	enemyWorking.stunCounter = 0;
	enemyWorking.spriteType = Actor.screwExplosionStart;
	sfxRequestSquare1 = Square1SFX.u10;
	if (enemyWeaponDir & 2) {
		enemyWorking.x += 24;
	} else {
		enemyWorking.x -= 24;
	}
}

void enemyAccelForwards(ref ubyte pos) {
	static immutable ubyte[] speedTable = [
	    0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x01, 0x02, 0x01, 0x02, 0x01, 0x02, 0x02, 0x03, 0x02,
	    0x03, 0x03, 0x04, 0x03, 0x04, 0x04, 0x03, 0x04,
	];
	if (enemyWorking.misc != 23) {
		enemyWorking.misc++;
	}
	pos += speedTable[enemyWorking.misc];
}

void enemyAccelBackwards(ref ubyte pos) {
	static immutable ubyte[] speedTable = [
		0x00, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0xFF, 0xFF, 0xFE, 0xFF, 0xFE, 0xFF, 0xFE, 0xFE, 0xFD, 0xFE,
		0xFD, 0xFD, 0xFC, 0xFD, 0xFC, 0xFC, 0xFD, 0xFC,
	];
	if (enemyWorking.misc != 23) {
		enemyWorking.misc++;
	}
	pos += speedTable[enemyWorking.misc];
}

void unknownProc6AE1() {
	assert(0); // TODO
}

void enemyCreateLinkForChildObject() {
	assert(0); // TODO
}

void enemyFlipSpriteIDFourFrame() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyFlipSpriteIDNow();
}
void enemyFlipSpriteIDTwoFrame() {
	if (enemyFrameCounter & 3) {
		return;
	}
	enemyFlipSpriteIDNow();
}
void enemyFlipSpriteIDNow() {
	enemyWorking.spriteType ^= 1;
}

void enemyFlipSpriteID2BitsFourFrame() {
	if (enemyFrameCounter & 3) {
		return;
	}
	enemyFlipSpriteID2BitsNow();
}
void enemyFlipSpriteID2BitsTwoFrame() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyFlipSpriteID2BitsNow();
}
void enemyFlipSpriteID2BitsNow() {
	enemyWorking.spriteType ^= 3;
}

void enemyFlipHorizontalTwoFrame() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyFlipHorizontalNow();
}
void enemyFlipHorizontalFourFrame() {
	if (enemyFrameCounter & 3) {
		return;
	}
	enemyFlipHorizontalNow();
}
void enemyFlipHorizontalNow() {
	enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
}

void enemyFlipVertical() {
	assert(0); // TODO
}

void enAIMetroidStinger() {
	if (++enemyWorking.counter != 138) {
		if (enemyWorking.counter == 1) { // stuff only happens on frame 0
			metroidCountDisplayed += 8;
			metroidCountShuffleTimer = 202;
			songRequest = Song.metroidHiveWithIntro;
			cutsceneActive = 1;
		}
	} else { // after 138 frames, clean up
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 2;
		cutsceneActive = 0;
	}
}

void enAIHatchingAlpha() {
	enemyGetSamusCollisionResults();
	if (alphaStunCounter) {
		if (--alphaStunCounter != 0) {
			metroidMissileKnockback();
			enemyToggleVisibility();
			if (enemyWeaponType >= CollisionType.screwAttack) {
				return;
			}
			sfxRequestSquare1 = Square1SFX.beamDink;
			return;
		} else {
			enemyWorking.status = 0;
			enemyWorking.directionFlags = 0xFF;
			enemyWorking.spriteType = Actor.alpha1;
		}
	}
	if (metroidState == 2) {
		enAIAlphaMetroidCheckIfHurt();
		return;
	}
	if (enemyWorking.spawnFlag == 4) {
		enAIAlphaMetroidCheckIfInRange();
		return;
	}
	// c = spawnflag
	if (metroidState == 1) {
		enAIAlphaMetroidStartFight();
		return;
	}
	if (enemyWorking.spriteType == Actor.alphaFace) {
		enAIAlphaMetroidAppearanceRise();
		return;
	}
	if (!cutsceneActive) {
		if (enemyFrameCounter & 3) {
			return;
		}
		enemyWorking.stunCounter ^= 0x10;
		byte distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
		if (distance < 0) {
			distance = cast(byte)-distance;
		}
		if (distance >= 0x50) {
			return;
		}
		cutsceneActive = 1;
		metroidFightActive = 1;
		if (songPlaying == Song.metroidBattle) {
			return;
		}
		songRequest = Song.metroidBattle;
	} else {
		if (enemyFrameCounter & 3) {
			return;
		}
		if (++enemyWorking.counter == 8) {
			enAIAlphaMetroidAppearanceFaceScreen();
		} else {
			enemyWorking.stunCounter ^= 0x10;
		}
	}
}

void enAIAlphaMetroid() {
	if (metroidFightActive) {
		enAIHatchingAlpha();
	} else {
		enemyWorking.spawnFlag = 4;
		enAIAlphaMetroidCheckIfInRange();
	}
}

void enAIAlphaMetroidCheckIfInRange() {
	enemyWorking.spriteType = Actor.alpha1;
	byte distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
	if (distance < 0) {
		distance = cast(byte)-distance;
	}
	if (distance >= 0x50) {
		return;
	}
	alphaStunCounter = 0;
	metroidFightActive = 1;
	metroidState = 2;
	if (songPlaying == Song.metroidBattle) {
		return;
	}
	songRequest = Song.metroidBattle;
	enAIAlphaMetroidStandardAction();
}

void enAIAlphaMetroidCheckIfHurt() {
	if (enemyWeaponType >= CollisionType.contact) {
		enAIAlphaMetroidStandardAction();
	} else if (enemyWeaponType == CollisionType.screwAttack) {
		enAIAlphaMetroidScrewReaction();
	} else if (enemyWeaponType == CollisionType.missiles) {
		enAIAlphaMetroidHurtReaction();
	} else {
		sfxRequestSquare1 = Square1SFX.beamDink;
	}
}
void enAIAlphaMetroidStandardAction() {
	if (enemyWorking.directionFlags != 0xFF) {
		metroidScrewKnockback();
		if (!metroidScrewKnockbackDone) {
			return;
		}
		metroidScrewKnockbackDone = 0;
		enemyWorking.directionFlags = 0xFF;
		enemyWorking.spriteType = Actor.alpha1;
		enemyWorking.counter = 0;
		enemyWorking.state = 0;
		return;
	}
	if (enemyWorking.counter == 0) {
		alphaGetAngle();
		if (samusOnScreenXPos >= (enemyWorking.x + 16)) {
			enemyWorking.spriteAttributes = OAMFlags.xFlip;
		} else {
			enemyWorking.spriteAttributes = 0;
		}
	}
	if (++enemyWorking.counter >= 14) {
		if (enemyWorking.counter != 20) {
			return;
		}
		enemyWorking.counter = 0;
	}
	enAIAlphaMetroidLungeMovement(alphaGetSpeedVector());
	enAIAlphaMetroidAnimate();
}

void enAIAlphaMetroidScrewReaction() {
	metroidScrewReaction();
	sfxRequestSquare1 = Square1SFX.u1A;
}

void enAIAlphaMetroidHurtReaction() {
	if (--enemyWorking.health == 0) {
		enAIAlphaMetroidDeath();
		return;
	}
	alphaStunCounter = 8;
	sfxRequestNoise = NoiseSFX.u05;
	enemyWorking.directionFlags = 0;
	static void knockbackRandHorizontal(ref ubyte dir) {
		if (gb.DIV & 1) {
			dir |= 0b0001;
		} else {
			dir |= 0b0100;
		}
	}
	static void knockbackRandVertical(ref ubyte dir) {
		if (gb.DIV & 1) {
			dir |= 0b0010;
		} else {
			dir |= 0b1000;
		}
	}
	if (enemyWeaponDir & 0b0001) { //right
		enemyWorking.directionFlags |= 0b0001;
		enemyWorking.x += 5;
		knockbackRandVertical(enemyWorking.directionFlags);
	} else if (enemyWeaponDir & 0b1000) { //down
		enemyWorking.directionFlags |= 0b0010;
		enemyWorking.y += 5;
		knockbackRandHorizontal(enemyWorking.directionFlags);
	} else if (enemyWeaponDir & 0b0010) { //left
		if (enemyWorking.x - 5 >= 8) {
			enemyWorking.x -= 5;
			enemyWorking.directionFlags |= 0b0100;
		}
		knockbackRandVertical(enemyWorking.directionFlags);
	} else { //up
		if (enemyWorking.y - 5 >= 16) {
			enemyWorking.y -= 5;
			enemyWorking.directionFlags |= 0b1000;
		}
		knockbackRandHorizontal(enemyWorking.directionFlags);
	}
}
void enAIAlphaMetroidDeath() {
	enemyWorking.counter = 0;
	enemyWorking.state = 0;
	metroidState = 0x80;
	enemyWorking.spriteType = Actor.screwExplosionStart;
	sfxRequestNoise = NoiseSFX.u0D;
	songRequest = Song.killedMetroid;
	metroidFightActive = 2;
	enemyWorking.spawnFlag = 2;
	metroidCountReal--;
	metroidCountDisplayed--;
	metroidCountShuffleTimer = 192;
	earthquakeCheck();
}
void enAIAlphaMetroidStartFight() {
	enemyWorking.spriteType = Actor.alpha1;
	enemyWorking.spawnFlag = 4;
	cutsceneActive = 0;
	metroidState = 2;
}
void enAIAlphaMetroidAppearanceFaceScreen() {
	enemyWorking.counter = 0;
	enemyWorking.stunCounter = 0;
	enemyWorking.spriteType = Actor.alphaFace;
}
void enAIAlphaMetroidAppearanceRise() {
	enAIZetaMetroidOscillateNarrow();
	if (enemyFrameCounter & 7) {
		return;
	}
	enemyWorking.y -= 2;
	if (++enemyWorking.counter != 13) {
		return;
	}
	enemyWorking.counter = 0;
	metroidState = 1;
}
void enAIAlphaMetroidLungeMovement(ushort vector) {
	const ubyte x = vector & 0xFF;
	const ubyte y = vector >> 8;
	if (y != 0) {
		if (y & 0x80) {
			enemyWorking.y -= y & 0x7F;
			enCollisionUpFarWide();
			if (enBGCollisionResult & 0b1000) {
				enemyWorking.y = enemyYPosMirror;
			}
		} else {
			enemyWorking.y += y;
			enCollisionDownFarWide();
			if (enBGCollisionResult & 0b0010) {
				enemyWorking.y = enemyYPosMirror;
			}
		}
	}
	if (x == 0) {
		return;
	}
	if (x & 0x80) {
		enemyWorking.x -= x & 0x7F;
		enCollisionLeftFarWide();
		if (enBGCollisionResult & 0b0100) {
			enemyWorking.x = enemyXPosMirror;
		}
	} else {
		enemyWorking.x += x;
		enCollisionRightFarWide();
		if (enBGCollisionResult & 0b0001) {
			enemyWorking.x = enemyXPosMirror;
		}
	}
}
void enAIAlphaMetroidAnimate() {
	enemyWorking.spriteType ^= 7;
}

void metroidScrewReaction() {
	ubyte d;
	ubyte e;
	byte distanceY = cast(byte)(samusOnScreenYPos - enemyWorking.y);
	if (distanceY < 0) {
		distanceY = cast(byte)-distanceY;
		e++;
	}
	byte distanceX = cast(byte)(samusOnScreenXPos - enemyWorking.x);
	if (distanceX < 0) {
		distanceX = cast(byte)-distanceX;
		d++;
	}
	ubyte dir;
	if (distanceX < distanceY) {
		if (e) {
			dir = 1;
		} else {
			dir = 3;
		}
	} else {
		if (d) {
			dir = 2;
		} else {
			dir = 0;
		}
	}
	enemyWorking.directionFlags = dir;
	enemyWorking.counter = 0;
	enemyWorking.state = 0;
	metroidScrewKnockback();
}

void metroidScrewKnockback() {
	if (++enemyWorking.counter == 6) {
		metroidScrewKnockbackDone = 1;
		return;
	}
	switch (enemyWorking.directionFlags) {
		case 0:
			enemyWorking.x += 5;
			enCollisionRightFarWide();
			if (enBGCollisionResult & 0b0001) {
				enemyWorking.x = enemyXPosMirror;
			}
			break;
		case 2:
			if (enemyWorking.x - 5 < 16) {
				return;
			}
			enemyWorking.x -= 5;
			enCollisionLeftFarWide();
			if (enBGCollisionResult & 0b0100) {
				enemyWorking.x = enemyXPosMirror;
			}
			break;
		case 1:
			enemyWorking.y += 5;
			enCollisionDownFarWide();
			if (enBGCollisionResult & 0b0010) {
				enemyWorking.y = enemyYPosMirror;
			}
			break;
		default:
		case 3:
			if (enemyWorking.y - 5 < 16) {
				return;
			}
			enemyWorking.y -= 5;
			enCollisionUpFarWide();
			if (enBGCollisionResult & 0b1000) {
				enemyWorking.y = enemyYPosMirror;
			}
			break;
	}
}

void metroidMissileKnockback() {
	static void moveBack(ref ubyte pos) {
		if (pos - 4 >= 16) {
			pos -= 4;
		}
	}
	static void moveForwards(ref ubyte pos) {
		pos += 4;
	}
	if (!(enemyWorking.directionFlags & 0b0010)) {
		if (enemyWorking.directionFlags & 0b1000) {
			moveBack(enemyWorking.y);
			enCollisionUpFarWide();
			if (enBGCollisionResult & 0b1000) { // collided, undo Y movement
				enemyWorking.y = enemyYPosMirror;
			}
		}
	} else {
		moveForwards(enemyWorking.y);
		enCollisionDownFarWide();
		if (enBGCollisionResult & 0b0010) { // collided, undo Y movement
			enemyWorking.y = enemyYPosMirror;
		}
	}
	if (!(enemyWorking.directionFlags & 0b0001)) {
		if (!(enemyWorking.directionFlags & 0b0100)) {
			return;
		}
		moveBack(enemyWorking.x);
		enCollisionLeftFarWide();
		if (enBGCollisionResult & 0b0100) { // collided, undo X movement
			enemyWorking.x = enemyXPosMirror;
		}
	} else {
		moveForwards(enemyWorking.x);
		enCollisionRightFarWide();
		if (enBGCollisionResult & 0b0001) { // collided, undo X movement
			enemyWorking.x= enemyXPosMirror;
		}
	}
}

void enAIGammaMetroid() {
	assert(0); // TODO
}

void enemySpawnObjectLongHeader(const(EnemyHeader)* header, EnemySlot* dest) {
	dest.spriteType = header.spriteType;
	dest.baseSpriteAttributes = header.baseSpriteAttributes;
	dest.spriteAttributes = header.spriteAttributes;
	dest.stunCounter = header.stunCounter;
	dest.misc = header.misc;
	dest.directionFlags = header.directionFlags;
	dest.counter = header.counter;
	dest.state = header.state;
	dest.iceCounter = header.iceCounter;
	dest.health = header.health;
	dest.dropType = 0;
	dest.explosionFlag = 0;
	dest.yScreen = 0;
	dest.xScreen = 0;
	dest.maxHealth = header.health;
	dest.spawnFlag = enemyTempSpawnFlag;
	dest.spawnNumber = header.spawnNumber;
	dest.ai = header.ai;
	enemySpawnFlags[dest.spawnNumber] = enemyTempSpawnFlag;
	numEnemies.total++;
	numEnemies.active++;
}
void enemySpawnObjectShortHeader(const(ShortEnemyHeader)* header, EnemySlot* dest) {
	dest.stunCounter = header.stunCounter;
	dest.misc = header.misc;
	dest.directionFlags = header.directionFlags;
	dest.counter = header.counter;
	dest.state = header.state;
	dest.iceCounter = header.iceCounter;
	dest.health = header.health;
	dest.dropType = 0;
	dest.explosionFlag = 0;
	dest.yScreen = 0;
	dest.xScreen = 0;
	dest.maxHealth = header.health;
	dest.spawnFlag = enemyTempSpawnFlag;
	dest.spawnNumber = header.spawnNumber;
	dest.ai = header.ai;
	enemySpawnFlags[dest.spawnNumber] = enemyTempSpawnFlag;
	numEnemies.total++;
	numEnemies.active++;
}

void enemyGetAddressOfParentObject() {
	assert(0); // TODO
}

void enAIZetaMetroid() {
	assert(0); // TODO
}

void enAIZetaMetroidOscillateNarrow() {
	if (enemyFrameCounter & 3) {
		return;
	}
	if ((enemyFrameCounter & 3) == 2) {
		enemyWorking.x -= 2;
	} else if ((enemyFrameCounter & 3) == 1) {
		enemyWorking.x += 2;
	}
}

void enAIOmegaMetroid() {
	assert(0); // TODO
}

void enAINormalMetroid() {
	assert(0); // TODO
}

void enAIBabyMetroid() {
	assert(0); // TODO
}

void metroidCorrectPosition() {
	assert(0); // TODO
}

void babyCheckBlocks() {
	assert(0); // TODO
}

void babyClearBlocks() {
	assert(0); // TODO
}

void enemyGetSamusCollisionResults() {
	enemyWeaponType = CollisionType.nothing;
	if (enSprCollision.enemy != enemyWRAMAddr) {
		return;
	}
	enemyWeaponType = enSprCollision.weaponType;
	enemyWeaponDir = enSprCollision.weaponDir;
	enSprCollision = EnSprCollision.init;
}

void enemyKeepOnscreen() {
	assert(0); // TODO
}

void babyKeepOnscreen() {
	assert(0); // TODO
}

void enemyToggleVisibility() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyWorking.status ^= 0x80;
}
