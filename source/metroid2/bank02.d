module metroid2.bank02;

import metroid2.bank00;
import metroid2.bank01;
import metroid2.bank03;
import metroid2.defs;
import metroid2.globals;
import metroid2.registers;

import libgb;

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
		if (LY >= 0x70) {
			return;
		}
		if (!loadSpawnFlagsRequest) {
			ingameLoadEnemySaveFlags();
			loadSpawnFlagsRequest = 1;
		}
		scrollEnemies();
		processEnemies();
		updateScrollHistory();
		if (LY < 0x70) {
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
			if (LY >= 88) {
				enemyFirstEnemy = enemyDataSlots[i .. $];
				enemySameEnemyFrameFlag++;
				break;
			}
		}
	} else {
		allEnemiesDone();
	}
	if (LY >= 108) {
		return;
	}
	handleEnemyLoading();
}

void ingameLoadEnemySaveFlags() {
	previousLevelBank = currentLevelBank;
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
					saveBuf.enemySpawnFlags[currentLevelBank][i] = value;
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
	if (collision.weaponType == 0xFF) {
		return false;
	}
	if (enemyWRAMAddr != collision.enemy) {
		return false;
	}
	if (enemyWorking.explosionFlag) {
		 return transferCollisionResults();
	}
	static bool prepareDrop(ubyte v) {
		ubyte drop;
		if ((enemyWorking.spawnFlag == 6) || ((enemyWorking.spawnFlag & 0xF) == 0) || (enemyWorking.maxHealth < 10)) {
			v |= 1 << 1;
		} else if ((enemyWorking.maxHealth == 0xFD) || (enemyWorking.maxHealth == 0xFE)) {
			// nothing
		} else if ((enemyWorking.maxHealth & 1) == 0) {
			v |= 1 << 2;
		} else {
			v |= 1 << 1;
		}
		enemyWorking.explosionFlag = v;
		enemyWorking.counter = 0;
		sfxRequestNoise = NoiseSFX.u02;
		transferCollisionResults();
		return true;
	}
	if (!enemyWorking.dropType) {
		if ((enemyWorking.spriteType >= Actor.metroid1) && (enemyWorking.spriteType <= Actor.metroid3)) {
			return transferCollisionResults();
		}
		if (collision.weaponType == 0x10) {
			if (enemyWorking.health != 0xFF) {
				return prepareDrop(0x20);
			}
			sfxRequestSquare1 = Square1SFX.beamDink;
			 return transferCollisionResults();
		} else if (collision.weaponType > 0x10) {
			return transferCollisionResults();
		}
		if (collision.weaponType != 1) {
			enemyCheckDirectionalShields();
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
				enemyCheckDirectionalShields();
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
	if (collision.weaponType < 0x10) {
		return transferCollisionResults();
	}
	static void giveHealth(ubyte amount) {
		samusCurHealth += amount;
		if (samusCurHealth / 100 >= samusEnergyTanks) {
			samusCurHealth = cast(ushort)((samusEnergyTanks * 100) - 1);
		}
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

void enemyCheckDirectionalShields() {
	if (collision.weaponType == CollisionType.waveBeam) {
		return;
	}
	if (!(enemyWorking.directionFlags & 0xF0)) {
		return;
	}
	if (((enemyWorking.directionFlags & 0xF0) >> 4) & collision.weaponDir) {
		sfxRequestSquare1 = Square1SFX.beamDink;
		enSprCollision.weaponType = collision.weaponType;
		enSprCollision.enemy = collision.enemy;
		enSprCollision.weaponDir = collision.weaponDir;
		collision = EnSprCollision.init;
	}
}


immutable ubyte[] weaponDamageTable = [
	CollisionType.powerBeam: 0x01,
	CollisionType.iceBeam: 0x02,
	CollisionType.waveBeam: 0x04,
	CollisionType.spazer: 0x08,
	CollisionType.plasmaBeam: 0x1E,
	CollisionType.unk5: 0x00,
	CollisionType.unk6: 0x00,
	CollisionType.bombs: 0x02,
	CollisionType.missiles: 0x14,
	CollisionType.bombExplosion: 0x0A,
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
	if (enemy.stunCounter < 17) {
		return false;
	}
	if (++enemy.stunCounter != 20) {
		return true;
	} else if (enemy.iceCounter == 0) {
		enemy.stunCounter = 0;
	} else {
		enemy.stunCounter = 16;
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
			enemyWorking.y++;
		}
	} else if (enemyWorking.yScreen == 0) {
		if ((enemyWorking.y >= 192) && (enemyWorking.y < 216)) {
			enemyWorking.y++;
		} else if ((enemyWorking.y >= 216) && (enemyWorking.y < 240)) {
			enemyWorking.y--;
		}
	} else if (enemyWorking.yScreen == 1) {
		if (enemyWorking.y < 192) {
			enemyWorking.y--;
		}
	}
	if (enemyWorking.xScreen == 0xFF) {
		if (enemyWorking.x >= 240) {
			enemyWorking.x++;
		}
	} else if (enemyWorking.xScreen == 0) {
		if ((enemyWorking.x >= 192) && (enemyWorking.x < 216)) {
			enemyWorking.x++;
		} else if ((enemyWorking.x >= 216) && (enemyWorking.x < 240)) {
			enemyWorking.x--;
		}
	} else if (enemyWorking.xScreen == 1) {
		if (enemyWorking.x < 192) {
			enemyWorking.x--;
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

void enCollisionRight() {
	assert(0); // TODO
}

void enCollisionLeft() {
	assert(0); // TODO
}

void enCollisionDownNearSmall() {
	assert(0); // TODO
}

void enCollisionDownNearMedium() {
	assert(0); // TODO
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
	assert(0); // TODO
}

void enCollisionDownOnePoint() {
	assert(0); // TODO
}

void enCollisionDownFarMedium() {
	assert(0); // TODO
}

void enCollisionDownFarWide() {
	assert(0); // TODO
}

void enCollisionDownCrawlA() {
	assert(0); // TODO
}

void enCollisionDownCrawlB() {
	assert(0); // TODO
}

void enCollisionUp() {
	assert(0); // TODO
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

void enAIBlobThrower() {
	assert(0); // TODO
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
	assert(0); // TODO
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
	assert(0); // TODO
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
	if (DIV & 1) {
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
	assert(0); // TODO
}

void enAICrawlerA() {
	assert(0); // TODO
}

void crawlerMove() {
	assert(0); // TODO
}

void crawlerTurn() {
	assert(0); // TODO
}

void enAICrawlerB() {
	assert(0); // TODO
}

void skreekProjectileCode() {
	assert(0); // TODO
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

void enAISenjooShirk() {
	assert(0); // TODO
}

void enAIGullugg() {
	assert(0); // TODO
}

void enAIChuteLeech() {
	assert(0); // TODO
}

void enAIPipeBug() {
	assert(0); // TODO
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
	assert(0); // TODO
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
	assert(0); // TODO
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
	assert(0); // TODO
}

void enemyAccelForwards() {
	assert(0); // TODO
}

void enemyAccelBackwards() {
	assert(0); // TODO
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

void enemyFlipSpriteID2Bits() {
	assert(0); // TODO
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
	assert(0); // TODO
}

void enAIHatchingAlpha() {
	assert(0); // TODO
}

void enAIAlphaMetroid() {
	assert(0); // TODO
}

void metroidScrewReaction() {
	assert(0); // TODO
}

void metroidScrewKnockback() {
	assert(0); // TODO
}

void metroidMissileKnockback() {
	assert(0); // TODO
}

void enAIGammaMetroid() {
	assert(0); // TODO
}

void enemySpawnObject() {
	assert(0); // TODO
}

void enemyGetAddressOfParentObject() {
	assert(0); // TODO
}

void enAIZetaMetroid() {
	assert(0); // TODO
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
	assert(0); // TODO
}
