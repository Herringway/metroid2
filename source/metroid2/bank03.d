module metroid2.bank03;

import metroid2.defs;
import metroid2.enemies;
import metroid2.globals;

void handleEnemyLoading() {
	loadEnemies();
	scrollHistoryB.y[0] = scrollHistoryB.y[1];
	scrollHistoryB.y[1] = scrollY;
	scrollHistoryB.x[0] = scrollHistoryB.x[1];
	scrollHistoryB.x[1] = scrollX;
}

void loadEnemies() {
	assert(0); // TODO
}

void loadEnemiesVertical() {
	assert(0); // TODO
}

void loadEnemiesHorizontal() {
	assert(0); // TODO
}

void loadOneEnemy() {
	assert(0); // TODO
}

size_t loadEnemyGetFirstEmptySlot() {
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if (enemyDataSlots[i].status == 0xFF) {
			return i;
		}
	}
	return enemyDataSlots.length;
}

immutable(ubyte[][]) loadEnemyGetBankOffset() {
	return enemyDataPointers[currentLevelBank - 9];
}

const(ubyte)* loadEnemyGetPointer(const ubyte[][] base, ubyte index) {
	return &base[index][0];
}

void enemyDeleteSelf() {
	assert(0); // TODO
}

void enemySeekSamus() {
	assert(0); // TODO
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
	assert(0); // TODO
}

void scrollEnemiesSaveToWRAM() {
	assert(0); // TODO
}

void queenInitialize() {
	assert(0); // TODO
}

void queenDeactivateActors() {
	assert(0); // TODO
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
