module metroid2.bank03;

import metroid2.defs;
import metroid2.enemies;
import metroid2.external;
import metroid2.globals;

import replatform64.gameboy;

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
	version(original) {} else {
		import std.algorithm.comparison : clamp;
		enemyWorking.counter = clamp(enemyWorking.counter, ubyte(0), cast(ubyte)(speedTable.length - 1));
		enemyWorking.state = clamp(enemyWorking.state, ubyte(0), cast(ubyte)(speedTable.length - 1));
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
	oamScratchpad[] = OAMEntry.init;
	queenBodyY = 103;
	queenBodyHeight = 55;
	gb.STAT = 0b01000100;
	queenBodyX = 92;
	queenCameraX = scrollX;
	gb.WX = 3;
	queenHeadX = 3;
	queenCameraY = scrollY;
	gb.WY = 0x70;
	queenHeadY = 0x70;
	queenInterruptListBuffer[] = InterruptCommand(0xFF);
	queenInterruptList = null;
	queenNeckYMovementSum = 9;
	queenNeckXMovementSum = 9;
	queenOAMScratchpad = &oamScratchpad[0];
	for (int i = 0; i < 12; i++) {
		oamScratchpad[i + QueenOAM.wall].y = cast(ubyte)(120 + 8 * i);
		oamScratchpad[i + QueenOAM.wall].x = 162;
		oamScratchpad[i + QueenOAM.wall].tile = 176;
		oamScratchpad[i + QueenOAM.wall].flags.raw = 0;
	}
	queenAdjustWallSpriteToHead();
	queenNextState = &queenStateList[0];
	queenState = QueenState.introA;

	enemyDataSlots[0 .. 13] = EnemySlot.init;
	queenHealth = 150;

	queenSetActorPositions();

	enemyDataSlots[ReservedEnemySlots.queenBody].spriteType = Actor.queenBody;
	enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType = Actor.queenMouthClosed;
	enemyDataSlots[ReservedEnemySlots.queenHeadL].spriteType = Actor.queenHeadLeft;
	enemyDataSlots[ReservedEnemySlots.queenHeadR].spriteType = Actor.queenHeadRight;
	foreach(i; ReservedEnemySlots.queenNeck .. ReservedEnemySlots.queenNeck6 + 1) {
		enemyDataSlots[i].spriteType = Actor.queenNeck;
	}
	queenDeactivateActorsNeck();
	queenHeadFrameNext = 1;
	queenHeadFrame = 1;
	queenDelayTimer = 140;
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
	ubyte y = cast(ubyte)(queenHeadY + 16);
	for (int i = 0; i < 5; i++) {
		oamScratchpad[i + QueenOAM.wallHead].y = y;
		y += 8;
	}
}

void queenHandler() {
	if (deathFlag) {
		queenFootFrame = 0;
		queenHeadFrameNext = 0;
		queenDeathBitmask = 0;
		queenWriteOAM();
		return;
	}
	if (!(frameCounter & 3) && queenBodyPalette) {
		queenBodyPalette ^= 0x90;
		for (int i = 0; i < 12; i++) {
			oamScratchpad[QueenOAM.start].flags.raw ^= 0x10; // make queen flash
		}
	}
	if (queenHealth && (queenHealth < 100)) {
		queenMidHealthFlag = 1;
		if (queenHealth < 50) {
			queenLowHealthFlag = 1;
		}
	}
	queenHandleState();
	queenWalk();
	queenMoveNeck();
	queenDrawNeck();
	queenGetCameraDelta();
	queenAdjustBodyForCamera();
	queenAdjustSpritesForCamera();
	queenSetActorPositions();
	queenAdjustWallSpriteToHead();
	queenWriteOAM();
	queenHeadCollision();
}

void queenHeadCollision() {
	if (queenFlashTimer) {
		if (--queenFlashTimer == 0) {
			queenBodyPalette = 0;
			queenSetDefaultNeckAttributes();
		}
	}
	const weaponTypeTmp = collision.weaponType;
	collision.weaponType = CollisionType.nothing;

	if ((weaponTypeTmp == CollisionType.nothing) || (weaponTypeTmp != CollisionType.missiles)) {
		return;
	}
	if ((collision.enemy == &enemyDataSlots[ReservedEnemySlots.queenMouth]) && (enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType == Actor.queenMouthOpen)) {
		return;
	} else if ((collision.enemy == &enemyDataSlots[ReservedEnemySlots.queenHeadL]) || (collision.enemy == &enemyDataSlots[ReservedEnemySlots.queenHeadL])) {
		return;
	}
	queenMissileHurt();
	queenFlashTimer = 8;
	if (queenBodyPalette) {
		return;
	}
	queenBodyPalette = 0x93;
	if (queenLowHealthFlag) {
		audio.sfxRequestNoise = NoiseSFX.u0A;
	} else {
		audio.sfxRequestNoise = NoiseSFX.u09;
	}
}

void queenSetActorPositions() {
	enemyDataSlots[ReservedEnemySlots.queenBody].y = cast(ubyte)(queenBodyY + 24);
	enemyDataSlots[ReservedEnemySlots.queenBody].x = cast(ubyte)(-queenBodyX + 48);

	enemyDataSlots[ReservedEnemySlots.queenHeadL].y = cast(ubyte)(queenHeadY + 16);
	enemyDataSlots[ReservedEnemySlots.queenHeadL].x = queenHeadX;

	enemyDataSlots[ReservedEnemySlots.queenHeadR].y = cast(ubyte)(queenHeadY + 16);
	enemyDataSlots[ReservedEnemySlots.queenHeadR].x = cast(ubyte)(queenHeadX + 32);

	ubyte xMod = 18;
	ubyte yMod = 14;
	if (enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType == Actor.queenMouthStunned) {
		xMod = 21;
		yMod = 18;
	}

	enemyDataSlots[ReservedEnemySlots.queenMouth].x = cast(ubyte)(queenHeadX + xMod);
	enemyDataSlots[ReservedEnemySlots.queenMouth].y = cast(ubyte)(queenHeadY + yMod);

	queenDeactivateActorsNeck();
	if (queenHealth == 0) {
		return;
	}
	if (queenStomachBombedFlag) {
		if (queenProjectilesActive) {
			return;
		}
		if (queenOAMScratchpad is null) {
			return;
		}
		enemyDataSlots[ReservedEnemySlots.queenNeck3].spriteType = Actor.queenNeck;
		auto currentOAMSlot = queenOAMScratchpad;
		for (int i = ReservedEnemySlots.queenNeck; i <= ReservedEnemySlots.queenNeck6; i++) {
			enemyDataSlots[i].x = currentOAMSlot.x;
			enemyDataSlots[i].y = currentOAMSlot.y;
			enemyDataSlots[i].status = 0;
			currentOAMSlot -= 2;
		}
	} else {
		enemyDataSlots[ReservedEnemySlots.queenNeck].status = 0;
		enemyDataSlots[ReservedEnemySlots.queenNeck].y = oamScratchpad[QueenOAM.neck].y;
		enemyDataSlots[ReservedEnemySlots.queenNeck].x = oamScratchpad[QueenOAM.neck].x;
		enemyDataSlots[ReservedEnemySlots.queenNeck].spriteType = Actor.queenBentNeck;
	}
}

immutable ubyte[][3] queenHeadFrames = [
	[
		0xBB, 0xB1, 0xB2, 0xB3, 0xB4, 0xFF,
		0xC0, 0xC1, 0xC2, 0xC3, 0xC4, 0xFF,
		0xD0, 0xD1, 0xD2, 0xD3, 0xD4, 0xD5,
		0xFF, 0xFF, 0xE2, 0xE3, 0xE4, 0xE5,
		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	], [
		0xBB, 0xB1, 0xF5, 0xB8, 0xB9, 0xBA,
		0xC0, 0xC1, 0xC7, 0xC8, 0xC9, 0xCA,
		0xD0, 0xE6, 0xD7, 0xD8, 0xFF, 0xFF,
		0xFF, 0xF6, 0xE7, 0xE8, 0xFF, 0xFF,
		0xFF, 0xFF, 0xF7, 0xF8, 0xFF, 0xFF,
		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	], [
		0xFF, 0xBC, 0xBD, 0xBE, 0xFF, 0xFF,
		0xFF, 0xCB, 0xCC, 0xCD, 0xFF, 0xFF,
		0xDA, 0xDB, 0xDC, 0xDD, 0xFF, 0xFF,
		0xEA, 0xEB, 0xEC, 0xED, 0xDE, 0xFF,
		0xFA, 0xFB, 0xFC, 0xFD, 0xEE, 0xD9,
		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	]
];

void queenDrawHead() {
	static void resumeB(ushort destination, const(ubyte)* tiles) {
		for (int i = 3; i > 0; i--) {
			for (int j = 6; j > 0; j--) {
				gb.vram[destination++ - 0x8000] = (tiles++)[0];
			}
			destination += 26;
		}
		if (queenHeadFrameNext == 0xFF) {
			queenHeadFrameNext = 0;
		} else {
			queenHeadDest = destination & 0xFF;
			queenHeadSrc = tiles;
			queenHeadFrameNext = 0xFF;
		}
	}
	static void resumeA() {
		resumeB(VRAMDest.queenHeadRow1 + queenHeadDest, queenHeadSrc);
	}
	if (queenHeadFrameNext == 0) {
		return;
	}
	if (queenHeadFrameNext == 0xFF) {
		resumeA();
	}
	const(ubyte)* tiles = &queenHeadFrames[0][0];
	if (queenHeadFrameNext != 1) {
		tiles = &queenHeadFrames[1][0];
		if (queenHeadFrameNext != 2) {
			tiles = &queenHeadFrames[2][0];
		}
	}
	resumeB(VRAMDest.queenHeadRow1, tiles);
}

void queenDrawFeet() {
	if (queenFootFrame == 0) {
		return queenDrawHead();
	}
	if (queenFootAnimCounter != 0) {
		queenFootAnimCounter--;
		return queenDrawHead();
	}
	queenFootAnimCounter = 1;
	auto tilemaps = (queenFootFrame & 0x80) ? queenRearFootPointers : queenFrontFootPointers;
	auto offsets = (queenFootFrame & 0x80) ? queenRearFootOffsets : queenFrontFootOffsets;
	ubyte tilesToUpdate = (queenFootFrame & 0x80) ? 16 : 12;
	immutable(ubyte)* offset = &offsets[0];
	immutable(ubyte)* tile = &tilemaps[(queenFootFrame & 0x7F) - 1][0];
	while (tilesToUpdate--) {
		gb.vram[VRAMDest.queenFeet - 0x8000 + (offset++)[0]] = (tile++)[0];
	}
	ubyte a = queenFootFrame;
	if (a & 0x80) {
		a++;
	}
	a ^= 0x80;
	a &= 0x83;
	if (a == 0) {
		a++;
	}
	queenFootFrame = a;
}

immutable ubyte[][3] queenRearFootPointers = [
	[
		0x21, 0x22, 0x23, 0x24,
		0x30, 0x31, 0x32, 0x33,
		0x40, 0x41, 0x42, 0x44,
		0x50, 0x51, 0x52, 0x53,
	], [
		0x2C, 0x2D, 0x2E, 0x2F,
		0x3B, 0x3C, 0x3D, 0x3E,
		0x4B, 0x4C, 0x4D, 0x4F,
		0x7F, 0xF2, 0xEF, 0xDF,
	], [
		0x2C, 0x2D, 0x2E, 0x2F,
		0x3B, 0x3C, 0x3D, 0x3E,
		0x4B, 0x4C, 0x4D, 0x4F,
		0x10, 0x11, 0x12, 0xDF,
	]
];
immutable ubyte[][3] queenFrontFootPointers = [
	[
		0x28, 0x29, 0x2A,
		0x38, 0x39, 0x3A,
		0x48, 0x49, 0x4A,
		0xFE, 0xF9, 0xF4,
	], [
		0x1B, 0x1C, 0x1D,
		0x03, 0x04, 0x05,
		0x0E, 0x0F, 0x1F,
		0xFF, 0xFF, 0xFF,
	], [
		0x1B, 0x1C, 0x1D,
		0x03, 0x04, 0x05,
		0x0E, 0x0F, 0x1F,
		0x00, 0x01, 0x02,
	]
];

immutable ubyte[] queenRearFootOffsets = [
	0x01, 0x02, 0x03, 0x04,
	0x20, 0x21, 0x22, 0x23,
	0x40, 0x41, 0x42, 0x44,
	0x60, 0x61, 0x62, 0x63,
];
immutable ubyte[] queenFrontFootOffsets = [
	0x08, 0x09, 0x0A,
	0x28, 0x29, 0x2A,
	0x48, 0x49, 0x4A,
	0x68, 0x69, 0x6A,
];

void queenWriteOAM() {
	auto hl = &oamBuffer[QueenOAM.start];
	auto de = &oamBuffer[oamBufferIndex];
	for (ubyte c = 6; c != 0; c--) {
		if (queenOAMScratchpad + 2 == hl) {
			break;
		}
		(de++)[0] = (hl++)[0];
		oamBufferIndex++;
		(de++)[0] = (hl++)[0];
		oamBufferIndex++;
	}
	hl = &oamBuffer[QueenOAM.wall];
	for (short i = QueenOAM.wallEnd - QueenOAM.wall; i > 0; i--) {
		(de++)[0] = (hl++)[0];
		oamBufferIndex++;
	}
}

void queenGetCameraDelta() {
	const tmpY = queenCameraY;
	const a = (scrollY >= 248) ? 0 : scrollY;
	queenCameraY = a;
	queenCameraDeltaY = cast(ubyte)(a - tmpY);

	const tmpX = queenCameraX;
	queenCameraX = scrollX;
	queenCameraDeltaX = cast(ubyte)(scrollX - tmpX);
}

void queenAdjustBodyForCamera() {
	queenBodyX += queenCameraDeltaX;
	queenHeadX -= queenCameraDeltaX;

	queenHeadY -= queenCameraDeltaY;
	const c = (scrollY >= 248) ? 0 : scrollY;
	if (103 >= c) {
		queenBodyY = cast(ubyte)(103 - c);
		queenBodyHeight = 55;
	} else {
		queenBodyHeight = cast(ubyte)(103 - c + 55);
		queenBodyY = 0;
	}
}

void queenAdjustSpritesForCamera() {
	const b = queenCameraDeltaX;
	const c = queenCameraDeltaY;
	if (queenOAMScratchpad != null) {
		auto scratchpad = &queenOAMScratchpad[queenStomachBombedFlag ? 0 : 1];
		while (scratchpad >= &oamScratchpad[1]) {
			scratchpad[0].x -=b;
			scratchpad[0].y -=c;
			scratchpad--;
		}
		for (ubyte d = 3; d != 0; d--) {
			queenSingleCameraAdjustment(&enemyDataSlots[ReservedEnemySlots.queenSpitA + 3 - d], b, c);
		}
		for (ubyte d = 3; d != 0; d--) {
			queenSingleCameraAdjustment(&queenSamusTargetPoints[3 - d], b, c);
		}
	}
	for (ubyte d = 12; d != 0; d--) {
		oamScratchpad[QueenOAM.wall + 12 - d].y -= c;
		oamScratchpad[QueenOAM.wall + 12 - d].x -= b;
	}
	queenAdjustWallSpriteToHead();
}

void queenSingleCameraAdjustment(EnemySlot* hl, ubyte b, ubyte c) {
	hl.y -= c;
	hl.x -= b;
}

void queenSingleCameraAdjustment(Coords* hl, ubyte b, ubyte c) {
	hl.y -= c;
	hl.x -= b;
}

void queenDrawNeck() {
	auto oamScratch = queenOAMScratchpad;
	if (!queenNeckDrawingState) {
		return;
	}
	if (queenNeckDrawingState != 1) {
		if ((queenNeckXMovementSum < 8) && (queenNeckYMovementSum < 12)) {
			return;
		}
		queenNeckXMovementSum = 7;
		queenNeckYMovementSum = 7;
		oamScratch[0].y = 0xFF;
		oamScratch[1].y = 0xFF;
		oamScratch -= 2;
		queenOAMScratchpad = oamScratch;
		return;
	}
	if ((queenNeckXMovementSum < 8) && (queenNeckYMovementSum < 12)) {
		return;
	}
	queenNeckXMovementSum = 0;
	queenNeckYMovementSum = 0;
	if (oamScratch is &oamScratchpad[10]) {
		return;
	}
	const b = (queenHeadFrame == 3) ? 39 : 21;
	oamScratch[0].y = cast(ubyte)(queenHeadY + b);
	oamScratch[0].x = queenHeadX - 0;
	oamScratch[0].tile = 0xB5;
	oamScratch[0].flags.raw = OAMFlags.priority;
	oamScratch[1].y = cast(ubyte)(queenHeadY + b + 8);
	oamScratch[1].x = queenHeadX;
	oamScratch[1].tile = 0xC5;
	oamScratch[1].flags.raw = OAMFlags.priority;
	oamScratch += 2;
	queenOAMScratchpad = oamScratch;
}

void queenMoveNeck() {
	if (queenNeckControl == 0) {
		return;
	}
	if (queenNeckControl == 3) {
		queenHeadX += queenWalkSpeed;
		return;
	}
	if (queenNeckControl == 1) {
		auto neckPattern = queenNeckPattern;
		if (!(frameCounter & 1)) {
			return;
		}
		if (neckPattern[0] != 0x81) {
			ubyte a = swap(neckPattern[0] & 0xF0);
			if (a & 0x8) {
				a |= 0xF0;
				a = cast(ubyte)-a;
			} else {
				a = cast(ubyte)-a;
			}
			queenHeadY += a;
			if (a & 0x80) {
				a = cast(ubyte)-a;
			}
			queenNeckYMovementSum += a;
			queenHeadX -= neckPattern[0] & 0xF;
			queenNeckXMovementSum -= neckPattern[0] & 0xF;
			neckPattern--;
		} else {
			queenNeckControl = 0;
			queenNeckDrawingState = 0;
			queenNeckStatus = 0x82;
			queenEatingState = 0;
			enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType = Actor.queenMouthClosed;
			queenOAMScratchpad = &oamScratchpad[0];
			queenNeckXMovementSum = 9;
			queenNeckYMovementSum = 9;
			neckPattern = queenNeckPatternBase;
		}
		queenNeckPattern = neckPattern;
		return;
	}
	if (queenEatingState == 16) {
		if (enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType != Actor.queenMouthOpen) {
			if (queenStunTimer) {
				if (--queenStunTimer == 88) {
					queenBodyPalette = 0;
					queenSetDefaultNeckAttributes();
				}
			} else {
				queenStunTimer = 96;
				queenBodyPalette = 0x93;
				audio.sfxRequestNoise = NoiseSFX.u0A;
				enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType = Actor.queenMouthOpen;
			}
			return;
		}
	}
	if (queenEatingState == 1) {
		return;
	}
	if (queenEatingState != 2) {
		auto neckPattern = queenNeckPattern;
		while (true) {
			if (neckPattern[0] == 0x80) {
				queenNeckControl = 0;
				queenNeckDrawingState = 0;
				queenNeckStatus = 0x81;
				neckPattern--;
				break;
			}
			ubyte a = neckPattern[0] & 0xF0;
			if (a & 0x80) {
				a |= 0xF;
			}
			a = swap(a);
			if (a + queenHeadY >= 208) {
				if (!queenStomachBombedFlag) {
					queenState = QueenState.preparingNeckRetraction;
					queenWalkStatus = 0;
					queenNeckStatus = 0;
				} else {
					queenState = QueenState.vomittingSamus;
				}
				break;
			}
			queenHeadY += a;
			a = swap(neckPattern[0] & 0xF0);
			if (neckPattern[0] & 0x8) { //check if it was negative, MSB shifted over
				a |= 0xF0;
				a = cast(ubyte)-a;
			}
			queenNeckYMovementSum += a;
			queenHeadX += neckPattern[0] & 0xF;
			queenNeckXMovementSum += neckPattern[0] & 0xF;
			neckPattern++;
			if (!queenLowHealthFlag) {
				break;
			}
			queenLowHealthFlag = 0;
			queenDrawNeck();
		}
		queenNeckPattern = neckPattern;
		return;
	}
	queenBodyPalette = 0;
	queenSetDefaultNeckAttributes();
	queenState = QueenState.preparingEatSamus;
}

void queenMissileHurt() {
	if (queenHealth == 0) {
		return;
	}
	if (--queenHealth != 0) {
		return;
	}
	queenNeckStatus = 0x81;
	queenState = QueenState.preparingDeath;
	queenNeckControl = 0;
	queenWalkControl = 0;
	queenFootFrame = 0;
	queenHeadFrameNext = 0;
	queenDeactivateActorsNeck();
	queenDeactivateActorsArbitrary(&enemyDataSlots[ReservedEnemySlots.queenBody], 4);
	queenCloseFloor();
}

const(ubyte)* queenLoadNeckBasePointer() {
	return queenNeckPatternBase;
}

void queenSetNeckBasePointer() {
	queenNeckPatternBase = &queenNeckPatterns[queenNeckPatternID][0];
}

/**
 * 0xFF - repeat
 */
immutable ubyte[] queenStateList = [
	QueenState.preparingForwardWalk,
	QueenState.preparingNeckExtension,
	QueenState.preparingNeckRetraction,
	QueenState.preparingNeckExtension,
	QueenState.preparingNeckRetraction,
	QueenState.preparingBackwardWalk,
	QueenState.preparingProjectiles,
	0xFF
];

void queenHandleState() {
	final switch (cast(QueenState)queenState) {
		case QueenState.preparingForwardWalk:
			queenWalkCounter = 0;
			queenNeckDrawingState = 0;
			queenWalkControl = 1;
			queenNeckControl = 3;
			queenFootFrame = 2;
			queenState = QueenState.forwardWalk;
			break;
		case QueenState.forwardWalk:
			if (queenWalkStatus != 0x81) {
				return;
			}
			queenFootFrame = 0;
			goto case QueenState.pickNextState;
		case QueenState.preparingNeckExtension:
			enemyDataSlots[ReservedEnemySlots.queenMouth].status = 0;
			queenNeckControl = 1;
			queenNeckDrawingState = 1;
			queenState = QueenState.extendingNeck;
			queenNeckSelectionFlag ^= 1;
			if (!queenMidHealthFlag && queenNeckSelectionFlag) {
				queenNeckPatternID = QueenNeckPattern.downCurveDown;
				if (queenHeadY > 70) { // switch upwards if head below 70 pixels on screen (ie samus is high in the air)
					queenNeckPatternID = QueenNeckPattern.upCurveDown;
					queenHeadY -= 16;
					queenHeadFrameNext = 3;
					queenHeadFrame = 3;
				}
			} else {
				queenNeckPatternID = QueenNeckPattern.downCurveUp;
				if (queenHeadY > 41) {
					queenNeckPatternID = QueenNeckPattern.forward;
					if (queenHeadY > 76) {
						queenNeckPatternID = QueenNeckPattern.upCurveUp;
						queenHeadY -= 16;
					}
				}
				queenHeadFrameNext = 3;
				queenHeadFrame = 3;
				if (queenNeckPatternID != QueenNeckPattern.upCurveUp) {
					queenHeadFrameNext = 2;
					queenHeadFrame = 2;
					if ((gb.DIV & 3) != 0) {
						enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType = Actor.queenMouthOpen;
					}
				}
			}
			queenSetNeckBasePointer();
			queenNeckPattern = queenLoadNeckBasePointer() + 1;
			break;
		case QueenState.extendingNeck:
			if (queenNeckStatus != 0x81) {
				break;
			}
			goto case QueenState.pickNextState;
		case QueenState.preparingNeckRetraction:
			if (queenNeckPattern[0] == 0x81) { // fully extended
				goto case QueenState.pickNextState;
			}
			queenNeckDrawingState = 2;
			queenNeckControl = 2;
			if (queenHeadFrame == 3) { // facing upwards, move down a lil bit
				queenHeadY += 16;
			}
			queenHeadFrameNext = 1;
			queenHeadFrame = 1;
			enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType = Actor.queenMouthClosed;
			queenState = QueenState.retractingNeck;
			queenNeckPattern = queenNeckPattern - 1;
			break;
		case QueenState.retractingNeck:
			if (queenNeckStatus == 0x82) { // wait until done retracting
				goto case QueenState.pickNextState;
			}
			break;
		case QueenState.preparingBackwardWalk:
			queenWalkControl = 2;
			queenNeckControl = 3;
			queenNeckDrawingState = 0;
			queenFootFrame = 2;
			queenState = QueenState.backwardWalk;
			break;
		case QueenState.backwardWalk:
			if (queenWalkStatus == 0x82) {
				queenFootFrame = 0;
				goto case QueenState.pickNextState;
			}
			break;
		case QueenState.stomachBombed:
			static immutable queenBentNeckSprite = [
				BentNeckSprite(0, 0, 0xB5),
				BentNeckSprite(8, 0, 0xC5),
				BentNeckSprite(0, 8, 0xB6),
				BentNeckSprite(0, 16, 0xB7),
				BentNeckSprite(8, 12, 0xC6),
			];
			// dead code
			if ((queenHeadY == 0x2C) || (queenHeadY == 0x71)) {}
			queenNeckControl = 1;
			queenNeckDrawingState = 0;
			queenHeadFrameNext = 3;
			queenHeadFrame = 3;
			queenState = QueenState.preparingSamusVomit;
			for (ubyte i = 0; i < queenBentNeckSprite.length; i++) {
				oamScratchpad[QueenOAM.neck + i].y = cast(ubyte)(queenBentNeckSprite[i].y + queenHeadY + 20);
				oamScratchpad[QueenOAM.neck + i].x = cast(ubyte)(queenBentNeckSprite[i].x + queenHeadX + 2);
				oamScratchpad[QueenOAM.neck + i].tile = queenBentNeckSprite[i].tile;
				oamScratchpad[QueenOAM.neck + i].flags.raw = OAMFlags.priority;
			}
			queenOAMScratchpad = &oamScratchpad[QueenOAM.neck + queenBentNeckSprite.length - 1];
			queenNeckPatternID = QueenNeckPattern.vomiting;
			queenStomachBombedFlag = 4;
			queenSetNeckBasePointer();
			queenNeckPattern++;
			break;
		case QueenState.preparingSamusVomit:
			if (queenNeckStatus == 0x81) { // wait for neck to extend
				queenDelayTimer = 80;
				queenState = QueenState.vomittingSamus;
			}
			break;
		case QueenState.vomittingSamus:
			if (queenDelayTimer != 0) {
				queenDelayTimer--;
				if (queenFootFrame == 2) {
					queenFootFrame = 0;
				}
			} else {
				queenBodyPalette = 0;
				if (queenHealth == 0) {
					queenKillFromStomach();
					break;
				}
				if (queenHealth <= 30) {
					queenHealth -= 30;
					queenKillFromStomach();
					break;
				}
				queenHealth -= 30;
				queenNeckControl = 2;
				queenState = QueenState.doneVomittingSamus;
				queenNeckPattern--;
			}
			break;
		case QueenState.doneVomittingSamus:
			if (queenNeckStatus != 0x82) { // wait for neck to retract
				break;
			}
			queenHeadFrameNext = 1;
			queenHeadFrame = 1;
			queenStomachBombedFlag = 0;
			for (ubyte i = 0; i != 5; i++) {
				oamScratchpad[QueenOAM.neck + i].y = 0xFF;
				oamScratchpad[QueenOAM.neck + i].flags.raw = OAMFlags.priority;
			}
			queenOAMScratchpad = &oamScratchpad[0];
			goto case QueenState.pickNextState;
		case QueenState.pickNextState:
			auto nextState = queenNextState;
			while (true) {
				if (nextState[0] != 0xFF) {
					queenState = (nextState++)[0];
					queenNextState = nextState;
					break;
				} else {
					nextState = &queenStateList[0];
				}
			}
			break;
		case QueenState.preparingEatSamus:
			if (queenNeckPattern[0] == 0x81) { // pick something else if neck extended
				goto case QueenState.pickNextState;
			}
			queenNeckDrawingState = 2;
			queenNeckControl = 2;
			if (queenHeadFrame == 3) { // adjust head downwards if open
				queenHeadY += 16;
			}
			queenHeadFrameNext = 1;
			queenHeadFrame = 1;
			queenNeckStatus = 0;
			// close mouth
			enemyDataSlots[ReservedEnemySlots.queenMouth].status = 0xFF;
			enemyDataSlots[ReservedEnemySlots.queenMouth].spriteType = Actor.queenMouthClosed;

			queenState = QueenState.retractNeckEating;
			queenNeckPattern--;
			break;
		case QueenState.retractNeckEating:
			if (queenNeckStatus == 0x82) {
				queenEatingState = 3;
				queenState = QueenState.samusEaten;
				queenFootFrame = 1;
			}
			break;
		case QueenState.samusEaten:
			if (queenEatingState == 4) {
				if (queenHealth <= 10) {
					queenHealth = 0;
					queenEatingState = 32;
					queenState = QueenState.stomachBombed;
					queenBodyPalette = 0x93;
					audio.sfxRequestNoise = NoiseSFX.u0A;
				} else {
					queenHealth -= 10;
					queenEatingState = 5;
					queenHeadFrameNext = 2;
					queenHeadFrame = 2;
					queenState = QueenState.vomittingOutMouth;
					queenStunTimer = 62;
					queenBodyPalette = 0x93;
					audio.sfxRequestNoise = NoiseSFX.u0A;
				}
			} else if ((queenEatingState != 6) && (queenEatingState != 7)) {
				queenEatingState = 8;
				queenState = QueenState.stomachBombed;
				queenBodyPalette = 0x93;
				audio.sfxRequestNoise = NoiseSFX.u0A;
			}
			break;
		case QueenState.vomittingOutMouth:
			if (queenStunTimer != 0) {
				if (--queenStunTimer == 46) { // end of damage flash
					queenBodyPalette = 0;
					queenSetDefaultNeckAttributes();
				}
				if (queenFootFrame == 2) {
					queenFootFrame = 0;
				}
			} else {
				queenEatingState = 0;
				queenHeadFrameNext = 1;
				queenHeadFrame = 1;
				queenState = QueenState.preparingBackwardWalk;
				queenNextState = &queenStateList[6];
			}
			break;
		case QueenState.preparingDeath:
			if (queenNeckStatus != 0x81) { // wait for head to fall
				break;
			}
			queenDelayTimer = 80;
			queenState = QueenState.disintegrating;
			queenDeathAnimCounter = 5;
			queenHealth = 0;
			queenDeathArrayIndex = 0;
			queenDeathArray = [0xEE, 0xBB, 0xDD, 0x77, 0xEE, 0xBB, 0xDD, 0x77];
			earthquakeTimer = 0xD0;
			audio.songRequest = Song.earthquake;
			queenEatingState = 0x22;
			break;
		case QueenState.disintegrating:
			if (queenDelayTimer != 0) {
				queenDelayTimer--;
				if (queenDelayTimer == 76) {
					samusCurHealth = ((samusEnergyTanks + 1) * 100) - 1;
				}
				break;
			}
			if (queenDeathBitmask) {
				break;
			}
			queenDeathChr = queenDeathArray[queenDeathArrayIndex] | QueenDeathTile.first;
			queenDeathArrayIndex = (queenDeathArrayIndex + 3) & 7;
			if (queenDeathArrayIndex == 0) {
				if (--queenDeathAnimCounter == 0) {
					queenDeleteBody = &gb.vram[QueenDeathTile.bodyStart - 0x8000];
					queenState = QueenState.deleteBody;
					break;
				}
			}
			queenDeathArray[queenDeathArrayIndex] = rl(rl(rl(queenDeathArray[queenDeathArrayIndex])));
			queenDeathBitmask = queenDeathArray[queenDeathArrayIndex];
			break;
		case QueenState.deleteBody:
			auto queenDeleteBodyTmp = queenDeleteBody;
			for (ubyte i = 0; i != 11; i++) {
				// write twice, just to make sure it actually goes through
				gb.waitHBlank();
				queenDeleteBodyTmp[0] = 0xFF;
				gb.waitHBlank();
				queenDeleteBodyTmp[0] = 0xFF;
				queenDeleteBodyTmp++;
			}
			queenDeleteBodyTmp += 21;
			if (queenDeleteBodyTmp != &gb.vram[QueenDeathTile.bodyEnd - 0x8000]) {
				queenDeleteBody = queenDeleteBodyTmp;
			} else {
				queenEatingState = 0;
				metroidCountDisplayed = 0;
				metroidCountReal = 0;
				queenState = QueenState.deathDone;
				metroidCountShuffleTimer = 128;
				audio.sfxRequestNoise = NoiseSFX.u17;
			}
			break;
		case QueenState.preparingProjectiles:
			queenGetSamusTargets();
			queenSpawnOneProjectile(&enemyDataSlots[ReservedEnemySlots.queenSpitA], cast(ubyte)(queenHeadY + 32), cast(ubyte)(queenHeadX + 28), 0x20);
			queenSpawnOneProjectile(&enemyDataSlots[ReservedEnemySlots.queenSpitB], cast(ubyte)(queenHeadY + 32), cast(ubyte)(queenHeadX + 28), 0x20);
			queenSpawnOneProjectile(&enemyDataSlots[ReservedEnemySlots.queenSpitC], cast(ubyte)(queenHeadY + 32), cast(ubyte)(queenHeadX + 28), 0x21);
			queenDrawProjectiles();
			queenProjectileChaseCounter = 14;
			queenHeadFrameNext = 2;
			queenDelayTimer = 32;
			queenProjectileChaseTimer = 16;
			queenState = QueenState.projectilesActive;
			queenOAMScratchpad = &oamScratchpad[0];
			break;
		case QueenState.projectilesActive:
			if (queenDelayTimer != 0) {
				if (--queenDelayTimer == 0) {
					queenHeadFrameNext = 1;
				}
			}
			queenHandleProjectiles();
			sw: switch (collision.weaponType) {
				case CollisionType.screwAttack:
				case CollisionType.missiles:
					// prepare to delete if projectile enemy slots are hit with missiles/screw attack
					if (collision.enemy >= &enemyDataSlots[ReservedEnemySlots.queenSpitA]) {
						collision.enemy.status = 0xFF;
					}
					goto default;
				case CollisionType.nothing:
				case CollisionType.contact:
				default:
					collision.weaponType = CollisionType.nothing;
					for (ubyte i = ReservedEnemySlots.queenSpitA; i != ReservedEnemySlots.queenSpitC + 1; i++) {
						if (enemyDataSlots[i].status != 0xFF) {
							queenDrawProjectiles();
							break sw;
						}
					}
					for (ubyte i = ReservedEnemySlots.queenSpitA; i != ReservedEnemySlots.queenSpitC + 1; i++) {
						enemyDataSlots[i].status = 0xFF;
					}
					// move body + spit sprites offscreen. queen body gets redrawn anyways?
					for (ubyte i = QueenOAM.start; i != QueenOAM.wall; i++) {
						oamScratchpad[i].y = 0xFF;
					}
					queenProjectilesActive = 0;
					queenOAMScratchpad = &oamScratchpad[0];
					break;
			}
			goto case QueenState.pickNextState;
		case QueenState.deathDone:
			// nothing to do here
			break;
		case QueenState.introA:
			if (queenDelayTimer) {
				queenDelayTimer--;
			} else {
				queenHeadFrameNext = 2;
				queenState = QueenState.introB;
				audio.sfxRequestNoise = queenLowHealthFlag ? NoiseSFX.u0A : NoiseSFX.u09;
				queenDelayTimer = 50;
			}
			break;
		case QueenState.introB:
			if (queenDelayTimer) {
				queenDelayTimer--;
			} else {
				queenHeadFrameNext = 1;
				queenState = QueenState.pickNextState;
			}
			break;
		case QueenState.nothing:
			// calls the null AI routine, which would normally crash since it's in a different bank...
			break;
	}
}

void queenGetSamusTargets() {
	queenSamusTargetPoints[0].y = samusOnScreenYPos;
	queenSamusTargetPoints[0].x = samusOnScreenXPos;

	queenSamusTargetPoints[1].y = cast(ubyte)(samusOnScreenYPos - 16);
	queenSamusTargetPoints[1].x = cast(ubyte)(samusOnScreenXPos - 16);

	queenSamusTargetPoints[2].y = cast(ubyte)(samusOnScreenYPos + 16);
	queenSamusTargetPoints[2].x = cast(ubyte)(samusOnScreenXPos + 16);
}

void queenSpawnOneProjectile(EnemySlot* actor, ubyte y, ubyte x, ubyte direction) {
	actor.status = 0;
	actor.y = y;
	actor.x = x;
	actor.spriteType = Actor.queenProjectile;
	actor.directionFlags = direction;
}

void queenDrawProjectiles() {
	OAMEntry* sprites = &oamScratchpad[QueenOAM.start];
	for (ubyte i = 0; i != 3; i++) {
		auto enemy = &enemyDataSlots[ReservedEnemySlots.queenSpitA + i];
		if (enemy.status == 0xFF) {
			queenDrawOneProjectileMetasprite(sprites, 0xF0, 0xF0);
		} else {
			if ((enemy.y >= 0xE0) || (enemy.x >= 0xE0)) {
				enemy.status = 0xFF;
			} else {
				queenDrawOneProjectileMetasprite(sprites, enemy.y, enemy.x);
			}
		}
	}
}

void queenDrawOneProjectileMetasprite(ref OAMEntry* sprites, ubyte y, ubyte x) {
	queenDrawOneProjectileSprite(sprites, y, x, 0xF1, OAMFlags.priority | OAMFlags.yFlip);
	queenDrawOneProjectileSprite(sprites, cast(ubyte)(y - 8), x, 0xF1, OAMFlags.priority);
	queenDrawOneProjectileSprite(sprites, cast(ubyte)(y - 8), cast(ubyte)(x - 8), 0xF0, OAMFlags.priority);
	queenDrawOneProjectileSprite(sprites, y, cast(ubyte)(x - 8), 0xF0, OAMFlags.priority | OAMFlags.yFlip);
}

void queenDrawOneProjectileSprite(ref OAMEntry* sprite, ubyte y, ubyte x, ubyte tile, ubyte attr) {
	sprite.y = y;
	sprite.x = x;
	sprite.tile = tile;
	sprite.flags.raw = attr;
	sprite++;
}

void queenHandleProjectiles() {
	// move each projectile
	for (ubyte i = ReservedEnemySlots.queenSpitA; i != 3; i++) {
		if (enemyDataSlots[i].status != 0) {
			queenMoveOneProjectile(&enemyDataSlots[i]);
		}
	}
	// wait until timer is up
	if (queenProjectileChaseTimer != 0) {
		queenProjectileChaseTimer--;
		return;
	}
	queenProjectileChaseTimer = 3;
	// no projectiles left
	if (queenProjectileChaseCounter == 0) {
		return;
	}
	queenProjectileChaseCounter--;
	queenGetSamusTargets();
	for (ubyte i = 0; i != 3; i++) {
		queenProjectileSeek(&enemyDataSlots[ReservedEnemySlots.queenSpitA + i], &queenSamusTargetPoints[i]);
	}
}

void queenProjectileSeek(EnemySlot* actor, Coords* target) {
	queenProjectileTempDirection = actor.directionFlags;
	byte directionY = cast(byte)((queenProjectileTempDirection & 0b111) | ((queenProjectileTempDirection & 0b1000) ? 0b11111000 : 0b00000000));
	queenProjectileSeekOneAxis(actor.y, target.y, directionY);
	byte directionX = cast(byte)(((queenProjectileTempDirection >> 4) & 0b111) | (((queenProjectileTempDirection >> 4) & 0b1000) ? 0b11111000 : 0b00000000));
	queenProjectileSeekOneAxis(actor.x, target.x, directionX);
	actor.directionFlags = cast(ubyte)(directionY & 0xF) || cast(ubyte)((directionX & 0xF) << 4);
}

void queenProjectileSeekOneAxis(ubyte actorCoord, ubyte targetCoord, ref byte direction) {
	const diff = targetCoord - actorCoord;
	if (diff == 0) {
		return;
	}
	// don't do anything if direction is 0, unless far away from the target
	if ((direction != 0) || (diff < -6) && (diff > 6)) {
		if (direction < 0) {
			// don't go below -2
			if (direction == -2) {
				return;
			}
			if (--direction == 0) {
				direction--;
			}
		} else {
			// don't go above 2
			if (direction == 2) {
				return;
			}
			if (++direction == 0) {
				direction++;
			}
		}
	}
}

void queenMoveOneProjectile(EnemySlot* enemy) {
	queenProjectileTempDirection = enemy.directionFlags;
	ubyte tmp = queenProjectileTempDirection;
	for (int i = 2; i > 0; i--) {
		if ((tmp & 0x0F) != 0) {
			if ((tmp & 0x08) == 0) {
				enemy.y += 2;
			} else {
				enemy.y -= 2;
			}
		}
		enemy.x++;
		tmp = ((tmp & 0xF) << 4) | ((tmp & 0xF0) >> 4);
	}
}

void queenSetDefaultNeckAttributes() {
	for (ubyte i = QueenOAM.start; i < QueenOAM.wall; i++) {
		oamScratchpad[i].flags.raw = OAMFlags.priority;
	}
}

void queenKillFromStomach() {
	queenDeactivateActorsArbitrary(&enemyDataSlots[0], 13);
	queenNeckControl = 1;
	queenNeckDrawingState = 1;
	queenState = QueenState.preparingDeath;
	queenNeckXMovementSum = 0;
	queenNeckYMovementSum = 0;
	queenStomachBombedFlag = 0;
	queenHealth = 0;
	queenNeckStatus = 0;
	queenFootFrame = 0;
	queenHeadFrameNext = 0;
	queenLowHealthFlag = 0;
	queenOAMScratchpad = &oamScratchpad[QueenOAM.start];
	queenOAMScratchpad[0].flags.raw = OAMFlags.priority;
	queenOAMScratchpad[1].flags.raw = OAMFlags.priority;
	queenCloseFloor();
	audio.sfxRequestNoise = NoiseSFX.u0F;
	queenNeckPatternID = QueenNeckPattern.dying;
	queenNeckPattern = queenLoadNeckBasePointer() + 1;
}

void queenCloseFloor() {
	// write tiles directly to VRAM
	//while ((gb.STAT & 0x03) != 0) {} // wait for HBlank
	gb.vram[0x1800 + 32 * 24 + 14] = 0x5D;
	//while ((gb.STAT & 0x03) != 0) {} // wait for HBlank
	gb.vram[0x1800 + 32 * 24 + 15] = 0x5E;
}

void queenDisintegrate() {
	if (!queenDeathBitmask) {
		return;
	}
	auto chr = queenDeathChr;
	for (int i = 26; i > 0; i--) {
		gb.vram[chr - 0x8000] &= queenDeathBitmask;
		chr += 8;
		if (chr == VRAMDest.queenDeathLastTile) {
			queenDeathBitmask = 0;
			return;
		}
	}
	queenDeathChr = chr;
}

void queenWalk() {
	queenWalkSpeed = 0;
	if (!queenWalkControl) {
		return;
	}
	if (queenWalkWaitTimer) {
		queenWalkWaitTimer--;
	} else {
		const speed = queenWalkSpeedTable[queenWalkCounter++];
		if (queenWalkControl == 1) {
			if (speed == 0x81) {
				queenWalkStatus = 0x81;
				queenWalkControl = 0;
			} else {
				queenWalkSpeed = cast(ubyte)-speed;
				queenBodyX += speed;
			}
		} else {
			if (speed == 0x82) {
				queenWalkStatus = 0x82;
				queenWalkControl = 0;
				queenWalkCounter = 0;
			} else {
				queenWalkSpeed = cast(ubyte)-speed;
				queenBodyX += speed;
			}
		}
	}
}

immutable ubyte[] queenWalkSpeedTable = [
	0xFF, 0xFF, 0xFF, 0xFF, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE,
	0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFF, 0xFF,
	0xFF, 0xFF, 0x81, 0x01, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
	0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02,
	0x01, 0x01, 0x01, 0x01, 0x01, 0x82,
];

void lcdcInterruptHandler() {
	auto interrupts = queenInterruptList;
	loop: while (interrupts.scanline != 0xFF) {
		switch (interrupts.command & 0x7F) {
			default:
				gb.LCDC = gb.LCDC & ~0b00010000;
				gb.SCX = 0;
				gb.SCY = 112;
				break loop;
			case 1:
				gb.SCX = queenBodyX;
				if (queenBodyPalette) {
					gb.BGP = queenBodyPalette;
				}
				break;
			case 2:
				gb.SCX = scrollX;
				gb.BGP = 0x93;
				break;
			case 3:
				gb.LCDC = gb.LCDC & ~0b00010000;
				break;
		}
		if (interrupts.command & 0x80) {
			gb.LYC = interrupts[1].scanline;
			break;
		}
		interrupts++;
	}
	queenInterruptList = interrupts;
}

void vblankDrawQueen() {
	queenDrawFeet();
	queenDisintegrate();
	gb.SCX = scrollX;
	gb.SCY = scrollY;
	if (queenHeadX == 166) {
		gb.WX = 167;
	} else {
		gb.WX = queenHeadX;
	}
	gb.WY = queenHeadY;
	if (queenHeadY + 38 > 144) {
		queenHeadBottomY = 143;
	} else {
		queenHeadBottomY = cast(ubyte)(queenHeadY + 38);
	}
	ubyte bodyBottomY = cast(ubyte)(queenBodyHeight + queenBodyY);
	if (bodyBottomY > 144) {
		bodyBottomY = 143;
	}
	InterruptCommand* interrupt = &queenInterruptListBuffer[0];
	if (queenBodyY >= queenHeadBottomY) {
		(interrupt++)[0] = InterruptCommand(queenHeadBottomY, (queenBodyY == queenHeadBottomY) ? 0x03 : 0x83);
		(interrupt++)[0] = InterruptCommand(queenBodyY, 1);
		(interrupt++)[0] = InterruptCommand(bodyBottomY, 2);
	} else if (queenHeadBottomY >= bodyBottomY) {
		(interrupt++)[0] = InterruptCommand(queenBodyY, 1);
		(interrupt++)[0] = InterruptCommand(bodyBottomY, (queenHeadBottomY == bodyBottomY) ? 0x02 : 0x82);
		(interrupt++)[0] = InterruptCommand(queenHeadBottomY, 3);
	} else {
		(interrupt++)[0] = InterruptCommand(queenBodyY, 1);
		(interrupt++)[0] = InterruptCommand(queenHeadBottomY, 3);
		(interrupt++)[0] = InterruptCommand(bodyBottomY, 2);
	}
	interrupt = &queenInterruptListBuffer[0];
	for (int i = 3; i != 0; i--) {
		if (interrupt.scanline >= 135) {
			break;
		}
		interrupt++;
	}
	(interrupt++)[0] = InterruptCommand(135, 4);
	(interrupt++)[0] = InterruptCommand(0xFF);
	gb.LYC = queenInterruptListBuffer[0].scanline;
	queenInterruptList = &queenInterruptListBuffer[0];
	gb.LCDC = gb.LCDC | 0b00100000;
}
