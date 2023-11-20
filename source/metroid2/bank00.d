module metroid2.bank00;

import std.logger;

import metroid2.bank01;
import metroid2.bank02;
import metroid2.bank03;
import metroid2.bank04;
import metroid2.bank05;
import metroid2.bank06;
import metroid2.bank08;
import metroid2.data;
import metroid2.defs;
import metroid2.enemies;
import metroid2.external;
import metroid2.globals;
import metroid2.mapbanks;
import metroid2.registers;

import librehome.gameboy;

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
		vblankDrawCreditsLine();
	}
	if (deathAnimTimer) {
		vblankDeathSequence();
	}
	if (vramTransferFlag) {
		vblankVRAMDataTransfer();
	}
	if (doorIndex) {
		vblankUpdateMapDuringTransition();
	}
	if (queenRoomFlag == 0x11) {
		vblankUpdateStatusBar();
		oamDMA();
		vblankDrawQueen();
		vblankDoneFlag = 1;
	} else {
		if (mapUpdateBuffer[0].dest) {
			switchMapBank(currentLevelBank);
			vblankUpdateMap();
		} else {
			vblankUpdateStatusBar();
		}
		oamDMA();
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
		initializeAudio();
		enableSRAM();
		// some ram initialization happened here
		clearTilemaps();
		IE = 1;
		WX = 7;
		LCDC = 0x80;
		IF = 0;
		WY = 0;
		TMA = 0;
		enableSRAM();
		activeSaveSlot = 0;
		if (sram.saveLastSlot < 3) {
			activeSaveSlot = sram.saveLastSlot;
		}
		gameMode = GameMode.boot;
		disableSRAM();
		gameLoop: while (true) {
			mapUpdateBuffer[0].dest = 0;
			if (doorScrollDirection == 0) {
				readInput();
			}
			if (handleGameMode()) {
				break gameLoop;
			}
			handleAudio();
			executeDoorScript();
			if ((inputPressed & (Pad.start | Pad.select | Pad.b | Pad.a)) == (Pad.start | Pad.select | Pad.b | Pad.a)) {
				infof("resetting");
				waitNextFrame();
				break gameLoop;
			}
			waitNextFrame();
		}
	}
}

bool handleGameMode() {
	final switch (gameMode) {
		case GameMode.boot:
			handleBoot();
			break;
		case GameMode.title:
			handleTitle();
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
			handleDead();
			break;
		case GameMode.dying:
			handleDying();
			break;
		case GameMode.gameOver:
			if (handleGameOver()) {
				return true;
			}
			break;
		case GameMode.paused:
			handlePaused();
			break;
		case GameMode.saveGame:
			handleSaveGame();
			break;
		case GameMode.unusedA:
			handleUnusedA();
			break;
		case GameMode.newGame:
			handleNewGame();
			break;
		case GameMode.loadSave:
			handleLoadSave();
			break;
		case GameMode.none:
			handleNone();
			break;
		case GameMode.none2:
			handleNone();
			break;
		case GameMode.unusedB:
			if (handleUnusedB()) {
				return true;
			}
			break;
		case GameMode.unusedC:
			handleUnusedC();
			break;
		case GameMode.unusedD:
			handleUnusedD();
			break;
		case GameMode.prepareCredits:
			// TODO handlePrepareCredits();
			break;
		case GameMode.credits:
			// TODO handleCredits();
			break;
	}
	return false;
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
		oamBuffer[i - 1] = oamBuffer[i - 1].init;
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
	loadGameSamusData();
	const(ubyte)* src = &metatileTable[saveBuf.tiletableID][0];
	ubyte* dest = &tileTableArray[0];
	for (int i = 0; i < tileTableArray.length; i++) {
		*(dest++) = *(src++);
	}
	src = &collisionTable[saveBuf.collisionID][0];
	dest = &collisionArray[0];
	for (int i = 0; i < collisionArray.length; i++) {
		*(dest++) = *(src++);
	}
	currentLevelBank = saveBuf.currentLevelBank;
	samusSolidityIndex = saveBuf.samusSolidityIndex;
	enemySolidityIndexCanon = saveBuf.enemySolidityIndex;
	beamSolidityIndex = saveBuf.beamSolidityIndex;
	acidDamageValue = saveBuf.acidDamageValue;
	spikeDamageValue = saveBuf.spikeDamageValue;
	metroidCountReal = saveBuf.metroidCountReal;
	currentRoomSong = saveBuf.currentRoomSong;
	gameTimeMinutes = saveBuf.gameTimeMinutes;
	gameTimeHours = saveBuf.gameTimeHours;
	metroidCountDisplayed = saveBuf.metroidCountDisplayed;

	doorScrollDirection = 0;
	deathAnimTimer = 0;
	deathFlag = 0;
	vramTransferFlag = 0;
	unusedD06B = 0;
	itemCollected = 0;
	itemCollectionFlag = 0;
	maxOAMPrevFrame = 0;

	for (int i = 0; i < respawningBlockArray.length; i += 0x10) {
		respawningBlockArray[i].timer = 0;
	}
	ingameSaveAndLoadEnemySaveFlags();
	gameMode = GameMode.loadB;
}

void handleLoadB() {
	disableLCD();
	loadGameLoadGraphics();
	loadGameSamusItemGraphics();
	cameraY = saveBuf.cameraY;
	cameraX = saveBuf.cameraX;
	switchMapBank(currentLevelBank);
	do {
		mapUpdate.buffer = &mapUpdateBuffer[0];
		prepMapUpdateForceRow();
		vblankUpdateMap();
		cameraY = (cameraY + 16) & 0xFFF;
	} while (cameraY.pixel != saveBuf.cameraY.pixel);
	cameraY = saveBuf.cameraY;
	cameraX = saveBuf.cameraX;

	scrollY = (cast(ushort)(cameraY - 0x78)).pixel;
	scrollX = (cast(ushort)(cameraX - 0x30)).pixel;
	LCDC = 0xE3;
	unusedD011 = 0;
	gameMode = GameMode.main;
}

void handleMain() {
	if ((samusPose & 0x7F) == SamusPose.eatenByMetroidQueen) {
		miscInGameTasks();
		if (samusDispHealth == 0) {
			killSamus();
		}
		prevSamusY = samusY;
		prevSamusX = samusX;

		samusSpriteCollisionProcessedFlag = 0;

		samusHandlePose();
		collisionSamusEnemiesStandard();
		samusTryShooting();
		handleProjectiles();
		handleBombs();
		prepMapUpdate();
		handleCamera();
		convertCameraToScroll();
		drawSamus();
		drawProjectiles();
		handleRespawningBlocks();
		adjustHUDValues();
		if (samusUnmorphJumpTimer) {
			samusUnmorphJumpTimer--;
		}
		drawHUDMetroid();
		samusTopOAMOffset = oamBufferIndex;
		handleEnemiesOrQueen();
		clearUnusedOAMSlots();
		tryPausing();
	}
	miscInGameTasks();
	if (samusDispHealth == 0) {
		killSamus();
	}
	prevSamusY = samusY;
	prevSamusX = samusX;
	if (cutsceneActive) {
		samusPose &= 0x7F;
		if (inputRisingEdge & Pad.select) {
			samusTryShootingToggleMissiles();
		}
	} else {
		if (!doorScrollDirection) {
			samusSpriteCollisionProcessedFlag = 0;
			hurtSamus();
			samusHandlePose();
			collisionSamusEnemiesStandard();
			samusTryShooting();
			handleProjectiles();
			handleBombs();
		}
	}
	prepMapUpdate();
	handleCamera();
	convertCameraToScroll();
	handleItemPickup();
	drawSamus();
	drawProjectiles();
	handleRespawningBlocks();
	adjustHUDValues();
	if (samusUnmorphJumpTimer) {
		samusUnmorphJumpTimer--;
	}
	drawHUDMetroid();
	samusTopOAMOffset = oamBufferIndex;
	if (!doorIndex) {
		handleEnemiesOrQueen();
	}
	clearUnusedOAMSlots();
	tryPausing();
}

void handleEnemiesOrQueen() {
	if (queenRoomFlag != 0x11) {
		enemyHandler();
	} else {
		queenHandler();
	}
}

void loadGameLoadGraphics() {
	foreach (i, commonGraphics; graphicsItems[12 .. 16]) {
		copyToVRAM(&commonGraphics[0], &(vram()[VRAMDest.commonItems + i * 0x40]), commonGraphics.length);
	}
	copyToVRAM(&graphicsSamusPowerSuit[0], &(vram()[VRAMDest.samus]), graphicsSamusPowerSuit.length);
	copyToVRAM(enGfx(saveBuf.enGfxID), &(vram()[VRAMDest.enemies]), 0x400);
	if (loadingFromFile) {
		copyToVRAM(&graphicsItemFont[0], &(vram()[VRAMDest.itemFont]), 0x200);
	}
	copyToVRAM(bgGfx(saveBuf.bgGfxID), &(vram()[VRAMDest.bgTiles]), 0x800);
}

void queenRenderRoom() {
	mapSourceYPixel = 0;
	mapSourceXPixel = 0;
	mapSourceYScreen = cameraY.screen;
	mapSourceXScreen = cameraX.screen;
	do {
		mapUpdate.buffer = &mapUpdateBuffer[0];
		prepMapUpdateRow();
		vblankUpdateMap();
		mapSourceYPixel += 16;
	} while(mapSourceYPixel != 0);
}

void prepMapUpdate() {
	mapUpdate.buffer = &mapUpdateBuffer[0];
	mapUpdateUnusedVar = 0;
	switch (frameCounter & 3) {
		case 0: //up
			if ((cameraScrollDirection & (1 << 6)) == 0) {
				return;
			}
			mapUpdateUnusedVar = 0xFF;
			prepMapUpdateForceRow();
			break;
		case 1: //down
			if ((cameraScrollDirection & (1 << 7)) == 0) {
				return;
			}
			mapUpdateUnusedVar = 0xFF;
			mapSourceXPixel = ((cameraX - 0x80) & 0xFFF).pixel;
			mapSourceXScreen = ((cameraX - 0x80) & 0xFFF).screen;

			mapSourceYPixel = ((cameraY + 0x78) & 0xFFF).pixel;
			mapSourceYScreen = ((cameraY + 0x78) & 0xFFF).screen;
			cameraScrollDirection &= ~(1 << 7);
			prepMapUpdateRow();
			break;
		case 2: //left
			if ((cameraScrollDirection & (1 << 5)) == 0) {
				return;
			}
			mapUpdateUnusedVar = 0xFF;
			mapSourceXPixel = ((cameraX - 0x80) & 0xFFF).pixel;
			mapSourceXScreen = ((cameraX - 0x80) & 0xFFF).screen;

			mapSourceYPixel = ((cameraY - 0x78) & 0xFFF).pixel;
			mapSourceYScreen = ((cameraY - 0x78) & 0xFFF).screen;
			cameraScrollDirection &= ~(1 << 5);
			prepMapUpdateColumn();
			break;
		case 3: //right
			if ((cameraScrollDirection & (1 << 4)) == 0) {
				return;
			}
			mapUpdateUnusedVar = 0xFF;
			mapSourceXPixel = ((cameraX + 0x70) & 0xFFF).pixel;
			mapSourceXScreen = ((cameraX + 0x70) & 0xFFF).screen;

			mapSourceYPixel = ((cameraY - 0x78) & 0xFFF).pixel;
			mapSourceYScreen = ((cameraY - 0x78) & 0xFFF).screen;
			cameraScrollDirection &= ~(1 << 4);
			prepMapUpdateColumn();
			break;
		default: assert(0);
	}
}
void prepMapUpdateForceRow() {
	mapSourceXPixel = ((cameraX - 0x80) & 0xFFF).pixel;
	mapSourceXScreen = ((cameraX - 0x80) & 0xFFF).screen;

	mapSourceYPixel = cast(ubyte)((cameraY - 0x78) & 0xFFF).pixel;
	mapSourceYScreen = cast(ubyte)((cameraY - 0x78) & 0xFFF).screen;
	cameraScrollDirection &= ~(1 << 6);
	prepMapUpdateRow();
}

void prepMapUpdateRow() {
	const(ubyte)[] bc = mapUpdateGetSrcAndDest();
	mapUpdate.size = 0x10;
	do {
		mapUpdateWriteToBuffer(bc);
		mapUpdate.destAddr += 2;
		mapUpdate.destAddr &= 0x9BDF;
		mapUpdate.srcBlock += 1;
		if ((mapUpdate.srcBlock & 0xF) == 0) {
			mapUpdate.srcBlock -= 0x10;
			const tmpUpper = mapUpdate.srcScreen & 0xF0;
			mapUpdate.srcScreen = (mapUpdate.srcScreen + 1 & 0xF) | tmpUpper;
			bc = mapScreenPointers[mapUpdate.srcScreen];
		}
	} while (--mapUpdate.size != 0);
	mapUpdate.buffer.dest = 0;
}

void prepMapUpdateColumn() {
	cameraScrollDirection &= ~((1 << 5) | (1 << 4));
	const(ubyte)[] bc = mapUpdateGetSrcAndDest();
	mapUpdate.size = 0x10;
	do {
		mapUpdateWriteToBuffer(bc);
		mapUpdate.destAddr += 0x40;
		mapUpdate.destAddr &= 0x9BFF;
		mapUpdate.srcBlock += 0x10;
		if ((mapUpdate.srcBlock & 0xF0) == 0) {
			mapUpdate.srcScreen += 0x10;
			bc = mapScreenPointers[mapUpdate.srcScreen];
		}
	} while (--mapUpdate.size != 0);
	mapUpdate.buffer.dest = 0;
}
const(ubyte)[] mapUpdateGetSrcAndDest() {
	mapUpdate.srcScreen = ((mapSourceYScreen << 4) & 0xF0) | (mapSourceXScreen & 0xF);
	const(ubyte)[] bc = mapScreenPointers[mapUpdate.srcScreen];
	mapUpdate.srcBlock = (mapSourceYPixel & 0xF0) | ((mapSourceXPixel >> 4) & 0xF);
	mapUpdate.destAddr = 0x9800 + ((mapSourceYPixel & 0xF0) * 4) + ((mapSourceXPixel & 0xF0) / 8);
	return bc;
}
void mapUpdateWriteToBuffer(const(ubyte)[] bc) {
	tempMetaTile.topLeft = tileTableArray[bc[mapUpdate.srcBlock] * 4];
	tempMetaTile.topRight = tileTableArray[bc[mapUpdate.srcBlock] * 4 + 1];
	tempMetaTile.bottomLeft = tileTableArray[bc[mapUpdate.srcBlock] * 4 + 2];
	tempMetaTile.bottomRight = tileTableArray[bc[mapUpdate.srcBlock] * 4 + 3];
	mapUpdate.buffer.dest = mapUpdate.destAddr;
	mapUpdate.buffer.topLeft = tempMetaTile.topLeft;
	mapUpdate.buffer.topRight = tempMetaTile.topRight;
	mapUpdate.buffer.bottomLeft = tempMetaTile.bottomLeft;
	mapUpdate.buffer.bottomRight = tempMetaTile.bottomRight;
	mapUpdate.buffer++;
}

void vblankUpdateMap() {
	auto de = cast(MapUpdateBufferEntry*)&mapUpdateBuffer[0];
	do {
		ushort hl = de.dest;
		if ((hl & 0xFF00) == 0) {
			break;
		}
		// top left
		vram()[hl] = de.topLeft;
		// top right
		hl = (hl + 1) & 0x9BFF;
		vram()[hl] = de.topRight;
		// bottom left
		hl = (hl + 0x1F) & 0x9BFF;
		vram()[hl] = de.bottomLeft;
		// bottom right
		hl = (hl + 1) & 0x9BFF;
		vram()[hl] = de.bottomRight;
		de++;
	} while(true);
	mapUpdateBuffer[0].dest = 0;
}

void handleCamera() {
	if (doorScrollDirection) {
		handleCameraDoor();
		return;
	}
	const tmp = scrollData[(cameraY.screen << 4) | cameraX.screen];
	// righrward
	if (tmp & 1) { // right blocked
		if (cameraX.pixel == 176) {
			if (samusOnScreenXPos >= 161) {
				doorScrollDirection = 1;
				loadDoorIndex();
			}
			goto rightDone;
		} else if (cameraX.pixel >= 176) {
			cameraX = (cameraX - 1) & 0xFFF;
			goto rightDone;
		}
	}
	if (cameraSpeedRight) {
		cameraX = (cameraX + cameraSpeedRight) & 0xFFF;
		cameraScrollDirection |= ScrollDirection.right;
		if (samusX - cameraX + 96 >= 64) {
			cameraX = (cameraX + 1) & 0xFFF;
		} else if (samusX - cameraX + 96 < 63) {
			cameraX = (cameraX - 1) & 0xFFF;
		}
	}
	rightDone:
	// leftward
	if (tmp & 2) { // left blocked
		if (cameraX.pixel == 80) {
			if (samusOnScreenXPos < 15) {
				doorScrollDirection = 2;
				samusX = (samusX + 0x100) & 0xF00;
				loadDoorIndex();
			}
			goto leftDone;
		} else if (cameraX.pixel < 80) {
			cameraX = (cameraX + 1) & 0xFFF;
			goto leftDone;
		}
	}
	if (cameraSpeedLeft) {
		cameraX = (cameraX - cameraSpeedLeft) & 0xFFF;
		cameraScrollDirection |= ScrollDirection.left;
		if (samusX - cameraX + 96 < 112) {
			cameraX = (cameraX - 1) & 0xFFF;
		} else if (samusX - cameraX + 96 >= 113) {
			cameraX = (cameraX + 1) & 0xFFF;
		}
	}
	leftDone:
	cameraSpeedRight = 0;
	cameraSpeedLeft = 0;

	// downward
	auto tmp2 = cast(ubyte)(samusY.pixel - cameraY.pixel + 0x60);
	if (samusY.pixel == samusPrevYPixel) {
		goto exit;
	} else if (!(cast(ubyte)(samusY.pixel - samusPrevYPixel) & 0x80)) {
		cameraSpeedDown = cast(ubyte)(samusY.pixel - samusPrevYPixel);
		cameraScrollDirection |= ScrollDirection.down;
		if (tmp & 8) {
			if (((queenRoomFlag == 0x11) && (cameraY.pixel == 160)) || (cameraY.pixel == 192)) {
				if (samusOnScreenYPos < 120) {
					goto exit;
				}
				doorScrollDirection = 8;
				loadDoorIndex();
			} else if (((queenRoomFlag == 0x11) && (cameraY.pixel >= 160)) || (cameraY.pixel >= 192)) {
				cameraY = (cameraY -1) & 0xFFF;
				goto exit;
			} else {
				if (tmp2 >= 64) {
					cameraY = (cameraY + cameraSpeedDown) & 0xFFF;
				}
				goto exit;
			}
		} else if (tmp2 >= 80) {
			cameraY = (cameraY + cameraSpeedDown) & 0xFFF;
			goto exit;
		} else {
			goto exit;
		}
	}
	//upward
	cameraSpeedUp = cast(ubyte)-(samusY.pixel - samusPrevYPixel);
	cameraScrollDirection |= ScrollDirection.up;
	if (tmp & 4) {
		if (cameraY.pixel == 72) {
			if (samusOnScreenYPos < 27) {
				doorScrollDirection = 4;
				samusY = cameraY.screen << 8;
				if (queenRoomFlag != 0x11) {
					loadDoorIndex();
				}
			}
		} else if (cameraY.pixel < 72) {
			cameraY = (cameraY + 1) & 0xFFF;
		} else if (tmp2 < 62) {
			cameraY = cast(ushort)(cameraY - cameraSpeedUp); // no & 0xFFF?
		}
	} else if (tmp2 < 78) {
		cameraY = cast(ushort)(cameraY - cameraSpeedUp); // no & 0xFFF?
	}
	exit:
	cameraSpeedDown = 0;
	cameraSpeedUp = 0;
	samusPrevYPixel = samusY.pixel;
}
immutable ubyte[11] unknown0B39 = [0, 1, 1, 0, 0, 0, 1, 2, 2, 1, 1];

void handleCameraDoor() {
	samusSpinAnimationTimer++;
	if (doorScrollDirection & DoorDirection.right) {
		cameraX = (cameraX + 4) & 0xFFF;
		samusAnimationTimer += 3;
		cameraScrollDirection = ScrollDirection.right;
		samusX++;
		if (cameraX.pixel != 80) {
			return;
		}
	} else if (doorScrollDirection & DoorDirection.left) {
		cameraX = (cameraX - 4) & 0xFFF;
		samusAnimationTimer += 3;
		cameraScrollDirection = ScrollDirection.left;
		samusX--;
		if (cameraX.pixel != 176) {
			return;
		}
	} else if (doorScrollDirection & DoorDirection.up) {
		cameraY = (cameraY - 4) & 0xFFF;
		samusAnimationTimer += 3;
		cameraScrollDirection = ScrollDirection.up;
		samusY -= (frameCounter & 1) + 1;
		if (cameraY.pixel != 184) {
			return;
		}
	} else if (doorScrollDirection & DoorDirection.down) {
		cameraY = (cameraY + 4) & 0xFFF;
		samusAnimationTimer += 3;
		cameraScrollDirection = ScrollDirection.down;
		samusY += (frameCounter & 1) + 1;
		if (cameraY.pixel != 72) {
			return;
		}
	}
	doorScrollDirection = 0;
	cutsceneActive = 0;
	if (bgPalette == 0x93) {
		return;
	}
	fadeInTimer = 47;
}

void loadDoorIndex() {
	if (queenRoomFlag == 0x11) {
		if ((samusPose >= SamusPose.spiderBallRolling) && (samusPose <= SamusPose.spiderBall)) {
			samusPose = SamusPose.morphBall;
		}
	}
	samusHurtFlag = 0;
	saveContactFlag = 0;

	bombArray[0].type = BombType.invalid;
	bombArray[1].type = BombType.invalid;
	bombArray[2].type = BombType.invalid;

	justStartedTransition = 0xFF;
	doorIndex = roomTransitionIndices[(cameraY.screen << 4) | cameraX.screen] & 0xF7FF;

	doorExitStatus = 2;
	fadeInTimer = 0;

	if (debugFlag == 0) {
		return;
	}
	if (inputPressed & (Pad.start | Pad.select | Pad.b | Pad.a) == (Pad.start | Pad.a)) {
		doorIndex = 0x019D;
	}
}

void loadGameSamusData() {
	clearProjectileArray();
	samusX = saveBuf.samusX;
	samusY = saveBuf.samusY;
	samusPrevYPixel = saveBuf.samusY.pixel;
	samusInvulnerableTimer = 0;
	samusItems = saveBuf.samusItems;
	samusActiveWeapon = saveBuf.samusBeam;
	samusBeam = saveBuf.samusBeam;
	samusFacingDirection = saveBuf.samusFacingDirection;
	samusEnergyTanks = saveBuf.samusEnergyTanks;
	samusCurHealth = saveBuf.samusHealth;
	samusDispHealth = saveBuf.samusHealth;
	samusMaxMissiles = saveBuf.samusMaxMissiles;
	samusCurMissiles = saveBuf.samusCurMissiles;
	samusDispMissiles = saveBuf.samusCurMissiles;
	samusPose = SamusPose.facingScreen;
	countdownTimer = 0x0140;
	songRequest = Song.samusFanfare;
}

void samusHandlePose() {
	start:
	waterContactFlag = 0;
	acidContactFlag = 0;
	samusSpinAnimationTimer++;
	if (deathFlag) {
		inputRisingEdge = 0;
		inputPressed = 0;
	}
	if (doorScrollDirection) {
		return;
	}
	if (samusPose & 0x80) {
		collisionSamusBottom();
		if (!(inputRisingEdge & Pad.a)) {
			if (--samusTurnAnimTimer != 0) {
				return;
			}
		}
		samusPose &= 0x7F;
		goto start;
	} else {
		static void right() {
			samusRollRightSpider();
			spiderDisplacement = cameraSpeedRight;
		}
		static void left() {
			samusRollLeftSpider();
			spiderDisplacement = cameraSpeedLeft;
		}
		static void up() {
			samusMoveUp(1);
			spiderDisplacement = cameraSpeedUp;
		}
		static void down() {
			bool nc;
			nc = samusMoveVertical(1);
			spiderDisplacement = cameraSpeedDown;
			if (nc) {
				return;
			}
			if (samusOnSolidSprite) {
				return;
			}
			samusY = (samusY & 0xFF8) | 4;
			spiderDisplacement = 0;
		}
		final switch (samusPose) {
			case SamusPose.standing:
				if (!collisionSamusBottom()) {
					samusPose = SamusPose.falling;
					samusFallArcCounter = 1;
				}
				samusAnimationTimer = 0;
				if (inputRisingEdge & Pad.a) {
					if (inputPressed & (Pad.left | Pad.right)) {
						if (!(samusItems & ItemFlag.spaceJump)) {
							goto normalJump;
						}
						if (collisionSamusTop()) {
							return;
						}
						samusJumpArcCounter = samusJumpArrayBaseOffset - 0x1F;
						sfxRequestSquare1 = Square1SFX.hiJumping;
						if (!(samusItems & ItemFlag.hiJump)) {
							samusJumpArcCounter = samusJumpArrayBaseOffset - 0x0F;
							sfxRequestSquare1 = Square1SFX.jumping;
						}
						if (waterContactFlag) {
							samusJumpArcCounter += 16;
						}
						samusPose = SamusPose.startingToSpinJump;
						samusJumpStartCounter = 0;
						if (samusItems & ItemFlag.screwAttack) {
							sfxRequestSquare1 = Square1SFX.screwAttacking;
						}
					}
				}
				if (inputPressed & Pad.right) {
					if (samusFacingDirection != 1) {
						samusPose = cast(SamusPose)(SamusPose.running | 0x80);
						samusFacingDirection = 1;
						samusTurnAnimTimer = 2;
						sfxRequestSquare1 = Square1SFX.standingTransition;
					} else {
						if (samusWalkRight()) {
							return;
						}
						samusFacingDirection = 1;
						samusPose = SamusPose.running;
					}
				}
				if (inputPressed & Pad.left) {
					if (samusFacingDirection != 0) {
						samusPose = cast(SamusPose)(SamusPose.running | 0x80);
						samusFacingDirection = 0;
						samusTurnAnimTimer = 2;
						sfxRequestSquare1 = Square1SFX.standingTransition;
					} else {
						if (samusWalkLeft()) {
							return;
						}
						samusFacingDirection = 0;
						samusPose = SamusPose.running;
					}
				}
				if (inputRisingEdge & Pad.down) {
					samusAnimationTimer = 0;
					samusPose = SamusPose.crouching;
					sfxRequestSquare1 = Square1SFX.crouchingTransition;
				}
				if (inputRisingEdge & Pad.a) {
					normalJump:
					if (collisionSamusTop()) {
						return;
					}
					samusJumpArcCounter = samusJumpArrayBaseOffset - 0x1F;
					sfxRequestSquare1 = Square1SFX.hiJumping;
					if (!(samusItems & ItemFlag.hiJump)) {
						samusJumpArcCounter = samusJumpArrayBaseOffset - 0xF;
						sfxRequestSquare1 = Square1SFX.jumping;
					}
					if (waterContactFlag) {
						samusJumpArcCounter += 16;
					}
					samusPose = SamusPose.startingToJump;
					samusJumpStartCounter = 0;
				}
				return;
			case SamusPose.jumping:
				static void startFalling() {
					// naughty ROM write
					//jumpArcTable[0] = 0;
					samusFallArcCounter = 22;
					if (samusPose != SamusPose.morphBallJumping) {
						samusPose = SamusPose.falling;
					} else {
						samusPose = SamusPose.morphBallFalling;
					}
				}
				static void moveVertical(ubyte speed) {
					if (samusMoveVertical(speed)) {
						if (samusJumpArcCounter >= samusJumpArrayBaseOffset + 23) {
							return startFalling();
						}
					}
					samusJumpArcCounter++;
					if ((samusPose == SamusPose.morphBallJumping) && (inputRisingEdge & Pad.up)) {
						samusUnmorphInAir();
						samusUnmorphJumpTimer = 16;
					}
					if (inputPressed & Pad.right) {
						samusMoveRightInAirTurn();
					}
					if (inputPressed & Pad.left) {
						samusMoveLeftInAirTurn();
					}
				}
				ubyte speed;
				if (samusJumpArcCounter < samusJumpArrayBaseOffset) { //linear jumping phase
					if (inputPressed & Pad.a) {
						speed = cast(ubyte)(-2 - !!(samusItems & ItemFlag.hiJump));
						return moveVertical(speed);
					}
					samusJumpArcCounter = samusJumpArrayBaseOffset + 22;
				}
				speed = jumpArcTable[samusJumpArcCounter - samusJumpArrayBaseOffset];
				if (speed == 0x80) {
					return startFalling();
				}
				if (!(speed & 0x80)) {
					if (acidContactFlag) {
						return startFalling();
					}
				}
				return moveVertical(speed);
			case SamusPose.spinJumping:
				static void startFalling() {
					// naughty ROM write
					//jumpArcTable[0] = 0;
					samusFallArcCounter = 22;
					samusPose = SamusPose.falling;
				}
				static void breakSpin() {
					if (samusItems & (ItemFlag.spaceJump | ItemFlag.screwAttack)) {
						sfxRequestSquare1 = Square1SFX.standingTransition;
					}
					startFalling();
				}
				static void moveVertical(ubyte speed) {
					if (!(speed & 0x80) && acidContactFlag) {
						return breakSpin();
					}
					if (samusMoveVertical(speed)) {
						if (samusJumpArcCounter >= samusJumpArrayBaseOffset + 23) {
							return startFalling();
						}
					}
					samusJumpArcCounter++;
					if (inputPressed & Pad.right) {
						samusAirDirection = 1;
					}
					if (inputPressed & Pad.left) {
						samusAirDirection = 0xFF;
					}
					if (samusAirDirection == 1) {
						samusMoveRightInAirNoTurn();
					} else if (samusAirDirection == 0xFF) {
						samusMoveLeftInAirNoTurn();
					}
				}
				ubyte speed;
				if (inputRisingEdge & Pad.b) {
					samusPose = SamusPose.jumping;
				}
				if (samusJumpArcCounter < samusJumpArrayBaseOffset) {
					if (inputPressed & Pad.a) {
						speed = cast(ubyte)(-2 - !!(samusItems & ItemFlag.hiJump));
						return moveVertical(speed);
					}
					samusJumpArcCounter = samusJumpArrayBaseOffset + 22;
				}
				if (inputRisingEdge & Pad.a) {
					if ((spaceJumpTable[samusJumpArcCounter - samusJumpArrayBaseOffset]) && (samusItems & ItemFlag.spaceJump)) {
						samusJumpArcCounter = samusJumpArrayBaseOffset - 40;
						sfxRequestSquare1 = Square1SFX.hiJumping;
						if (!(samusItems & ItemFlag.hiJump)) {
							samusJumpArcCounter = samusJumpArrayBaseOffset - 24;
							sfxRequestSquare1 = Square1SFX.jumping;
						}
						if (samusItems & ItemFlag.screwAttack) {
							sfxRequestSquare1 = Square1SFX.screwAttacking;
						}
						if (samusAirDirection == 0) {
							return;
						}
						samusFacingDirection = (samusAirDirection + 1) / 2;
					}
				}
				if ((samusAirDirection == 0) && (inputPressed & Pad.up) && (frameCounter & 3)) {
					return;
				}
				speed = jumpArcTable[samusJumpArcCounter - samusJumpArrayBaseOffset];
				if (speed != 0x80) {
					return moveVertical(speed);
				}
				return breakSpin();
			case SamusPose.running:
				if (!collisionSamusBottom()) {
					samusPose = SamusPose.falling;
					samusFallArcCounter = 1;
					return;
				}
				samusAnimationTimer += 3;
				if ((inputRisingEdge & Pad.a) && (inputPressed & (Pad.left | Pad.right))) { // spin jump
					if (collisionSamusTop()) {
						return;
					}
					samusJumpArcCounter = cast(ubyte)(samusJumpArrayBaseOffset - 31);
					sfxRequestSquare1 = cast(Square1SFX)(Square1SFX.jumping + !!(samusItems & ItemFlag.hiJump));
					if (!(samusItems & ItemFlag.hiJump)) {
						samusJumpArcCounter = cast(ubyte)(samusJumpArrayBaseOffset - 15);
					}
					if (waterContactFlag) {
						samusJumpArcCounter += 16;
					}
					samusPose = SamusPose.startingToSpinJump;
					samusJumpStartCounter = 0;
					if (samusItems & ItemFlag.screwAttack) {
						sfxRequestSquare1 = Square1SFX.screwAttacking;
					}
					return;
				}
				if (inputPressed & Pad.right) {
					if (samusFacingDirection != 1) {
						samusPose = cast(SamusPose)(SamusPose.running | 0x80);
						samusFacingDirection = 1;
						samusTurnAnimTimer = 2;
						sfxRequestSquare1 = Square1SFX.standingTransition;
					} else if (samusWalkRight()) {
						samusPose = SamusPose.standing;
					}
					return;
				}
				if (inputPressed & Pad.left) {
					if (samusFacingDirection != 0) {
						samusPose = cast(SamusPose)(SamusPose.running | 0x80);
						samusFacingDirection = 0;
						samusTurnAnimTimer = 2;
						sfxRequestSquare1 = Square1SFX.standingTransition;
					} else if (samusWalkLeft()) {
						samusPose = SamusPose.standing;
					}
					return;
				}
				samusPose = SamusPose.standing;
				if (inputRisingEdge & Pad.down) {
					samusAnimationTimer = 0;
					samusPose = SamusPose.crouching;
					sfxRequestSquare1 = Square1SFX.crouchingTransition;
					return;
				}
				if (inputRisingEdge & Pad.a) {
					samusY -= 8;
					if (collisionSamusTop()) {
						return;
					}
					samusJumpArcCounter = samusJumpArrayBaseOffset - 31;
					if (!(samusItems & ItemFlag.hiJump)) {
						samusJumpArcCounter = samusJumpArrayBaseOffset - 15;
					}
					samusPose = SamusPose.startingToJump;
					samusJumpStartCounter = 0;
					sfxRequestSquare1 = Square1SFX.hiJumping;
					if (!(samusItems & ItemFlag.hiJump)) {
						sfxRequestSquare1 = Square1SFX.jumping;
					}
					if (waterContactFlag) {
						samusJumpArcCounter += 16;
					}
				}
				return;
			case SamusPose.crouching:
				if (!collisionSamusBottom()) {
					samusPose = SamusPose.falling;
					samusFallArcCounter = 1;
					return;
				}
				if ((inputPressed & Pad.right) && ((++samusAnimationTimer >= 8) || (inputRisingEdge & Pad.right))) {
					samusAnimationTimer = 0;
					if (samusFacingDirection == 1) {
						if (samusTryStanding()) {
							samusPose = SamusPose.morphBall;
							sfxRequestSquare1 = Square1SFX.morphingTransition;
						}
					} else {
						samusFacingDirection = 1;
					}
					return;
				}
				if ((inputPressed & Pad.left) && ((++samusAnimationTimer >= 8) || (inputRisingEdge & Pad.left))) {
					samusAnimationTimer = 0;
					if (samusFacingDirection == 0) {
						if (samusTryStanding()) {
							samusPose = SamusPose.morphBall;
							sfxRequestSquare1 = Square1SFX.morphingTransition;
						}
					} else {
						samusFacingDirection = 0;
					}
					return;
				}
				if (inputRisingEdge & Pad.a) {
					sfxRequestSquare1 = cast(Square1SFX)(Square1SFX.jumping + !!(samusItems & ItemFlag.hiJump));
					if (inputPressed & (Pad.left | Pad.right)) {
						samusPose = SamusPose.spinJumping;
						if (samusItems & ItemFlag.screwAttack) {
							sfxRequestSquare1 = Square1SFX.screwAttacking;
						}
					} else {
						samusPose = SamusPose.jumping;
					}
					samusJumpArcCounter = samusJumpArrayBaseOffset - 31;
					if (!(samusItems & ItemFlag.hiJump)) {
						samusJumpArcCounter = samusJumpArrayBaseOffset - 15;
					}
					if (waterContactFlag) {
						samusJumpArcCounter += 16;
					}
					samusJumpStartCounter = 0;
					return;
				}
				if (inputRisingEdge & Pad.down) {
					samusMorphOnGround();
					return;
				}
				if ((inputPressed & Pad.down) && (++samusAnimationTimer >= 16)) {
					samusMorphOnGround();
					return;
				}
				if (inputRisingEdge & Pad.up) {
					samusTryStanding();
					return;
				}
				if ((inputPressed & Pad.up) && (++samusAnimationTimer >= 16)) {
					samusTryStanding();
					return;
				}
				return;
			case SamusPose.morphBall:
				static void activateSpiderBall() {
					if (!(samusItems & ItemFlag.spiderBall)) {
						return;
					}
					samusPose = SamusPose.spiderBall;
					samusFallArcCounter = 1;
					spiderRotationState = 0;
					sfxRequestSquare1 = Square1SFX.spiderBall;
				}
				if (!collisionSamusBottom()) {
					samusPose = SamusPose.morphBallFalling;
					samusFallArcCounter = 1;
					return;
				}
				if (inputRisingEdge & Pad.down) {
					return activateSpiderBall();
				}
				if (inputRisingEdge & Pad.up) {
					samusGroundUnmorph();
					return;
				}
				if ((inputPressed & Pad.a) && (samusItems & ItemFlag.springBall)) {
					samusJumpArcCounter = samusJumpArrayBaseOffset - 18;
					samusPose = SamusPose.morphBallJumping;
					samusJumpStartCounter = 0;
					sfxRequestSquare1 = Square1SFX.jumping;
				}
				if (samusSpeedDown >= 2) {
					if (inputPressed & Pad.down) {
						return activateSpiderBall();
					}
					samusPose = SamusPose.morphBallJumping;
					sfxRequestSquare1 = Square1SFX.jumping;
					if (sfxRequestSquare1) { // k.
						samusJumpArcCounter = samusJumpArrayBaseOffset + 8;
					} else {
						samusJumpArcCounter = samusJumpArrayBaseOffset + 4;
					}
				} else {
					samusSpeedDown = 0;
					if (inputPressed & Pad.right) {
						samusRollRightMorph();
					} else if (inputPressed & Pad.left) {
						samusRollLeftMorph();
					}
				}
				return;
			case SamusPose.morphBallJumping:
				if ((inputRisingEdge & Pad.down) && (samusItems & ItemFlag.spiderBall)) {
					samusPose = SamusPose.spiderBallJumping;
					spiderRotationState = 0;
					sfxRequestSquare1 = Square1SFX.spiderBall;
					return;
				}
				goto case SamusPose.jumping;
			case SamusPose.falling:
				static void noJump() {
					if (inputPressed & Pad.right) {
						samusMoveRightInAirTurn();
					} else if (inputPressed & Pad.left) {
						samusMoveLeftInAirTurn();
					}
					if (!samusMoveVertical(samusFallArcTable[samusFallArcCounter])) {
						if (++samusFallArcCounter == 23) {
							samusFallArcCounter = 22;
						}
					} else {
						if (samusTryStanding()) {
							samusPose = SamusPose.crouching;
						}
						samusFallArcCounter = 0;
						if (samusOnSolidSprite) {
							return;
						}
						samusY = (samusY & 0xFF8) | 4;
					}
				}
				if (inputRisingEdge & Pad.a) {
					if (acidContactFlag) {
						samusJumpArcCounter = acidContactFlag; // not yet set for this frame
					} else {
						if (samusUnmorphJumpTimer) {
							return noJump();
						}
						samusJumpArcCounter = samusJumpArrayBaseOffset - 31;
					}
					sfxRequestSquare1 = Square1SFX.hiJumping;
					if (!(samusItems & ItemFlag.hiJump)) {
						samusJumpArcCounter = samusJumpArrayBaseOffset - 15;
						sfxRequestSquare1 = Square1SFX.jumping;
					}
					samusPose = SamusPose.startingToJump;
					samusJumpStartCounter = 0;
					samusUnmorphJumpTimer = 0;
					return;
				}
				return noJump();
			case SamusPose.morphBallFalling:
				if ((inputRisingEdge & Pad.down) && (samusItems & ItemFlag.spiderBall)) {
					samusPose = SamusPose.spiderBallFalling;
					spiderRotationState = 0;
					sfxRequestSquare1 = Square1SFX.spiderBall;
					return;
				}
				if ((inputRisingEdge & Pad.a) && acidContactFlag) {
					samusJumpArcCounter = acidContactFlag;
					samusPose = SamusPose.morphBallJumping;
					samusJumpStartCounter = 0;
					sfxRequestSquare1 = Square1SFX.jumping;
					return;
				}
				if (inputRisingEdge & Pad.up) {
					samusUnmorphInAir();
					samusUnmorphJumpTimer = samusUnmorphJumpTime;
					return;
				}
				if (inputPressed & Pad.right) {
					samusMoveRightInAirTurn();
					if (samusItems & ItemFlag.spiderBall) {
						//return moveVertical(cameraSpeedRight);
					}
				} else if (inputPressed & Pad.left) {
					samusMoveLeftInAirTurn();
					if (samusItems & ItemFlag.spiderBall) {
						//return moveVertical(cameraSpeedLeft);
					}
				}
				// moveVertical:
				if (!samusMoveVertical(samusFallArcTable[samusFallArcCounter])) {
					if (++samusFallArcCounter >= 23) {
						samusFallArcCounter = 22;
					}
				} else {
					samusPose = SamusPose.morphBall;
					samusFallArcCounter = 0;
					if (!samusOnSolidSprite) {
						samusY = (samusY & 0xFF8) | 4;
					}
				}
				return;
			case SamusPose.startingToJump:
			case SamusPose.startingToSpinJump:
				if (inputPressed & Pad.a) {
					if (samusMoveVertical(cast(ubyte)(-2 - ((frameCounter & 2) >> 1)))) {
						samusTryStanding();
						return;
					}
					if (++samusJumpStartCounter < 6) {
						 if (inputPressed & Pad.right) {
							samusMoveRightInAirTurn();
							return;
						 }
						 if (inputPressed & Pad.left) {
							samusMoveLeftInAirTurn();
							return;
						 }
						 return;
					}
				}
				if (samusPose == SamusPose.startingToJump) {
					samusPose = SamusPose.jumping;
				} else {
					samusAirDirection = directionTable[(inputPressed & (Pad.left | Pad.right)) >> 4];
					samusPose = SamusPose.spinJumping;
				}
				return;
			case SamusPose.spiderBallRolling:
				if (inputRisingEdge & Pad.a) {
					samusPose = SamusPose.morphBall;
					sfxRequestSquare1 = Square1SFX.morphingTransition;
					return;
				}
				if (!(inputPressed & (Pad.down | Pad.up | Pad.left | Pad.right))) {
					samusPose = SamusPose.spiderBall;
					spiderRotationState = 0;
					return;
				}
				collisionCheckSpiderSet();
				if (!spiderContactState) {
					assert(0);
					// TODO goto spiderballfall;
				}
				const(ubyte)[] hl;
				if (spiderRotationState & 1) {
					hl = spiderDirectionTable[ccwTry1];
				} else if (!(spiderRotationState & 2)) {
					return;
				} else {
					hl = spiderDirectionTable[cwTry1];
				}
				spiderBallDirection = hl[spiderContactState];

				spiderDisplacement = 0;
				if (spiderBallDirection & 1) {
					right();
				}
				if (spiderBallDirection & 2) {
					left();
				}
				if (spiderBallDirection & 4) {
					up();
				}
				if (spiderBallDirection & 8) {
					down();
				}
				if (spiderDisplacement) {
					return;
				}
				if (spiderRotationState & 1) {
					hl = spiderDirectionTable[ccwTry2];
				} else if (spiderRotationState & 2) {
					return;
				} else {
					hl = spiderDirectionTable[cwTry2];
				}
				spiderBallDirection = hl[spiderContactState];
				spiderDisplacement = 0;
				if (spiderBallDirection & 1) {
					right();
				}
				if (spiderBallDirection & 2) {
					left();
				}
				if (spiderBallDirection & 4) {
					up();
				}
				if (spiderBallDirection & 8) {
					down();
				}
				return;
			case SamusPose.spiderBallFalling:
				if (inputRisingEdge & Pad.a) {
					samusPose = SamusPose.morphBallFalling;
					sfxRequestSquare1 = Square1SFX.morphingTransition;
					return;
				}
				if (inputPressed & Pad.right) {
					right();
				} else if (inputPressed & Pad.left) {
					left();
				}
				if (samusMoveVertical(samusFallArcTable[samusFallArcCounter])) {
					if (!samusOnSolidSprite) {
						samusY = (samusY & 0xFF8) | 4;
					}
					samusPose = SamusPose.spiderBallRolling;
					samusFallArcCounter = 0;
					return;
				}
				collisionCheckSpiderSet();
				if (spiderContactState) {
					samusPose = SamusPose.spiderBallRolling;
					samusFallArcCounter = 0;
					return;
				}
				samusFallArcCounter++;
				if (samusFallArcCounter == 23) {
					samusFallArcCounter = 22;
				}
				return;
			case SamusPose.spiderBallJumping:
				if (inputRisingEdge & Pad.a) {
					samusPose = SamusPose.morphBallJumping;
					sfxRequestSquare1 = Square1SFX.morphingTransition;
					return;
				}
				static void moveVertical(byte amt) {
					if (samusMoveVertical(amt)) {
						assert(0);
						// TODO goto spiderFallLand
					}
					collisionCheckSpiderSet();
					if (spiderContactState) {
						assert(0);
						// TODO goto spiderFallAttach
					}
					samusJumpArcCounter++;
					if (inputPressed & Pad.right) {
						right();
					} else if (inputPressed & Pad.left) {
						samusRollLeftMorph();
					}
				}
				if (samusJumpArcCounter < samusJumpArrayBaseOffset) {
					if (inputPressed & Pad.a) {
						moveVertical(-2);
					} else {
						samusJumpArcCounter = samusJumpArrayBaseOffset + 0x16;
					}
				}
				if (jumpArcTable[samusJumpArcCounter - samusJumpArrayBaseOffset] == 0x80) {
					// no. that's ROM
					//jumpArcTable[0] = 0;
					samusFallArcCounter = 22;
					samusPose = SamusPose.spiderBallFalling;
					spiderRotationState = 0;
					return;
				}
				moveVertical(jumpArcTable[samusJumpArcCounter - samusJumpArrayBaseOffset]);
				return;
			case SamusPose.spiderBall:
				if (inputRisingEdge & Pad.a) {
					samusPose = SamusPose.morphBall;
					sfxRequestSquare1 = Square1SFX.morphingTransition;
					return;
				}
				collisionCheckSpiderSet();
				if (!spiderContactState) {
					samusPose = SamusPose.spiderBallFalling;
					samusFallArcCounter = 1;
				}
				if ((inputRisingEdge & (Pad.down | Pad.up | Pad.left | Pad.right)) == 0) {
					return;
				}
				collisionCheckSpiderSet();
				const a = (inputRisingEdge & (Pad.down | Pad.left | Pad.right | Pad.up)) >> 4;
				if (a) {
					spiderRotationState = spiderBallOrientationTable[(spiderContactState << 4) | a];
					samusPose = SamusPose.spiderBallRolling;
				} else {
					samusPose = SamusPose.spiderBallFalling;
				}
				return;
			case SamusPose.knockBack:
				if (!(inputRisingEdge & Pad.a)) {
					goto case SamusPose.standingBombed;
				}
				if (collisionSamusTop()) {
					return;
				}
				samusInvulnerableTimer = 0;
				samusJumpArcCounter = samusJumpArrayBaseOffset - 0x1F;
				sfxRequestSquare1 = Square1SFX.hiJumping;
				if (!(samusItems & ItemFlag.hiJump)) {
					samusJumpArcCounter = samusJumpArrayBaseOffset - 0xF;
					sfxRequestSquare1 = Square1SFX.jumping;
				}
				if (waterContactFlag) {
					samusJumpArcCounter += 0x10;
				}
				samusPose = SamusPose.startingToJump;
				samusJumpStartCounter = 0;
				return;
			case SamusPose.morphBallKnockBack:
				if (inputRisingEdge & Pad.up) {
					samusUnmorphInAir();
					samusUnmorphJumpTimer = samusUnmorphJumpTime;
				}
				if ((samusItems & ItemFlag.springBall) && (inputRisingEdge & Pad.a)) {
					samusInvulnerableTimer = 0;
					samusJumpArcCounter = samusJumpArrayBaseOffset - 0x12;
					samusPose = SamusPose.morphBallJumping;
					samusJumpStartCounter = 0;
					sfxRequestSquare1 = Square1SFX.jumping;
				}
				goto case SamusPose.standingBombed;
			case SamusPose.morphBallBombed:
			case SamusPose.escapedMetroidQueen:
				if ((inputRisingEdge & Pad.down) && (samusItems & ItemFlag.spiderBall)) {
					samusPose = SamusPose.spiderBallFalling;
					spiderRotationState = 0;
					sfxRequestSquare1 = Square1SFX.spiderBall;
					return;
				} else if (inputRisingEdge & Pad.up) {
					samusUnmorphInAir();
					samusUnmorphJumpTimer = samusUnmorphJumpTime;
				}
				goto case;
			case SamusPose.standingBombed:
				if ((bombArcTable[samusJumpArcCounter - samusJumpArrayBaseOffset] == 0x80) ||
					(samusMoveVertical(bombArcTable[samusJumpArcCounter - samusJumpArrayBaseOffset]) && (samusJumpArcCounter < samusJumpArrayBaseOffset + 0x17))) {
					samusJumpArcCounter = 0;
					samusFallArcCounter = 0;
					samusPose = fallingPoseTable[samusPose];
					return;
				}
				samusJumpArcCounter++;
				if (samusJumpArcCounter >= samusJumpArrayBaseOffset + 0x16) {
					if (inputPressed & Pad.right) {
						samusAirDirection = 1;
					}
					if (inputPressed & Pad.left) {
						samusAirDirection = 0xFF;
					}
				}
				if (samusAirDirection == 1) {
					samusMoveRightInAirNoTurn();
				}
				if (samusAirDirection == 0xFF) {
					samusMoveLeftInAirNoTurn();
				}
				return;
			case SamusPose.facingScreen:
			case SamusPose.facingScreen2:
			case SamusPose.facingScreen3:
			case SamusPose.facingScreen4:
			case SamusPose.facingScreen5:
				if (countdownTimer != 0) {
					return;
				}
				if (currentRoomSong != songPlaying) {
					songRequest = currentRoomSong;
				}
				if ((!loadingFromFile) && (inputPressed == 0)) {
					return;
				}
				samusPose = SamusPose.standing;
				return;
			case SamusPose.eatenByMetroidQueen:
				applyDamageQueenStomach();
				if (queenEatingState == 3) {
					samusPose = SamusPose.inMetroidQueenMouth;
				} else {
					ubyte c = 0;
					if (samusOnScreenYPos == queenHeadY + 19) {
						c = 1;
					} else if (samusOnScreenYPos >= queenHeadY + 19) {
						samusY--;
						cameraSpeedUp = 1;
					} else {
						samusY++;
						cameraSpeedDown = 1;
					}
					if (samusOnScreenXPos == queenHeadX + 26) {
						c++;
					} else if (samusOnScreenXPos >= queenHeadX + 26) {
						samusX -= 2;
						cameraSpeedLeft = 1;
					} else {
						samusX++;
						cameraSpeedRight = 1;
					}
					if (c == 2) {
						queenEatingState = 2;
					}
				}
				return;
			case SamusPose.inMetroidQueenMouth:
				samusY = (samusY & 0xF00) + 0x6C;
				samusX = (samusX & 0xF00) + 0xA6;
				applyDamageQueenStomach();
				if (queenEatingState == 5) {
					samusAirDirection = 1;
					samusJumpArcCounter = samusJumpArrayBaseOffset + 16;
					samusPose = SamusPose.escapedMetroidQueen;
				} else if (queenEatingState == 0x20) {
					samusJumpArcCounter = samusJumpArrayBaseOffset;
					samusAirDirection = 1;
					samusPose = SamusPose.escapedMetroidQueen;
				} else if (inputRisingEdge & Pad.left) {
					samusPose = SamusPose.swallowedByMetroidQueen;
					queenEatingState = 6;
				}
				return;
			case SamusPose.swallowedByMetroidQueen:
				applyDamageQueenStomach();
				if (samusX.pixel != 0x68) {
					if (queenHeadX + 6 + scrollX < samusX.pixel) {
						samusY--;
					}
					samusX--;
					if (samusX.pixel >= 0x80) {
						return;
					}
					samusY++;
				} else {
					samusPose = SamusPose.inMetroidQueenStomach;
				}
				return;
			case SamusPose.inMetroidQueenStomach:
				applyDamageQueenStomach();
				return;
			case SamusPose.escapingMetroidQueen:
				applyDamageQueenStomach();
				if (samusX.pixel != 0xB0) {
					samusX += 2;
					if (samusX.pixel < 0x80) {
						samusY -= 2;
					} else if (samusX.pixel >= 0x98) {
						samusY--;
					}
				} else {
					samusJumpArcCounter = samusJumpArrayBaseOffset;
					samusAirDirection = 1;
					samusPose = SamusPose.escapedMetroidQueen;
				}
				return;
		}
	}
}

immutable SamusPose[] fallingPoseTable = [
	SamusPose.standing: SamusPose.standing,
	SamusPose.jumping: SamusPose.standing,
	SamusPose.spinJumping: SamusPose.standing,
	SamusPose.running: SamusPose.standing,
	SamusPose.crouching: SamusPose.standing,
	SamusPose.morphBall: SamusPose.standing,
	SamusPose.morphBallJumping: SamusPose.standing,
	SamusPose.falling: SamusPose.standing,
	SamusPose.morphBallFalling: SamusPose.standing,
	SamusPose.startingToJump: SamusPose.standing,
	SamusPose.startingToSpinJump: SamusPose.standing,
	SamusPose.spiderBallRolling: SamusPose.standing,
	SamusPose.spiderBallFalling: SamusPose.standing,
	SamusPose.spiderBallJumping: SamusPose.standing,
	SamusPose.spiderBall: SamusPose.standing,
	SamusPose.knockBack: SamusPose.falling,
	SamusPose.morphBallKnockBack: SamusPose.morphBallFalling,
	SamusPose.standingBombed: SamusPose.falling,
	SamusPose.morphBallBombed: SamusPose.morphBallFalling,
	SamusPose.facingScreen: SamusPose.standing,
	SamusPose.facingScreen2: SamusPose.standing,
	SamusPose.facingScreen3: SamusPose.standing,
	SamusPose.facingScreen4: SamusPose.standing,
	SamusPose.facingScreen5: SamusPose.standing,
	SamusPose.eatenByMetroidQueen: SamusPose.eatenByMetroidQueen,
	SamusPose.inMetroidQueenMouth: SamusPose.inMetroidQueenMouth,
	SamusPose.swallowedByMetroidQueen: SamusPose.swallowedByMetroidQueen,
	SamusPose.inMetroidQueenStomach: SamusPose.inMetroidQueenStomach,
	SamusPose.escapingMetroidQueen: SamusPose.escapingMetroidQueen,
	SamusPose.escapedMetroidQueen: SamusPose.morphBallFalling,
];

immutable ubyte[] bombArcTable = [
	0xFD, 0xFD, 0xFD, 0xFD, 0xFE, 0xFD, 0xFE, 0xFD, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFE,
	0xFE, 0xFF, 0xFE, 0xFF, 0xFE, 0xFF, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x02, 0x01, 0x02,
	0x01, 0x02, 0x02, 0x01, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x03, 0x02, 0x03, 0x02, 0x03, 0x03,
	0x03, 0x03, 0x80,
];

immutable ubyte[] samusFallArcTable = [
	0x01, 0x01, 0x01, 0x01, 0x00, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x01,
	0x02, 0x02, 0x01, 0x02, 0x02, 0x02, 0x03,
];

immutable ubyte[] jumpArcTable = [
	0xFE, 0xFE, 0xFE, 0xFE, 0xFF, 0xFE, 0xFF, 0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0x00, 0xFF,
	0xFF, 0x00, 0xFF, 0x00, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x01,
	0x00, 0x01, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x02, 0x01, 0x02, 0x01, 0x02, 0x02,
	0x02, 0x02, 0x03, 0x02, 0x02, 0x03, 0x02, 0x02, 0x03, 0x02, 0x03, 0x02, 0x03, 0x02, 0x03, 0x02,
	0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x80,
];
immutable ubyte[] spaceJumpTable = [
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x01, 0x02, 0x02,
	0x02, 0x02, 0x03, 0x02, 0x02, 0x03, 0x02, 0x02, 0x03, 0x02, 0x03, 0x02, 0x03, 0x02, 0x03, 0x02,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,
];
immutable ubyte[] directionTable = [
	0x00, 0x01, 0xFF,
];

void collisionCheckSpiderSet() {
	enum spiderXLeft = 0x0A;
	enum spiderXRight = 0x15;
	enum spiderXMid = (spiderXLeft + spiderXRight) / 2;
	enum spiderYTop = 0x1E;
	enum spiderYBottom = 0x1C;
	enum spiderYMid = (spiderYTop + spiderYBottom) / 2;
	spiderContactState = 0;

	tileX = cast(ubyte)(samusX.pixel + spiderXRight);
	tileY = cast(ubyte)(samusY.pixel + spiderYTop);
	spiderContactState = rr(spiderContactState, collisionCheckSpiderPoint());

	tileY = cast(ubyte)(samusY.pixel + spiderYBottom);
	spiderContactState = rr(spiderContactState, collisionCheckSpiderPoint());

	tileX = cast(ubyte)(samusX.pixel + spiderXLeft);
	tileY = cast(ubyte)(samusY.pixel + spiderYTop);
	spiderContactState = rr(spiderContactState, collisionCheckSpiderPoint());

	tileY = cast(ubyte)(samusY.pixel + spiderYBottom);
	spiderContactState = swap(rr(spiderContactState, collisionCheckSpiderPoint()));

	tileX = cast(ubyte)(samusX.pixel + spiderXRight);
	tileY = cast(ubyte)(samusY.pixel + spiderYMid);
	if (collisionCheckSpiderPoint()) {
		spiderContactState |= 0b0011;
	}

	tileX = cast(ubyte)(samusX.pixel + spiderXLeft);
	tileY = cast(ubyte)(samusY.pixel + spiderYMid);
	if (collisionCheckSpiderPoint()) {
		spiderContactState |= 0b1100;
	}

	tileX = cast(ubyte)(samusX.pixel + spiderXMid);
	tileY = cast(ubyte)(samusY.pixel + spiderYTop);
	if (collisionCheckSpiderPoint()) {
		spiderContactState |= 0b0101;
	}

	tileY = cast(ubyte)(samusY.pixel + spiderYBottom);
	tileX = cast(ubyte)(samusX.pixel + spiderXMid);
	if (samusGetTileIndex() < samusSolidityIndex) {
		spiderContactState |= 0b1010;
	} else if (collisionSamusEnemiesDown()) {
		spiderContactState |= 0b1010;
	}
	if ((spiderContactState & 5) == 5) {
		return;
	}
	if (!(inputPressed & Pad.a)) {
		return;
	}
}

void samusGroundUnmorph() {
	tileX = cast(ubyte)(samusX.pixel + 11);
	tileY = cast(ubyte)(samusY.pixel + 24);
	ubyte tile = samusGetTileIndex();
	if (tile >= samusSolidityIndex) {
		tileX = cast(ubyte)(samusX.pixel + 20);
		tile = samusGetTileIndex();
		if (tile >= samusSolidityIndex) {
			samusPose = SamusPose.crouching;
			samusAnimationTimer = 0;
			sfxRequestSquare1 = Square1SFX.crouchingTransition;
			return;
		}
	}
	samusPose = SamusPose.morphBall;
	samusSpeedDown = 0;
}
bool samusTryStanding() {
	sfxRequestSquare1 = Square1SFX.standingTransition;
	tileX = cast(ubyte)(samusX.pixel + 12);
	tileY = cast(ubyte)(samusY.pixel + 16);
	if (samusGetTileIndex() < samusSolidityIndex) {
		return true;
	}
	tileX = cast(ubyte)(samusX.pixel + 20);
	if (samusGetTileIndex() < samusSolidityIndex) {
		return true;
	}
	samusPose = SamusPose.standing;
	sfxRequestSquare1 = Square1SFX.standingTransition;
	return false;
}
void samusMorphOnGround() {
	samusPose = SamusPose.morphBall;
	samusSpeedDown = 0;
	sfxRequestSquare1 = Square1SFX.morphingTransition;
}
void samusUnmorphInAir() {
	tileY = cast(ubyte)(samusY.pixel + 8);
	tileX = cast(ubyte)(samusX.pixel + 11);
	if (samusGetTileIndex() < samusSolidityIndex) {
		return;
	}
	tileX = cast(ubyte)(samusX.pixel + 20);
	if (samusGetTileIndex() < samusSolidityIndex) {
		return;
	}
	tileY = cast(ubyte)(samusY.pixel + 24);
	tileX = cast(ubyte)(samusX.pixel + 11);
	if (samusGetTileIndex() < samusSolidityIndex) {
		return;
	}
	tileX = cast(ubyte)(samusX.pixel + 20);
	if (samusGetTileIndex() < samusSolidityIndex) {
		return;
	}
	samusPose = SamusPose.falling;
	sfxRequestSquare1 = Square1SFX.standingTransition;
}
bool samusWalkRight() {
	samusFacingDirection = 1;
	ubyte walkingSpeed = 1; //water
	if (!waterContactFlag) {
		if (samusItems & ItemFlag.variaSuit) {
			walkingSpeed = 2;
		} else {
			walkingSpeed = (frameCounter & 1) + 1; // 1.5
		}
	}
	samusX = (samusX + walkingSpeed) & 0xFFF;
	tileX = samusX.screen;
	if (collisionSamusHorizontalRight()) {
		// restore position
		samusX = prevSamusX;
		return true;
	} else {
		cameraSpeedRight = walkingSpeed;
		return false;
	}
}
bool samusWalkLeft() {
	samusFacingDirection = 0;
	ubyte walkingSpeed = 1; //water
	if (!waterContactFlag) {
		if (samusItems & ItemFlag.variaSuit) {
			walkingSpeed = 2;
		} else {
			walkingSpeed = (frameCounter & 1) + 1; // 1.5
		}
	}
	samusX = (samusX - walkingSpeed) & 0xFFF;
	tileX = samusX.screen;
	if (collisionSamusHorizontalLeft()) {
		// restore position
		samusX = prevSamusX;
		return true;
	} else {
		cameraSpeedLeft = walkingSpeed;
		return false;
	}
}
void samusRollRightSpider() {
	samusRollRight(1);
}
void samusRollRightMorph() {
	samusRollRight(2);
}
void samusRollRight(ubyte speed) {
	samusFacingDirection = 1;
	samusX = (samusX + speed) & 0xFFF;
	tileX = samusX.screen;
	if (collisionSamusHorizontalRight()) {
		samusX = prevSamusX;
	} else {
		cameraSpeedRight = speed;
	}
}
void samusRollLeftSpider() {
	samusRollLeft(1);
}
void samusRollLeftMorph() {
	samusRollLeft(2);
}
void samusRollLeft(ubyte speed) {
	samusFacingDirection = 0;
	samusX = (samusX - speed) & 0xFFF;
	tileX = samusX.screen;
	if (collisionSamusHorizontalLeft()) {
		samusX = prevSamusX;
	} else {
		cameraSpeedLeft = speed;
	}
}
void samusMoveRightInAirTurn() {
	samusFacingDirection = 1;
	samusMoveRightInAirNoTurn();
}
void samusMoveRightInAirNoTurn() {
	const speed = 1;
	samusX = (samusX + speed) & 0xFFF;
	tileX = samusX.screen;
	if (collisionSamusHorizontalRight()) {
		samusX = prevSamusX;
	} else {
		cameraSpeedRight = speed;
	}
}
void samusMoveLeftInAirTurn() {
	samusFacingDirection = 0;
	samusMoveLeftInAirNoTurn();
}
void samusMoveLeftInAirNoTurn() {
	const speed = 1;
	samusX = (samusX - speed) & 0xFFF;
	tileX = samusX.screen;
	if (collisionSamusHorizontalLeft()) {
		samusX = prevSamusX;
	} else {
		cameraSpeedLeft = speed;
	}
}
bool samusMoveVertical(ubyte speed) {
	if (speed >= 0x80) {
		return samusMoveUp(cast(ubyte)-speed);
	}
	samusSpeedDownTemp = speed;
	samusY = (samusY + speed) & 0xFFF;
	if (collisionSamusBottom()) {
		samusY = prevSamusY;
		return true;
	} else {
		if (waterContactFlag) {
			samusY = (prevSamusY + speed / 2) & 0xFFF;
		}
		cameraSpeedDown = speed;
		samusSpeedDown = samusSpeedDownTemp;
	}
	return false;
}
bool samusMoveUp(ubyte speed) {
	samusY = (samusY - speed) & 0xFFF;
	if (collisionSamusTop()) {
		samusJumpArcCounter = samusJumpArrayBaseOffset + 22;
		samusY = prevSamusY;
		return true;
	} else {
		if (waterContactFlag) {
			samusY -= speed / 2; // no masking?
		}
		cameraSpeedUp = speed;
		return false;
	}
}
bool collisionSamusHorizontalLeft() {
	tileX = cast(ubyte)(samusX.pixel + 11);
	return collisionSamusHorizontal();
}
bool collisionSamusHorizontalRight() {
	tileX = cast(ubyte)(samusX.pixel + 20);
	return collisionSamusHorizontal();
}
bool collisionSamusHorizontal() {
	if (collisionSamusEnemiesHorizontal()) {
		return true;
	}
	bool seen80;
	for (int i = 5; i >= 0; i--) {
		const a = samusHorizontalYOffsetLists[samusPose][i];
		if (!seen80) {
			if (a == 0x80) {
				seen80 = true;
			}
			continue;
		}
		if (i < 4) {
			collisionSamusYOffsets[i] = a;
		}
		tileY = cast(ubyte)(samusY.pixel + a);
		if (samusGetTileIndex() < samusSolidityIndex) {
			return true;
		}
	}
	return false;
}
bool collisionSamusTop() {
	if (collisionSamusEnemiesUp()) {
		return true;
	}
	tileX = cast(ubyte)(samusX.pixel + 12);
	tileY = cast(ubyte)(samusY.pixel + samusBGHitboxTopTable[samusPose]);

	const a = samusGetTileIndex();

	if (collisionArray[a] & BlockType.water) {
		waterContactFlag = 0xFF;
	}
	if (collisionArray[a] & BlockType.up) {
		return false;
	}
	if (collisionArray[a] & BlockType.acid) {
		acidContactFlag = 0x40;
		applyDamageAcid(acidDamageValue);
	}
	if (a < samusSolidityIndex) {
		return true;
	}
	tileX = cast(ubyte)(samusX.pixel + 20);
	const a2 = samusGetTileIndex();
	bool ignore;
	if (collisionArray[a2] & BlockType.water) {
		waterContactFlag = 0xFF;
	}
	if (collisionArray[a2] & BlockType.up) {
		ignore = true;
	}
	if (collisionArray[a2] & BlockType.acid) {
		acidContactFlag = 0x40;
		applyDamageAcid(acidDamageValue);
	}
	if (ignore) {
		return false;
	}
	return a2 < samusSolidityIndex;
}
bool collisionSamusBottom() {
	EnemySlot* enemy;
	if (collisionSamusEnemiesDown(enemy)) {
		samusOnSolidSprite = 1;
		collision.enemy = enemy;
		collision.weaponType = CollisionType.contact;
		return true;
	}
	tileX = cast(ubyte)(samusX.pixel + 12);
	tileY = cast(ubyte)(samusY.pixel + 44);

	const a = samusGetTileIndex();

	if (collisionArray[a] & BlockType.water) {
		waterContactFlag = 49;
	}
	if (collisionArray[a] & BlockType.save) {
		saveContactFlag = 0xFF;
	}
	if (collisionArray[a] & BlockType.down) {
		return false;
	}
	if (collisionArray[a] & BlockType.acid) {
		acidContactFlag = 0x40;
		applyDamageAcid(acidDamageValue);
	}
	if (a < samusSolidityIndex) {
		return true;
	}
	tileX = cast(ubyte)(samusX.pixel + 20);
	const a2 = samusGetTileIndex();
	if (collisionArray[a2] & BlockType.water) {
		waterContactFlag = 0xFF;
	}
	if (collisionArray[a2] & BlockType.save) {
		saveContactFlag = 0xFF;
	}
	bool ignore;
	if (collisionArray[a2] & BlockType.down) {
		ignore = true;
	}
	if (collisionArray[a2] & BlockType.acid) {
		acidContactFlag = 0x40;
		applyDamageAcid(acidDamageValue);
	}
	if (a2 < samusSolidityIndex) {
		samusUnmorphJumpTimer = 0;
	}
	if (ignore) {
		return false;
	}
	return a2 < samusSolidityIndex;
}
bool collisionCheckSpiderPoint() {
	const index = samusGetTileIndex();
	if (index < samusSolidityIndex) {
		if (collisionArray[index] & BlockType.acid) {
			acidContactFlag = 0x40;
			applyDamageAcid(acidDamageValue);
		}
		return false;
	}
	if (collisionArray[index] & BlockType.acid) {
		acidContactFlag = 0x40;
		applyDamageAcid(acidDamageValue);
	}
	return true;
}
ubyte samusGetTileIndex() {
	getTilemapAddress();
	if (gameOverLCDCCopy & 8) {
		tilemapDest += 0x400; // use other screen tilemap
	}
	waitHBlank();
	const b = vram()[tilemapDest];
	waitHBlank();
	const a = vram()[tilemapDest] & b;
	if (!samusInvulnerableTimer) {
		if (collisionArray[a] & BlockType.spike) {
			sfxRequestSquare1 = Square1SFX.standingTransition;
			samusHurtFlag = 1;
			samusDamageBoostDirection = 0;
			samusDamageValue = spikeDamageValue;
		}
	}
	return a;
}

immutable ubyte[] metroidLCounterTable = [ //originally BCD indexed
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x01, 0x02, 0x03, 0x01, 0x01, 0x01, 0x02, 0x03, 0x04, 0x05, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x06, 0x07, 0x01, 0x02, 0x01, 0x01, 0x02, 0x03, 0x04, 0x05, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x06, 0x07, 0x08, 0x09, 0x10, 0x01, 0x02, 0x03, 0x04, 0x05, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x06, 0x07, 0x08, 0x01, 0x02, 0x03, 0x04, 0x01,
];
immutable ubyte[8] saveMagic = [
	0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef
];

immutable SamusPose[] samusDamagePoseTransitionTable = [
	SamusPose.standing: SamusPose.knockBack,
	SamusPose.jumping: SamusPose.knockBack,
	SamusPose.spinJumping: SamusPose.knockBack,
	SamusPose.running: SamusPose.knockBack,
	SamusPose.crouching: SamusPose.knockBack,
	SamusPose.morphBall: SamusPose.morphBallKnockBack,
	SamusPose.morphBallJumping: SamusPose.morphBallKnockBack,
	SamusPose.falling: SamusPose.knockBack,
	SamusPose.morphBallFalling: SamusPose.morphBallKnockBack,
	SamusPose.startingToJump: SamusPose.knockBack,
	SamusPose.startingToSpinJump: SamusPose.knockBack,
	SamusPose.spiderBallRolling: SamusPose.morphBallKnockBack,
	SamusPose.spiderBallFalling: SamusPose.morphBallKnockBack,
	SamusPose.spiderBallJumping: SamusPose.morphBallKnockBack,
	SamusPose.spiderBall: SamusPose.morphBallKnockBack,
	SamusPose.knockBack: SamusPose.knockBack,
	SamusPose.morphBallKnockBack: SamusPose.morphBallKnockBack,
	SamusPose.standingBombed: SamusPose.knockBack,
	SamusPose.morphBallBombed: SamusPose.morphBallKnockBack,
	SamusPose.facingScreen: SamusPose.knockBack,
	SamusPose.facingScreen2: SamusPose.standing,
	SamusPose.facingScreen3: SamusPose.standing,
	SamusPose.facingScreen4: SamusPose.standing,
	SamusPose.facingScreen5: SamusPose.standing,
	SamusPose.eatenByMetroidQueen: SamusPose.morphBallKnockBack,
	SamusPose.inMetroidQueenMouth: SamusPose.morphBallKnockBack,
	SamusPose.swallowedByMetroidQueen: SamusPose.swallowedByMetroidQueen,
	SamusPose.inMetroidQueenStomach: SamusPose.inMetroidQueenStomach,
	SamusPose.escapingMetroidQueen: SamusPose.escapingMetroidQueen,
	SamusPose.escapedMetroidQueen: SamusPose.escapedMetroidQueen,
];

// Values
// - 0: Nothing
// - 1: Move Right
// - 2: Move Left
// - 4: Move Up
// - 8: Move Down
//
//    ______________________________________________ 0: In air
//   |   ___________________________________________ 1: Outside corner: Of left-facing wall and ceiling
//   |  |   ________________________________________ 2: Outside corner: Of left-facing wall and floor
//   |  |  |   _____________________________________ 3: Flat surface:   Left-facing wall
//   |  |  |  |   __________________________________ 4: Outside corner: Of right-facing wall and ceiling
//   |  |  |  |  |   _______________________________ 5: Flat surface:   Ceiling
//   |  |  |  |  |  |   ____________________________ 6: Unused:         Top-left and bottom-right corners of ball in contact
//   |  |  |  |  |  |  |   _________________________ 7: Inside corner:  Of left-facing wall and ceiling
//   |  |  |  |  |  |  |  |   ______________________ 8: Outside corner: Of right-facing wall and floor
//   |  |  |  |  |  |  |  |  |   ___________________ 9: Unused:         Bottom-left and top-right corners of ball in contact
//   |  |  |  |  |  |  |  |  |  |   ________________ A: Flat surface:   Floor
//   |  |  |  |  |  |  |  |  |  |  |   _____________ B: Inside corner:  Of left-facing wall and floor
//   |  |  |  |  |  |  |  |  |  |  |  |   __________ C: Flat surface:   Right-facing wall
//   |  |  |  |  |  |  |  |  |  |  |  |  |   _______ D: Inside corner:  Of right-facing wall and ceiling
//   |  |  |  |  |  |  |  |  |  |  |  |  |  |   ____ E: Inside corner:  Of right-facing wall and floor
//   |  |  |  |  |  |  |  |  |  |  |  |  |  |  |   _ F: Unused:         Embedded in solid
//   |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  |
immutable ubyte[16][4] spiderDirectionTable = [
	[0, 4, 1, 4, 2, 2, 0, 2, 8, 0, 1, 4, 8, 8, 1, 0],
	[0, 2, 4, 2, 8, 8, 0, 8, 1, 0, 4, 2, 1, 1, 4, 0],
	[0, 1, 8, 8, 4, 1, 0, 8, 2, 0, 2, 2, 4, 1, 4, 0],
	[0, 8, 2, 2, 1, 8, 0, 2, 4, 0, 4, 4, 1, 8, 1, 0],
];

immutable ubyte[] samusBGHitboxTopTable = [
	SamusPose.standing: 0x08,
	SamusPose.jumping: 0x14,
	SamusPose.spinJumping: 0x1A,
	SamusPose.running: 0x08,
	SamusPose.crouching: 0x10,
	SamusPose.morphBall: 0x20,
	SamusPose.morphBallJumping: 0x20,
	SamusPose.falling: 0x10,
	SamusPose.morphBallFalling: 0x20,
	SamusPose.startingToJump: 0x10,
	SamusPose.startingToSpinJump: 0x10,
	SamusPose.spiderBallRolling: 0x20,
	SamusPose.spiderBallFalling: 0x20,
	SamusPose.spiderBallJumping: 0x20,
	SamusPose.spiderBall: 0x20,
	SamusPose.knockBack: 0x10,
	SamusPose.morphBallKnockBack: 0x20,
	SamusPose.standingBombed: 0x10,
	SamusPose.morphBallBombed: 0x20,
	SamusPose.facingScreen: 0x08,
	SamusPose.facingScreen2: 0x20,
	SamusPose.facingScreen3: 0x20,
];

immutable ubyte[8][] samusHorizontalYOffsetLists = [
	SamusPose.standing: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.jumping: [0x14,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.spinJumping: [0x1A,  0x20,  0x28,  0x2A,  0x80, 0, 0, 0],
	SamusPose.running: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.crouching: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.morphBall: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.morphBallJumping: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.falling: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.morphBallFalling: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.startingToJump: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.startingToSpinJump: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.spiderBallRolling: [0x20,  0x25,  0x2B,  0x80, 0, 0, 0, 0],
	SamusPose.spiderBallFalling: [0x20,  0x25,  0x2B,  0x80, 0, 0, 0, 0],
	SamusPose.spiderBallJumping: [0x20,  0x25,  0x2B,  0x80, 0, 0, 0, 0],
	SamusPose.spiderBall: [0x20,  0x25,  0x2B,  0x80, 0, 0, 0, 0],
	SamusPose.knockBack: [0x14,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.morphBallKnockBack: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.standingBombed: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.morphBallBombed: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.facingScreen: [0x10,  0x18,  0x20,  0x28,  0x2A,  0x80, 0, 0],
	SamusPose.facingScreen2: [0, 0, 0, 0, 0, 0, 0, 0],
	SamusPose.facingScreen3: [0, 0, 0, 0, 0, 0, 0, 0],
	SamusPose.facingScreen4: [0, 0, 0, 0, 0, 0, 0, 0],
	SamusPose.facingScreen5: [0, 0, 0, 0, 0, 0, 0, 0],
	SamusPose.eatenByMetroidQueen: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.inMetroidQueenMouth: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.swallowedByMetroidQueen: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.inMetroidQueenStomach: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.escapingMetroidQueen: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
	SamusPose.escapedMetroidQueen: [0x20,  0x25,  0x2A,  0x80, 0, 0, 0, 0],
];

void clearProjectileArray() {
	for (int i = 0; i < projectileArray.length; i++) {
		projectileArray[i] = Projectile.init;
	}
}

void samusTryShooting() {
	if ((samusPose == SamusPose.facingScreen) || (queenEatingState == 0x22) || !(inputRisingEdge & Pad.select)) {
		if (!(inputRisingEdge & Pad.b) && (!(inputPressed & Pad.b) || (++samusBeamCooldown <= 16))) {
			return;
		}
		beamLoop: while (true) {
			if (samusPose & 0x80) {
				return;
			}
			if (!samusPossibleShotDirections[samusPose]) {
				return;
			}
			if (samusPossibleShotDirections[samusPose] == 0x80) {
				if (!(samusItems & ItemFlag.bomb) || !(inputRisingEdge & Pad.b)) {
					return;
				}
				ubyte bombIndex;
				for (bombIndex = 0; bombIndex < bombArray.length; bombIndex++) {
					if (bombArray[bombIndex].type == BombType.invalid) {
						break;
					}
				}
				if (bombIndex == bombArray.length) {
					return;
				}
				bombArray[bombIndex].type = BombType.bomb;
				bombArray[bombIndex].timer = 96; // was this supposed to be 60 frames or $60?
				bombArray[bombIndex].y = cast(ubyte)(samusY.pixel + 38);
				bombArray[bombIndex].x = cast(ubyte)(samusX.pixel + 16);
				sfxRequestSquare1 = Square1SFX.bombLaid;
				return;
			}
			samusBeamCooldown = 0;
			ubyte firingDirection;
			const possibleDirections = (inputPressed >> 4) & samusPossibleShotDirections[samusPose];
			if (!possibleDirections) {
				firingDirection = 1;
				if (!samusFacingDirection) {
					firingDirection = 2;
				}
			} else {
				firingDirection = samusShotDirectionPriorityTable[possibleDirections];
			}
			ubyte shotY = cast(ubyte)(samusCannonYOffsetByPose[samusPose] + samusCannonYOffsetByAimDirection[firingDirection] - 4);
			ubyte shotX = cast(ubyte)(samusCannonXOffsetTable[firingDirection][samusFacingDirection] - 4);
			if (samusActiveWeapon == CollisionType.plasmaBeam) {
				if (projectileArray[0].type != CollisionType.nothing) {
					return;
				}
				for (int slot = 0; slot < projectileArray.length; slot++) {
					if (firingDirection < BeamDirection.up) {
						shotX -= 8;
						if (slot == 0) {
							shotX += 16;
						}
					} else {
						shotY -= 8;
						if (slot == 0) {
							shotY += 16;
						}
					}
					projectileArray[slot].type = samusActiveWeapon;
					projectileArray[slot].direction = firingDirection;
					projectileArray[slot].y = cast(ubyte)(shotY + samusY.pixel);
					projectileArray[slot].x = cast(ubyte)(shotX + samusX.pixel);
					projectileArray[slot].waveIndex = (frameCounter & 0x10) >> 1;
					projectileArray[slot].frameCounter = 0;
				}
				sfxRequestSquare1 = beamSoundTable[samusActiveWeapon];
			}
			const slot = getFirstEmptyProjectileSlot();
			if (slot >= projectileArray.length) {
				return;
			}
			if (samusActiveWeapon == CollisionType.missiles) {
				if (!samusCurMissiles) {
					sfxRequestSquare1 = Square1SFX.noMissileDudShot;
					return;
				}
				samusCurMissiles--;
			}
			projectileArray[slot].type = samusActiveWeapon;
			projectileArray[slot].direction = firingDirection;
			projectileArray[slot].y = cast(ubyte)(shotY + samusY.pixel);
			projectileArray[slot].x = cast(ubyte)(shotX + samusX.pixel);
			projectileArray[slot].waveIndex = (frameCounter & 0x10) >> 1;
			projectileArray[slot].frameCounter = 0;
			if ((samusActiveWeapon != CollisionType.spazer) || (slot >= projectileArray.length - 1)) {
				break beamLoop;
			}
		}
		sfxRequestSquare1 = beamSoundTable[samusActiveWeapon];
		return;
	}
	samusTryShootingToggleMissiles();
}

GraphicsInfo graphicsInfoCannonMissile() {
	return GraphicsInfo(graphicsCannonMissile, VRAMDest.cannon, 0x20);
}
GraphicsInfo graphicsInfoCannonBeam() {
	return GraphicsInfo(graphicsCannonBeam, VRAMDest.cannon, 0x20);
}

void samusTryShootingToggleMissiles() {
	if (samusActiveWeapon == CollisionType.missiles) {
		samusActiveWeapon = samusBeam;
		loadGraphics(graphicsInfoCannonBeam);
		sfxRequestSquare1 = Square1SFX.select;
	} else {
		samusBeam = samusActiveWeapon;
		samusActiveWeapon = CollisionType.missiles;
		loadGraphics(graphicsInfoCannonMissile);
		sfxRequestSquare1 = Square1SFX.select;
	}
}


//alias getTileIndex = getTileIndexEnemy;
ubyte getTileIndexEnemy() {
	tileY = cast(ubyte)(scrollY + enemyTestPointYPos);
	tileX = cast(ubyte)(scrollX + enemyTestPointXPos);
	return getTileIndexProjectile();
}
ubyte getTileIndexProjectile() {
	getTilemapAddress();
	if (gameOverLCDCCopy & 8) {
		tilemapDest += 0x400;
	}
	waitHBlank();
	const b = vram()[tilemapDest];
	waitHBlank();
	return vram()[tilemapDest] & b;
}


void readInput() {
	writeJoy(0x20);
	ubyte tmp = ((~readJoy()) & 0xF) << 4;
	writeJoy(0x10);
	tmp |= ~readJoy() & 0xF;
	inputRisingEdge = (inputPressed ^ tmp) & tmp;
	inputPressed = tmp;
	writeJoy(0x30);
}

void getTilemapAddress() {
	tilemapDest = 0x9800 + (cast(ubyte)(tileY - 16) / 8) * 0x20 + cast(ubyte)(tileX - 8) / 8;
}

unittest {
	tileY = 0x00;
	tileX = 0x9D;
	getTilemapAddress();
	assert(tilemapDest == 0x9BD2);
}

void getTilemapCoordinates() {
	assert(0); // not used
}

void unknown230C() {
	assert(0); // not used
}
void oamDMA() {
	vram()[0xFE00 .. 0xFEA0] = cast(ubyte[])(oamBuffer[]);
}
void executeDoorScript() {
	if (doorIndex) {
		infof("Executing script %s", doorIndex);
		oamBufferIndex = samusTopOAMOffset;
		clearUnusedOAMSlots();
		waitOneFrame();
		oamDMA();
		doorScriptBuffer[0 .. doorPointerTable[doorIndex].length] = doorPointerTable[doorIndex][];
		const(ubyte)* script = &doorScriptBuffer[0];
		while (true) {
			if (script[0] == DoorCommand.end) {
				script++;
				break;
			}
			switch (cast(DoorCommand)(script[0] & 0xF0)) {
				case DoorCommand.loadData:
					saveMessageCooldownTimer = 0;
					saveContactFlag = 0;
					WY = 0x88;
					doorLoadGraphics(script);
					break;
				case DoorCommand.copyData:
					saveMessageCooldownTimer = 0;
					saveContactFlag = 0;
					WY = 0x88;
					doorCopyData(script);
					break;
				case DoorCommand.tileTable:
					doorLoadTileTable(script);
					break;
				case DoorCommand.collision:
					doorLoadCollision(script);
					break;
				case DoorCommand.solidity:
					const solidity = solidityIndexTable[script[0] & 0xF];
					script++;
					samusSolidityIndex = solidity[0];
					saveBuf.samusSolidityIndex = solidity[0];
					enemySolidityIndex = solidity[1];
					saveBuf.enemySolidityIndex = solidity[1];
					beamSolidityIndex = solidity[2];
					saveBuf.beamSolidityIndex = solidity[2];
					break;
				case DoorCommand.warp:
					doorWarp(script);
					doorExitStatus = 1;
					queenRoomFlag &= 0xF;
					break;
				case DoorCommand.escapeQueen:
					script++;
					IE &= ~(1 << 1);
					samusY = (samusY.screen << 8) | 0xD7;
					samusX = (samusX.screen << 8) | 0x78;
					cameraY = (cameraY.screen << 8) | 0xC0;
					cameraX = (cameraX.screen << 8) | 0x80;
					vramTransfer.src = &hudBaseTilemap[0];
					vramTransfer.dest = &(vram()[VRAMDest.statusBar]);
					vramTransfer.size = 0x14;
					beginGraphicsTransfer();
					loadSpawnFlagsRequest = 0;
					break;
				case DoorCommand.damage:
					script++;
					acidDamageValue = script[0];
					saveBuf.acidDamageValue = script[0];
					script++;
					spikeDamageValue = script[0];
					saveBuf.spikeDamageValue = script[0];
					script++;
					break;
				case DoorCommand.exitQueen:
					script++;
					queenRoomFlag = 0;
					WY = 0x88;
					WX = 7;
					IE &= ~(1 << 1);
					vramTransfer.src = &hudBaseTilemap[0];
					vramTransfer.dest = &(vram()[VRAMDest.statusBar]);
					vramTransfer.size = 0x14;
					beginGraphicsTransfer();
					break;
				case DoorCommand.enterQueen:
					samusOnScreenYPos = 0;
					samusOnScreenXPos = 0;
					oamBufferIndex = 0;
					soundPlayQueenRoar = 0;
					songRequest = Song.metroidQueenBattle;
					clearAllOAM();
					waitOneFrame();
					oamDMA();
					doorQueen(script);
					doorExitStatus = 1;
					queenRoomFlag = 0x11;
					IE |= 1 << 1;
					break;
				case DoorCommand.ifMetLess:
					script++;
					if ((script++)[0] < metroidCountReal) {
						script += 2;
					} else {
						doorIndex = *cast(const(ushort)*)script;
						script += 2; // doesn't actually matter since we're loading a new script
						return executeDoorScript();
					}
					break;
				case DoorCommand.fadeout:
					static immutable ubyte[] fadePaletteTable = [0xFF, 0xFB, 0xE7];
					script++;
					waitOneFrame();
					waitOneFrame();
					waitOneFrame();
					waitOneFrame();
					countdownTimer = 47;
					while (countdownTimer >= 14) {
						bgPalette = fadePaletteTable[(countdownTimer & 0xF0) >> 4];
						obPalette0 = fadePaletteTable[(countdownTimer & 0xF0) >> 4];
						waitOneFrame();
					}
					countdownTimer = 0;
					break;
				case DoorCommand.song:
					if (songInterruptionPlaying != Song2.earthquake) {
						if ((script[0] & 0xF) != 0xA) {
							songRequest = cast(Song)script[0];
							currentRoomSong = cast(Song)script[0];
							script++;
							if (currentRoomSong == Song.metroidQueenHallway) {
								soundPlayQueenRoar = 0xFF;
								songRequestAfterEarthquake = Song.nothing;
							} else {
								songRequestAfterEarthquake = Song.nothing;
								soundPlayQueenRoar = 0;
							}
						} else {
							songRequest = Song.invalid;
							currentRoomSong = Song.invalid;
							songRequestAfterEarthquake = Song.nothing;
							soundPlayQueenRoar = 0xFF;
						}
					} else {
						if ((script[0] & 0xF) != 0xA) {
							songRequestAfterEarthquake = cast(Song)script[0];
							if (songRequestAfterEarthquake == Song.metroidQueenHallway) {
								soundPlayQueenRoar = 0xFF;
							} else {
								soundPlayQueenRoar = 0;
							}
						} else {
							songRequestAfterEarthquake = Song.invalid;
							soundPlayQueenRoar = 0xFF;
						}
					}
					break;
				case DoorCommand.item:
					const itemID = (script[0] - 1) & 0xF;
					vramTransfer.src = &graphicsItems[itemID][0];
					vramTransfer.dest = &(vram()[VRAMDest.item]);
					vramTransfer.size = 0x40;
					beginGraphicsTransfer();
					vramTransfer.src = &graphicsItems[11][0];
					vramTransfer.dest = &(vram()[VRAMDest.itemOrb]);
					vramTransfer.size = 0x40;
					beginGraphicsTransfer();
					vramTransfer.src = &graphicsItemFont[0];
					vramTransfer.dest = &(vram()[VRAMDest.itemFont]);
					vramTransfer.size = 0x230;
					beginGraphicsTransfer();

					vramTransfer.src = &itemTextPointerTable[script[0] & 0xF][0];
					script++;
					vramTransfer.dest = &(vram()[VRAMDest.itemText]);
					vramTransfer.size = 0x10;
					beginGraphicsTransfer();
					break;
				default: assert(0);
			}
			waitOneFrame();
		}
	}
	saveLoadSpawnFlagsRequest = doorExitStatus;
	doorIndex = 0;
	doorExitStatus = 0;
	wramUnknownD0A8 = 0;
}

void doorLoadGraphics(ref const(ubyte)* script) {
	if (((script++)[0] & 0xF) != 1) {
		const gfxID = script++[0];
		vramTransfer.src = enGfx(gfxID);
		saveBuf.enGfxID = gfxID;
		vramTransfer.dest = &(vram()[VRAMDest.enemies]);
		vramTransfer.size = 0x400;
		beginGraphicsTransfer();
	} else {
		const gfxID = script++[0];
		vramTransfer.src = bgGfx(gfxID);
		saveBuf.bgGfxID = gfxID;
		vramTransfer.dest = &(vram()[VRAMDest.bgTiles]);
		vramTransfer.size = 0x800;
		beginGraphicsTransfer();
	}
}

void doorCopyData(ref const(ubyte)* script) {
	switch ((script++)[0] & 0xF) {
		case DoorCommand.copyBG & 0xF:
		case DoorCommand.copySpr & 0xF:
			vramTransfer.src = specialData(script++[0]);
			vramTransfer.dest = &(vram()[*cast(const(ushort)*)(script)]);
			script += 2;
			vramTransfer.size = *cast(const(ushort)*)(script);
			script += 2;
			beginGraphicsTransfer();
			break;
		default: return loadGraphics(*cast(const(GraphicsInfo)*)script);
	}
}

void loadGraphics(const GraphicsInfo gfx) {
	vramTransfer.src = &gfx.data[0];
	vramTransfer.dest = &(vram()[gfx.destination]);
	vramTransfer.size = gfx.length;
	beginGraphicsTransfer();
}

void convertCameraToScroll() {
	scrollY = cast(ubyte)(cameraY.pixel - 0x48);
	scrollX = cast(ubyte)(cameraX.pixel - 0x50);
	earthquakeAdjustScroll();
}

void beginGraphicsTransfer() {
	vramTransferFlag = 0xFF;
	while (vramTransferFlag) {
		if (variaAnimationFlag) {
			drawSamus();
			handleEnemiesOrQueen();
			drawHUDMetroid();
			clearUnusedOAMSlots();
		}
		waitOneFrame();
	}
}

void animateGettingVaria(const GraphicsInfo gfx) {
	vramTransfer.src = &gfx.data[0];
	vramTransfer.dest = &(vram()[gfx.destination]);
	vramTransfer.size = gfx.length;
	vramTransferFlag = 0xFF;
	variaTransferDone = false;
	while (!variaTransferDone) {
		WY = 0x80;
		drawSamus();
		handleEnemiesOrQueen();
		drawHUDMetroid();
		clearUnusedOAMSlots();
		waitOneFrame();
	}
	variaAnimationFlag = 0;
}

void doorLoadTileTable(ref const(ubyte)* script) {
	const tiles = (script++)[0] & 0xF;
	saveBuf.tiletableID = tiles;
	tileTableArray[0 .. metatileTable[tiles].length] = metatileTable[tiles][];
	doorWarpRerender();
}
void doorLoadCollision(ref const(ubyte)* script) {
	const col = (script++)[0] & 0xF;
	saveBuf.collisionID = col;
	collisionArray[] = collisionTable[col][];
}
void doorQueen(ref const(ubyte)* script) {
	assert(0); // TODO
}
void doorWarp(ref const(ubyte)* script) {
	currentLevelBank = (script++)[0] & 0xF;
	saveBuf.currentLevelBank = currentLevelBank;
	cameraY = cameraY & 0xFF | ((script[0] & 0xF0) << 4);
	samusY = samusY & 0xFF | ((script[0] & 0xF0) << 4);
	cameraX = cameraX & 0xFF | ((script[0] & 0xF) << 8);
	samusX = samusX & 0xFF | ((script[0] & 0xF) << 8);
	script++;
	waitOneFrame();
	doorWarpRerender();
}
void doorWarpRerender() {
	if (doorScrollDirection == DoorDirection.right) {
		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX = (cameraX + 0x50) & 0xFFF;
		mapSourceXPixel = tmpX.pixel;
		mapSourceXScreen = tmpX.screen;
		const tmpY = (cameraY - 0x74) & 0xFFF;
		mapSourceYPixel = tmpY.pixel;
		mapSourceYScreen = tmpY.screen;
		prepMapUpdateColumn();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX2 = (cameraX + 0x60) & 0xFFF;
		mapSourceXPixel = tmpX2.pixel;
		mapSourceXScreen = tmpX2.screen;
		prepMapUpdateColumn();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX3 = (cameraX + 0x70) & 0xFFF;
		mapSourceXPixel = tmpX3.pixel;
		mapSourceXScreen = tmpX3.screen;
		prepMapUpdateColumn();
	}
	if (doorScrollDirection == DoorDirection.left) {
		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX = (cameraX - 0x60) & 0xFFF;
		mapSourceXPixel = tmpX.pixel;
		mapSourceXScreen = tmpX.screen;
		const tmpY = (cameraY - 0x74) & 0xFFF;
		mapSourceYPixel = tmpY.pixel;
		mapSourceYScreen = tmpY.screen;
		prepMapUpdateColumn();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX2 = (cameraX - 0x70) & 0xFFF;
		mapSourceXPixel = tmpX2.pixel;
		mapSourceXScreen = tmpX2.screen;
		prepMapUpdateColumn();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX3 = (cameraX - 0x80) & 0xFFF;
		mapSourceXPixel = tmpX3.pixel;
		mapSourceXScreen = tmpX3.screen;
		prepMapUpdateColumn();
	}
	if (doorScrollDirection == DoorDirection.down) {
		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX = (cameraX - 0x80) & 0xFFF;
		mapSourceXPixel = tmpX.pixel;
		mapSourceXScreen = tmpX.screen;
		const tmpY = (cameraY + 0x78) & 0xFFF;
		mapSourceYPixel = tmpY.pixel;
		mapSourceYScreen = tmpY.screen;
		prepMapUpdateRow();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpY2 = (cameraY + 0x68) & 0xFFF;
		mapSourceYPixel = tmpY2.pixel;
		mapSourceYScreen = tmpY2.screen;
		prepMapUpdateRow();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpY3 = (cameraY + 0x58) & 0xFFF;
		mapSourceYPixel = tmpY3.pixel;
		mapSourceYScreen = tmpY3.screen;
		prepMapUpdateRow();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpY4 = (cameraY + 0x48) & 0xFFF;
		mapSourceYPixel = tmpY4.pixel;
		mapSourceYScreen = tmpY4.screen;
		prepMapUpdateRow();
	}
	if (doorScrollDirection == DoorDirection.up) {
		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpX = (cameraX - 0x80) & 0xFFF;
		mapSourceXPixel = tmpX.pixel;
		mapSourceXScreen = tmpX.screen;
		const tmpY = (cameraY - 0x78) & 0xFFF;
		mapSourceYPixel = tmpY.pixel;
		mapSourceYScreen = tmpY.screen;
		prepMapUpdateRow();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpY2 = (cameraY - 0x68) & 0xFFF;
		mapSourceYPixel = tmpY2.pixel;
		mapSourceYScreen = tmpY2.screen;
		prepMapUpdateRow();
		waitOneFrame();

		switchMapBank(currentLevelBank);
		mapUpdate.buffer = &mapUpdateBuffer[0];
		mapUpdateUnusedVar = 0xFF;
		const tmpY3 = (cameraY - 0x58) & 0xFFF;
		mapSourceYPixel = tmpY3.pixel;
		mapSourceYScreen = tmpY3.screen;
		prepMapUpdateRow();
	}
}

void vblankUpdateMapDuringTransition() {
	if (!mapUpdateBuffer[0].dest != 0) {
		vblankDoneFlag = 1;
		return;
	}
	vblankUpdateMap();
	vblankDoneFlag = 1;
}

void vblankVRAMDataTransfer() {
	if (variaAnimationFlag) {
		vblankVariaAnimation();
		return;
	}
	auto size = vramTransfer.size;
	auto dest = vramTransfer.dest;
	auto src = vramTransfer.src;
	assert(dest);
	assert(src);
	dest[0 .. size] = src[0 .. size];
	vramTransfer.size = 0;
	vramTransfer.src = null;
	vramTransfer.dest = null;
	vramTransferFlag = 0;
	vblankDoneFlag = 1;
}
void vblankVariaAnimation() {
	assert(0); // TODO
}

void waitOneFrame() {
	handleAudio();
	waitNextFrameExternal();
	frameCounter++;
	vblankDoneFlag = 0;
	unusedFlag1 = 0xC0;
	oamBufferIndex = 0;
}
void tryPausing() {
	if (!(inputRisingEdge & Pad.start) || (queenRoomFlag == 0x11) || (samusPose == SamusPose.facingScreen) || doorScrollDirection || saveContactFlag) {
		return;
	}
	metroidLCounterDisp = metroidLCounterTable[metroidCountReal];
	if (nextEarthquakeTimer || earthquakeTimer) {
		metroidLCounterDisp = 0;
	}
	if (debugFlag) {
		oamBufferIndex = 0;
		clearUnusedOAMSlots();
	}
	debugItemIndex = 0;
	unusedD011 = 0;
	auto hl = &oamBuffer[0];
	while (hl < &oamBuffer.ptr[40]) {
		if ((hl.tile >= 0x9A) && (hl.tile <= 0x9B)) {
			hl.tile = 0x36;
			hl++;
			hl.tile = 0x0F;
			break;
		}
		hl++;
	}
	audioPauseControl = 1;
	gameMode = GameMode.paused;
}
void handlePaused() {
	const b = (frameCounter & (1 << 4)) ? 147 : 231;
	bgPalette = b;
	obPalette0 = b;
	debug (saveAnywhere) {
		if (inputRisingEdge & Pad.b) {
			handleSaveGame();
			gameMode = GameMode.paused;
		}
	}
	if (debugFlag) {
		drawHUDMetroid();
		if (!(inputRisingEdge & Pad.start)) {
			if (inputRisingEdge & Pad.right) {
				if (!(inputPressed & Pad.b)) {
					debugItemIndex = (debugItemIndex - 1) & 7;
				} else if (inputPressed & Pad.a) {
					metroidCountReal--;
					metroidCountDisplayed--;
				} else if (samusEnergyTanks) {
					samusEnergyTanks = cast(ubyte)(samusEnergyTanks - 1);
					samusCurHealth = (samusEnergyTanks << 8) | 99;
				}
			}
			if (inputRisingEdge & Pad.left) {
				if (!(inputPressed & Pad.b)) {
					debugItemIndex = (debugItemIndex - 1) & 7;
				} else if (inputPressed & Pad.a) {
					metroidCountReal++;
					metroidCountDisplayed++;
				} else if (samusEnergyTanks != 5) {
					samusEnergyTanks++;
					samusCurHealth = (samusEnergyTanks << 8) | 99;
				}
			}
			if (inputRisingEdge & Pad.a) {
				samusItems ^= (1 << debugItemIndex);
			}
			if (inputRisingEdge & Pad.up) {
				if (!(inputPressed & Pad.b)) {
					samusActiveWeapon++;
					samusBeam = samusActiveWeapon;
				} else {
					samusMaxMissiles += 10;
					samusCurMissiles = samusMaxMissiles;
				}
			}
			if (inputRisingEdge & Pad.down) {
				if (!(inputPressed & Pad.b)) {
					samusActiveWeapon--;
					samusBeam = samusActiveWeapon;
				} else {
					samusMaxMissiles -= 10;
					samusCurMissiles = samusMaxMissiles;
				}
			}
			spriteYPixel = 0x58;
			spriteXPixel = cast(ubyte)((debugItemIndex << 3) + 0x69);
			// TODO debugDrawNumberOneDigit(debugItemIndex);
			spriteYPixel = 0x54;
			spriteID = 0x36;
			spriteXPixel = 0x34;
			if (samusItems & ItemFlag.unused) {
				drawSamusSprite();
			}
			spriteXPixel = 0x3C;
			if (samusItems & ItemFlag.variaSuit) {
				drawSamusSprite();
			}
			spriteXPixel = 0x44;
			if (samusItems & ItemFlag.spiderBall) {
				drawSamusSprite();
			}
			spriteXPixel = 0x4C;
			if (samusItems & ItemFlag.springBall) {
				drawSamusSprite();
			}
			spriteXPixel = 0x54;
			if (samusItems & ItemFlag.spaceJump) {
				drawSamusSprite();
			}
			spriteXPixel = 0x5C;
			if (samusItems & ItemFlag.screwAttack) {
				drawSamusSprite();
			}
			spriteXPixel = 0x64;
			if (samusItems & ItemFlag.hiJump) {
				drawSamusSprite();
			}
			spriteXPixel = 0x6C;
			if (samusItems & ItemFlag.bomb) {
				drawSamusSprite();
			}
			spriteYPixel = 0x68;
			spriteXPixel = 0x50;
			// TODO debugDrawNumberTwoDigit(samusActiveWeapon);
			maxOAMPrevFrame = oamBufferIndex;
			if (inputRisingEdge & Pad.select) {
				return;
			}
			if (inputPressed & Pad.select) {
				return;
			}
			if ((samusPose == SamusPose.standing) || (samusPose == SamusPose.morphBall)) {
				gameMode = GameMode.saveGame;
			}
			return;
		}
		bgPalette = 147;
		obPalette1 = 147;
		clearUnusedOAMSlots();
		audioPauseControl = 2;
		gameMode = GameMode.main;
	}
	if (!(inputRisingEdge & Pad.start)) {
		return;
	}
	bgPalette = 147;
	obPalette0 = 147;
	audioPauseControl = 2;
	gameMode = GameMode.main;
}

void hurtSamus() {
	if (samusHurtFlag != 1) {
		return;
	}
	samusHurtFlag = 0;
	if (samusInvulnerableTimer) {
		return;
	}
	applyDamageEnemySpike(samusDamageValue);
	samusInvulnerableTimer = 51;
	samusPose = samusDamagePoseTransitionTable[samusPose];
	samusAirDirection = samusDamageBoostDirection;
	if (queenRoomFlag == 0x11) {
		samusAirDirection = 1;
	}
	samusJumpArcCounter = samusJumpArrayBaseOffset;
	samusUnmorphJumpTimer = 0;
}

void applyDamageQueenStomach() {
	if (frameCounter & 0x7) { // every 8 frames
		return;
	}
	sfxRequestNoise = NoiseSFX.u07;
	if (frameCounter & 0xF) { // every 16 frames
		return;
	}
	applyDamage(2);
}
void applyDamageLarvaMetroid() {
	if (frameCounter & 0x7) { // every 8 frames
		return;
	}
	sfxRequestNoise = NoiseSFX.u07;
	applyDamage(3);
}
void applyDamageAcid(ubyte amount) {
	if (frameCounter & 0xF) { // every 16 frames
		return;
	}
	sfxRequestNoise = NoiseSFX.u07;
	applyDamage(amount);
}
void applyDamageEnemySpike(ubyte amount) {
	if (amount > 60) {
		return;
	}
	sfxRequestNoise = NoiseSFX.u06;
	applyDamage(amount);
}
void applyDamage(ubyte amount) {
	if (samusItems & ItemFlag.variaSuit) {
		amount /= 2;
	}
	samusCurHealth -= amount;
	if (samusCurHealth >= 0xFF00) {
		samusCurHealth = 0;
	}
}

void handleDying() {
	if (queenRoomFlag == 0x11) {
		drawSamus();
		drawHUDMetroid();
		queenHandler();
		clearUnusedOAMSlots();
	}
}

void killSamus() {
	silenceAudio();
	sfxRequestNoise = NoiseSFX.u0B;
	waitOneFrame();
	drawSamusIgnoreDamageFrames();
	deathAnimTimer = 0x20;
	deathAltAnimBase = &(vram()[VRAMDest.samus]);
	deathFlag = 1;
	gameMode = GameMode.dying;
}

void prepUnusedDeathAnimation() {
	samusTurnAnimTimer = 160;
	samusPose = cast(SamusPose)(SamusPose.standing | 0x80);
	deathAnimTimer = 32;
	deathAltAnimBase = &(vram()[VRAMDest.samus]);
}

void vblankDeathSequence() {
	if (!deathFlag) {
		unusedDeathAnimation();
		return;
	}
	if (!(frameCounter & 3)) { // every 4 frames
		auto hl = &(vram()[VRAMDest.samus + deathAnimationTable[deathAnimTimer - 1]]);
		while (hl < &(vram()[0x8800])) {
			*hl = 0;
			hl += 0x20;
		}
		if (--deathAnimTimer == 0) {
			deathFlag = 0xFF;
			gameMode = GameMode.dead;
		}
	}
	SCY = scrollY;
	SCX = scrollX;
	oamDMA();
	if (queenRoomFlag == 0x11) {
		vblankDrawQueen();
	}
	vblankDoneFlag = 1;
}

immutable ubyte[] deathAnimationTable = [
	0x00, 0x04, 0x08, 0x0C, 0x10, 0x14, 0x18, 0x1C, 0x01, 0x05, 0x09, 0x0D, 0x11, 0x15, 0x19, 0x1D,
	0x02, 0x06, 0x0A, 0x0E, 0x12, 0x16, 0x1A, 0x1E, 0x03, 0x07, 0x0B, 0x0F, 0x13, 0x17, 0x1B, 0x1F,
];

void unusedDeathAnimation() {
	assert(0); // TODO
}

void collisionBombEnemies() {
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if ((enemyDataSlots[i].status & 0xF) == 0) {
			if (collisionBombOneEnemy(&enemyDataSlots[i])) {
				break;
			}
		}
	}
}
bool collisionBombOneEnemy(EnemySlot* enemy) {
	if (enemy.y >= 224) {
		return false;
	}
	collisionEnY = enemy.y;
	if (enemy.x >= 224) {
		return false;
	}
	collisionEnX = enemy.x;
	collisionEnSprite = enemy.spriteType;
	collisionEnAttr = enemy.spriteAttributes;
	const(Rectangle)* hitbox = enemyHitboxes[collisionEnSprite];
	if (!(collisionEnAttr & OAMFlags.yFlip)) {
		collisionEnTop = cast(ubyte)(enemy.y + hitbox.top - 16);
		collisionEnBottom = cast(ubyte)(enemy.y + hitbox.bottom + 16);
	} else {
		collisionEnTop = cast(ubyte)(-(enemy.y - hitbox.top) + 15);
		collisionEnBottom = cast(ubyte)(-(enemy.y - hitbox.bottom) - 15);
	}
	if (!(collisionEnAttr & OAMFlags.xFlip)) {
		collisionEnLeft = cast(ubyte)(enemy.x + hitbox.left - 16);
		collisionEnRight = cast(ubyte)(enemy.x + hitbox.right + 16);
	} else {
		collisionEnLeft = cast(ubyte)(-(enemy.x - hitbox.left) + 15);
		collisionEnRight = cast(ubyte)(-(enemy.x - hitbox.right) - 15);
	}
	if (cast(ubyte)(spriteYPixel - collisionEnTop) > cast(ubyte)(collisionEnBottom - collisionEnTop)) {
		return false;
	}
	if (cast(ubyte)(spriteXPixel - collisionEnLeft) > cast(ubyte)(collisionEnRight - collisionEnLeft)) {
		return false;
	}
	collision.weaponType = CollisionType.bombExplosion;
	collision.enemy = enemy;
	if (queenEatingState == 3) {
		if (collisionEnSprite == Actor.queenHeadLeft) {
			queenEatingState = 4;
		}
	}
	if (queenEatingState == 6) {
		if (collisionEnSprite == Actor.queenBody){
			queenEatingState = 7;
			samusPose = SamusPose.escapingMetroidQueen;
		}
	}
	return true;
}
bool collisionProjectileEnemies() {
	const y = cast(ubyte)(tileY - scrollY);
	const x = cast(ubyte)(tileX - scrollX);
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if (((enemyDataSlots[i].status & 0xF) == 0) && collisionProjectileOneEnemy(&enemyDataSlots[i], x, y)) {
			return true;
		}
	}
	return false;
}
bool collisionProjectileOneEnemy(EnemySlot* enemy, ubyte x, ubyte y) {
	if (enemy.y >= 224) {
		return false;
	}
	collisionEnY = enemy.y;
	if (enemy.x >= 224) {
		return false;
	}
	collisionEnX = enemy.x;
	collisionEnSprite = enemy.spriteType;
	collisionEnAttr = enemy.baseSpriteAttributes;
	if (enemyDamageTable[collisionEnSprite] == 0) {
		return false;
	}
	const(Rectangle)* hitbox = enemyHitboxes[collisionEnSprite];
	if (!(collisionEnAttr & OAMFlags.yFlip)) {
		collisionEnTop = cast(ubyte)(hitbox.top + collisionEnY);
		collisionEnBottom = cast(ubyte)(hitbox.bottom + collisionEnY);
	} else {
		collisionEnBottom = cast(ubyte)(-(hitbox.top - collisionEnY - 1));
		collisionEnTop = cast(ubyte)(-(hitbox.bottom - collisionEnY - 1));
	}
	if (!(collisionEnAttr & OAMFlags.xFlip)) {
		collisionEnLeft = cast(ubyte)(hitbox.left + collisionEnX);
		collisionEnRight = cast(ubyte)(hitbox.right + collisionEnX);
	} else {
		collisionEnRight = cast(ubyte)(-(hitbox.left - collisionEnX - 1));
		collisionEnLeft = cast(ubyte)(-(hitbox.right - collisionEnX - 1));
	}
	if (cast(ubyte)(y - collisionEnTop) > cast(ubyte)(collisionEnBottom - collisionEnTop)) {
		return false;
	}
	if (cast(ubyte)(x - collisionEnLeft) > cast(ubyte)(collisionEnRight - collisionEnLeft)) {
		return false;
	}
	collision.weaponType = weaponType;
	collision.enemy = enemy;
	collision.weaponDir = weaponDirection;
	if ((weaponType == CollisionType.missiles) && (collisionEnSprite == Actor.queenMouthOpen)) {
		queenEatingState = 16;
	}
	return true;
}
bool collisionSamusEnemiesStandard() {
	if ((samusPose >= SamusPose.eatenByMetroidQueen) || deathFlag || samusInvulnerableTimer || samusSpriteCollisionProcessedFlag) {
		return false;
	}
	return collisionSamusEnemies(samusOnScreenXPos);
}
bool collisionSamusEnemiesHorizontal() {
	if ((samusPose >= SamusPose.eatenByMetroidQueen) || deathFlag || deathAnimTimer || samusInvulnerableTimer) {
		return false;
	}
	return collisionSamusEnemies(cast(ubyte)(tileX - cameraX.pixel + 0x50));
}
bool collisionSamusEnemies(ubyte x) {
	samusSpriteCollisionProcessedFlag = 0xFF;
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if (((enemyDataSlots[i].status & 0xF) == 0) && collisionSamusOneEnemy(&enemyDataSlots[i], x, cast(ubyte)(samusY.pixel - cameraY.pixel + 0x62))) {
			return true;
		}
	}
	return false;
}
bool collisionSamusOneEnemy(EnemySlot* enemy, ubyte samusX, ubyte samusY) {
	if (enemy.y > 224) {
		return false;
	}
	collisionEnY = enemy.y;
	if (enemy.x > 224) {
		return false;
	}
	collisionEnX = enemy.x;
	collisionEnSprite = enemy.spriteType;
	collisionEnAttr = enemy.baseSpriteAttributes;
	collisionEnIce = enemy.iceCounter;
	const(Rectangle)* hitbox = enemyHitboxes[collisionEnSprite];
	if (!(collisionEnAttr & OAMFlags.yFlip)) {
		collisionEnTop = cast(ubyte)(hitbox.top + collisionEnY - 17);
		collisionEnBottom = cast(ubyte)(hitbox.bottom + collisionEnY - 4);
	} else {
		collisionEnBottom = cast(ubyte)(-(hitbox.top - collisionEnY) - 4);
		collisionEnTop = cast(ubyte)(-(hitbox.bottom - collisionEnY) - 17);
	}
	if (!(collisionEnAttr & OAMFlags.xFlip)) {
		collisionEnLeft = cast(ubyte)(hitbox.left + collisionEnX - 5);
		collisionEnRight = cast(ubyte)(hitbox.right + collisionEnX + 5);
	} else {
		collisionEnRight = cast(ubyte)(-(hitbox.left - collisionEnX) + 5);
		collisionEnLeft = cast(ubyte)(-(hitbox.right - collisionEnX) - 5);
	}
	collisionEnBottom = cast(ubyte)(collisionEnBottom - collisionSamusSpriteHitboxTopTable[samusPose & 0x7F]);
	if (cast(ubyte)(samusY - collisionEnTop) > collisionEnBottom - collisionEnTop) {
		return false;
	}
	samusDamageBoostDirection = 1;
	if (cast(ubyte)(samusX - collisionEnLeft) >cast(ubyte)(collisionEnRight - collisionEnLeft)) {
		return false;
	}
	if (cast(ubyte)(samusX - collisionEnLeft) < cast(ubyte)((collisionEnRight - collisionEnLeft) / 2)) {
		samusDamageBoostDirection = 0xFF;
	}
	if ((samusItems & ItemFlag.screwAttack) && ((samusPose == SamusPose.spinJumping) || (samusPose == SamusPose.startingToSpinJump))) {
		if (!collisionEnIce && (enemyDamageTable[collisionEnSprite] != solidEnemy)) {
			samusDamageValue = enemyDamageTable[collisionEnSprite];
			collision.weaponType = CollisionType.screwAttack;
			collision.enemy = enemy;
			return false;
		}
	}
	if (collisionEnIce || (enemyDamageTable[collisionEnSprite] == solidEnemy)) {
		if (collisionEnSprite == Actor.queenMouthStunned) {
			if ((samusPose == SamusPose.morphBall) || (samusPose == SamusPose.morphBallJumping) || (samusPose == SamusPose.morphBallFalling)) {
				queenEatingState = 1;
				samusPose = SamusPose.eatenByMetroidQueen;
			}
		}
		return true;
	}
	if (enemyDamageTable[collisionEnSprite] == drainsHealth) {
		applyDamageLarvaMetroid();
		collision.enemy = enemy;
		collision.weaponType = CollisionType.contact;
		return false;
	}
	if (enemyDamageTable[collisionEnSprite] == 0) {
		collision.enemy = enemy;
		collision.weaponType = CollisionType.contact;
		return false;
	}
	samusDamageValue = enemyDamageTable[collisionEnSprite];
	samusHurtFlag = 1;
	collision.enemy = enemy;
	collision.weaponType = CollisionType.contact;
	return true;
}

bool collisionSamusEnemiesDown() {
	EnemySlot* _;
	return collisionSamusEnemiesDown(_);
}
bool collisionSamusEnemiesDown(out EnemySlot* enemy) {
	if ((samusPose >= SamusPose.eatenByMetroidQueen) || deathFlag || samusInvulnerableTimer) {
		return false;
	}
	const tempY = cast(ubyte)(samusOnScreenYPos + 18);
	samusOnSolidSprite = 0;
	const tempX = cast(ubyte)(samusX.pixel - cameraX.pixel + 96);
	for (int i = 0; i < enemyDataSlots.length; i++) {
		ubyte enemyTop;
		if (((enemyDataSlots[i].status & 0xF) == 0) && (collisionSamusOneEnemyVertical(&enemyDataSlots[i], tempX, tempY, enemyTop))) {
			if (samusDamageValue - 1 >= 0xFE) { //0 or 0xFF
				samusY = (samusY - enemyTop) & 0xFFF;
			}
			enemy = &enemyDataSlots[i];
			return true;
		}
	}
	return false;
}
bool collisionSamusEnemiesUp() {
	if ((samusPose >= SamusPose.eatenByMetroidQueen) || deathFlag || samusInvulnerableTimer) {
		return false;
	}
	const tempY = cast(ubyte)(collisionSamusSpriteHitboxTopTable[samusPose & 0x7F] + samusOnScreenYPos);
	samusOnSolidSprite = 0;
	const tempX = cast(ubyte)(samusX.pixel - cameraX.pixel + 96);
	ubyte unused;
	for (int i = 0; i < enemyDataSlots.length; i++) {
		if (((enemyDataSlots[i].status & 0xF) == 0) && (collisionSamusOneEnemyVertical(&enemyDataSlots[i], tempX, tempY, unused))) {
			return true;
		}
	}
	return false;
}
bool collisionSamusOneEnemyVertical(EnemySlot* enemy, ubyte samusX, ubyte samusY, out ubyte enemyTop) {
	if ((enemy.y >= 224) || (enemy.x >= 224)) { // offscreen
		return false;
	}
	collisionEnSprite = enemy.spriteType;
	collisionEnAttr = enemy.baseSpriteAttributes;
	collisionEnIce = enemy.iceCounter;
	const(Rectangle)* hitbox = enemyHitboxes[collisionEnSprite];
	if (!(collisionEnAttr & OAMFlags.yFlip)) {
		collisionEnTop = cast(ubyte)(hitbox.top + collisionEnY);
		collisionEnBottom = cast(ubyte)(hitbox.bottom + collisionEnY);
	} else {
		collisionEnBottom = cast(ubyte)-(hitbox.top - collisionEnY);
		collisionEnTop = cast(ubyte)-(hitbox.bottom - collisionEnY);
	}
	if (!(collisionEnAttr & OAMFlags.xFlip)) {
		collisionEnLeft = cast(ubyte)(hitbox.left + collisionEnX - 5);
		collisionEnRight = cast(ubyte)(hitbox.right + collisionEnX + 5);
	} else {
		collisionEnRight = cast(ubyte)(-(hitbox.left - collisionEnX) + 5);
		collisionEnLeft = cast(ubyte)(-(hitbox.right - collisionEnX) - 5);
	}
	enemyTop = cast(ubyte)(samusY - (collisionEnBottom - collisionEnTop));
	if (cast(ubyte)(samusY - collisionEnTop) >  collisionEnBottom - collisionEnTop) {
		return false;
	}
	samusDamageBoostDirection = 1;
	if (cast(ubyte)(samusX - collisionEnLeft) > collisionEnRight - collisionEnLeft) {
		return false;
	}
	if ((samusItems & ItemFlag.screwAttack) && ((samusPose == SamusPose.spinJumping) || (samusPose == SamusPose.startingToSpinJump))) {
		if (!collisionEnIce && (enemyDamageTable[collisionEnSprite] != solidEnemy)) {
			samusDamageValue = enemyDamageTable[collisionEnSprite];
			collision.weaponType = CollisionType.screwAttack;
			collision.enemy = enemy;
			return false;
		}
	}
	if (collisionEnIce || (collisionEnSprite == 0) || (enemyDamageTable[collisionEnSprite] == solidEnemy)) {
		if (collisionEnSprite == Actor.queenMouthStunned) {
			if ((samusPose == SamusPose.morphBall) || (samusPose == SamusPose.morphBallJumping) || (samusPose == SamusPose.morphBallFalling)) {
				queenEatingState = 1;
				samusPose = SamusPose.eatenByMetroidQueen;
			}
		}
		return true;
	}
	if (enemyDamageTable[collisionEnSprite] == drainsHealth) {
		applyDamageLarvaMetroid();
		collision.enemy = enemy;
		collision.weaponType = CollisionType.contact;
		return false;
	}
	if (enemyDamageTable[collisionEnSprite] == 0) {
		collision.enemy = enemy;
		collision.weaponType = CollisionType.contact;
		return false;
	}
	samusDamageValue = enemyDamageTable[collisionEnSprite];
	samusHurtFlag = 1;
	collision.enemy = enemy;
	collision.weaponType = CollisionType.contact;
	return false;
}
immutable ubyte[] collisionSamusSpriteHitboxTopTable = [
	SamusPose.standing: 0xEC,
	SamusPose.jumping: 0xF4,
	SamusPose.spinJumping: 0xFC,
	SamusPose.running: 0xEC,
	SamusPose.crouching: 0xF6,
	SamusPose.morphBall: 0x04,
	SamusPose.morphBallJumping: 0x04,
	SamusPose.falling: 0xEC,
	SamusPose.morphBallFalling: 0x04,
	SamusPose.startingToJump: 0xEC,
	SamusPose.startingToSpinJump: 0xEC,
	SamusPose.spiderBallRolling: 0x04,
	SamusPose.spiderBallFalling: 0x04,
	SamusPose.spiderBallJumping: 0x04,
	SamusPose.spiderBall: 0x04,
	SamusPose.knockBack: 0xEC,
	SamusPose.morphBallKnockBack: 0x04,
	SamusPose.standingBombed: 0xEC,
	SamusPose.morphBallBombed: 0x04,
	SamusPose.facingScreen: 0xEC,
	SamusPose.facingScreen2: 0x04,
];

void handleDead() {
	while (sfxPlayingNoise == 0xB) {
		handleAudio();
		waitNextFrame();
	}
	queenRoomFlag = 0;
	disableLCD();
	clearTilemaps();
	oamBufferIndex = 0;
	clearAllOAM();
	vram()[VRAMDest.titleTiles .. VRAMDest.titleTiles + 0xA00] = graphicsTitleScreen[];
	vram()[VRAMDest.titleTiles + 0xA00 .. VRAMDest.titleTiles + 0xD00] = graphicsCreditsFont[];
	vram()[VRAMDest.titleTiles + 0xD00 .. VRAMDest.titleTiles + 0xF00] = graphicsItemFont[];
	vram()[VRAMDest.titleTiles + 0xF00 .. VRAMDest.titleTiles + 0x1000] = graphicsCreditsNumbers[];
	auto text = &gameOverText[0];
	auto textDest = &(vram()[0x9800 + 8 * 32 + 6]);
	while (*text != 0x80) {
		*(textDest++) = *(text++);
	}
	scrollY = 0;
	scrollX = 0;
	SCY = 0;
	SCX = 0;
	gameOverLCDCCopy = 0xC3;
	LCDC = 0xC3;
	countdownTimer = 0xFF;
	gameMode = GameMode.gameOver;
}

immutable ubyte[] gameOverText = [0x56, 0x50, 0x5C, 0x54, 0xFF, 0x5E, 0x65, 0x54, 0x61, 0x80];

bool handleGameOver() {
	handleAudio();
	waitNextFrame();
	if ((countdownTimer != 0) && !(inputRisingEdge & Pad.start)) {
		return false;
	}
	return true;
}

void handleItemPickup() {
	if (!itemCollected) {
		return;
	}
	waitOneFrame();
	waitOneFrame();
	waitOneFrame();
	waitOneFrame();
	itemCollectedCopy = itemCollected;
	sfxRequestSquare1 = Square1SFX.u12;
	songInterruptionRequest = Song2.itemGet;
	countdownTimer = 352;
	if (itemCollected - 1 >= ItemID.energyRefill) {
		if (itemCollected - 1 < ItemID.missileRefill) {
			songInterruptionRequest = Song2.missilePickup;
			countdownTimer = 96;
		} else {
			songInterruptionRequest = Song2.nothing;
			countdownTimer = 0;
			sfxRequestSquare1 = Square1SFX.pickedUpSmallEnergyDrop;
			if (sfxRequestSquare1 != 0) { // ok.
				sfxRequestSquare1 = Square1SFX.pickedUpMissileDrop;
			}
		}
	}
	if (songInterruptionPlaying == Song2.earthquake) {
		songInterruptionRequest = Song2.nothing;
	}
	final switch (cast(ItemID)(itemCollected - 1)) {
		case ItemID.plasmaBeam:
			samusBeam = CollisionType.plasmaBeam;
			loadGraphics(graphicsInfoPlasma);
			if (samusActiveWeapon != CollisionType.missiles) {
				samusActiveWeapon = CollisionType.plasmaBeam;
				samusBeam = CollisionType.plasmaBeam;
			}
			break;
		case ItemID.iceBeam:
			samusBeam = CollisionType.iceBeam;
			loadGraphics(graphicsInfoIce);
			if (samusActiveWeapon != CollisionType.missiles) {
				samusActiveWeapon = CollisionType.iceBeam;
				samusBeam = CollisionType.iceBeam;
			}
			break;
		case ItemID.waveBeam:
			samusBeam = CollisionType.waveBeam;
			loadGraphics(graphicsInfoWave);
			if (samusActiveWeapon != CollisionType.missiles) {
				samusActiveWeapon = CollisionType.waveBeam;
				samusBeam = CollisionType.waveBeam;
			}
			break;
		case ItemID.spazer:
			samusBeam = CollisionType.spazer;
			loadGraphics(graphicsInfoSpazer);
			if (samusActiveWeapon != CollisionType.missiles) {
				samusActiveWeapon = CollisionType.spazer;
				samusBeam = CollisionType.spazer;
			}
			break;
		case ItemID.bombs:
			samusItems |= ItemFlag.bomb;
			break;
		case ItemID.screwAttack:
			samusItems |= ItemFlag.screwAttack;
			if (!(samusItems & ItemFlag.spaceJump)) {
				loadGraphics(graphicsInfoSpinScrewTop);
				loadGraphics(graphicsInfoSpinScrewBottom);
			} else {
				loadGraphics(graphicsInfoSpinSpaceTop);
				loadGraphics(graphicsInfoSpinSpaceBottom);
			}
			break;
		case ItemID.variaSuit:
			while (--countdownTimer) {
				drawSamus();
				handleEnemiesOrQueen();
				drawHUDMetroid();
				clearUnusedOAMSlots();
				WY = 0x80;
				waitOneFrame();
			}
			samusItems |= ItemFlag.variaSuit;
			samusPose = cast(SamusPose)(SamusPose.standing | 0x80);
			samusTurnAnimTimer = 0x10;
			waitOneFrame();
			sfxRequestSquare1 = Square1SFX.variaSuitTransformation;
			variaAnimationFlag = 0xFF;
			animateGettingVaria(graphicsInfoVariaSuit);
			variaAnimationFlag = 0;
			loadGraphics(graphicsInfoVariaSuit);
			if (samusActiveWeapon == CollisionType.missiles) {
				loadGraphics(graphicsInfoCannonMissile);
			}
			variaLoadExtraGraphics();
			break;
		case ItemID.hiJumpBoots:
			samusItems |= ItemFlag.hiJump;
			break;
		case ItemID.spaceJump:
			samusItems |= ItemFlag.spaceJump;
			if (!(samusItems & ItemFlag.screwAttack)) {
				loadGraphics(graphicsInfoSpinSpaceTop);
				loadGraphics(graphicsInfoSpinSpaceBottom);
			} else {
				loadGraphics(graphicsInfoSpinSpaceTop);
				loadGraphics(graphicsInfoSpinSpaceBottom);
			}
			break;
		case ItemID.spiderBall:
			samusItems |= ItemFlag.spiderBall;
			break;
		case ItemID.springBall:
			samusItems |= ItemFlag.springBall;
			loadGraphics(graphicsInfoSpringBallTop);
			loadGraphics(graphicsInfoSpringBallBottom);
			break;
		case ItemID.energyTank:
			if (samusEnergyTanks != 5) {
				samusEnergyTanks++;
			}
			samusCurHealth = cast(ushort)(((samusEnergyTanks + 1) * 100) - 1);
			break;
		case ItemID.missileTank:
			samusMaxMissiles += 10;
			if (samusMaxMissiles >= 1000) {
				samusMaxMissiles = 999;
			}
			samusCurMissiles += 10;
			if (samusCurMissiles >= 1000) {
				samusCurMissiles = 999;
			}
			break;
		case ItemID.energyRefill:
			samusCurHealth = cast(ushort)(((samusEnergyTanks + 1) * 100) - 1);
			break;
		case ItemID.missileRefill:
			if (metroidCountReal == 0) {
				countdownTimer = 0xFF;
				songInterruptionRequest = Song2.fadeOut;
				gameMode = GameMode.prepareCredits;
				return;
			} else {
				samusCurMissiles = samusMaxMissiles;
			}
			break;
	}
	while (countdownTimer > 0) {
		drawSamus();
		drawHUDMetroid();
		enemyHandler();
		handleAudio();
		clearUnusedOAMSlots();
		if (itemCollectedCopy < ItemID.energyTank) {
			WY = 0x80;
		}
		waitNextFrame();
	}
	if ((itemCollectedCopy - 1 < ItemID.energyRefill) && (songInterruptionPlaying != Song2.earthquake)) {
		songInterruptionRequest = Song2.endRequest;
	}
	itemCollectedCopy = 0;
	itemCollectionFlag = 3;
	enSprCollision.weaponType = itemOrbCollisionType;
	enSprCollision.enemy = itemOrbEnemyWRAM;
	while (itemCollectionFlag) {
		drawSamus();
		drawHUDMetroid();
		collisionSamusEnemiesStandard();
		enemyHandler();
		handleAudio();
		clearUnusedOAMSlots();
		waitNextFrame();
	}
}

GraphicsInfo graphicsInfoPlasma() {
	return GraphicsInfo(graphicsBeamSpazerPlasma, VRAMDest.beam, 0x20);
}
alias graphicsInfoSpazer = graphicsInfoPlasma;

GraphicsInfo graphicsInfoIce() {
	return GraphicsInfo(graphicsBeamIce, VRAMDest.beam, 0x20);
}

GraphicsInfo graphicsInfoWave() {
	return GraphicsInfo(graphicsBeamWave, VRAMDest.beam, 0x20);
}

GraphicsInfo graphicsInfoVariaSuit() {
	return GraphicsInfo(graphicsSamusVariaSuit, VRAMDest.samus, 0x07B0);
}

GraphicsInfo graphicsInfoSpinSpaceTop() {
	return GraphicsInfo(graphicsSpinSpaceTop, VRAMDest.spinTop, 0x0070);
}
GraphicsInfo graphicsInfoSpinSpaceBottom() {
	return GraphicsInfo(graphicsSpinSpaceBottom, VRAMDest.spinBottom, 0x0050);
}

GraphicsInfo graphicsInfoSpinScrewTop() {
	return GraphicsInfo(graphicsSpinScrewTop, VRAMDest.spinTop, 0x0070);
}
GraphicsInfo graphicsInfoSpinScrewBottom() {
	return GraphicsInfo(graphicsSpinScrewBottom, VRAMDest.spinBottom, 0x0050);
}

GraphicsInfo graphicsInfoSpinSpaceScrewTop() {
	return GraphicsInfo(graphicsSpinSpaceScrewTop, VRAMDest.spinTop, 0x0070);
}
GraphicsInfo graphicsInfoSpinSpaceScrewBottom() {
	return GraphicsInfo(graphicsSpinSpaceScrewBottom, VRAMDest.spinBottom, 0x0050);
}

GraphicsInfo graphicsInfoSpringBallTop() {
	return GraphicsInfo(graphicsSpringBallTop, VRAMDest.ballTop, 0x0020);
}
GraphicsInfo graphicsInfoSpringBallBottom() {
	return GraphicsInfo(graphicsSpringBallBottom, VRAMDest.ballBottom, 0x0020);
}

void variaLoadExtraGraphics() {
	assert(0); // TODO
}
void handleUnusedA() {
	silenceAudio();
	sfxRequestLowHealthBeep = 0xFF;
	disableLCD();
	clearTilemaps();
	oamBufferIndex = 0;
	clearAllOAM();
	version(original) {
		vram()[0x8000 .. 0x9800] = graphicsTitleScreen[];
	} else {
		vram()[VRAMDest.titleTiles .. VRAMDest.titleTiles + 0xA00] = graphicsTitleScreen[];
		vram()[VRAMDest.titleTiles + 0xA00 .. VRAMDest.titleTiles + 0xD00] = graphicsCreditsFont[];
		vram()[VRAMDest.titleTiles + 0xD00 .. VRAMDest.titleTiles + 0xF00] = graphicsItemFont[];
		vram()[VRAMDest.titleTiles + 0xF00 .. VRAMDest.titleTiles + 0x1000] = graphicsCreditsNumbers[];
	}
	auto text = &gameSavedText[0];
	auto textDest = &(vram()[0x9800 + 8 * 32 + 5]);
	while (*text != 0x80) {
		*(textDest++) = *(text++);
	}
	scrollY = 0;
	scrollX = 0;
	LCDC = 0xC3;
	countdownTimer = 416;
	gameMode = GameMode.unusedB;
}
immutable ubyte[] gameSavedText = [0x56, 0x50, 0x5C, 0x54, 0xFF, 0x62, 0x50, 0x65, 0x54, 0x53, 0x80];

bool handleUnusedB() {
	handleAudio();
	waitNextFrame();
	if ((countdownTimer != 0) && (inputRisingEdge & Pad.start)) {
		return false;
	}
	return true;
}

void handleUnusedC() {
	silenceAudio();
	sfxRequestLowHealthBeep = 0xFF;
	disableLCD();
	clearTilemaps();
	oamBufferIndex = 0;
	clearAllOAM();
	vram()[VRAMDest.titleTiles .. VRAMDest.titleTiles + 0xA00] = graphicsTitleScreen[];
	vram()[VRAMDest.titleTiles + 0xA00 .. VRAMDest.titleTiles + 0xD00] = graphicsCreditsFont[];
	vram()[VRAMDest.titleTiles + 0xD00 .. VRAMDest.titleTiles + 0xF00] = graphicsItemFont[];
	vram()[VRAMDest.titleTiles + 0xF00 .. VRAMDest.titleTiles + 0x1000] = graphicsCreditsNumbers[];
	auto text = &gameClearedText[0];
	auto textDest = &(vram()[0x9800 + 8 * 32 + 4]);
	while (*text != 0x80) {
		*(textDest++) = *(text++);
	}
	scrollY = 0;
	scrollX = 0;
	LCDC = 0xC3;
	countdownTimer = 255;
	gameMode = GameMode.unusedD;
}
immutable ubyte[] gameClearedText = [0x56, 0x50, 0x5C, 0x54, 0xFF, 0x52, 0x5B, 0x54, 0x50, 0x61, 0x54, 0x53, 0x80];

void handleUnusedD() {
	waitNextFrame();
	if ((countdownTimer != 0) && (inputRisingEdge & Pad.start)) {
		return;
	}
	gameMode = GameMode.boot;
}

void loadGameSamusItemGraphics() {
	if (samusItems & ItemFlag.variaSuit) {
		loadGameCopyItemToVRAM(graphicsInfoVariaSuit);
	}
	if (samusItems & ItemFlag.springBall) {
		loadGameCopyItemToVRAM(graphicsInfoSpringBallTop);
		loadGameCopyItemToVRAM(graphicsInfoSpringBallBottom);
	}
	if ((samusItems & (ItemFlag.spaceJump | ItemFlag.screwAttack)) == (ItemFlag.spaceJump | ItemFlag.screwAttack)) {
		loadGameCopyItemToVRAM(graphicsInfoSpinSpaceScrewTop);
		loadGameCopyItemToVRAM(graphicsInfoSpinSpaceScrewBottom);
	} else if (samusItems & (ItemFlag.spaceJump | ItemFlag.screwAttack) == ItemFlag.spaceJump) {
		loadGameCopyItemToVRAM(graphicsInfoSpinSpaceTop);
		loadGameCopyItemToVRAM(graphicsInfoSpinSpaceBottom);
	} else if (samusItems & (ItemFlag.spaceJump | ItemFlag.screwAttack) == ItemFlag.screwAttack) {
		loadGameCopyItemToVRAM(graphicsInfoSpinScrewTop);
		loadGameCopyItemToVRAM(graphicsInfoSpinScrewBottom);
	}
	switch (samusActiveWeapon) {
		case CollisionType.iceBeam:
			loadGameCopyItemToVRAM(graphicsInfoIce);
			break;
		case CollisionType.spazer:
			loadGameCopyItemToVRAM(graphicsInfoSpazer);
			break;
		case CollisionType.waveBeam:
			loadGameCopyItemToVRAM(graphicsInfoWave);
			break;
		case CollisionType.plasmaBeam:
			loadGameCopyItemToVRAM(graphicsInfoPlasma);
			break;
		default: break;
	}
}

void loadGameCopyItemToVRAM(const GraphicsInfo gfx) {
	copyToVRAM(&gfx.data[0], &(vram()[gfx.destination]), gfx.length);
}

void unusedDecreasingVRAMTransfer(const GraphicsInfo gfx) {
	copyToVRAM(&gfx.data[0], &(vram()[gfx.destination]), gfx.length - 1);
}

void loadCreditsText() {
	auto text = &creditsText[0];
	auto dest = &creditsTextBuffer[0];
	enableSRAM();
	while (*text != 0xF0) {
		*(dest++) = *(text++);
	}
	disableSRAM();
}

void handleBoot() {
	disableLCD();
	oamClearTable();
	oamBufferIndex = 0;
	clearUnusedOAMSlots();
	silenceAudio();
	loadTitleScreen();
}

void handleTitle() {
	oamClearTable();
	titleScreenRoutine();
}

void loadScreenSpritePriorityBit() {
	samusScreenSpritePriority = (roomTransitionIndices[((samusY.screen & 0xF) << 4) | (samusX.screen & 0xF)] >> 11) & 1;
}
void unusedDeathAnimationCopy() {
	assert(0); // TODO
}
