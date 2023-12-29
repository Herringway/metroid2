module metroid2.bank03;

import metroid2.defs;
import metroid2.enemies;
import metroid2.globals;

import std.logger;

void handleEnemyLoading() {
	loadEnemies();
	scrollHistoryB.y[0] = scrollHistoryB.y[1];
	scrollHistoryB.y[1] = scrollY;
	scrollHistoryB.x[0] = scrollHistoryB.x[1];
	scrollHistoryB.x[1] = scrollX;
}

void loadEnemies() {
	bottomEdge = (cameraY + 104) & 0xFFF0;
	topEdge = (cameraY - 88) & 0xFFF0;
	rightEdge = (cameraX + 104) & 0xFFF8;
	leftEdge = (cameraX - 96) & 0xFFF8;
	// avoid map wraparound
	if (!(bottomEdge & 0xF00) && ((topEdge & 0xF00) == 0xF)) {
		if (cameraY.screen != bottomEdge.screen) {
			bottomEdge = (topEdge.screen << 8) | 0xFF;
		} else {
			topEdge = bottomEdge.screen << 8;
		}
	}
	if (!(rightEdge & 0xF00) && ((leftEdge & 0xF00) == 0xF)) {
		if (cameraX.screen != rightEdge.screen) {
			rightEdge = (leftEdge.screen << 8) | 0xFF;
		} else {
			leftEdge = rightEdge.screen << 8;
		}
	}
	loadEnemiesOscillator ^= 1;
	if (!loadEnemiesOscillator) {
		loadEnemiesHorizontal();
	} else {
		loadEnemiesVertical();
	}
}

void loadEnemiesVertical() {
	const(EnemySpawn)* enemies;
	ushort tmpA;
	if (scrollY == scrollHistoryB.y[1]) {
		return;
	} else if (scrollY >= scrollHistoryB.y[1]) {
		loadEnemiesUnusedVar = 1;
		 tmpA = bottomEdge;
		enemies = loadEnemyGetPointerScreen(loadEnemyGetBankOffset(), leftEdge.screen, bottomEdge.screen);
	} else {
		loadEnemiesUnusedVar = 3;
		 tmpA = topEdge;
		enemies = loadEnemyGetPointerScreen(loadEnemyGetBankOffset(), leftEdge.screen, topEdge.screen);
	}
	while (true) {
		if (enemies[0].spawnNumber == 0xFF) {
			// can't assume contiguous data, so just load neighbour screen set
			enemies = loadEnemyGetPointerScreen(loadEnemyGetBankOffset(), cast(ubyte)(leftEdge.screen + 1), tmpA.screen);
			if (rightEdge.screen <= leftEdge.screen) {
				return;
			}
			while (true) {
				if (enemies[0].spawnNumber == 0xFF) {
					return;
				}
				if (enemySpawnFlags[enemies[0].spawnNumber] >= 0xFE) {
					const x = enemies[0].x & 0xF8;
					if (rightEdge.pixel < x) {
						return;
					}
					const y = enemies[0].y & 0xF0;
					if (tmpA.pixel != y) {
						enemies++;
						continue;
					}
					loadOneEnemy(enemies);
				}
				enemies++;
			}
		}
		if (enemySpawnFlags[enemies[0].spawnNumber] >= 0xFE) {
			const x = enemies[0].x & 0xF8;
			if (leftEdge.pixel >= x) {
				enemies++;
				continue;
			}
			if ((rightEdge.pixel >= leftEdge.pixel) && (rightEdge.pixel < x)) { // sus
				return;
			}
			const y = enemies[0].y & 0xF0;
			if (tmpA.pixel != y) {
				enemies++;
				continue;
			}
			loadOneEnemy(enemies);
		}
		enemies++;
	}
}

void loadEnemiesHorizontal() {
	const(EnemySpawn)* enemies;
	ushort tmpA;
	if (scrollX == scrollHistoryB.x[1]) {
		return;
	} else if (scrollX >= scrollHistoryB.x[1]) {
		loadEnemiesUnusedVar = 0;
		tmpA = rightEdge;
		loadEnemyUnusedVarB = rightEdge.screen;
		enemies = loadEnemyGetPointerScreen(loadEnemyGetBankOffset(), rightEdge.screen, topEdge.screen);
	} else {
		loadEnemiesUnusedVar = 1;
		tmpA = leftEdge;
		enemies = loadEnemyGetPointerScreen(loadEnemyGetBankOffset(), leftEdge.screen, topEdge.screen);
	}
	while (true) {
		if (enemies[0].spawnNumber == 0xFF) { //nothing left on this screen, check screen below
			checkBottom:
			if (bottomEdge.screen != topEdge.screen + 1) {
				return;
			}
			enemies = loadEnemyGetPointerScreen(loadEnemyGetBankOffset(), tmpA.screen, cast(ubyte)(topEdge.screen + 1));
			while (true) {
				if (enemies[0].spawnNumber == 0xFF) {
					return;
				}
				if (enemySpawnFlags[enemies[0].spawnNumber] >= 0xFE) {
					const x = enemies[0].x & 0xF8;
					if (tmpA < x) {
						return;
					}
					if (tmpA != x) {
						enemies++;
						continue;
					}
					const y = enemies[0].y & 0xF0;
					if (bottomEdge.pixel < y) {
						enemies++;
						continue;
					}
					loadOneEnemy(enemies);
				}
				enemies++;
			}
		}
		if (enemySpawnFlags[enemies[0].spawnNumber] >= 0xFE) {
			const x = enemies[0].x & 0xF8;
			if (tmpA.pixel != x) {
				if (tmpA.pixel >= x) {
					enemies++;
					continue;
				} else {
					goto checkBottom;
				}
			}
			const y = enemies[0].y & 0xF0;
			if (topEdge.pixel > y) {
				enemies++;
				continue;
			}
			if ((bottomEdge.pixel >= topEdge.pixel) && (bottomEdge.pixel < y)) {
				enemies++;
				continue;
			}
			loadOneEnemy(enemies);
		}
		enemies++;
	}
}

void loadOneEnemy(const(EnemySpawn)* enemySpawn) {
	enemyWRAM = &enemyDataSlots[loadEnemyGetFirstEmptySlot()];
	enemyWRAM.status = 0;
	enemyWRAM.y = cast(ubyte)(enemySpawn.y + 0x10 - scrollY);
	enemyWRAM.x = cast(ubyte)(enemySpawn.x + 0x08 - scrollX);
	infof("Attempting to spawn %s at %02X, %02X (%02X, %02X)", *enemySpawn, enemyWRAM.x, enemyWRAM.y, scrollX, scrollY);
	enemyWRAM.spriteType = enemySpawn.id;
	enemyWRAM.spawnNumber = enemySpawn.spawnNumber;
	if (enemySpawnFlags[enemySpawn.spawnNumber] != 0xFF) {
		enemySpawnFlags[enemySpawn.spawnNumber] = 4;
		loadEnemySpawnFlagTemp = 4;
	} else {
		enemySpawnFlags[enemySpawn.spawnNumber] = 1;
		loadEnemySpawnFlagTemp = 1;
	}
	auto header = &enemyHeaderPointers[enemyWRAM.spriteType];
	enemyWRAM.baseSpriteAttributes = header.baseSpriteAttributes;
	enemyWRAM.spriteAttributes = header.spriteAttributes;
	enemyWRAM.stunCounter = header.stunCounter;
	enemyWRAM.misc = header.misc;
	enemyWRAM.directionFlags = header.directionFlags;
	enemyWRAM.counter = header.counter;
	enemyWRAM.state = header.state;
	enemyWRAM.iceCounter = header.iceCounter;
	enemyWRAM.health = header.health;
	enemyWRAM.dropType = 0;
	enemyWRAM.explosionFlag = 0;
	enemyWRAM.yScreen = 0;
	enemyWRAM.xScreen = 0;
	enemyWRAM.maxHealth = header.health;
	enemyWRAM.spawnFlag = loadEnemySpawnFlagTemp;
	enemyWRAM.ai = header.ai;
	numEnemies.total++;
	numEnemies.active++;
}

size_t loadEnemyGetFirstEmptySlot() {
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if (enemyDataSlots[i].status == 0xFF) {
			return i;
		}
	}
	return enemyDataSlots.length;
}

immutable(EnemySpawn[][]) loadEnemyGetBankOffset() {
	return enemyDataPointers[currentLevelBank - 9];
}

const(EnemySpawn)* loadEnemyGetPointerScreen(const EnemySpawn[][] base, ubyte x, ubyte y) {
	return loadEnemyGetPointerHeader(base, cast(ubyte)((y << 4) | x));
}
const(EnemySpawn)* loadEnemyGetPointerHeader(const EnemySpawn[][] base, ubyte index) {
	return &base[index][0];
}

void enemyDeleteSelf() {
	const c = enemyWorking.status;
	(cast(ubyte*)&enemyWorking)[0 .. EnemyWorking.spawnFlag.offsetof] = 0xFF;
	if ((enemyWorking.spawnFlag & 0xF) == 0) {
		EnemySlot* slot = &enemyDataSlots[enemyWorking.spawnFlag >> 4];
		ubyte a;
		if (slot.spawnFlag != 3) {
			if (slot.spawnFlag == 5) {
				slot.spawnFlag = 4;
				enemySpawnFlags[slot.spawnNumber] = 4;
			}
		} else {
			slot.spawnFlag = 1;
			enemySpawnFlags[slot.spawnNumber] = 1;
		}
	}
	enemyWorking.ai = null;
	enemyWorking.yScreen = 0xFF;
	enemyWorking.xScreen = 0xFF;
	numEnemies.total--;
	numEnemies.active--;
	if (enSprCollision.enemy != enemyWRAMAddr) {
		return;
	}
	enSprCollision = EnSprCollision.init;
}

void enemySeekSamus(ubyte b, ubyte d, ubyte e) {
	static immutable ubyte[] speedTable = [0xFB, 0xFB, 0xFC, 0xFC, 0xFD, 0xFE, 0xFD, 0xFD, 0xFD, 0xFF, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x02, 0x02, 0x01, 0x03, 0x03, 0x03, 0x02, 0x03, 0x04, 0x04, 0x05, 0x05];
	tracef("%02X", enemyWorking.counter);
	seekSamusTemp.samusX = cast(ubyte)(samusOnScreenXPos + 16);
	seekSamusTemp.samusY = cast(ubyte)(samusOnScreenYPos + 16);
	seekSamusTemp.enemyX = cast(ubyte)(enemyWorking.x + 16);
	seekSamusTemp.enemyY = cast(ubyte)(enemyWorking.y + 16);
	if (seekSamusTemp.samusY > seekSamusTemp.enemyY) {
		if (enemyWorking.counter != d) {
			enemyWorking.counter += b;
		}
	} else if (seekSamusTemp.samusY < seekSamusTemp.enemyY) {
		if (enemyWorking.counter != e) {
			enemyWorking.counter -= b;
		}
	}
	if (seekSamusTemp.samusX > seekSamusTemp.enemyX) {
		if (enemyWorking.state != d) {
			enemyWorking.state += b;
		}
	} else if (seekSamusTemp.samusX < seekSamusTemp.enemyX) {
		if (enemyWorking.state != e) {
			enemyWorking.state -= b;
		}
	}
	enemyWorking.y += speedTable[enemyWorking.counter];
	enemyWorking.x += speedTable[enemyWorking.state];
}

void scrollEnemies() {
	const byte deltaY = cast(byte)(scrollY - scrollHistoryA[$ - 1].y);
	const byte deltaX = cast(byte)(scrollX - scrollHistoryA[$ - 1].x);
	if (!(deltaX | deltaY) || (numEnemies.total == 0)) {
		return;
	}
	scrollEnemiesNumEnemiesLeft = numEnemies.total;
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if (enemyDataSlots[i].status == 0xFF) {
			continue;
		}
		//scrollEnemiesLoadToHRAM(); // this is an optimization that's not really needed now
		if (deltaY < 0) {
			ushort tmp = cast(ushort)(enemyDataSlots[i].y + -deltaY);
			enemyDataSlots[i].y = cast(ubyte)tmp;
			if ((tmp >= 0x100) && (enemyDataSlots[i].status == 1)) {
				enemyDataSlots[i].yScreen++;
			}
		} else {
			ushort tmp = cast(ushort)(enemyDataSlots[i].y - deltaY);
			enemyDataSlots[i].y = cast(ubyte)tmp;
			if ((tmp >= 0x100) && (enemyDataSlots[i].status == 1)) {
				enemyDataSlots[i].yScreen--;
			}
		}
		if (deltaX < 0) {
			ushort tmp = cast(ushort)(enemyDataSlots[i].x + -deltaX);
			enemyDataSlots[i].x = cast(ubyte)tmp;
			if ((tmp >= 0x100) && (enemyDataSlots[i].status == 1)) {
				enemyDataSlots[i].xScreen++;
			}
		} else {
			ushort tmp = cast(ushort)(enemyDataSlots[i].x - deltaX);
			enemyDataSlots[i].x = cast(ubyte)tmp;
			if ((tmp >= 0x100) && (enemyDataSlots[i].status == 1)) {
				enemyDataSlots[i].xScreen--;
			}
		}
		//scrollEnemiesSaveToWRAM();
		if (--scrollEnemiesNumEnemiesLeft == 0) {
			break;
		}
	}
}

void scrollEnemiesLoadToHRAM() {
	enemyWorking.status = enemyWRAM.status;
	enemyWorking.y = enemyWRAM.y;
	enemyWorking.x = enemyWRAM.x;
	enemyWorking.yScreen = enemyWRAM.yScreen;
	enemyWorking.xScreen = enemyWRAM.xScreen;
}

void scrollEnemiesSaveToWRAM() {
	enemyWRAM.y = enemyWorking.y;
	enemyWRAM.x = enemyWorking.x;
	enemyWRAM.yScreen = enemyWorking.yScreen;
	enemyWRAM.xScreen = enemyWorking.xScreen;
}

immutable ubyte[][] queenNeckPatterns = [
	QueenNeckPattern.downCurveUp: [0x81, 0x33, 0x33, 0x32, 0x32, 0x32, 0x32, 0x33, 0x23, 0x23, 0x24, 0x23, 0x23, 0x23, 0x24, 0x13, 0x13, 0x13, 0x13, 0x13, 0x00, 0x80],
	QueenNeckPattern.upCurveUp: [0x81, 0xE3, 0xE3, 0xE3, 0xE3, 0xE3, 0xE2, 0xE2, 0xE2, 0xE2, 0xE2, 0xE2, 0xD2, 0xD2, 0xD2, 0xD2, 0xD2, 0xD2, 0x00, 0x00, 0x00, 0x80],
	QueenNeckPattern.downCurveDown: [0x81, 0x01, 0x01, 0x01, 0x01, 0xF1, 0x01, 0xF1, 0xF1, 0xF1, 0xF1, 0xF1, 0xF1, 0xF2, 0xF2, 0xE2, 0xE2, 0xE2, 0xE2, 0xE2, 0xE2, 0xE2, 0xD2, 0xD2, 0xD2, 0xD2, 0xD2, 0x00, 0x00, 0x00, 0x80],
	QueenNeckPattern.upCurveDown: [0x81, 0x01, 0x02, 0x12, 0x02, 0x12, 0x12, 0x12, 0x12, 0x13, 0x13, 0x13, 0xF3, 0x03, 0x03, 0xF3, 0x03, 0xF3, 0xF3, 0xF3, 0x00, 0x00, 0x00, 0x00, 0x80],
	QueenNeckPattern.vomiting: [0x81, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x02, 0x12, 0x02, 0x12, 0x02, 0x12, 0x12, 0x12, 0x12, 0x12, 0x22, 0x22, 0x22, 0x23, 0x23, 0x33, 0x33, 0x33, 0x00, 0x00, 0x00, 0x80],
	QueenNeckPattern.dying: [0x81, 0x93, 0x93, 0x93, 0xD3, 0x00, 0x00, 0x00, 0x80],
	QueenNeckPattern.forward: [0x81, 0x10, 0x20, 0x20, 0x20, 0x20, 0x20, 0x21, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x20, 0x21, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x21, 0x21, 0x21, 0x20, 0x20, 0x20, 0x20, 0x20, 0x21, 0x21, 0x21, 0x00, 0x80],
];

void queenInitialize() {
	assert(0); // TODO
}

void queenDeactivateActorsNeck() {
	queenDeactivateActorsArbitrary(&enemyDataSlots[ReservedEnemySlots.queenNeck], 6);
}

void queenDeactivateActorsArbitrary(EnemySlot* slot, ubyte count) {
	while(count--) {
		(slot++).status = 0xFF;
	}
}

void queenAdjustWallSpriteToHead() {
	assert(0); // TODO
}

void queenHandler() {
	assert(0); // TODO
}

void queenHeadCollision() {
	assert(0); // TODO
}

void queenSetActorPositions() {
	assert(0); // TODO
}

void queenDrawHead() {
	assert(0); // TODO
}

void queenDrawFeed() {
	assert(0); // TODO
}

void queenWriteOAM() {
	assert(0); // TODO
}

void queenGetCameraDelta() {
	assert(0); // TODO
}

void queenAdjustBodyForCamera() {
	assert(0); // TODO
}

void queenAdjustSpritesForCamera() {
	assert(0); // TODO
}

void queenSingleCameraAdjustment() {
	assert(0); // TODO
}

void queenDrawNeck() {
	assert(0); // TODO
}

void queenMoveNeck() {
	assert(0); // TODO
}

void queenMissileHurt() {
	assert(0); // TODO
}

void queenLoadNeckBasePointer() {
	assert(0); // TODO
}

void queenSetNeckBasePointer() {
	assert(0); // TODO
}

void queenHandleState() {
	assert(0); // TODO
}

void queenGetSamusTargets() {
	assert(0); // TODO
}

void queenSpawnOneProjectile() {
	assert(0); // TODO
}

void queenDrawProjectiles() {
	assert(0); // TODO
}

void queenDrawOneProjectileMetasprite() {
	assert(0); // TODO
}

void queenDrawOneProjectileSprite() {
	assert(0); // TODO
}

void queenHandleProjectiles() {
	assert(0); // TODO
}

void queenProjectileSeek() {
	assert(0); // TODO
}

void queenProjectileSeekOneAxis() {
	assert(0); // TODO
}

void queenMoveOneProjectile() {
	assert(0); // TODO
}

void queenSetDefaultNeckAttributes() {
	assert(0); // TODO
}

void queenCloseFloor() {
	assert(0); // TODO
}

void queenKillFromStomach() {
	assert(0); // TODO
}

void queenDisintegrate() {
	assert(0); // TODO
}

void queenWalk() {
	assert(0); // TODO
}

void lcdcInterruptHandler() {
	assert(0); // TODO
}

void vblankDrawQueen() {
	assert(0); // TODO
}
