module metroid2.bank00;

import std.logger;

import metroid2.bank06;
import metroid2.data;
import metroid2.defs;
import metroid2.external;
import metroid2.globals;
import metroid2.mapbanks;
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
		vblankUpdateMapDuringTransition();
	}
	if (queenRoomFlag == 0x11) {
		//vblankUpdateStatusBar();
		oamDMA();
		//vblankDrawQueen();
		vblankDoneFlag = 1;
	} else {
		if (mapUpdateFlag) {
			vblankUpdateMap();
		} else {
			//vblankUpdateStatusBar();
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
			handleDying();
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
	loadGameSamusData();
	const(ubyte)* src = saveBufTiletableSrc;
	ubyte* dest = &tileTableArray[0];
	for (int i = 0; i < tileTableArray.length; i++) {
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
		prepMapUpdateForceRow();
		vblankUpdateMap();
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

		samusHandlePose();
		//collisionSamusEnemiesStandard();
		samusTryShooting();
		//handleProjectiles();
		//handleBombs();
		prepMapUpdate();
		handleCamera();
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
			samusTryShootingToggleMissiles();
		}
	} else {
		if (doorScrollDirection) {
			samusSpriteCollisionProcessedFlag = 0;
			hurtSamus();
			samusHandlePose();
			//collisionSamusEnemiesStandard();
			samusTryShooting();
			//handleProjectiles();
			//handleBombs();
		}
	}
	prepMapUpdate();
	handleCamera();
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
	tryPausing();
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
			mapSourceXPixel = cast(ubyte)(cameraXPixel - 0x80);
			if (cameraXPixel >= 0x80) {
				cameraXScreen--;
			}
			mapSourceXScreen = cameraXScreen & 0xF;

			mapSourceYPixel = cast(ubyte)(cameraYPixel + 0x78);
			if (cameraYPixel < 0x78) {
				cameraYScreen++;
			}
			mapSourceYScreen = cameraYScreen & 0xF;
			cameraScrollDirection &= ~(1 << 7);
			prepMapUpdateRow();
			break;
		case 2: //left
			if ((cameraScrollDirection & (1 << 5)) == 0) {
				return;
			}
			mapUpdateUnusedVar = 0xFF;
			mapSourceXPixel = cast(ubyte)(cameraXPixel - 0x80);
			if (cameraXPixel >= 0x80) {
				cameraXScreen--;
			}
			mapSourceXScreen = cameraXScreen & 0xF;

			mapSourceYPixel = cast(ubyte)(cameraYPixel - 0x78);
			if (cameraYPixel >= 0x88) {
				cameraYScreen--;
			}
			mapSourceYScreen = cameraYScreen & 0xF;
			cameraScrollDirection &= ~(1 << 5);
			prepMapUpdateColumn();
			break;
		case 3: //right
			if ((cameraScrollDirection & (1 << 4)) == 0) {
				return;
			}
			mapUpdateUnusedVar = 0xFF;
			mapSourceXPixel = cast(ubyte)(cameraXPixel + 0x70);
			if (cameraXPixel < 0x70) {
				cameraXScreen++;
			}
			mapSourceXScreen = cameraXScreen & 0xF;

			mapSourceYPixel = cast(ubyte)(cameraYPixel - 0x78);
			if (cameraYPixel >= 0x88) {
				cameraYScreen--;
			}
			mapSourceYScreen = cameraYScreen & 0xF;
			cameraScrollDirection &= ~(1 << 4);
			prepMapUpdateColumn();
			break;
		default: assert(0);
	}
}
void prepMapUpdateForceRow() {
	mapSourceXPixel = cast(ubyte)(cameraXPixel - 0x80);
	if (cameraXPixel >= 0x80) {
		cameraXScreen--;
	}
	mapSourceXScreen = cameraXScreen & 0xF;

	mapSourceYPixel = cast(ubyte)(cameraYPixel - 0x78);
	if (cameraYPixel >= 0x88) {
		cameraYScreen--;
	}
	mapSourceYScreen = cameraYScreen & 0xF;
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
	*cast(ubyte*)mapUpdate.buffer = 0;
	*(cast(ubyte*)mapUpdate.buffer + 1) = 0;
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
	*cast(ubyte*)mapUpdate.buffer = 0;
	*(cast(ubyte*)mapUpdate.buffer + 1) = 0;
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
	*cast(ushort*)mapUpdate.buffer = mapUpdate.destAddr;
	mapUpdate.buffer += 2;
	*cast(ubyte*)(mapUpdate.buffer++) = tempMetaTile.topLeft;
	*cast(ubyte*)(mapUpdate.buffer++) = tempMetaTile.topRight;
	*cast(ubyte*)(mapUpdate.buffer++) = tempMetaTile.bottomLeft;
	*cast(ubyte*)(mapUpdate.buffer++) = tempMetaTile.bottomRight;
}

void vblankUpdateMap() {
	auto de = &mapUpdateBuffer[0] - 1;
	do {
		ushort hl = *cast(ushort*)de;
		if ((hl & 0xFF00) == 0) {
			break;
		}
		de += 2;
		// top left
		vram()[hl] = *(de++);
		hl = (hl + 1) & 0x9BFF;
		// top right
		vram()[hl] = *(de++);
		hl = (hl + 1) & 0x9BFF;
		// bottom left
		vram()[hl] = *(de++);
		hl = (hl + 0x1F) & 0x9BFF;
		// bottom right
		vram()[hl] = *(de++);
		hl = (hl + 1) & 0x9BFF;
	} while(true);
	mapUpdateFlag = 0;
}

void handleCamera() {
	assert(0, "NYI");
}
immutable ubyte[11] unknown0B39 = [0, 1, 1, 0, 0, 0, 1, 2, 2, 1, 1];

void handleCameraDoor() {
	assert(0, "NYI");
}

void loadDoorIndex() {
	if (queenRoomFlag == 0x11) {
		if ((samusPose >= SamusPose.spiderBallRolling) && (samusPose <= SamusPose.spiderBall)) {
			samusPose = SamusPose.morphBall;
		}
	}
	samusHurtFlag = 0;
	saveContactFlag = 0;

	bombArray[0][0] = 0xFF;
	bombArray[1][0] = 0xFF;
	bombArray[2][0] = 0xFF;

	justStartedTransition = 0xFF;
	doorIndex = roomTransitionIndices[(cameraYScreen << 4) | cameraXScreen] & 0xF7FF;

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
	samusXPixel = saveBufSamusXPixel;
	samusYPixel = saveBufSamusYPixel;
	samusPrevYPixel = saveBufSamusYPixel;
	samusXScreen = saveBufSamusXScreen;
	samusYScreen = saveBufSamusYScreen;
	samusInvulnerableTimer = 0;
	samusItems = saveBufSamusItems;
	samusActiveWeapon = saveBufSamusBeam;
	samusBeam = saveBufSamusBeam;
	samusFacingDirection = saveBufSamusFacingDirection;
	samusEnergyTanks = saveBufSamusEnergyTanks;
	samusCurHealth = saveBufSamusHealth;
	samusDispHealth = saveBufSamusHealth;
	samusMaxMissiles = saveBufSamusMaxMissiles;
	samusCurMissiles = saveBufSamusCurMissiles;
	samusDispMissiles = saveBufSamusCurMissiles;
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
			samusTurnAnimTimer--;
			return;
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
			samusYPixel = (samusYPixel & 0xF8) | 4;
			spiderDisplacement = 0;
		}
		final switch (samusPose) {
			case SamusPose.standing:
				assert(0);
			case SamusPose.jumping:
				assert(0);
			case SamusPose.spinJumping:
				assert(0);
			case SamusPose.running:
				assert(0);
			case SamusPose.crouching:
				assert(0);
			case SamusPose.morphBall:
				assert(0);
			case SamusPose.morphBallJumping:
				assert(0);
			case SamusPose.falling:
				assert(0);
			case SamusPose.morphBallFalling:
				assert(0);
			case SamusPose.startingToJump:
				assert(0);
			case SamusPose.startingToSpinJump:
				assert(0);
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
					//goto spiderballfall;
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
				if (samusMoveVertical(fallArcTable[samusFallArcCounter])) {
					if (!samusOnSolidSprite) {
						samusYPixel = (samusYPixel & 0xF8) | 4;
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
				if (samusFallArcCounter == 0x17) {
					samusFallArcCounter = 0x16;
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
						//goto spiderFallLand
					}
					collisionCheckSpiderSet();
					if (spiderContactState) {
						//goto spiderFallAttach
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
					samusFallArcCounter = 0x16;
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
						samusYPixel--;
						cameraSpeedUp = 1;
					} else {
						samusYPixel++;
						cameraSpeedDown = 1;
					}
					if (samusOnScreenXPos == queenHeadX + 26) {
						c++;
					} else if (samusOnScreenXPos >= queenHeadX + 26) {
						samusXPixel -= 2;
						cameraSpeedLeft = 1;
					} else {
						samusXPixel++;
						cameraSpeedRight = 1;
					}
					if (c == 2) {
						queenEatingState = 2;
					}
				}
				return;
			case SamusPose.inMetroidQueenMouth:
				samusYPixel = 0x6C;
				samusXPixel = 0xA6;
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
				if (samusXPixel != 0x68) {
					if (queenHeadX + 6 + scrollX < samusXPixel) {
						samusYPixel--;
					}
					samusXPixel--;
					if (samusXPixel >= 0x80) {
						return;
					}
					samusYPixel++;
				} else {
					samusPose = SamusPose.inMetroidQueenStomach;
				}
				return;
			case SamusPose.inMetroidQueenStomach:
				applyDamageQueenStomach();
				return;
			case SamusPose.escapingMetroidQueen:
				applyDamageQueenStomach();
				if (samusXPixel != 0xB0) {
					samusXPixel += 2;
					if (samusXPixel < 0x80) {
						samusYPixel -= 2;
					} else if (samusXPixel >= 0x98) {
						samusYPixel--;
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

immutable ubyte[] fallArcTable = [
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

	tileX = cast(ubyte)(samusXPixel + spiderXRight);
	tileY = cast(ubyte)(samusYPixel + spiderYTop);
	collisionCheckSpiderPoint();
	spiderContactState = rr(spiderContactState);

	tileY = cast(ubyte)(samusYPixel + spiderYBottom);
	collisionCheckSpiderPoint();
	spiderContactState = rr(spiderContactState);

	tileX = cast(ubyte)(samusXPixel + spiderXLeft);
	tileY = cast(ubyte)(samusYPixel + spiderYTop);
	collisionCheckSpiderPoint();
	spiderContactState = rr(spiderContactState);

	tileY = cast(ubyte)(samusYPixel + spiderYBottom);
	collisionCheckSpiderPoint();
	spiderContactState = swap(rr(spiderContactState));

	tileX = cast(ubyte)(samusXPixel + spiderXRight);
	tileY = cast(ubyte)(samusYPixel + spiderYMid);
	if (collisionCheckSpiderPoint()) {
		spiderContactState |= 0b0011;
	}

	tileX = cast(ubyte)(samusXPixel + spiderXLeft);
	tileY = cast(ubyte)(samusYPixel + spiderYMid);
	if (collisionCheckSpiderPoint()) {
		spiderContactState |= 0b1100;
	}

	tileX = cast(ubyte)(samusXPixel + spiderXMid);
	tileY = cast(ubyte)(samusYPixel + spiderYTop);
	if (collisionCheckSpiderPoint()) {
		spiderContactState |= 0b0101;
	}

	tileY = cast(ubyte)(samusYPixel + spiderYBottom);
	tileX = cast(ubyte)(samusXPixel + spiderXMid);
	//if (samusGetTileIndex() < samusSolidityIndex) {
	//	spiderContactState |= 0b1010;
	//} else if (collisionSamusEnemiesDown()) {
	//	spiderContactState |= 0b1010;
	//}
	if ((spiderContactState & 5) == 5) {
		return;
	}
	if (!(inputPressed & Pad.a)) {
		return;
	}
}

void samusGroundUnmorph() {
	assert(0);
}
bool samusTryStanding() {
	assert(0);
}
void samusMorphOnGround() {
	samusPose = SamusPose.morphBall;
	samusSpeedDown = 0;
	sfxRequestSquare1 = Square1SFX.morphingTransition;
}
void samusUnmorphInAir() {
	assert(0);
}
void samusWalkRight() {
	assert(0);
}
void samusWalkLeft() {
	assert(0);
}
void samusRollRightSpider() {
	samusRollRight(1);
}
void samusRollRightMorph() {
	samusRollRight(2);
}
void samusRollRight(ubyte a) {
	assert(0);
}
void samusRollLeftSpider() {
	samusRollLeft(1);
}
void samusRollLeftMorph() {
	samusRollLeft(2);
}
void samusRollLeft(ubyte a) {
	assert(0);
}
void samusMoveRightInAir() {
	samusFacingDirection = 1;
	samusMoveRightInAirNoTurn();
}
void samusMoveRightInAirNoTurn() {
	assert(0);
}
void samusMoveLeftInAir() {
	samusFacingDirection = 0;
	samusMoveLeftInAirNoTurn();
}
void samusMoveLeftInAirNoTurn() {
	assert(0);
}
bool samusMoveVertical(ubyte a) {
	assert(0);
}
void samusMoveUp(ubyte a) {
	assert(0);
}
bool collisionSamusHorizontal() {
	assert(0);
}
bool collisionSamusTop() {
	assert(0);
}
bool collisionSamusBottom() {
	assert(0);
}
bool collisionCheckSpiderPoint() {
	assert(0);
}
ubyte samusGetTileIndex() {
	assert(0);
}

immutable metroidLCounterTable = [ //originally BCD indexed
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x01, 0x02, 0x03, 0x01, 0x01, 0x01, 0x02, 0x03, 0x04, 0x05, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x06, 0x07, 0x01, 0x02, 0x01, 0x01, 0x02, 0x03, 0x04, 0x05, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x06, 0x07, 0x08, 0x09, 0x10, 0x01, 0x02, 0x03, 0x04, 0x05, /*0x00, 0x00, 0x00, 0x00, 0x00, 0x00,*/
	0x06, 0x07, 0x08, 0x01, 0x02, 0x03, 0x04, 0x01,
];
immutable saveMagic = [
	0x01, 0x23, 0x45, 0x67, 0x89, 0xab, 0xcd, 0xef
];

immutable ubyte[] samusDamagePoseTransitionTable = [
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
		projectileArray[i] = 0xFF;
	}
}

void samusTryShooting() {
	if ((samusPose != SamusPose.facingScreen) || (queenEatingState != 0x22) || !(inputRisingEdge & Pad.select)) {
		//samusShoot
	}
	samusTryShootingToggleMissiles();
}
void samusTryShootingToggleMissiles() {
	auto graphicsInfoCannonMissile = GraphicsInfo(graphicsCannonMissile, 0x8080, 0x20);
	auto graphicsInfoCannonBeam = GraphicsInfo(graphicsCannonBeam, 0x8080, 0x20);
	if (samusActiveWeapon == 8) {
		samusActiveWeapon = samusBeam;
		//loadGraphics(graphicsInfoCannonBeam);
		sfxRequestSquare1 = Square1SFX.select;
	} else {
		samusBeam = samusActiveWeapon;
		samusActiveWeapon = 8;
		//loadGraphics(graphicsInfoCannonMissile);
		sfxRequestSquare1 = Square1SFX.select;
	}
}


ubyte getTileIndex() {
	assert(0);
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

void getTilemapAddress() {
	tilemapDest = &(vram()[0x9800 + ((tileY - 16) / 8) * 0x20 + (tileX - 8) / 8]);
}

void getTilemapCoordinates() {
	assert(0);
}

void unknown230C() {
	assert(0);
}
void oamDMA() {
	vram()[0xFE00 .. 0xFEA0] = cast(ubyte[])(oamBuffer[]);
}
void executeDoorScript() {
	//assert(0);
}

void beginGraphicsTransfer() {
	vramTransferFlag = 0xFF;
	while (vramTransferFlag) {
		if (variaAnimationFlag) {
			//drawSamus();
			handleEnemiesOrQueen();
			//drawHudMetroid();
			//clearUnusedOAMSlots();
		}
		//waitOneFrame();
	}
}

void animateGettingVaria() {
	assert(0);
}

void doorLoadTileTable() {
	assert(0);
}
void doorLoadCollision() {
	assert(0);
}
void doorQueen() {
	assert(0);
}
void doorWarp() {
	assert(0);
}

void vblankUpdateMapDuringTransition() {
	if (!mapUpdateFlag) {
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
	do {
		*cast(ubyte*)(dest++) = *cast(ubyte*)(src++);
	} while (size > 0);
	vramTransfer.size = 0;
	vramTransfer.src = null;
	vramTransfer.dest = null;
	vramTransferFlag = 0;
	vblankDoneFlag = 1;
}
void vblankVariaAnimation() {
	assert(0);
}

void waitOneFrame() {
	//handleAudio();
	waitNextFrameExternal();
	frameCounter++;
	vblankDoneFlag = 0;
	unusedFlag1 = 0xC0;
	oamBufferIndex = 0;
}
void tryPausing() {
	assert(0);
}
void gameModePaused() {
	const b = (frameCounter & (1 << 4)) ? 147 : 231;
	bgPalette = b;
	obPalette0 = b;
	if (debugFlag) {
		//drawHudMetroid();
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
			//debugDrawNumberOneDigit(debugItemIndex);
			spriteYPixel = 0x54;
			spriteID = 0x36;
			spriteXPixel = 0x34;
			if (samusItems & ItemFlag.unused) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x3C;
			if (samusItems & ItemFlag.variaSuit) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x44;
			if (samusItems & ItemFlag.spiderBall) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x4C;
			if (samusItems & ItemFlag.springBall) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x54;
			if (samusItems & ItemFlag.spaceJump) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x5C;
			if (samusItems & ItemFlag.screwAttack) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x64;
			if (samusItems & ItemFlag.hiJump) {
				//drawSamusSprite();
			}
			spriteXPixel = 0x6C;
			if (samusItems & ItemFlag.bomb) {
				//drawSamusSprite();
			}
			spriteYPixel = 0x68;
			spriteXPixel = 0x50;
			//debugDrawNumberTwoDigit(samusActiveWeapon);
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
		//clearUnusedOAMSlots();
		//audioPauseControl = 2;
		gameMode = GameMode.main;
	}
	if (!(inputRisingEdge & Pad.start)) {
		return;
	}
	bgPalette = 147;
	obPalette0 = 147;
	//audioPauseControl = 2;
	gameMode = GameMode.main;
}

void hurtSamus() {
	assert(0);
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
		//drawSamus();
		//drawHudMetroid();
		//queenHandler();
		//clearUnusedOAMSlots();
	}
}

void killSamus() {
	//silenceAudio();
	sfxRequestNoise = NoiseSFX.u0B;
	waitOneFrame();
	//drawSamusIgnoreDamageFrames();
	deathAnimTimer = 0x20;
	deathAltAnimBase = &(vram()[0x8000]);
	deathFlag = 1;
	gameMode = GameMode.dying;
}
