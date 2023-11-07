module metroid2.bank02;

import metroid2.defs;
import metroid2.globals;

void enemyHandler() {
	//assert(0);
}

void processEnemies() {
	assert(0);
}

void ingameLoadEnemySaveFlags() {
	assert(0);
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
	enemyFirstEnemy = &enemyDataSlots[0];
	enemiesLeftToProcess = 0;
	enemySameEnemyFrameFlag = 0;
	enSprCollision.weaponType = 0xFF;
	enSprCollision.enemy = null;
	scrollHistoryB[0 .. 2] = scrollY;
	scrollHistoryB[2 .. 4] = scrollX;
	deactivateAllEnemies();
}
void deactivateAllEnemies() {
	for (int i = 0; i < enemyDataSlots.length; i++) {
		enemyDataSlots[i].u0 = 0xFF;
	}
	enemyWorking = EnemyWorking.init;
	numEnemies = NumEnemies.init;
}
