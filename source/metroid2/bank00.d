module metroid2.bank00;

import std.logger;

import metroid2.data;
import metroid2.defs;
import metroid2.external;
import metroid2.globals;
import metroid2.registers;
import metroid2.sram;

void vblank() {
	SCY = scrollY;
	SCX = scrollX;
	BGP = bgPalette;
	OBP0 = obPalette0;
	OBP1 = obPalette1;
	if (countdownTimer > 0) {
		countdownTimer--;
	}
	if (creditsNextLineReady) {
		//vblankDrawCreditsLine();
	}
	if (deathAnimTimer) {
		//vblankDeathSequence();
	}
	if (vramTransferFlag) {
		//vblankVRAMDataTransfer();
	}
	if (doorIndex) {
		//vblankUpdateMapDuringTransition();
	}
	if (queenRoomFlag == 0x11) {
		//vblankUpdateStatusBar();
		//oamDMA();
		//vblankDrawQueen();
		vblankDoneFlag = 1;
	} else {
		if (mapUpdateFlag) {
			//vblankUpdateMap();
		} else {
			//vblankUpdateStatusBar();
		}
		//oamDMA();
		vblankDoneFlag = 1;
	}
}

void start() {
	while (true) {
		IF = 0;
		IE = 0;
		SCY = 0;
		SCX = 0;
		STAT = 0;
		SB = 0;
		SC = 0;
		LCDC = 0x80;
		LCDC = 0x03;
		bgPalette = 0x93;
		obPalette0 = 0x93;
		obPalette1 = 0x43;
		//initializeAudio();
		// some ram initialization happened here
		//clearTilemaps();
		IE = 1;
		WX = 7;
		LCDC = 0x80;
		IF = 0;
		WY = 0;
		TMA = 0;
		activeSaveSlot = 0;
		if (sram.saveLastSlot < 3) {
			activeSaveSlot = sram.saveLastSlot;
		}
		gameMode = GameMode.boot;
		gameLoop: while (true) {
			mapUpdateFlag = 0;
			if (doorScrollDirection == 0) {
				readInput();
			}
			handleGameMode();
			//handleAudio();
			//executeDoorScript();
			if ((inputPressed & (Pad.start | Pad.select | Pad.b | Pad.a)) == (Pad.start | Pad.select | Pad.b | Pad.a)) {
				infof("resetting");
				waitNextFrame();
				break gameLoop;
			}
			waitNextFrame();
		}
	}
}

void handleGameMode() {
	final switch (gameMode) {
		case GameMode.boot:
			//handleBoot();
			break;
		case GameMode.title:
			//handleTitle();
			break;
		case GameMode.loadA:
			handleLoadA();
			break;
		case GameMode.loadB:
			handleLoadB();
			break;
		case GameMode.main:
			handleMain();
			break;
		case GameMode.dead:
			//handleDead();
			break;
		case GameMode.dying:
			//handleDying();
			break;
		case GameMode.gameOver:
			//handleGameOver();
			break;
		case GameMode.paused:
			//handlePaused();
			break;
		case GameMode.saveGame:
			//handleSaveGame();
			break;
		case GameMode.unusedA:
			//handleUnusedA();
			break;
		case GameMode.newGame:
			//handleNewGame();
			break;
		case GameMode.loadSave:
			//handleLoadSave();
			break;
		case GameMode.none:
			handleNone();
			break;
		case GameMode.none2:
			handleNone();
			break;
		case GameMode.unusedB:
			//handleUnusedB();
			break;
		case GameMode.unusedC:
			//handleUnusedC();
			break;
		case GameMode.unusedD:
			//handleUnusedD();
			break;
		case GameMode.prepareCredits:
			//handlePrepareCredits();
			break;
		case GameMode.credits:
			//handleCredits();
			break;
	}
}

void handleNone() {} //nothing

void waitNextFrame() {
	if (++frameCounter == 0) {
		if (gameMode == 4) {
			if (++gameTimeSeconds == 14) {
				gameTimeSeconds = 0;
				if (++gameTimeMinutes >= 60) {
					gameTimeMinutes = 0;
					if (++gameTimeHours == 0) {
						gameTimeMinutes = 59;
						gameTimeHours = 99;
					}
				}
			}
		}
	}
	vblankDoneFlag = 0;
	unusedFlag1 = 0xC0;
	oamBufferIndex = 0;
	waitNextFrameExternal();
}

void oamClearTable() {
	for (int i = oamBuffer.length; i != 0; i--) {
		oamBuffer[i] = oamBuffer[i].init;
	}
}
void clearTilemaps() {
	bgTilemap()[] = 0xFF;
	windowTilemap()[] = 0xFF;
}
// hl: src, de: dest, bc: length
void copyToVRAM(const(void)* src, void* destination, size_t length) {
	auto usrc = cast(const(ubyte)*)src;
	auto udest = cast(ubyte*)destination;
	while (length--) {
		*(udest++) = *(usrc++);
	}
}
void unusedCopy(const(void)* src, void* dest) {
	auto usrc = cast(const(ubyte)*)src;
	auto udest = cast(ubyte*)dest;
	while (*usrc != 0xFF) {
		*(udest++) = *(usrc++);
	}
}

void timerOverflowInterruptStub() {}

void disableLCD() {
	//const tmp = IE;
	//IE &= 0xFE;
	//while (LY != 145) {
	//}
	//LCDC &= 0x7F;
	//IE = tmp;
}

void handleLoadA() {
	//loadGameSamusData();
	const(ubyte)* src = saveBufTiletableSrc;
	ubyte* dest = &tiletableArray[0];
	for (int i = 0; i < tiletableArray.length; i++) {
		*(dest++) = *(src++);
	}
	src = saveBufCollisionSrc;
	dest = &collisionArray[0];
	for (int i = 0; i < collisionArray.length; i++) {
		*(dest++) = *(src++);
	}
	currentLevelBank = saveBufCurrentLevelBank;
	samusSolidityIndex = saveBufSamusSolidityIndex;
	enemySolidityIndexCanon = saveBufEnemySolidityIndex;
	beamSolidityIndex = saveBufBeamSolidityIndex;
	acidDamageValue = saveBufAcidDamageValue;
	spikeDamageValue = saveBufSpikeDamageValue;
	metroidCountReal = saveBufMetroidCountReal;
	currentRoomSong = saveBufCurrentRoomSong;
	gameTimeMinutes = saveBufGameTimeMinutes;
	gameTimeHours = saveBufGameTimeHours;
	metroidCountDisplayed = saveBufMetroidCountDisplayed;

	doorScrollDirection = 0;
	deathAnimTimer = 0;
	deathFlag = 0;
	vramTransferFlag = 0;
	unusedD06B = 0;
	itemCollected = 0;
	itemCollectionFlag = 0;
	maxOAMPrevFrame = 0;

	for (int i = 0; i < respawningBlockArray.length; i += 0x10) {
		respawningBlockArray[i] = 0;
	}
	//saveAndLoadEnemySaveFlags();
	gameMode = GameMode.loadB;
}

void handleLoadB() {
	disableLCD();
	loadGameLoadGraphics();
	//loadGameSamusItemGraphics();
	cameraYPixel = saveBufCameraYPixel;
	cameraYScreen = saveBufCameraYScreen;
	cameraXPixel = saveBufCameraXPixel;
	cameraXScreen = saveBufCameraXScreen;
	do {
		mapUpdate.buffer = &mapUpdateBuffer[0];
		//prepMapUpdateForceRow();
		//vblankUpdateMap();
		cameraYPixel += 16;
		if (cameraYPixel < 16) {
			cameraYScreen = (cameraYScreen + 1) & 15;
		}
	} while (cameraYPixel != saveBufCameraYPixel);
	cameraYPixel = saveBufCameraYPixel;
	cameraYScreen = saveBufCameraYScreen;
	cameraXPixel = saveBufCameraXPixel;
	cameraXScreen = saveBufCameraXScreen;

	scrollY = cast(ubyte)(cameraYPixel - 0x78);
	scrollX = cast(ubyte)(cameraXPixel - 0x30);
	LCDC = 0xE3;
	unusedD011 = 0;
	gameMode = GameMode.main;
}

void handleMain() {
	if ((samusPose & 0x7F) == SamusPose.eatenByMetroidQueen) {
		//miscInGameTasks();
		if (samusDispHealth == 0) {
			//killSamus();
		}
		prevSamusYPixel = samusYPixel;
		prevSamusYScreen = samusYScreen;
		prevSamusXPixel = samusXPixel;
		prevSamusXScreen = samusXScreen;

		samusSpriteCollisionProcessedFlag = 0;

		//samusHandlePose();
		//collisionSamusEnemiesStandard();
		//samusTryShooting();
		//handleProjectiles();
		//handleBombs();
		//prepMapUpdate();
		//handleCamera();
		//convertCameraToScroll();
		//drawSamus();
		//drawProjectiles();
		//handleRespawningBlocks();
		//adjustHudValues();
		if (samusUnmorphJumpTimer) {
			samusUnmorphJumpTimer--;
		}
		//drawHudMetroid();
		samusTopOAMOffset = oamBufferIndex;
		handleEnemiesOrQueen();
		//clearUnusedOAMSlots();
		//tryPausng();
	}
	//miscInGameTasks();
	if (samusDispHealth == 0) {
		//killSamus();
	}
	prevSamusYPixel = samusYPixel;
	prevSamusYScreen = samusYScreen;
	prevSamusXPixel = samusXPixel;
	prevSamusXScreen = samusXScreen;
	if (cutsceneActive) {
		samusPose &= 0x7F;
		if (inputRisingEdge & Pad.select) {
			//samusTryShootingToggleMissiles();
		}
	} else {
		if (doorScrollDirection) {
			samusSpriteCollisionProcessedFlag = 0;
			//hurtSamus();
			//samusHandlePose();
			//collisionSamusEnemiesStandard();
			//samusTryShooting();
			//handleProjectiles();
			//handleBombs();
		}
	}
	//prepMapUpdate();
	//handleCamera();
	//convertCameraToScroll();
	//handleItemPickup();
	//drawSamus();
	//drawProjectiles();
	//handleRespawningBlocks();
	//adjustHudValues();
	if (samusUnmorphJumpTimer) {
		samusUnmorphJumpTimer--;
	}
	//drawHudMetroid();
	samusTopOAMOffset = oamBufferIndex;
	if (!doorIndex) {
		handleEnemiesOrQueen();
	}
	//clearUnusedOAMSlots();
	//tryPausing();
}

void handleEnemiesOrQueen() {
	if (queenRoomFlag == 0x11) {
		//enemyHandler();
	} else {
		//queenHandler();
	}
}

void loadGameLoadGraphics() {
	copyToVRAM(&graphicsCommonItems[0], &(vram()[0x8F00]), graphicsCommonItems.length);
	copyToVRAM(&graphicsSamusPowerSuit[0], &(vram()[0x8000]), graphicsSamusPowerSuit.length);
	copyToVRAM(saveBufEnGfxSrc, &(vram()[0x8B00]), 0x400);
	if (loadingFromFile) {
		copyToVRAM(&graphicsItemFont[0], &(vram()[0x8C00]), 0x200);
	}
	copyToVRAM(saveBufBGGfxSrc, &(vram()[0x9000]), 0x800);
}

void queenRenderRoom() {
	mapSourceYPixel = 0;
	mapSourceXPixel = 0;
	mapSourceYScreen = cameraYScreen;
	mapSourceXScreen = cameraXScreen;
	do {
		mapUpdate.buffer = &mapUpdateBuffer[0];
		//prepMapUpdateRow();
		//vblankUpdateMap();
		mapSourceYPixel += 16;
	} while(mapSourceYPixel != 0);
}

void readInput() {
	writeJoy(0x20);
	ubyte tmp = ((~readJoy()) & 0xF) << 4;
	writeJoy(0x10);
	tmp |= ~readJoy() & 0xF;
	inputRisingEdge = inputPressed ^ tmp;
	inputPressed = tmp;
	writeJoy(0x30);
}
