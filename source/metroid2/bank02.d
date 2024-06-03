module metroid2.bank02;

import metroid2.bank00;
import metroid2.bank01;
import metroid2.bank03;
import metroid2.bank08;
import metroid2.defs;
import metroid2.globals;
import metroid2.external;

import replatform64.gameboy;

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
			audio.songRequest = cast(Song)(currentRoomSong + Song.noIntroStart);
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
			if (!started) {
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
		audio.sfxRequestNoise = NoiseSFX.u02;
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
			audio.sfxRequestSquare1 = Square1SFX.beamDink;
			 return transferCollisionResults();
		} else if (collision.weaponType > CollisionType.screwAttack) {
			return transferCollisionResults();
		}
		if (collision.weaponType != 1) {
			if (enemyCheckDirectionalShields()) {
				return true;
			}
			if (enemyWorking.health >= 0xFE) {
				audio.sfxRequestSquare1 = Square1SFX.beamDink;
				return transferCollisionResults();
			}
			const overkill = enemyWorking.health < weaponDamageTable[collision.weaponType];
			enemyWorking.health -= weaponDamageTable[collision.weaponType];
			if ((enemyWorking.health == 0) || overkill) {
				return prepareDrop(0x10);
			}
			audio.sfxRequestNoise = NoiseSFX.u01;
			transferCollisionResults();
			enemyWorking.stunCounter = 17;
			return true;
		} else {
			if (enemyWorking.health == 0) {
				return prepareDrop(0x10);
			} else if (enemyWorking.health == 0xFF) {
				audio.sfxRequestSquare1 = Square1SFX.beamDink;
				return transferCollisionResults();
			} else if (enemyWorking.health == 0xFE) {
				audio.sfxRequestSquare1 = Square1SFX.beamDink;
			} else {
				if (enemyCheckDirectionalShields()) {
					return true;
				}
				enemyWorking.health--;
				if (enemyWorking.health) {
					enemyWorking.health--;
				}
				audio.sfxRequestNoise = NoiseSFX.u01;
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
			audio.sfxRequestSquare1 = Square1SFX.pickedUpSmallEnergyDrop;
			giveHealth(5);
			break;
		case 2:
			audio.sfxRequestSquare1 = Square1SFX.pickedUpLargeEnergyDrop;
			giveHealth(20);
			break;
		default:
			audio.sfxRequestSquare1 = Square1SFX.pickedUpMissileDrop;
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
		audio.sfxRequestSquare1 = Square1SFX.beamDink;
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
	if (enemyWorking.x < samusOnScreenXPos) {
		samusDirectionFromEnemy = 0;
	} else {
		samusDirectionFromEnemy = 2;
	}
}

void unusedSetXFlip() {
	if (enemyWorking.directionFlags != 0) {
		enemyWorking.spriteAttributes = 0;
	} else {
		enemyWorking.spriteAttributes = OAMFlags.xFlip;
	}
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
		audio.sfxRequestSquare1 = Square1SFX.nothing;
		audio.sfxRequestNoise = NoiseSFX.u02;
		enemyWorking.spriteType++;
		return;
	} else {
		if (enemyWeaponType != CollisionType.contact) {
			if (enemyWeaponType != CollisionType.screwAttack) {
				return;
			}
			audio.sfxRequestSquare1 = Square1SFX.clear;
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
bool getFacingDirection() {
	blobThrowerFacingDirection = 0;
	if (enemyWorking.x >= samusOnScreenXPos) {
		blobThrowerFacingDirection = 1;
	}
	return !!blobThrowerFacingDirection;
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

enum ArachnusState {
	initial,
	initialBounce1,
	initialBounce2,
	standing1,
	standing2,
	attacking,
	jumping,
	unused,
}

void enAIArachnus() {
	static immutable ubyte[] fullJumpSpeedTable = [
	//high
		0xFF, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFE, 0xFF, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF, 0x00, 0x00,
		0x00, 0x00, 0x01, 0x00, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
		0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03,
		0x00, 0x80,
	//mid
		0xFC, 0xFD, 0xFD, 0xFD, 0xFE, 0xFE, 0xFD, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFE, 0xFF, 0xFE, 0xFF,
		0xFF, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x01, 0x02, 0x01, 0x02, 0x02, 0x02, 0x02, 0x03,
		0x02, 0x02, 0x03, 0x03, 0x03, 0x04, 0x00, 0x80,
	//low
		0xFD, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0x00, 0xFF, 0x00, 0x00, 0x01, 0x00, 0x01,
		0x01, 0x00, 0x01, 0x01, 0x02, 0x02, 0x02, 0x03, 0x81,
	];
	static const(ubyte)[] jumpSpeedTableHigh() {
		return fullJumpSpeedTable;
	}
	static const(ubyte)[] jumpSpeedTableMid() {
		return fullJumpSpeedTable[50 .. $];
	}
	static const(ubyte)[] jumpSpeedTableLow() {
		return fullJumpSpeedTable[90 .. $];
	}
	static void fireballAI() {
		if (enemyWorking.misc == 0) {
			enemyWorking.x -= 3;
		} else {
			enemyWorking.x += 3;
		}
		if (!(frameCounter & 6)) {
			enemyWorking.spriteType ^= Actor.arachnusFireball ^ Actor.arachnusFireball2;
		}
	}
	static immutable fireballHeader = EnemyHeader(Actor.arachnusFireball, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, &fireballAI);
	static bool jump(const(ubyte)[] speedTable) {
		ubyte b = speedTable[arachnus.jumpCounter];
		if (b == 0x80) {
			b = 3;
			arachnus.jumpStatus = 0x80;
		} else if (b == 0x81) {
			b = 3;
			arachnus.jumpStatus = 0x81;
		} else {
			arachnus.jumpCounter++;
			arachnus.jumpStatus = 0;
		}
		enemyWorking.y += b;
		enCollisionDownMidMedium();
		if (!(enBGCollisionResult & 0b0010)) {
			return false;
		}
		if ((arachnus.jumpStatus != 0) && (arachnus.jumpStatus != 0x81)) {
			arachnus.jumpCounter++;
			return false;
		} else {
			return true;
		}
	}
	static void flipSpriteID() {
		if (frameCounter & 6) {
			return;
		}
		enemyWorking.spriteType ^= 1;
	}
	static void jumpAndAnimate(const(ubyte)[] speedTable) {
		if (!jump(speedTable)) {
			flipSpriteID();
		} else {
			arachnus.actionTimer = 4;
			enemyWorking.misc = ArachnusState.standing1;
		}
	}
	static void faceSamus() {
		if (getFacingDirection()) {
			enemyWorking.spriteAttributes = 0;
		} else {
			enemyWorking.spriteAttributes = OAMFlags.xFlip;
		}
	}
	static void shootFireball() {
		const slot = loadEnemyGetFirstEmptySlot();
		enemyDataSlots[slot].status = 0;
		enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y + 0xFD);
		if (enemyWorking.spriteAttributes == 0) {
			enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 24);
		} else {
			enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x + 24);
		}
		enemyCreateLinkForChildObject();
		enemySpawnObjectLongHeader(&fireballHeader, &enemyDataSlots[slot]);
		enemyDataSlots[slot].misc = enemyWorking.spriteAttributes;
		enemyWorking.spawnFlag = 3;
	}
	final switch (cast(ArachnusState)enemyWorking.misc) {
		case ArachnusState.initial:
			arachnus = arachnus.init;
			arachnus.health = 6;
			enemyWorking.health = 0xFF;
			enemyGetSamusCollisionResults();
			// do nothing until hit with a weapon
			if (enemyWeaponType == CollisionType.nothing) {
				return;
			}
			if (enemyWeaponType >= CollisionType.bombExplosion) {
				return;
			}
			enemyWorking.spriteType = Actor.arachnusRoll1;
			arachnus.unknownVar = 5;
			arachnus.jumpCounter = 0;
			arachnus.actionTimer = 32;
			enemyWorking.misc = ArachnusState.initialBounce1;
			break;
		case ArachnusState.initialBounce1:
			if (jump(jumpSpeedTableHigh)) {
				arachnus.unknownVar = 5;
				arachnus.jumpCounter = 0;
				arachnus.actionTimer = 32;
				enemyWorking.misc = ArachnusState.initialBounce2;
			}
			enemyWorking.x++;
			flipSpriteID();
			break;
		case ArachnusState.initialBounce2:
			jumpAndAnimate(jumpSpeedTableLow);
			break;
		case ArachnusState.standing1:
			if (arachnus.actionTimer != 0) {
				arachnus.actionTimer--;
				flipSpriteID();
			} else {
				faceSamus();
				enemyWorking.y -= 8;
				enemyWorking.spriteType = Actor.arachnusUpright1;
				arachnus.actionTimer = 4;
				enemyWorking.misc = ArachnusState.standing2;
			}
			break;
		case ArachnusState.standing2:
			if (arachnus.actionTimer != 0) {
				arachnus.actionTimer--;
			} else {
				enemyWorking.spriteType = Actor.arachnusUpright3;
				arachnus.actionTimer = 4;
				enemyWorking.misc = ArachnusState.attacking;
			}
			break;
		case ArachnusState.attacking:
			enemyGetSamusCollisionResults();
			if ((enemyWeaponType != CollisionType.nothing) && (enemyWeaponType == CollisionType.bombExplosion)) {
				audio.sfxRequestNoise = NoiseSFX.u05;
				enemyWorking.stunCounter = 17;
				if (--arachnus.health == 0) {
					audio.sfxRequestNoise = NoiseSFX.u0D;
					enemyWorking.health = 0xFF;
					enemyWorking.spriteType = Actor.springBall;
					enemyWorking.ai = &enAIItemOrb;
				}
			} else if (!(inputPressed & Pad.b)) {
				faceSamus();
				if (arachnus.actionTimer != 0) {
					arachnus.actionTimer--;
				} else {
					enemyWorking.spriteType = Actor.arachnusUpright3;
					if (enemyWorking.spawnFlag == 1) {
						shootFireball();
						enemyWorking.spriteType = Actor.arachnusUpright2;
						arachnus.actionTimer = 16;
					}
				}
			} else {
				enemyWorking.y -= 8;
				enemyWorking.spriteType = Actor.arachnusRoll1;
				arachnus.jumpCounter = 0;
				arachnus.actionTimer = 32;
				enemyWorking.misc = ArachnusState.jumping;
			}
			break;
		case ArachnusState.jumping:
			if (enemyWorking.spriteAttributes != 0) {
				enCollisionRightMidMedium();
				if (!(enBGCollisionResult & 0b0001)) {
					enemyWorking.x++;
				}
				jumpAndAnimate(jumpSpeedTableMid);
			} else {
				enCollisionLeftMidMedium();
				if (!(enBGCollisionResult & 0b0100)) {
					enemyWorking.x--;
				}
				jumpAndAnimate(jumpSpeedTableMid);
			}
			break;
		case ArachnusState.unused:
			break;
	}
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
	static void flip() {
		enemyWorking.spriteType = Actor.glowflyIdle1;
		enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
		enemyWorking.directionFlags ^= 1;
		enemyWorking.state = 0;
	}
	static void deadCode(ubyte* hl) {
		*hl = 0;
		enemyWorking.directionFlags ^= 1;
		enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
	}
	if (enemyWorking.state != 0) {
		enemyWorking.spriteType = Actor.glowflyMoving;
		if (enemyWorking.directionFlags == 0) {
			enemyWorking.x += 3;
		} else {
			enemyWorking.x -= 3;
		}
		if (enemyWorking.directionFlags != 0) {
			enCollisionLeftNearSmall();
			if (enBGCollisionResult & 0b0100) {
				flip();
			}
		} else {
			enCollisionRightNearSmall();
			if (enBGCollisionResult & 0b0001) {
				flip();
			}
		}
	} else if (++enemyWorking.counter == 80) {
		enemyWorking.spriteType = Actor.glowflyWindup;
		enemyWorking.counter = 0;
		enemyWorking.state = 1;
	} else if (enemyWorking.counter == 69) {
		enemyWorking.spriteType = Actor.glowflyWindup;
	} else {
		if (enemyFrameCounter & 7) {
			return;
		}
		if (enemyWorking.spriteType == Actor.glowflyIdle1) {
			enemyWorking.spriteType = Actor.glowflyIdle2;
		} else if (enemyWorking.spriteType == Actor.glowflyIdle2) {
			enemyWorking.spriteType = Actor.glowflyIdle1;
		} else {
			enemyWorking.spriteType = Actor.glowflyIdle1;
		}
	}
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
				if (enemyWorking.y < PPU.width) {
					return;
				}
			}
			audio.sfxRequestNoise = NoiseSFX.u11;
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
			audio.sfxRequestNoise = NoiseSFX.u02;
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

enum SkreekState {
	idle,
	jumping,
	waitingForProjectile,
	falling,
}

void enAISkreek() {
	immutable ubyte[] jumpSpeedTable = [
		0x00, 0x05, 0x05, 0x05, 0x04, 0x05, 0x03, 0x03, 0x02, 0x03, 0x03, 0x03, 0x02, 0x03, 0x03, 0x02,
		0x02, 0x03, 0x02, 0x02, 0x00, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00,
		0x00,
	];
	immutable projectileHeader = ShortEnemyHeader(0, 0, 0, 0x10, 0, 0, 0xFF, 0x07, &enAISkreek);
	static void animate() {
		if (enemyWorking.spawnFlag == 3) {
			return;
		}
		if (enemyFrameCounter & 3) {
			return;
		}
		if (enemyWorking.spriteType != Actor.skreek3) {
			enemyWorking.spriteType++;
		} else {
			enemyWorking.spriteType = Actor.skreek;
		}
	}
	if ((enemyWorking.spawnFlag & 0xF) == 0) { // I'm a projectile
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
	} else {
		animate();
		final switch (cast(SkreekState)enemyWorking.counter) {
			case SkreekState.idle:
				if (++enemyWorking.state != 16) {
					return;
				}
				enemyWorking.state = 0;
				ubyte attr = 0;
				byte distance = cast(byte)(enemyWorking.x - samusOnScreenXPos);
				if (distance < 0) {
					distance = cast(byte)-distance;
					attr = OAMFlags.xFlip;
				}
				if (distance >= 48) {
					return;
				}
				enemyWorking.spriteAttributes = attr;
				enemyWorking.counter = SkreekState.jumping;
				break;
			case SkreekState.jumping:
				if (enemyWorking.state != 33) {
					enemyWorking.y -= jumpSpeedTable[enemyWorking.state];
					enemyWorking.state++;
				} else {
					enemyWorking.counter = SkreekState.waitingForProjectile;
					const slot = loadEnemyGetFirstEmptySlot();
					enemyDataSlots[slot].status = 0;
					enemyDataSlots[slot].y = enemyWorking.y;
					if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
						enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 4);
					} else {
						enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x + 4);
					}
					enemyDataSlots[slot].spriteType = Actor.skreekSpit;
					enemyDataSlots[slot].baseSpriteAttributes = 0x80;
					enemyDataSlots[slot].spriteAttributes = enemyWorking.spriteAttributes;
					enemyCreateLinkForChildObject();
					enemySpawnObjectShortHeader(&projectileHeader, &enemyDataSlots[slot]);
					enemyWorking.spawnFlag = 3;
					enemyWorking.spriteType = Actor.skreek4;
					audio.sfxRequestNoise = NoiseSFX.u12;
				}
				break;
			case SkreekState.waitingForProjectile:
				if (enemyWorking.spawnFlag == 3) {
					return;
				}
				enemyWorking.spriteType = Actor.skreek;
				enemyWorking.counter = SkreekState.falling;
				break;
			case SkreekState.falling:
				if (--enemyWorking.state != 0) {
					enemyWorking.y += jumpSpeedTable[enemyWorking.state];
				} else {
					enemyWorking.counter = SkreekState.idle;
				}
				break;
		}
	}
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
	static immutable ubyte[] ySpeedTable = [
		0x01, 0x01, 0x01, 0x02, 0x03, 0x03, 0x03, 0x03, 0x03, 0x02, 0x02, 0x02, 0x02, 0x01, 0x01, 0x00,
		0x00, 0xFF, 0xFE, 0xFD, 0xFC, 0xFA, 0xFD, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0x80,
	];
	static immutable ubyte[] xSpeedTable = [
		0x00, 0x01, 0x00, 0x01, 0x01, 0x02, 0x01, 0x02, 0x02, 0x03, 0x02, 0x03, 0x04, 0x03, 0x03, 0x02,
		0x04, 0x02, 0x05, 0x04, 0x05, 0x04, 0x01, 0x02, 0x01, 0x01, 0x00, 0x01, 0x00, 0x80,
	];
	static immutable projectileHeader = EnemyHeader(Actor.drivelSpit, 0x80, 0, 0, 0, 0, 0, 0, 0, 1, 0, &enAIDrivelSpit);
	static void resetAnimation() {
		enemyWorking.spriteType = Actor.drivel;
	}
	static bool animate() {
		static void nextFrame() {
			if (enemyFrameCounter & 1) {
				return;
			}
			if (enemyWorking.spriteType == Actor.drivel3) {
				resetAnimation();
			} else {
				enemyWorking.spriteType++;
			}
		}
		if (enemyWorking.spawnFlag == 3) {
			nextFrame();
			return true;
		}
		if (enemyWorking.counter >= 12) {
			nextFrame();
			return false;
		}
		resetAnimation();
		return false;
	}
	static void move() {
		const speed = ySpeedTable[enemyWorking.counter];
		if (speed == 0x80) {
			enemyWorking.directionFlags ^= 2;
			enemyWorking.counter = 0;
		} else {
			enemyWorking.y += speed;
			enemyWorking.x += xSpeedTable[enemyWorking.counter];
			enemyWorking.counter++;
		}
	}
	static void tryShooting() {
		byte distance = cast(byte)(enemyWorking.x - samusOnScreenXPos);
		if (distance < 0) {
			distance = cast(byte)-distance;
		}
		if (distance >= 48) {
			return move();
		}
		enemyWorking.state = 0;
		const slot = loadEnemyGetFirstEmptySlot();
		enemyDataSlots[slot].status = 0;
		enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y + 8);
		enemyDataSlots[slot].x = enemyWorking.x;
		enemyCreateLinkForChildObject();
		enemySpawnObjectLongHeader(&projectileHeader, &enemyDataSlots[slot]);
		enemyWorking.spawnFlag = 3;
	}
	static void startTryShooting() {
		enemyWorking.state = 1;
		tryShooting();
	}
	if (animate()) {
		return;
	}
	if (enemyWorking.state != 0) {
		return tryShooting();
	}
	if (!(gb.DIV & 0xF)) {
		return startTryShooting();
	}
	move();
}

void enAIDrivelSpit() {
	if (enemyWorking.spriteType == Actor.drivelSpit3) {
		enemyWorking.y++;
		enemyAccelForwards(enemyWorking.y);
		enCollisionDownNearSmall();
		if (!(enBGCollisionResult & 0b0010)) {
			return;
		}
		enemyWorking.spriteType = Actor.drivelSpit4;
		audio.sfxRequestNoise = NoiseSFX.u11;
	} else if (enemyWorking.spriteType > Actor.drivelSpit3) {
		if (enemyFrameCounter & 3) {
			return;
		}
		if (++enemyWorking.spriteType < Actor.drivelSpit6 + 1) {
			return;
		}
		if (enemyDataSlots[enemyWorking.spawnFlag >> 4].spawnFlag == 3) {
			enemyDataSlots[enemyWorking.spawnFlag >> 4].spawnFlag = 1;
			enemySpawnFlags[enemyDataSlots[enemyWorking.spawnFlag >> 4].spawnNumber] = 1;
		}
		enemyDeleteSelf();
		audio.sfxRequestNoise = NoiseSFX.u03;
		enemyWorking.spawnFlag = 0xFF;
	} else {
		if (enemyFrameCounter & 3) {
			return;
		}
		enemyWorking.spriteType++;
	}
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
			audio.sfxRequestSquare1 = Square1SFX.u14;
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
		enemyDataSlots[slot].spawnFlag = cast(ubyte)((enemyWRAMAddr - &enemyDataSlots[0]) << 4);
		enemyTempSpawnFlag = enemyDataSlots[slot].spawnFlag;
		enemyDataSlots[slot].spawnNumber = enemyWorking.spriteType & 1;
		enemyDataSlots[slot].ai = &enAIPipeBug;
		enemySpawnFlags[enemyDataSlots[slot].spawnNumber] = enemyTempSpawnFlag;
		numEnemies.total++;
		numEnemies.active++;
		enemyWorking.spawnFlag = 3;
	}
}

enum SkorpState {
	extend,
	extendIdle,
	retract,
	retractIdle,
}

void enAISkorpVert() {
	final switch (cast(SkorpState)enemyWorking.state) {
		case SkorpState.extend:
			if (++enemyWorking.counter != 32) {
				enemyFlipHorizontalTwoFrame();
				if (enemyWorking.spriteAttributes & OAMFlags.yFlip) {
					enemyWorking.y++;
				} else {
					enemyWorking.y--;
				}
			} else {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.extendIdle;
			}
			break;
		case SkorpState.extendIdle:
			if (++enemyWorking.counter == 8) {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.retract;
			}
			break;
		case SkorpState.retract:
			if (++enemyWorking.counter == 32) {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.retractIdle;
			} else {
				enemyFlipHorizontalTwoFrame();
				if (enemyWorking.spriteAttributes & OAMFlags.yFlip) {
					enemyWorking.y--;
				} else {
					enemyWorking.y++;
				}
			}
			break;
		case SkorpState.retractIdle:
			if (++enemyWorking.counter == 8) {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.extend;
			}
			break;
	}
}

void enAISkorpHori() {
	final switch (cast(SkorpState)enemyWorking.state) {
		case SkorpState.extend:
			if (++enemyWorking.counter != 32) {
				enemyFlipVerticalTwoFrame();
				if (enemyWorking.spriteAttributes & OAMFlags.xFlip) {
					enemyWorking.x--;
				} else {
					enemyWorking.x++;
				}
			} else {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.extendIdle;
			}
			break;
		case SkorpState.extendIdle:
			if (++enemyWorking.counter == 8) {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.retract;
			}
			break;
		case SkorpState.retract:
			if (++enemyWorking.counter == 32) {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.retractIdle;
			} else {
				enemyFlipVerticalTwoFrame();
				if (enemyWorking.spriteAttributes & OAMFlags.xFlip) {
					enemyWorking.x++;
				} else {
					enemyWorking.x--;
				}
			}
			break;
		case SkorpState.retractIdle:
			if (++enemyWorking.counter == 8) {
				enemyWorking.counter = 0;
				enemyWorking.state = SkorpState.extend;
			}
			break;
	}
}

void enAIAutrack() {
	static immutable laserHeader = ShortEnemyHeader(0, 0, 0, 0, 0, 0, 0xFE, 0, &enAIAutrack);
	static void action() {
		if (enemyFrameCounter & 15) {
			return;
		}
		enemyWorking.directionFlags ^= 10;
		if (enemyWorking.directionFlags == 8) {
			audio.sfxRequestNoise = NoiseSFX.u18;
		}
	}
	if (enemyWorking.spriteType == Actor.autrackFlipped) {
		enemyWorking.spriteType = Actor.autrack;
	}
	if (enemyWorking.spawnFlag == 6) {
		if (enemyWorking.spriteAttributes & OAMFlags.xFlip) {
			enemyWorking.x += 5;
		} else {
			enemyWorking.x -= 5;
		}
	} else {
		if (!(enemyWorking.directionFlags & 0b0010)) {
			if (enemyWorking.spriteType == Actor.autrack3) {
				if (enemyFrameCounter & 15) {
					return;
				}
				const slot = loadEnemyGetFirstEmptySlot();
				enemyDataSlots[slot].status = 0;
				enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y - 20);
				if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
					enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 8);
				} else {
					enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x + 8);
				}
				enemyDataSlots[slot].spriteType = Actor.autrackLaser;
				enemyDataSlots[slot].baseSpriteAttributes = 0;
				enemyDataSlots[slot].spriteAttributes = enemyWorking.spriteAttributes;
				enemyTempSpawnFlag = 6;
				enemySpawnObjectShortHeader(&laserHeader, &enemyDataSlots[slot]);
				enemyWorking.spriteType = Actor.autrack4;
				audio.sfxRequestNoise = NoiseSFX.u13;
				action();
			} else {
				enemyWorking.spriteType++;
			}
		} else {
			if (enemyWorking.spriteType == Actor.autrack) {
				action();
			} else {
				enemyWorking.spriteType--;
			}
		}
	}
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
				if (enBGCollisionResult & 0b0010) { // found ground, start jumping again
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
			if (enBGCollisionResult & 0b0010) { // found ground, start jumping again
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
					audio.sfxRequestNoise = NoiseSFX.u1A;
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
			audio.sfxRequestNoise = NoiseSFX.u03;
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
		audio.sfxRequestNoise = NoiseSFX.u12;
		return;
	}
	enemyWorking.spriteType = Actor.wallfireDead;
	audio.sfxRequestSquare1 = Square1SFX.clear;
	audio.sfxRequestNoise = NoiseSFX.u02;
}

enum GunzooState {
	shootMove,
	shootTimer,
	move
}

void enAIGunzoo() {
	static immutable upperCannonShotHeader = EnemyHeader(Actor.gunzooHShot1, 0, 0, 0, 0, 0, 0, 0, 0, 0xFE, 1, &enAIGunzoo);
	static immutable lowerCannonShotHeader = EnemyHeader(Actor.gunzooHShot1, 0, 0, 0, 0, 0, 0, 0, 0, 0xFE, 2, &enAIGunzoo);
	static immutable diagonalShotHeader = EnemyHeader(Actor.gunzooDiagShot1, 0, 0, 0, 0, 0, 0, 0, 0, 0xFE, 3, &enAIGunzoo);
	if (enemyWorking.spawnFlag != 6) {
		if (enemyWorking.spriteType >= Actor.gunzooHShot1) {
			if (enemyWorking.spriteType == Actor.gunzooHShot5) {
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 0xFF;
			} else if (enemyWorking.spriteType < Actor.gunzooHShot3) {
				enemyWorking.x -= 3;
				enCollisionLeftNearSmall();
				if (enBGCollisionResult & 0b0100) {
					enemyWorking.spriteType = Actor.gunzooHShot3;
					audio.sfxRequestNoise = NoiseSFX.u03;
				}
			} else {
				enemyWorking.spriteType++;
			}
		} else if (enemyWorking.spriteType == Actor.gunzooDiagShot2) {
			enemyWorking.spriteType = Actor.gunzooDiagShot3;
			enemyWorking.y -= 8;
		} else if (enemyWorking.spriteType == Actor.gunzooDiagShot3) {
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 0xFF;
		} else {
			enemyWorking.y += 2;
			enemyWorking.x -= 2;
			enCollisionDownNearSmall();
			if (enBGCollisionResult & 0b0010) {
				enemyWorking.spriteType = Actor.gunzooDiagShot3;
				enemyWorking.y -= 4;
				audio.sfxRequestNoise = NoiseSFX.u03;
			}
		}
		return;
	} else if (!(enemyWorking.directionFlags & 0b0001)) {
		if ((enemyWorking.state != GunzooState.shootMove) && ((gb.DIV & 0x1F) == 0)) {
			const slot = loadEnemyGetFirstEmptySlot();
			enemyDataSlots[slot].status = 0;
			enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y + 8);
			enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 8);
			enemyTempSpawnFlag = 6;
			enemySpawnObjectLongHeader(&diagonalShotHeader, &enemyDataSlots[slot]);
			enemyWorking.state = GunzooState.shootTimer;
			audio.sfxRequestNoise = NoiseSFX.u12;
		} else if (enemyWorking.directionFlags & 0b0010) {
			if (--enemyWorking.counter == 0) {
				if (enemyWorking.state != GunzooState.shootMove) {
					enemyWorking.counter = 0;
					enemyWorking.state = GunzooState.shootMove;
					enemyWorking.directionFlags = 1;
				} else {
					enemyWorking.directionFlags ^= 2;
				}
			}
			enemyWorking.x -= 2;
		} else {
			if (++enemyWorking.counter == 32) {
				enemyWorking.directionFlags ^= 2;
			} else {
				enemyWorking.x += 2;
			}
		}
		return;
	} else {
		if (enemyWorking.spriteType != Actor.gunzoo) {
			if (!(enemyFrameCounter & 7)) {
				enemyWorking.spriteType = Actor.gunzoo;
			}
			return;
		}
		final switch (cast(GunzooState)enemyWorking.state) {
			case GunzooState.shootMove:
				if ((gb.DIV & 0x1F) 	== 0) {
					const slot = loadEnemyGetFirstEmptySlot();
					enemyDataSlots[slot].status = 0;
					enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y - 8);
					enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 16);
					enemyTempSpawnFlag = 6;
					enemySpawnObjectLongHeader(&upperCannonShotHeader, &enemyDataSlots[slot]);
					enemyWorking.spriteType++;
					enemyWorking.state = GunzooState.shootTimer;
					audio.sfxRequestNoise = NoiseSFX.u12;
					return;
				}
				goto case GunzooState.move;
			case GunzooState.shootTimer:
				if (enemyFrameCounter & 0x1F) {
					goto case GunzooState.move;
				}
				const slot = loadEnemyGetFirstEmptySlot();
				enemyDataSlots[slot].status = 0;
				enemyDataSlots[slot].y = enemyWorking.y;
				enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 16);
				enemyTempSpawnFlag = 6;
				enemySpawnObjectLongHeader(&lowerCannonShotHeader, &enemyDataSlots[slot]);
				enemyWorking.spriteType = Actor.gunzoo3;
				enemyWorking.state = GunzooState.move;
				audio.sfxRequestNoise = NoiseSFX.u12;
				break;
			case GunzooState.move:
				if (enemyWorking.directionFlags & 0b0010) {
					if (--enemyWorking.counter == 0) {
						if (enemyWorking.state == GunzooState.move) {
							enemyWorking.spriteType = Actor.gunzoo;
							enemyWorking.directionFlags = 0;
							enemyWorking.counter = 0;
							enemyWorking.state = GunzooState.shootMove;
						} else {
							enemyWorking.directionFlags ^= 2;
						}
						return;
					}
					return;
				}
				if (++enemyWorking.counter == 32) {
					enemyWorking.directionFlags ^= 2;
					return;
				}
				enemyWorking.y -= 2;
				break;
		}
	}
}

void enAIAutom() {
	immutable flamethrowerHeader = EnemyHeader(Actor.automShot1, 0, 0, 0, 0, 0, 0, 0, 0, 0xFF, 0, &enAIAutom);
	if (enemyWorking.spawnFlag == 3) { // flames are active, do nothing else
		return;
	}
	if ((enemyWorking.spawnFlag & 0xF) == 0) { // flames are active, and we are flames
		audio.sfxRequestSquare2 = Square2SFX.u7;
		if (enemyWorking.spriteType < Actor.automShot3) {
			enemyWorking.spriteType++;
			enemyWorking.y += 8;
		} else if (enemyWorking.spriteType == Actor.automShot3) {
			enemyWorking.spriteType++;
		} else if (enemyWorking.spriteType > Actor.automShot3) {
			enemyFlipSpriteID2BitsFourFrame();
			if (++enemyWorking.counter == 32) {
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 0xFF;
			}
		}
		return;
	}
	if ((gb.DIV & 0x1F) == 0) { // start shooting at random
		const slot = loadEnemyGetFirstEmptySlot();
		enemyDataSlots[slot].status = 0;
		enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y + 16);
		enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x + 1);
		enemyCreateLinkForChildObject();
		enemySpawnObjectLongHeader(&flamethrowerHeader, &enemyDataSlots[slot]);
		enemyWorking.spriteType = Actor.autom2;
		enemyWorking.spawnFlag = 3;
	} else {
		enemyWorking.spriteType = Actor.autom;
		if (enemyWorking.state == 0) {
			if (++enemyWorking.counter == 32) {
				enemyWorking.state ^= 1;
			} else {
				enemyWorking.x += 3;
			}
		} else {
			if (--enemyWorking.counter == 0) {
				enemyWorking.state ^= 1;
			} else {
				enemyWorking.x -= 3;
			}
		}
	}
}

enum ProboscumState {
	retracted,
	retractedDiagonal,
	extended,
	extendedDiagonal,
}

void enAIProboscum() {
	if (enemyWorking.spriteType == Actor.proboscumFlipped) {
		enemyWorking.spriteType = Actor.proboscum;
	}
	final switch (cast(ProboscumState)enemyWorking.state) {
		case ProboscumState.retracted:
		case ProboscumState.extended:
			if (++enemyWorking.counter == 64) {
				enemyWorking.counter = 0;
				enemyWorking.spriteType = Actor.proboscum2;
				enemyWorking.state++;
			}
			break;
		case ProboscumState.retractedDiagonal:
			if (++enemyWorking.counter == 2) {
				enemyWorking.counter = 0;
				enemyWorking.spriteType = Actor.proboscum3;
				enemyWorking.state = ProboscumState.extended;
			}
			break;
		case ProboscumState.extendedDiagonal:
			if (++enemyWorking.counter == 2) {
				enemyWorking.counter = 0;
				enemyWorking.spriteType = Actor.proboscum;
				enemyWorking.state = ProboscumState.retracted;
			}
			break;
	}
}

enum MissileBlockState {
	idle,
	rising,
	falling,
	exploding,
}

void enAIMissileBlock() {
	static void animate() {
		if (enemyFrameCounter & 3) {
			return;
		}
		if (enemyWorking.directionFlags) {
			if (enemyWorking.spriteAttributes == 0) {
				enemyWorking.spriteAttributes = OAMFlags.xFlip;
			} else if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
				enemyWorking.spriteAttributes = OAMFlags.xFlip | OAMFlags.yFlip;
			} else if (!(enemyWorking.spriteAttributes & OAMFlags.yFlip)) {
				enemyWorking.spriteAttributes = 0;
			} else {
				enemyWorking.spriteAttributes = OAMFlags.yFlip;
			}
		} else {
			if (enemyWorking.spriteAttributes == 0) {
				enemyWorking.spriteAttributes = OAMFlags.yFlip;
			} else if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
				enemyWorking.spriteAttributes = 0;
			} else if (!(enemyWorking.spriteAttributes & OAMFlags.yFlip)) {
				enemyWorking.spriteAttributes = OAMFlags.xFlip | OAMFlags.yFlip;
			} else {
				enemyWorking.spriteAttributes = OAMFlags.xFlip;
			}
		}
	}
	enemyGetSamusCollisionResults();
	final switch (cast(MissileBlockState)enemyWorking.state) {
		case MissileBlockState.idle:
			if (enemyWeaponType >= CollisionType.contact) {
				return;
			}
			audio.sfxRequestSquare1 = Square1SFX.beamDink;
			if (enemyWeaponType != CollisionType.missiles) {
				return;
			}
			audio.sfxRequestSquare1 = Square1SFX.clear;
			audio.sfxRequestNoise = NoiseSFX.u08;
			if (!(enemyWeaponDir & 0b0001)) {
				enemyWorking.directionFlags = 2;
			}
			enemyWorking.state = MissileBlockState.rising;
			enemyWorking.misc = 1;
			goto case;
		case MissileBlockState.rising:
			if (enemyWorking.counter == 10) {
				enemyWorking.counter = 0;
				enemyWorking.state = MissileBlockState.falling;
				goto case;
			} else {
				enAIHalzynMoveVertical();
				if (enemyWorking.directionFlags) {
					enAIHalzynMoveLeft();
				} else {
					enAIHalzynMoveRight();
				}
			}
			break;
		case MissileBlockState.falling:
			enemyWorking.y += 4;
			enemyAccelForwards(enemyWorking.y);
			if (enemyWorking.directionFlags) {
				enemyWorking.x--;
			} else {
				enemyWorking.x++;
			}
			break;
		case MissileBlockState.exploding:
			if (enemyWorking.spriteType == Actor.screwExplosionEnd) {
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 2;
			}
			enemyWorking.spriteType++;
			return;
	}
	animate();
	enCollisionDownMidMedium();
	if (!(enBGCollisionResult & 0b0010)) {
		return;
	}
	enemyWorking.state = MissileBlockState.exploding;
	enemyWorking.spriteType = Actor.screwExplosionStart;
}

void enAIMoto() {
	static void animate() {
		if (enemyFrameCounter & 1) {
			return;
		}
		if (enemyWorking.spriteType == Actor.moto) {
			if (enemyWorking.counter) {
				enemyWorking.spriteType = Actor.moto2;
			} else {
				enemyWorking.spriteType = Actor.moto;
			}
		} else {
			enemyWorking.spriteType = Actor.moto;
			enemyWorking.counter ^= 1;
		}
	}
	animate();
	if (enemyFrameCounter & 1) {
		return;
	}
	if ((enemyWorking.directionFlags & 0xF) == 0) {
		enemyWorking.x += 2;
	} else {
		enemyWorking.x -= 2;
	}
	enCollisionDownOnePoint();
	if (enBGCollisionResult & 0b0010) {
		return;
	}
	enemyWorking.spriteAttributes ^= OAMFlags.xFlip;
	enemyWorking.directionFlags ^= 0b00110010; // shield and direction
}

void enAIHalzyn() {
	enemyFlipHorizontalFourFrame();
	enAIHalzynMoveVertical();
	if ((enemyWorking.directionFlags & 0xF) != 0) {
		enAIHalzynMoveLeft();
		enCollisionLeftFarMedium();
		if (!(enBGCollisionResult & 0b0100)) { // don't turn around if we haven't hit anything
			return;
		}
		enemyWorking.directionFlags &= 0xF0; // turn around, but preserve shields
	} else {
		enAIHalzynMoveRight();
		enCollisionRightFarMedium();
		if (!(enBGCollisionResult & 0b0001)) { // don't turn around if we haven't hit anything
			return;
		}
		enemyWorking.directionFlags &= 0xF0; // turn around, but preserve shields
		enemyWorking.directionFlags += 2;
	}
}

enum HalzynMovementState {
	state0,
	state1,
	state2,
	state3,
}

void halzynMoveBack(ubyte a, ref ubyte pos) {
	pos -= a;
	if (enemyWorking.misc & 1) {
		pos -= a;
	}
}

void halzynMoveAhead(ubyte a, ref ubyte pos) {
	pos += a;
	if (enemyWorking.misc & 1) {
		pos += a;
	}
}

immutable ubyte[] concaveSpeedTable = [0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x00];
immutable ubyte[] convexSpeedTable = [0x00, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01];

void enAIHalzynMoveVertical() {
	if (enemyWorking.counter == 10) {
		enemyWorking.counter = 0;
		if (enemyWorking.state != HalzynMovementState.state3) {
			enemyWorking.state++;
		} else {
			enemyWorking.state = HalzynMovementState.state0;
			enemyWorking.misc ^= 1;
		}
	}
	final switch (cast(HalzynMovementState)enemyWorking.state) {
		case HalzynMovementState.state0:
			halzynMoveBack(concaveSpeedTable[enemyWorking.counter], enemyWorking.y);
			break;
		case HalzynMovementState.state1:
			halzynMoveAhead(convexSpeedTable[enemyWorking.counter], enemyWorking.y);
			break;
		case HalzynMovementState.state2:
			halzynMoveAhead(concaveSpeedTable[enemyWorking.counter], enemyWorking.y);
			break;
		case HalzynMovementState.state3:
			halzynMoveBack(convexSpeedTable[enemyWorking.counter], enemyWorking.y);
			break;
	}
}

void enAIHalzynMoveLeft() {
	const counter = enemyWorking.counter++;
	final switch (cast(HalzynMovementState)enemyWorking.state) {
		case HalzynMovementState.state0:
			halzynMoveBack(convexSpeedTable[counter], enemyWorking.x);
			break;
		case HalzynMovementState.state1:
			halzynMoveBack(concaveSpeedTable[counter], enemyWorking.x);
			break;
		case HalzynMovementState.state2:
			halzynMoveBack(convexSpeedTable[counter], enemyWorking.x);
			break;
		case HalzynMovementState.state3:
			halzynMoveBack(concaveSpeedTable[counter], enemyWorking.x);
			break;
	}
}

void enAIHalzynMoveRight() {
	const counter = enemyWorking.counter++;
	final switch (cast(HalzynMovementState)enemyWorking.state) {
		case HalzynMovementState.state0:
			halzynMoveAhead(convexSpeedTable[counter], enemyWorking.x);
			break;
		case HalzynMovementState.state1:
			halzynMoveAhead(concaveSpeedTable[counter], enemyWorking.x);
			break;
		case HalzynMovementState.state2:
			halzynMoveAhead(convexSpeedTable[counter], enemyWorking.x);
			break;
		case HalzynMovementState.state3:
			halzynMoveAhead(concaveSpeedTable[counter], enemyWorking.x);
			break;
	}
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

enum VanishingFlittState {
	state0,
	state1,
	state2,
	state3,
}

void enAIFlittVanishing() {
	final switch (cast(VanishingFlittState)enemyWorking.state) {
		case VanishingFlittState.state0:
			if (++enemyWorking.counter == 56) {
				enemyWorking.counter = 0;
				enemyWorking.state = VanishingFlittState.state1;
				enemyWorking.spriteType = Actor.flittMoving;
			}
			break;
		case VanishingFlittState.state1:
			if (++enemyWorking.counter == 14) {
				enemyWorking.counter = 0;
				enemyWorking.state = VanishingFlittState.state2;
				enemyWorking.spriteType = Actor.flittInvisible;
			}
			break;
		case VanishingFlittState.state2:
			if (++enemyWorking.counter == 12) {
				enemyWorking.counter = 0;
				enemyWorking.state = VanishingFlittState.state3;
				enemyWorking.spriteType = Actor.flittMoving;
			}
			break;
		case VanishingFlittState.state3:
			if (++enemyWorking.counter == 13) {
				enemyWorking.counter = 0;
				enemyWorking.state = VanishingFlittState.state0;
				enemyWorking.spriteType = Actor.flittVanishing;
			}
			break;
	}
}

void enAIFlittMoving() {
	enemyFlipSpriteIDFourFrame();
	enemyGetSamusCollisionResults();
	if (enemyWorking.directionFlags == 0) {
		if (++enemyWorking.counter != 96) {
			enemyWorking.x++;
			if (enemyWeaponType == CollisionType.contact) {
				samusOnScreenXPos++;
				cameraSpeedRight++;
				samusX++;
			}
		} else {
			enemyWorking.directionFlags = 2;
		}
	} else {
		if (--enemyWorking.counter != 0) {
			enemyWorking.x--;
			if (enemyWeaponType == CollisionType.contact) {
				samusOnScreenXPos--;
				cameraSpeedLeft++;
				samusX--;
			}
		} else {
			enemyWorking.directionFlags = 0;
		}
	}
}

enum GravittState {
	idle,
	unburrow,
	crawl,
	crawl2,
	burrow,
	wait,
}

void enAIGravitt() {
	static void animate() {
		if (enemyFrameCounter & 1) {
			return;
		}
		if (++enemyWorking.spriteType > Actor.gravitt5) {
			enemyWorking.spriteType = Actor.gravitt2;
		}
	}
	final switch (cast(GravittState)enemyWorking.state) {
		case GravittState.idle:
			auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
			bool faceRight;
			if (distance < 0) {
				distance = cast(byte)-distance;
				faceRight = true;
			}
			if (distance >= 56) {
				return;
			}
			enemyWorking.spriteType++;
			enemyWorking.y -= 2;
			enemyWorking.state = GravittState.unburrow;
			if (!faceRight) {
				enemyWorking.directionFlags = 0b10000000;
			} else {
				enemyWorking.directionFlags = 0b10000010;
			}
			break;
		case GravittState.unburrow:
			if (++enemyWorking.counter != 6) {
				enemyWorking.y -= 2;
			} else {
				enemyWorking.counter = 0;
				enemyWorking.state = GravittState.crawl;
			}
			break;
		case GravittState.crawl:
		case GravittState.crawl2:
			animate();
			if (++enemyWorking.counter != 24) {
				if (enemyWorking.directionFlags & 0b0010) {
					enemyWorking.x -= 2;
				} else {
					enemyWorking.x += 2;
				}
			} else {
				enemyWorking.counter = 0;
				enemyWorking.directionFlags ^= 2;
				enemyWorking.state++;
			}
			break;
		case GravittState.burrow:
			if (++enemyWorking.counter != 7) {
				enemyWorking.y += 2;
			} else {
				enemyWorking.counter = 0;
				enemyWorking.state = GravittState.wait;
				enemyWorking.spriteType = Actor.gravitt;
			}
			break;
		case GravittState.wait:
			if (++enemyWorking.counter == 48) {
				enemyWorking.counter = 0;
				enemyWorking.state = GravittState.idle;
			}
			break;
	}
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
	audio.sfxRequestSquare1 = Square1SFX.beamDink;
	if (enemyWeaponType != CollisionType.missiles) {
		return;
	}
	audio.sfxRequestSquare1 = Square1SFX.clear;
	audio.sfxRequestNoise = NoiseSFX.u08;
	enemyWorking.stunCounter = 19;
	if (++enemyWorking.counter != 5) {
		return;
	}
	enemyWorking.counter = 0;
	enemyWorking.stunCounter = 0;
	enemyWorking.spriteType = Actor.screwExplosionStart;
	audio.sfxRequestSquare1 = Square1SFX.u10;
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

void unknownProc6AE1(ref ubyte pos) {
	static immutable byte[] speedTable = [0, -2, -2, -2, -1, -2, -2, -1, -1, -2, -1, -1, -1, 0, -1, -1, 0, -1, 0, 0, -1, 0, 0, 0];
	if (enemyWorking.misc != 23) {
		enemyWorking.misc++;
	}
	byte value = speedTable[enemyWorking.misc];
	if (value < 0) {
		value = cast(byte)-value;
		pos -= value;
	} else {
		pos += value;
	}
}

void enemyCreateLinkForChildObject() {
	const parent = enemyWRAMAddr - &enemyDataSlots[0];
	tracef("Creating link to parent %s", parent);
	enemyTempSpawnFlag = cast(ubyte)(parent << 4);
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

void enemyFlipVerticalTwoFrame() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyFlipVerticalNow();
}
void enemyFlipVerticalFourFrame() {
	if (enemyFrameCounter & 3) {
		return;
	}
	enemyFlipVerticalNow();
}
void enemyFlipVerticalNow() {
	enemyWorking.spriteAttributes ^= OAMFlags.yFlip;
}

void enAIMetroidStinger() {
	if (++enemyWorking.counter != 138) {
		if (enemyWorking.counter == 1) { // stuff only happens on frame 0
			metroidCountDisplayed += 8;
			metroidCountShuffleTimer = 202;
			audio.songRequest = Song.metroidHiveWithIntro;
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
			audio.sfxRequestSquare1 = Square1SFX.beamDink;
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
		if (audio.songPlaying == Song.metroidBattle) {
			return;
		}
		audio.songRequest = Song.metroidBattle;
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
	if (audio.songPlaying == Song.metroidBattle) {
		return;
	}
	audio.songRequest = Song.metroidBattle;
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
		audio.sfxRequestSquare1 = Square1SFX.beamDink;
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
	audio.sfxRequestSquare1 = Square1SFX.u1A;
}

void enAIAlphaMetroidHurtReaction() {
	if (--enemyWorking.health == 0) {
		enAIAlphaMetroidDeath();
		return;
	}
	alphaStunCounter = 8;
	audio.sfxRequestNoise = NoiseSFX.u05;
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
	audio.sfxRequestNoise = NoiseSFX.u0D;
	audio.songRequest = Song.killedMetroid;
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
	static immutable projectileHeader = ShortEnemyHeader(0, 0, 0xFF, 0, 0, 0, 0xFF, 7, &enAIGammaMetroid);
	static void despawn() {
		enemyDeleteSelf();
		enemyWorking.spawnFlag = 0xFF;
	}
	static void projectileCode() {
		if (enemyFrameCounter & 1) {
			return;
		}
		if (enemyWorking.spriteType != Actor.gammaBolt1) {
			enemyWorking.spriteType--;
			enemyWorking.spriteAttributes |= OAMFlags.yFlip;
			enemyWorking.y -= 13;
			if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
				enemyWorking.x += 4;
			} else {
				enemyWorking.x -= 4;
			}
		} else if (!(enemyWorking.spriteAttributes & OAMFlags.yFlip)) {
			enemyWorking.spriteType++;
			enemyWorking.y -= 16;
			if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
				enemyWorking.x -= 4;
			} else {
				enemyWorking.x += 4;
			}
		} else {
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 0xFF;
		}
	}
	static void checkIfActing() {
		if (metroidState != 0) {
			if (enemyWorking.spawnFlag == 5) {
				return;
			}
			if ((enemyWorking.spawnFlag & 0xF) == 0) {
				projectileCode();
				if (enemyWeaponType >= CollisionType.screwAttack) {
					return;
				}
				audio.sfxRequestSquare1 = Square1SFX.beamDink;
			} else {
				switch (enemyWeaponType) {
					case CollisionType.nothing:
					case CollisionType.contact:
						if (enemyWorking.directionFlags != 0xFF) { // was hit with something painful previously
							metroidScrewKnockback();
							if (!metroidScrewKnockbackDone) {
								return;
							}
							metroidScrewKnockbackDone = 0;
							enemyWorking.directionFlags = 0xFF;
							enemyWorking.counter = 0;
							enemyWorking.state++;
							enemyWorking.spriteType = Actor.zetaMetroid;
							return;
						}
						if (enemyWorking.counter == 0) {
							gammaGetAngle();
							if (samusOnScreenXPos >= enemyWorking.x + 16) {
								enemyWorking.spriteAttributes = OAMFlags.xFlip;
							} else {
								enemyWorking.spriteAttributes = 0;
							}
						}
						if (++enemyWorking.counter < 15) {
							enAIAlphaMetroidLungeMovement(gammaGetSpeedVector());
							enemyWorking.spriteType = Actor.gamma2;
						} else if (enemyWorking.counter >= 20) {
							const slot = loadEnemyGetFirstEmptySlot();
							enemyDataSlots[slot].status = 0;
							enemyDataSlots[slot].y = cast(byte)(enemyWorking.y + 12);
							if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
								enemyDataSlots[slot].x = cast(byte)(enemyWorking.x - 8);
							} else {
								enemyDataSlots[slot].x = cast(byte)(enemyWorking.x + 8);
							}
							enemyDataSlots[slot].spriteType = Actor.gammaBolt1;
							enemyDataSlots[slot].baseSpriteAttributes = 0;
							enemyDataSlots[slot].spriteAttributes = enemyWorking.spriteAttributes;
							enemyCreateLinkForChildObject();
							enemySpawnObjectShortHeader(&projectileHeader, &enemyDataSlots[slot]);
							enemyWorking.spawnFlag = 5;
							enemyWorking.counter = 0;
							audio.sfxRequestNoise = NoiseSFX.u14;
						}
						break;
					case CollisionType.screwAttack:
						metroidScrewReaction();
						audio.sfxRequestSquare1 = Square1SFX.u1A;
						break;
					case CollisionType.missiles:
						if (--enemyWorking.health == 0) {
							enemyWorking.counter = 0;
							enemyWorking.state = 0;
							metroidState = 0x80;
							enemyWorking.spriteType = Actor.screwExplosionStart;
							audio.sfxRequestNoise = NoiseSFX.u0D;
							audio.songRequest = Song.killedMetroid;
							metroidFightActive = 2;
							enemyWorking.spawnFlag = 2;
							metroidCountReal--;
							metroidCountDisplayed--;
							metroidCountShuffleTimer = 192;
							earthquakeCheck();
						} else {
							gammaStunCounter = 8;
							audio.sfxRequestNoise = NoiseSFX.u05;
							enemyWorking.directionFlags = 0;
							static void knockbackRandHorizontal() {
								if (gb.DIV & 1) {
									enemyWorking.directionFlags |= 0b0001;
								} else {
									enemyWorking.directionFlags |= 0b0100;
								}
							}
							static void knockbackRandVertical() {
								if (gb.DIV & 1) {
									enemyWorking.directionFlags |= 0b0010;
								} else {
									enemyWorking.directionFlags |= 0b1000;
								}
							}
							if (enemyWeaponDir & 0b0001) {
								enemyWorking.x += 5;
								enCollisionRightFarWide();
								if (!(enBGCollisionResult & 0b0001)) {
									enemyWorking.directionFlags |= 0b0001;
								} else {
									enemyWorking.x = enemyXPosMirror;
								}
								knockbackRandVertical();
							} else if (enemyWeaponDir & 0b1000) {
								enemyWorking.y += 5;
								enCollisionDownFarWide();
								if (!(enBGCollisionResult & 0b0010)) {
									enemyWorking.directionFlags |= 0b0010;
								} else {
									enemyWorking.y = enemyYPosMirror;
								}
								knockbackRandHorizontal();
							} else if (enemyWeaponDir & 0b0010) {
								if (enemyWorking.x >= 16) {
									enemyWorking.x -= 5;
									enCollisionLeftFarWide();
									if (!(enBGCollisionResult & 0b0100)) {
										enemyWorking.directionFlags |= 0b0100;
									} else {
										enemyWorking.x = enemyXPosMirror;
									}
								}
								knockbackRandVertical();
							} else {
								if (enemyWorking.y - 5 >= 16) {
									enemyWorking.y -= 5;
									enCollisionUpFarWide();
									if (!(enBGCollisionResult & 0b1000)) {
										enemyWorking.directionFlags |= 0b1000;
									} else {
										enemyWorking.y = enemyYPosMirror;
									}
								}
								knockbackRandHorizontal();
							}
						}
						break;
					default:
						audio.sfxRequestSquare1 = Square1SFX.beamDink;
						break;
				}
			}
		} else if (enemyWorking.spawnFlag == 4) {
			enemyWorking.spriteType = Actor.zetaMetroid;
			auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
			if (distance < 0) {
				distance = cast(byte)-distance;
			}
			if (distance >= 80) {
				return;
			}
			gammaStunCounter = 0;
			metroidState++;
			metroidFightActive = 1;
			if (audio.songPlaying != Song.metroidBattle) {
				audio.songRequest = Song.metroidBattle;
			}
		} else if ((enemyWorking.spawnFlag & 0xF) == 0) {
			despawn();
		} else {
			if (!cutsceneActive) {
				auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
				if (distance < 0) {
					distance = cast(byte)-distance;
				}
				if (distance >= 80) {
					return;
				}
				cutsceneActive = 1;
				audio.songRequest = Song.metroidBattle;
				metroidFightActive = 1;
			}
			if (enemyFrameCounter & 3) {
				return;
			}
			if (++enemyWorking.counter == 16) {
				enemyWorking.counter = 0;
				enemyWorking.spriteType = Actor.zetaMetroid;
				cutsceneActive = 0;
				metroidState++;
				enemyWorking.spawnFlag = 4;
			} else {
				enemyWorking.spriteType ^= Actor.alpha1 ^ Actor.zetaMetroid;
			}
		}
	}
	enemyGetSamusCollisionResults();
	if (gammaStunCounter == 0) {
		checkIfActing();
	} else if (--gammaStunCounter == 0) {
		enemyWorking.directionFlags = 0xFF;
		enemyWorking.status = 0;
		checkIfActing();
	} else {
		metroidMissileKnockback();
		enemyToggleVisibility();
		if (enemyWeaponType >= CollisionType.screwAttack) {
			audio.sfxRequestSquare1 = Square1SFX.beamDink;
		}
	}
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

EnemySlot* enemyGetAddressOfParentObject() {
	return &enemyDataSlots[enemyWorking.spawnFlag >> 4];
}

void enAIZetaMetroid() {
	static immutable gammaHuskHeader = EnemyHeader(Actor.gammaHusk, 0x80, 0, 0, 0, 0, 0, 0, 0, 0xFF, 6, &enAIZetaMetroid);
	static immutable fireballHeader = ShortEnemyHeader(0, 0, 0xFF, 0, 0, 0, 0xFF, 8, &enAIZetaMetroid);
	static void standardAction() {
		if (enemyWorking.directionFlags != 0xFF) {
			metroidScrewKnockback();
			if (metroidScrewKnockbackDone != 0) {
				metroidScrewKnockbackDone = 0;
				enemyWorking.directionFlags = 0xFF;
				enemyWorking.spriteType = Actor.zeta5;
				enemyWorking.counter = 16;
				enemyWorking.state = 16;
				metroidState = 3;
			}
		} else if (metroidState >= 4) {
			switch (metroidState) {
				case 4:
				default:
					if (enemyFrameCounter & 1) {
						return;
					}
					if (enemyWorking.counter != 0) {
						if (enemyWorking.spriteType == Actor.zeta5) {
							enemyWorking.spriteType--;
						}
					} else {
						enemyWorking.spriteType++;
						enemyWorking.counter = 1;
					}
					enemyWorking.counter = 0;
					metroidState = 5;
					break;
				case 5:
					enemyAccelBackwards(enemyWorking.y);
					if (enemyWorking.y >= 48) {
						if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
							enemyWorking.x--;
						} else {
							enemyWorking.x++;
						}
					} else {
						metroidState = 6;
						enemyWorking.misc = 0;
						enemyWorking.spriteType = Actor.zeta1;
					}
					break;
				case 6:
					if (++enemyWorking.counter != 32) {
						if (enemyFrameCounter & 3) {
							return;
						}
						if (enemyWorking.spriteType == Actor.zeta4) {
							enemyWorking.spriteType = cast(Actor)(Actor.zeta1 - 1);
						}
						enemyWorking.spriteType++;
					} else {
						enemyWorking.counter = 0;
						metroidState = 3;
						enemyWorking.spawnFlag = 4;
						enemyWorking.spriteType = Actor.zeta5;
					}
					break;
			}
		} else {
			enemySeekSamus(2, 32, 0);
			if (samusOnScreenXPos >= enemyWorking.x) {
				if (samusOnScreenXPos - enemyWorking.x < 32) {
					zetaXProximityFlag = 1;
				}
				enemyWorking.spriteAttributes = OAMFlags.xFlip;
			} else {
				if (samusOnScreenXPos - enemyWorking.x >= -32) {
					zetaXProximityFlag = 1;
				}
				enemyWorking.spriteAttributes = 0;
			}
			if (!zetaXProximityFlag) {
				return;
			}
			zetaXProximityFlag = 0;
			if ((samusOnScreenXPos < enemyWorking.y) || (samusOnScreenYPos - enemyWorking.y >= 32)) {
				return;
			}
			const slot = loadEnemyGetFirstEmptySlot();
			enemyDataSlots[slot].status = 0;
			enemyDataSlots[slot].y = cast(ubyte)(enemyWorking.y + 4);
			if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
				enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 24);
			} else {
				enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x + 24);
			}
			enemyDataSlots[slot].spriteType = Actor.zetaShot;
			enemyDataSlots[slot].baseSpriteAttributes = 0x80;
			enemyDataSlots[slot].spriteAttributes = enemyWorking.spriteAttributes;
			enemyTempSpawnFlag = 6;
			enemySpawnObjectShortHeader(&fireballHeader, &enemyDataSlots[slot]);
			audio.sfxRequestNoise = NoiseSFX.u15;
			enemyWorking.spawnFlag = 5;
			metroidState = 4;
			enemyWorking.counter = 0;
			enemyWorking.state = 0;
			enemyWorking.spriteType = Actor.zeta6;
		}
	}
	static void knockbackRandVertical() {
		if (gb.DIV & 1) {
			enemyWorking.directionFlags |= 0b0010;
		} else {
			enemyWorking.directionFlags |= 0b1000;
		}
	}
	static void checkIfActing() {
		if (metroidState >= 3) {
			switch (enemyWeaponType) {
				case CollisionType.nothing:
				case CollisionType.contact:
					standardAction();
					break;
				case CollisionType.screwAttack:
					metroidScrewReaction();
					audio.sfxRequestSquare1 = Square1SFX.u1A;
					break;
				case CollisionType.missiles:
					if (enemyWeaponDir & 0b0100) {
						audio.sfxRequestSquare1 = Square1SFX.beamDink;
					} else if (--enemyWorking.health == 0) {
						enemyWorking.counter = 0;
						enemyWorking.state = 0;
						metroidState = 0x80;
						enemyWorking.spriteType = Actor.screwExplosionStart;
						audio.sfxRequestNoise = NoiseSFX.u0D;
						audio.songRequest = Song.killedMetroid;
						metroidFightActive = 2;
						enemyWorking.spawnFlag = 2;
						metroidCountReal--;
						metroidCountDisplayed--;
						metroidCountShuffleTimer = 192;
						earthquakeCheck();
					} else {
						enemyWorking.spriteType = Actor.zeta8;
						zetaStunCounter = 8;
						audio.sfxRequestNoise = NoiseSFX.u05;
						enemyWorking.directionFlags = 0;
						if (enemyWeaponDir & 0b0001) {
							enemyWorking.directionFlags |= 0b0001;
							enemyWorking.x += 5;
							knockbackRandVertical();
						} else if (enemyWeaponDir & 0b1000) {
							if (enemyWorking.x - 5 >= 16) {
								enemyWorking.x -= 5;
								enemyWorking.directionFlags |= 0b0100;
							}
							knockbackRandVertical();
						} else { //down
							enemyWorking.directionFlags |= 0b0010;
							enemyWorking.y += 5;
							if (gb.DIV & 1) {
								enemyWorking.directionFlags |= 0b0001;
							} else {
								enemyWorking.directionFlags |= 0b0100;
							}
						}
					}
					break;
				default:
					audio.sfxRequestSquare1 = Square1SFX.beamDink;
					break;
			}
		} else if (enemyWorking.spawnFlag == 4) {
			enemyWorking.spriteType = Actor.zeta5;
			auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
			if (distance < 80) {
				distance = cast(byte)-distance;
			}
			enemyWorking.counter = 16;
			enemyWorking.state = 16;
			zetaStunCounter = 0;
			metroidFightActive = 1;
			metroidState = 3;
			if (audio.songPlaying != Song.metroidBattle) {
				audio.songRequest = Song.metroidBattle;
			}
			standardAction();
		} else if (metroidState == 2) {
			enemyWorking.spriteType = Actor.zeta5;
			enemyWorking.counter = 0;
			enemyWorking.state = 0;
			enemyWorking.spawnFlag = 4;
			cutsceneActive = 0;
			metroidState = 3;
		} else if (enemyWorking.spriteType == Actor.gammaHusk) {
			if (metroidState == 0) {
				enAIZetaMetroidOscillateWide();
			} else {
				enemyWorking.stunCounter = 16;
				enemyAccelForwards(enemyWorking.y);
				if (enemyWorking.y < PPU.height) {
					return;
				}
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 2;
				metroidState = 2;
			}
		} else if (enemyWorking.spriteType == Actor.zeta1) {
			if (metroidState != 0) {
				return;
			}
			enAIZetaMetroidOscillateNarrow();
			if (enemyFrameCounter & 7) {
				return;
			}
			enemyWorking.y--;
			if (++enemyWorking.counter == 6) {
				enemyWorking.counter = 0;
				metroidState = 1;
			}
		} else if (cutsceneActive) {
			if (enemyFrameCounter & 3) {
				return;
			}
			if (++enemyWorking.counter == 8) {
				enemyWorking.counter = 0;
				enemyWorking.stunCounter = 0;
				const slot = loadEnemyGetFirstEmptySlot();
				enemyDataSlots[slot].status = 0;
				enemyDataSlots[slot].y = enemyWorking.y;
				enemyDataSlots[slot].x = enemyWorking.x;
				enemyTempSpawnFlag = 3;
				enemySpawnObjectLongHeader(&gammaHuskHeader, &enemyDataSlots[slot]);
				enemyWorking.y -= 8;
				enemyWorking.spriteType = Actor.zeta1;
			} else {
				enemyWorking.stunCounter ^= 16;
			}
		} else if (!(enemyFrameCounter & 3)) {
			enemyWorking.stunCounter ^= 16;
			auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
			if (distance < 0) {
				distance = cast(byte)-distance;
			}
			if (distance < 80) {
				cutsceneActive = 1;
				audio.songRequest = Song.metroidBattle;
				metroidFightActive = 1;
			}
		}
	}
	enemyGetSamusCollisionResults();
	if (enemyWorking.spawnFlag == 6) {
		if (metroidState != 6) {
			if (enemyWorking.y + 3 < PPU.height) {
				enemyWorking.y += 3;
				if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
					enemyWorking.x--;
				} else {
					enemyWorking.x++;
				}
			}
		} else {
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 0xFF;
		}
	} else {
		if (metroidState != 0) {
			enemyKeepOnscreen();
		}
		if (zetaStunCounter == 0) {
			checkIfActing();
		} else if (--zetaStunCounter == 1) {
			enemyWorking.status = 0;
			enemyWorking.directionFlags = 0xFF;
			enemyWorking.spriteType = Actor.zeta5;
			enemyWorking.counter = 16;
			enemyWorking.state = 16;
			checkIfActing();
		} else {
			if (enemyWorking.spriteType == Actor.zetaB) {
				enemyWorking.spriteType = Actor.zeta8;
			}
			enemyWorking.spriteType++;
			if (enemyWeaponType < CollisionType.screwAttack) {
				audio.sfxRequestSquare1 = Square1SFX.beamDink;
			}
		}
	}
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

void enAIZetaMetroidOscillateWide() {
	if (!(enemyFrameCounter & 3)) {
		return;
	}
	if ((enemyFrameCounter & 3) == 2) {
		enemyWorking.x -= 3;
	} else if ((enemyFrameCounter & 3) == 1) {
		enemyWorking.x += 3;
	}
}

void enAIOmegaMetroid() {
	static immutable fireballHeader = ShortEnemyHeader(0, 0, 0xFF, 0, 0, 0, 0xFF, 8, &enAIOmegaMetroid);
	static void unused() {
		switch (++enemyWorking.counter) {
			case 1:
				enemyWorking.y -= 5;
				enemyWorking.x -= 5;
				break;
			case 2:
				enemyWorking.y -= 5;
				enemyWorking.x += 5;
				break;
			case 3:
				enemyWorking.y += 5;
				enemyWorking.x += 5;
				break;
			default:
				enemyWorking.counter = 0;
				enemyWorking.x -= 5;
				break;
		}
	}
	static void selectChaseTimer() {
		if (omegaWaitCounter != 64) {
			omegaWaitCounter++;
			return;
		}
		omegaWaitCounter = 0;
		if (omegaSamusPrevHealth - samusCurHealth >= 48) {
			omegaChaseTimerIndex = 0;
			enemyWorking.misc = 12;
		} else {
			switch (omegaChaseTimerIndex) {
				case 1:
					enemyWorking.misc = 20;
					break;
				case 2:
					enemyWorking.misc = 40;
					break;
				case 3:
					enemyWorking.misc = 64;
					break;
				case 4:
					enemyWorking.misc = 96;
					break;
				default:
					omegaChaseTimerIndex = 0;
					enemyWorking.misc = 12;
					break;
			}
		}
		omegaSamusPrevHealth = samusCurHealth;
		enemyWorking.counter = 16;
		enemyWorking.state = 16;
		enemyWorking.spriteType = Actor.omega5;
		audio.sfxRequestSquare1 = Square1SFX.u2D;
		metroidState = 5;
	}
	static void animateTail() {
		if (enemyFrameCounter & 3) {
			return;
		}
		enemyWorking.spriteType ^= Actor.omega1 ^ Actor.omega2;
	}
	static void faceSamus() {
		if (samusOnScreenXPos < enemyWorking.x) {
			enemyWorking.spriteAttributes = 0;
		} else {
			enemyWorking.spriteAttributes = OAMFlags.xFlip;
		}
		animateTail();
	}
	static void death() {
		enemyWorking.counter = 0;
		enemyWorking.state = 0;
		omegaWaitCounter = 0;
		omegaChaseTimerIndex = 0;
		metroidState = 0x80;
		enemyWorking.spriteType = Actor.screwExplosionStart;
		audio.sfxRequestNoise = NoiseSFX.u0E;
		audio.songRequest = Song.killedMetroid;
		metroidFightActive = 2;
		enemyWorking.spawnFlag = 2;
		metroidCountReal--;
		metroidCountDisplayed--;
		metroidCountShuffleTimer = 192;
		earthquakeCheck();
	}
	static void hurtOneDamage() {
		if (--enemyWorking.health == 0) {
			death();
		} else {
			omegaStunCounter = 3;
		}
	}
	static void hurtWeakPoint() {
		enemyWorking.health -= 3;
		if ((enemyWorking.health == 0) || (enemyWorking.health > ubyte.max - 2)) {
			death();
		} else {
			omegaStunCounter = 16;
		}
	}
	static void chaseSamus() {
		enemySeekSamus(2, 0x20, 0);
		if (samusOnScreenXPos >= enemyWorking.x) {
			if (samusOnScreenXPos - enemyWorking.x >= 16) {
				enemyWorking.spriteAttributes = OAMFlags.xFlip;
			}
		} else {
			if (samusOnScreenXPos - enemyWorking.x < 240) {
				enemyWorking.spriteAttributes = 0;
			}
		}
	}
	static void checkIfHurt() {
		if (metroidState == 0) {
			if (enemyWorking.spawnFlag == 4) {
				enemyWorking.spriteType = Actor.omega1;
				auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
				if (distance < 0) {
					distance = cast(byte)-distance;
				}
				if (distance < 80) {
					enemyWorking.misc = 0;
					enemyWorking.counter = 0;
					enemyWorking.state = 0;
					omegaStunCounter = 0;
					omegaWaitCounter = 0;
					omegaChaseTimerIndex = 0;
					metroidState = 1;
					metroidFightActive = 1;
					enemyWorking.directionFlags = 0xFF;
					if (audio.songPlaying != Song.metroidBattle) {
						audio.songRequest = Song.metroidBattle;
					}
				}
			} else {
				if (!cutsceneActive) {
					auto distance = cast(byte)(samusOnScreenXPos + 16 - (enemyWorking.x + 16));
					if (distance < 0) {
						distance = cast(byte)-distance;
					}
					if (distance < 80) {
						cutsceneActive = 1;
						audio.songRequest = Song.metroidBattle;
						metroidFightActive = 1;
					}
				}
				if (!(enemyFrameCounter & 3)) {
					if (++enemyWorking.counter == 24) {
						enemyWorking.counter = 0;
						enemyWorking.spriteType = Actor.omega1;
						cutsceneActive = 0;
						metroidState = 1;
						enemyWorking.spawnFlag = 4;
					} else {
						enemyWorking.spriteType ^= Actor.zeta1 ^ Actor.omega1;
					}
				}
			}
		} else {
			switch (enemyWeaponType) {
				case CollisionType.contact:
				case CollisionType.nothing:
					if (enemyWorking.directionFlags == 0xFF) {
						switch (metroidState) {
							case 5:
								if (--enemyWorking.misc == 0) {
									//moveToState6
								} else if (omegaChaseTimerIndex == 4) {
									return faceSamus();
								} else if ((samusPose & 0x7F) == SamusPose.crouching) {
									//moveToState6
								} else {
									return chaseSamus();
								}
								//moveToState6:
								metroidState = 6;
								enemyWorking.misc = 0;
								enemyWorking.counter = 0;
								enemyWorking.state = 0;
								break;
							case 6:
								enemyAccelBackwards(enemyWorking.y);
								if (enemyWorking.y >= 52) {
									if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
										enemyWorking.x -= 2;
									} else {
										enemyWorking.x += 2;
									}
								} else {
									metroidState = 7;
									enemyWorking.misc = 0;
									enemyWorking.spriteType = Actor.omega1;
								}
								break;
							case 7:
								if (++enemyWorking.counter != 56) {
									animateTail();
								} else {
									enemyWorking.counter = 0;
									metroidState = 1;
								}
								break;
							case 4:
								selectChaseTimer();
								enemyWorking.counter = 0;
								enemyWorking.state = 0;
								metroidState = 1;
								enemyWorking.spriteType = Actor.omega1;
								break;
							case 1:
								selectChaseTimer();
								faceSamus();
								if (++enemyWorking.counter == 16) {
									enemyWorking.counter = 0;
									const slot = loadEnemyGetFirstEmptySlot();
									enemyDataSlots[slot].status = 0;
									enemyDataSlots[slot].y = enemyWorking.y;
									if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
										enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x - 16);
									} else {
										enemyDataSlots[slot].x = cast(ubyte)(enemyWorking.x + 16);
									}
									enemyDataSlots[slot].spriteType = Actor.omegaShot1;
									enemyDataSlots[slot].baseSpriteAttributes = 0;
									enemyDataSlots[slot].spriteAttributes = enemyWorking.spriteAttributes;
									enemyTempSpawnFlag = 6;
									enemySpawnObjectShortHeader(&fireballHeader, &enemyDataSlots[slot]);
									metroidState = 2;
									enemyWorking.spawnFlag = 5;
									enemyWorking.spriteType = Actor.omega3;
									audio.sfxRequestNoise = NoiseSFX.u15;
								}
								break;
							case 2:
							default: // states 0 and 3 are unused
								if (numEnemies.total - 1 == 0) {
									goto case 4;
								}
								selectChaseTimer();
								if (enemyWorking.counter == 0) {
									if (enemyWorking.state != 36) {
										enemyWorking.state++;
										animateTail();
									} else {
										faceSamus();
									}
								} else {
									if (++enemyWorking.counter == 24) {
										enemyWorking.spriteType = Actor.omega1;
									} else {
										enemyFlipSpriteID2BitsTwoFrame();
									}
								}
								break;
						}
					} else {
						metroidScrewKnockback();
						if (metroidScrewKnockbackDone) {
							enemyWorking.directionFlags = 0xFF;
							omegaWaitCounter = 0;
							omegaChaseTimerIndex = 3;
							enemyWorking.misc = 16;
							enemyWorking.counter = 16;
							enemyWorking.state = 16;
							enemyWorking.spriteType = Actor.omega5;
							metroidState = 5;
						}
					}
					break;
				case CollisionType.screwAttack:
					metroidScrewReaction();
					audio.sfxRequestSquare1 = Square1SFX.u1A;
					break;
				case CollisionType.missiles:
					if (!(enemyWeaponDir & 0b0011)) { // can't hit from above or below
						goto default;
					}
					if (!(enemyWorking.spriteAttributes & OAMFlags.xFlip)) {
						if (!(enemyWeaponDir & 0b0010)) {
							hurtOneDamage();
						} else {
							hurtWeakPoint();
						}
					} else {
						if (!(enemyWeaponDir & 0b0001)) {
							hurtOneDamage();
						} else {
							hurtWeakPoint();
						}
					}
					omegaTempSpriteType = enemyWorking.spriteType;
					enemyWorking.spriteType = Actor.omega6;
					audio.sfxRequestNoise = NoiseSFX.u09;
					if (enemyWeaponDir & 0b0001) {
						enemyWorking.x += 5;
					} else {
						if (enemyWorking.x - 5 > 16) {
							enemyWorking.x -= 5;
						}
					}
					break;
				default:
					audio.sfxRequestSquare1 = Square1SFX.beamDink;
					break;
			}
		}
	}
	enemyGetSamusCollisionResults();
	if (enemyWorking.spawnFlag == 6) { // I am a fireball
		if (metroidFightActive == 2) {
			enemyDeleteSelf();
			enemyWorking.spawnFlag = 0xFF;
			if (metroidState == 2) {
				metroidState = 4;
			}
		} else if (enemyWorking.spriteType >= Actor.omegaShot3) {
			if (enemyWorking.spriteType == Actor.omegaShot7) {
				enemyDeleteSelf();
				enemyWorking.spawnFlag = 0xFF;
				if (metroidState == 2) {
					metroidState = 4;
				}
			} else if (!(enemyFrameCounter & 1)) {
				enemyWorking.spriteType++;
			}
		} else {
			if (enemyWorking.counter == 0) {
				enemyWorking.counter = 1;
				gammaGetAngle();
			}
			const bc = gammaGetSpeedVector();
			const ubyte b = bc >> 8;
			const ubyte c = bc & 0xFF;
			if (b != 0) {
				if (b & 0b10000000) {
					enemyWorking.y -= b & ~0b10000000;
					enCollisionUpNearSmall();
					if (enBGCollisionResult & 0b1000) {
						unknownC42D = enBGCollisionResult;
						enemyWorking.counter = 0;
						enemyWorking.state = 0;
						enemyWorking.spriteType = Actor.omegaShot3;
						return;
					}
				} else {
					enemyWorking.y += b;
					enCollisionDownNearSmall();
					if (enBGCollisionResult & 0b0010) {
						unknownC42D = enBGCollisionResult;
						enemyWorking.counter = 0;
						enemyWorking.state = 0;
						enemyWorking.spriteType = Actor.omegaShot3;
						return;
					}
				}
			}
			if (c & 0b10000000) {
				enemyWorking.x -= c & ~0b10000000;
			} else {
				enemyWorking.x += c;
			}
			if (!(enemyFrameCounter & 3)) {
				enemyFlipSpriteIDNow();
			}
		}
		return;
	}
	if (metroidState != 0) {
		enemyKeepOnscreen();
	}
	if (omegaStunCounter == 0) {
		return checkIfHurt();
	}
	if (--omegaStunCounter == 0) { //stun's done
		enemyWorking.spriteType = omegaTempSpriteType;
		return checkIfHurt();
	}
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyFlipSpriteIDNow();
	if (enemyWeaponType < CollisionType.screwAttack) {
		audio.sfxRequestSquare1 = Square1SFX.beamDink;
	}
}

enum MetroidLatchState {
	unlatched,
	unlatching,
	latched,
}

void enAINormalMetroid() {
	static void animate() {
		if (enemyFrameCounter & 3) {
			return;
		}
		enemyWorking.spriteType ^= Actor.metroid1 ^ Actor.metroid;
	}
	static void freeze() {
		audio.sfxRequestSquare1 = Square1SFX.u1A;
		enemyWorking.stunCounter = 16;
		enemyWorking.iceCounter = 68;
		enemyWorking.status = 0;
	}
	enemyGetSamusCollisionResults();
	if (enemyWorking.misc == 0) { //unlatched
		if (larvaHurtAnimCounter) {
			if (--larvaHurtAnimCounter != 0) {
				return;
			}
			enemyWorking.spriteType = Actor.metroid;
		}
		if (enemyWorking.iceCounter == 0) {
			animate();
			switch (enemyWeaponType) {
				case CollisionType.nothing:
					if (enemyWorking.directionFlags != 0xFF) {
						metroidScrewKnockback();
						if (metroidScrewKnockbackDone != 0) {
							metroidScrewKnockbackDone = 0;
							enemyWorking.directionFlags = 0xFF;
							enemyWorking.counter = 16;
							enemyWorking.state = 16;
						}
					} else {
						enemySeekSamus(1, 30, 2);
						metroidCorrectPosition();
					}
					break;
				case CollisionType.contact:
					if (larvaBombState != 2) {
						if (larvaBombState != 1) {
							larvaBombState = 1;
						}
						larvaLatchState = MetroidLatchState.latched;
					} else {
						larvaLatchState = MetroidLatchState.unlatching;
					}
					enemyWorking.misc = 1;
					enemyWorking.counter = 0;
					break;
				case CollisionType.screwAttack:
				case CollisionType.bombExplosion:
					enemyWorking.counter = 0;
					metroidScrewReaction();
					audio.sfxRequestSquare1 = Square1SFX.u1A;
					break;
				case CollisionType.iceBeam:
					freeze();
					break;
				default:
					audio.sfxRequestSquare1 = Square1SFX.beamDink;
					break;
			}
		} else {
			enemyAnimateIceCall();
			if (enemyWorking.iceCounter == 0) {
				enemyWorking.counter = 16;
				enemyWorking.state = 16;
				enemyWorking.spriteType = Actor.metroid;
				enemyWorking.health = 5;
			} else {
				if (enemyWeaponType < CollisionType.contact) {
					if (enemyWeaponType == CollisionType.missiles) {
						if (--enemyWorking.health == 0) {
							enemyWorking.counter = 0;
							larvaBombState = 0;
							larvaLatchState = MetroidLatchState.unlatched;
							enemyWorking.spawnFlag = 2;
							enemyWorking.explosionFlag = 16;
							audio.sfxRequestNoise = NoiseSFX.u0D;
							metroidCountReal--;
							metroidCountDisplayed--;
							metroidCountShuffleTimer = 192;
							earthquakeCheck();
						} else {
							larvaHurtAnimCounter = 3;
							enemyWorking.spriteType = Actor.metroid3;
							audio.sfxRequestNoise = NoiseSFX.u05;
						}
					} else if (enemyWeaponType == CollisionType.iceBeam) {
						freeze();
					} else {
						audio.sfxRequestSquare1 = Square1SFX.beamDink;
					}
				}
			}
		}
	} else { //latched
		animate();
		final switch (cast(MetroidLatchState)larvaLatchState) {
			case MetroidLatchState.unlatched:
				larvaBombState = 0;
				enemyWorking.misc = 0;
				larvaLatchState = MetroidLatchState.unlatched;
				enemyWorking.counter = 16;
				enemyWorking.state = 16;
				break;
			case MetroidLatchState.unlatching:
				if (++enemyWorking.counter == 24) {
					goto case MetroidLatchState.unlatched;
				}
				larvaBombState = 2;
				if (enemyWorking.y - 3 >= 16) {
					enemyWorking.y -= 3;
					enCollisionUpFarWide();
					if (enBGCollisionResult & 0b1000) {
						enemyWorking.y = enemyYPosMirror;
					}
				}
				if (enemyWorking.x - 3 >= 16) {
					enemyWorking.x -= 3;
					enCollisionLeftFarWide();
					if (enBGCollisionResult & 0b0100) {
						enemyWorking.x = enemyXPosMirror;
					}
				}
				break;
			case MetroidLatchState.latched:
				enemyWorking.y = samusOnScreenYPos;
				enemyWorking.x = samusOnScreenXPos;
				if (enemyWeaponType == CollisionType.bombExplosion) {
					larvaLatchState = MetroidLatchState.unlatching;
				}
				break;
		}
	}
}

enum BabyMetroidState {
	egg,
	hatching2,
	active,
	hatching,
}

void enAIBabyMetroid() {
	static void animateFlash() {
		if (enemyFrameCounter & 3) {
			return;
		}
		enemyWorking.stunCounter ^= 0x10;
	}
	static void animateEggWiggle() {
		if (enemyFrameCounter & 1) {
			return;
		}
		if (enemyWorking.counter != 1) {
			if (++enemyWorking.spriteType != Actor.egg3) {
				return;
			}
		} else {
			if (--enemyWorking.spriteType == Actor.egg1) {
				return;
			}
		}
		enemyWorking.counter ^= 1;
	}
	final switch (cast(BabyMetroidState)metroidState) {
		case BabyMetroidState.egg:
			if (enemyWorking.spawnFlag != 4) {
				animateFlash();
				auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
				if (distance < 0) {
					distance = cast(byte)-distance;
				}
				if (distance >= 24) {
					return;
				}
				distance = cast(byte)(samusOnScreenYPos - enemyWorking.y);
				if (distance < 0) {
					distance = cast(byte)-distance;
				}
				if (distance >= 16) {
					return;;
				}
				cutsceneActive = 1;
				animateEggWiggle();
				if (++enemyWorking.state != 48) {
					return;
				}
				enemyWorking.state = 0;
				enemyWorking.counter = 0;
				enemyWorking.stunCounter = 0;
				metroidState = BabyMetroidState.hatching;
				metroidFightActive++; // YOU WANNA GO???
				enemyWorking.spawnFlag = 4;
				audio.sfxRequestNoise = NoiseSFX.u16;
			} else {
				enemyWorking.spriteType = Actor.baby1;
				auto distance = cast(byte)(samusOnScreenXPos - enemyWorking.x);
				if (distance < 0) {
					distance = cast(byte)-distance;
				}
				if (distance >= 96) {
					return;
				}
				metroidFightActive = 1;
				metroidState = BabyMetroidState.active;
				audio.sfxRequestNoise = NoiseSFX.u16;
			}
			break;
		case BabyMetroidState.hatching2:
			enAIZetaMetroidOscillateWide();
			enemyWorking.y--;
			if (++enemyWorking.counter == 12) {
				enemyWorking.counter = 16;
				enemyWorking.state = 16;
				metroidState = BabyMetroidState.active;
				cutsceneActive = 0;
			}
			break;
		case BabyMetroidState.active:
			enemyFlipSpriteIDFourFrame();
			enemySeekSamus(2, 32, 0);
			babyCheckBlocks();
			babyKeepOnscreen();
			break;
		case BabyMetroidState.hatching:
			if (++enemyWorking.counter & 1) {
				enemyWorking.spriteType = cast(Actor)(Actor.screwExplosionStart + (enemyWorking.counter >> 1));
			} else {
				if (enemyWorking.counter == 12) {
					enemyWorking.counter = 0;
					metroidState = BabyMetroidState.hatching2;
				}
				enemyWorking.spriteType = Actor.baby1;
			}
			break;
	}
}

void metroidCorrectPosition() {
	if (enemyWorking.counter >= 16) {
		enCollisionDownFarWide();
		if (enBGCollisionResult & 0b0010) {
			enemyWorking.y = enemyYPosMirror;
		}
	} else {
		if (enemyWorking.y < 16) {
			enemyWorking.y = enemyYPosMirror;
		}
		enCollisionUpFarWide();
		if (enBGCollisionResult & 0b1000) {
			enemyWorking.y = enemyYPosMirror;
		}
	}
	if (enemyWorking.state >= 16) {
		enCollisionRightFarWide();
		if (enBGCollisionResult & 0b0001) {
			enemyWorking.x = enemyXPosMirror;
		}
	} else {
		if (enemyWorking.x < 16) {
			enemyWorking.x = enemyXPosMirror;
		}
		enCollisionLeftFarWide();
		if (enBGCollisionResult & 0b0100) {
			enemyWorking.x = enemyXPosMirror;
		}
	}
}

void babyCheckBlocks() {
	babyTempXPos = enemyWorking.x;
	enemyWorking.x = enemyXPosMirror;
	if (enemyWorking.counter >= 16) {
		enCollisionDownMidMedium();
		if (enBGCollisionResult & 0b0010) {
			if (metroidBabyTouchingTile == 100) {
				babyClearBlock();
			}
			enemyWorking.y = enemyYPosMirror;
		}
	} else {
		if (enemyWorking.y < 16) {
			enemyWorking.y = enemyYPosMirror;
		} else {
			enCollisionUpMidMedium();
			if (enBGCollisionResult & 0b1000) {
				if (metroidBabyTouchingTile == 100) {
					babyClearBlock();
				}
				enemyWorking.y = enemyYPosMirror;
			}
		}
	}
	enemyWorking.x = babyTempXPos;
	if (enemyWorking.state >= 16) {
		enCollisionRightMidMedium();
		if (enBGCollisionResult & 0b0001) {
			if (metroidBabyTouchingTile == 100) {
				babyClearBlock();
			}
			enemyWorking.x = enemyXPosMirror;
		}
	} else {
		if (enemyWorking.x < 16) {
			enemyWorking.x = enemyXPosMirror;
		} else {
			enCollisionLeftMidMedium();
			if (enBGCollisionResult & 0b0100) {
				if (metroidBabyTouchingTile == 100) {
					babyClearBlock();
				}
				enemyWorking.x = enemyXPosMirror;
			}
		}
	}
}

void babyClearBlock() {
	destroyBlock();
	audio.sfxRequestNoise = NoiseSFX.u16;
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
	if (enemyWorking.y < 24) {
		enemyWorking.y = 24;
	}
	if (enemyWorking.x < 24) {
		enemyWorking.x = 24;
	} else if (enemyWorking.x >= PPU.width - 16) {
		enemyWorking.x = PPU.width - 16;
	}
}

void babyKeepOnscreen() {
	if (enemyWorking.y < 24) {
		enemyWorking.y = 24;
	} else if (enemyWorking.y >= PPU.height) {
		enemyWorking.y = PPU.height;
	}
	if (enemyWorking.x < 24) {
		enemyWorking.x = 24;
	} else if (enemyWorking.x >= PPU.width - 16) {
		enemyWorking.x = PPU.width - 16;
	}
}

void enemyToggleVisibility() {
	if (enemyFrameCounter & 1) {
		return;
	}
	enemyWorking.status ^= 0x80;
}
