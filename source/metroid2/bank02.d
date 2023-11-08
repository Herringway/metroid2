module metroid2.bank02;

import metroid2.bank01;
import metroid2.bank03;
import metroid2.defs;
import metroid2.globals;
import metroid2.registers;

import libgb;

void enemyHandler() {
	unusedROMBankPlusOne = cast(ubyte)(currentLevelBank + 1);
	const started = justStartedTransition;
	if (justStartedTransition) {
		larvaBombState = 0;
		larvaLatchState = 0;
		justStartedTransition = 0;
		enSprCollision.weaponType = 0xFF;
		enSprCollision.enemy = null;
		enSprCollision.weaponDir = 0xFF;
		collision.weaponType = 0xFF;
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
		if (LY >= 0x70) {
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
	if (enemiesLeftToProcess) {
		for (int i = 0; i < enemyFirstEnemy.length; i++) {
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
				enemyFirstEnemy = enemyDataSlots[];
				enemySameEnemyFrameFlag = !enemySameEnemyFrameFlag;
				break;
			}
			//we don't need to restore the enemy address.
			if (LY >= 88) {
				enemyFirstEnemy = enemyDataSlots[i .. $];
				enemySameEnemyFrameFlag++;
				break;
			}
		}
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
	enSprCollision.weaponType = 0xFF;
	enSprCollision.enemy = null;
	enemyWeaponType = 0xFF;
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
	enSprCollision.weaponType = 0xFF;
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
	assert(0); // TODO
}

void enemyGetDirectionalShields() {
	assert(0); // TODO
}

bool enemyMoveFromWRAMtoHRAM(EnemySlot* enemy) {
	assert(0); // TODO
}

void enemyMoveFromHRAMtoWRAM() {
	assert(0); // TODO
}

bool deleteOffscreenEnemy() {
	assert(0); // TODO
}

bool reactivateOffscreenEnemy() {
	assert(0); // TODO
}

bool deactivateOffscreenEnemy() {
	assert(0); // TODO
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

void enCollisonRight() {
	assert(0); // TODO
}

void enCollisonLeft() {
	assert(0); // TODO
}

void enCollisonDown() {
	assert(0); // TODO
}

void enCollisonUp() {
	assert(0); // TODO
}

void blobThrowerLoadSprite() {
	enSpriteBlobThrower[] = enAIBlobThrowerSprite[];
	hitboxC360 = enAIBlobThrowerHitbox;
	blobThrowerActionTimer = 0;
}

void enAIItemOrb() {
	assert(0); // TODO
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

void enAIRockIcicle() {
	assert(0); // TODO
}

void enemyCommonAI() {
	assert(0); // TODO
}

void enAINULL() {}

void enemyAnimateIce() {
	assert(0); // TODO
}

void enemyAnimateDrop() {
	assert(0); // TODO
}

void enemyAnimateExplosion() {
	assert(0); // TODO
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
	assert(0); // TODO
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

void enAIHopper() {
	assert(0); // TODO
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

void enemyFlipSpriteID() {
	assert(0); // TODO
}

void enemyFlipSpriteID2Bits() {
	assert(0); // TODO
}

void enemyFlipHorizontal() {
	assert(0); // TODO
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
	assert(0); // TODO
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
