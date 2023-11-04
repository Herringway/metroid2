module metroid2.globals;

import libgb;

import metroid2.defs;

__gshared OAMEntry[40] oamBuffer;

__gshared ubyte tileX;
__gshared ubyte tileY;
__gshared ubyte scrollX;
__gshared ubyte scrollY;
__gshared ubyte* tilemapDest;
__gshared ubyte gameOverLCDCCopy;
__gshared ubyte unknownC227;

__gshared ubyte[0x60] oamScratchpad;
__gshared ubyte[4] hitboxC360;

__gshared ubyte blobThrowerActionTimer;
__gshared ubyte blobThrowerWaitTimer;
__gshared ubyte blobThrowerState;
__gshared ubyte blobThrowerFacingDirection;
__gshared ubyte blobThrowerBlobUnknownVar;

__gshared ubyte tempSpriteType;

__gshared ubyte arachnusJumpCounter;
__gshared ubyte arachnusActionTimer;
__gshared ubyte arachnusUnknownVar;
__gshared ubyte arachnusJumpStatus;
__gshared ubyte arachnusHealth;

__gshared ubyte queenBodyY;
__gshared ubyte queenBodyXScroll;
__gshared ubyte queenBodyHeight;
__gshared ubyte queenWalkWaitTimer;
__gshared ubyte queenWalkCounter;
__gshared const(ubyte)* queenNeckPattern;
__gshared ubyte queenHeadX;
__gshared ubyte queenHeadY;
__gshared const(ubyte)* queenInterruptList;
__gshared ubyte queenHeadBottomY;
__gshared ubyte queenInterruptListID;
__gshared ubyte queenNeckXMovementSum;
__gshared ubyte queenNeckYMovementSum;
__gshared ubyte* queenOAMScratchpad;
__gshared ubyte queenNeckDrawingState;
__gshared ubyte queenCameraDeltaX;
__gshared ubyte queenCameraDeltaY;
__gshared ubyte queenWalkControl;
__gshared ubyte queenNeckSelectionFlag;
__gshared ubyte queenWalkStatus;
__gshared ubyte queenNeckControl;
__gshared ubyte queenNeckStatus;
__gshared ubyte queenWalkSpeed;
__gshared ubyte queenState;
__gshared const(ubyte)* queenNextState;
__gshared ubyte queenCameraX;
__gshared ubyte queenCameraY;
__gshared ubyte queenFootFrame;
__gshared ubyte queenFootAnimCounter;
__gshared ubyte queenHeadFrameNext;
__gshared ubyte queenHeadFrame;
__gshared ubyte queenNeckPatternID;
__gshared const(ubyte)* queenNeckPatternBase;
__gshared ubyte queenDelayTimer;
__gshared ubyte queenStunTimer;
__gshared ubyte queenStomachBombedFlag;
__gshared ubyte queenBodyPalette;
__gshared ubyte queenHealth;
__gshared ubyte queenDeathArrayIndex;
__gshared ubyte queenDeathAnimCounter;
__gshared ubyte[8] queenDeathArray;
__gshared ubyte* queenDeathChr;
__gshared ubyte queenDeathBitmask;
__gshared ubyte queenProjectilesActive;
__gshared ubyte queenProjectileTempDirection;
__gshared ubyte queenProjectileChaseTimer;
__gshared ubyte queenLowHealthFlag;
__gshared ubyte queenFlashTimer;
__gshared ubyte queenMidHealthFlag;
__gshared ubyte queenHeadDest;
__gshared const(ubyte)* queenHeadSrc;

__gshared ubyte loadEnemiesUnusedVar;
__gshared ubyte loadEnemiesOscillator;
__gshared ubyte bgCollisionResult;
__gshared ubyte enemySolidityIndex;
__gshared ubyte[6] scrollHistoryA;
__gshared ubyte samusDirectionFromEnemy;

__gshared ubyte bottomEdgeScreen;
__gshared ubyte bottomEdgePixel;
__gshared ubyte topEdgeScreen;
__gshared ubyte topEdgePixel;
__gshared ubyte rightEdgeScreen;
__gshared ubyte rightEdgePixel;
__gshared ubyte leftEdgeScreen;
__gshared ubyte leftEdgePixel;

__gshared ubyte metroidBabyTouchingTile;

__gshared ubyte unusedROMBankPlusOne;

__gshared ubyte metroidPostDeathTimer;
__gshared ubyte metroidState;

__gshared ubyte enemyYPosMirror;
__gshared ubyte enemyXPosMirror;

__gshared ubyte samusHurtFlag;
__gshared ubyte samusDamageBoostDirection;
__gshared ubyte samusDamageValue;

__gshared ubyte unknownC42D;

__gshared ubyte drawEnemyYPos;
__gshared ubyte drawEnemyXPos;
__gshared ubyte drawEnemySprite;
__gshared ubyte drawEnemyAttr;

__gshared ubyte[4] scrollHistoryB;

__gshared ubyte loadSpawnFlagsRequest;

__gshared ubyte zetaXProximityFlag;

__gshared ubyte enemySameEnemyFrameFlag;

__gshared ubyte enemiestLeftToProcess;

__gshared ubyte samusOnSolidSprite;

__gshared ubyte babyTempXPos;

__gshared ubyte[4] seekSamusTemp;

__gshared ubyte saveLoadSpawnFlagsRequest;

__gshared ubyte scrollEnemiesNumEnemiesLeft;

__gshared ubyte enemyTextPointYPos;
__gshared ubyte enemyTextPointXPos;

__gshared ubyte omegaTempSpriteType;
__gshared ubyte* enemyWRAM;

__gshared void* enemyFirstEnemy;
__gshared void* drawEnemy;

__gshared ubyte loadEnemyUnusedVarA;
__gshared ubyte loadEnemyUnusedVarB;

__gshared ubyte doorExitStatus;
__gshared ubyte previousLevelBank;
__gshared ubyte metroidSamusXDir;
__gshared ubyte metroidSamusYDir;
__gshared ubyte metroidAngleTableIndex;
__gshared ubyte metroidAbsSamusDistY;
__gshared ubyte metroidAbsSamusDistX;
__gshared ushort metroidSlopeToSamus;

__gshared ubyte loadEnemySpawnFlagTemp;

__gshared ubyte omegaStunCounter;
__gshared ubyte cutsceneActive;
__gshared ubyte alphaStunCounter;
__gshared ubyte metroidFightActive;

__gshared ubyte[4] enSprCollision;

__gshared ubyte gammaStunCounter;
__gshared ubyte enemyWeaponType;
__gshared ubyte enemyWeaponDir;

__gshared ubyte omegaWaitCounter;
__gshared ubyte omegaSamusPrevHealth;

__gshared ubyte metroidScrewKnockbackDone;
__gshared ubyte larvaHurtAnimCounter;
__gshared ubyte larvaBombState;
__gshared ubyte larvaLatchState;

__gshared ubyte enemyTempSpawnFlag;

__gshared ubyte omegaChaseTimerIndex;

__gshared ubyte hasMovedOffscreen;

__gshared ubyte[0x40] enemySpawnFlagsUnsaved;
__gshared ubyte[0x40] enemySpawnFlagsSaved;

__gshared EnemySlot[16] enemyDataSlots;

__gshared ubyte[448] saveBufEnemySpawnFlags;

__gshared Square1SFX sfxRequestSquare1;
__gshared Square1SFX sfxPlayingSquare1;
__gshared ubyte sfxTimerSquare1;

__gshared ubyte samusHealthChangedOptionSetIndex;

__gshared Square2SFX sfxRequestSquare2;
__gshared Square2SFX sfxPlayingSquare2;
__gshared ubyte sfxTimerSquare2;
__gshared ubyte square2VariableFrequency;
__gshared ubyte sfxRequestFakeWave;
__gshared ubyte sfxPlayingFakeWave;
__gshared NoiseSFX sfxRequestNoise;
__gshared NoiseSFX sfxPlayingNoise;
__gshared ubyte sfxTimerNoise;
__gshared Song songRequest;
__gshared Song songPlaying;
__gshared Song2 songInterruptionRequest;
__gshared Song2 songInterruptionPlaying;
__gshared ubyte sfxActiveSquare1;
__gshared ubyte sfxActiveSquare2;
__gshared ubyte sfxActiveWave;
__gshared ubyte sfxActiveNoise;
__gshared ubyte resumeScrewAttackSoundEffectFlag;

__gshared ubyte songTranspose;
__gshared void* songInstructionTimerArrayPointer;

__gshared ubyte[4] tempMetaTile;
__gshared ubyte samusPrevYPixel;
__gshared ubyte samusBeamCooldown;
__gshared ubyte doorScrollDirection;
__gshared ubyte samusAirDirection;
__gshared ubyte samusJumpStartCounter;
__gshared ubyte unusedD011;
__gshared ubyte weaponDirection;
__gshared SamusPose samusPose;
__gshared ubyte samusAnimationTimer;
__gshared ubyte cameraScrollDirection;
__gshared ubyte samusFallArcCounter;
__gshared ubyte samusJumpArcCounter;

__gshared ubyte prevSamusXPixel;
__gshared ubyte prevSamusXScreen;
__gshared ubyte prevSamusYPixel;
__gshared ubyte prevSamusYScreen;

__gshared ubyte samusFacingDirection;
__gshared ubyte samusTurnAnimTimer;
__gshared ubyte collisionSamusYOffsetA;
__gshared ubyte collisionSamusYOffsetB;
__gshared ubyte collisionSamusYOffsetC;
__gshared ubyte collisionSamusYOffsetD;

__gshared ubyte projectileIndex;

__gshared ubyte samusSpeedDown;
__gshared ubyte samusSpeedDownTemp;

__gshared ubyte cameraSpeedRight;
__gshared ubyte cameraSpeedLeft;
__gshared ubyte cameraSpeedUp;
__gshared ubyte cameraSpeedDown;

__gshared ubyte titleUnusedD039;

__gshared ubyte samusOnScreenYPos;
__gshared ubyte samusOnScreenXPos;
__gshared ubyte spiderContactState;
__gshared ubyte spiderBallDirection;
__gshared ubyte spiderDisplacement;
__gshared ubyte spiderRotationState;

__gshared ubyte samusItems;

__gshared ubyte debugItemIndex;

__gshared ubyte vramTransferFlag;

__gshared ubyte waterContactFlag;
__gshared ubyte samusUnmorphJumpTimer;

__gshared ubyte bombMapYPixel;
__gshared ubyte bombMapXPixel;

__gshared ubyte mapUpdateUnusedVar;

__gshared ubyte samusActiveWeapon;
__gshared ubyte bankRegMirror;

__gshared ubyte samusInvulnerableTimer;
__gshared ubyte samusEnergyTanks;
__gshared ushort samusCurHealth;
__gshared ushort samusCurMissiles;
__gshared ubyte samusSolidityIndex;
__gshared ubyte samusScreenSpritePriority;
__gshared ubyte currentLevelBank;
__gshared ubyte deathAnimTimer;
__gshared void* deathAltAnimBase;
__gshared ubyte samusSpriteCollisionProcessedFlag;
__gshared ubyte collisionWeaponType;
__gshared void* collisionEnemy;
__gshared ubyte collisionWeaponDir;

__gshared ubyte acidContactFlag;

__gshared ubyte deathFlag;
__gshared ubyte samusTopOAMOffset;

__gshared ubyte vramTransferSrcBank;

__gshared ushort countdownTimer;

__gshared ubyte enemySolidityIndexCanon;
__gshared ubyte unusedD06B;
__gshared ubyte itemCollected;
__gshared ubyte itemCollectionFlag;

__gshared ubyte maxOAMPrevFrame;

__gshared ubyte itemOrbCollisionType;
__gshared void* itemOrbEnemyWRAM;

__gshared ubyte samusSpinAnimationFlag;

__gshared void* creditsTextPointer;
__gshared ubyte creditsUnusedVar;
__gshared ubyte creditsNextLineReady;
__gshared ubyte acidDamageValue;
__gshared ubyte spikeDamageValue;

__gshared ubyte loadingFromFile;

__gshared ubyte titleClearSelected;

__gshared ubyte titleStarY;
__gshared ubyte titleStarX;

__gshared ubyte saveContactFlag;

__gshared ubyte bgPalette;
__gshared ubyte obPalette0;
__gshared ubyte obPalette1;

__gshared ushort samusMaxMissiles;

__gshared ubyte earthquakeTimer;

__gshared ushort samusDispHealth;
__gshared ushort samusDispMissiles;

__gshared ubyte saveMessageCooldownTimer;
__gshared ubyte metroidCountReal;

__gshared ubyte beamSolidityIndex;

__gshared ubyte queenRoomFlag;

__gshared ubyte variaAnimationFlag;

__gshared ubyte weaponType;

__gshared ushort doorIndex;

__gshared ubyte queenEatingState;

__gshared ubyte nextEarthquakeTimer;

__gshared ubyte currentRoomSong;

__gshared ubyte itemCollectedCopy;
__gshared ubyte unusedItemOrbYPos;
__gshared ubyte unusedItemOrbXPos;

__gshared ubyte metroidCountShuffleTimer;

__gshared ubyte creditsSamusAnimState;

__gshared ubyte gameTimeMinutes;
__gshared ubyte gameTimeHours;

__gshared ubyte metroidCountDisplayed;

__gshared ubyte fadeInTimer;

__gshared ubyte creditsRunAnimFrame;
__gshared ubyte creditsRunAnimCounter;

__gshared ubyte justStartedTransition;

__gshared ubyte creditsScrollingDone;

__gshared ubyte debugFlag;

__gshared ubyte samusPrevHealth;

__gshared ubyte gameTimeSeconds;

__gshared ubyte activeSaveSlot;
__gshared ubyte titleShowClearOption;

__gshared ubyte songRequestAfterEarthquake;
__gshared ubyte soundPlayQueenRoar;

__gshared ubyte metroidLCounterDisp;

__gshared ubyte wramUnknownD0A8;

__gshared ubyte[0x20] creditsStarArray;
__gshared ubyte[0x40] doorScriptBuffer;

__gshared ubyte saveBufSamusYPixel;
__gshared ubyte saveBufSamusYScreen;
__gshared ubyte saveBufSamusXPixel;
__gshared ubyte saveBufSamusXScreen;
__gshared ubyte saveBufCameraYPixel;
__gshared ubyte saveBufCameraYScreen;
__gshared ubyte saveBufCameraXPixel;
__gshared ubyte saveBufCameraXScreen;
__gshared const(ubyte)* saveBufEnGfxSrc;
__gshared ubyte saveBufBGGfxSrcBank;
__gshared const(ubyte)* saveBufBGGfxSrc;
__gshared const(ubyte)* saveBufTiletableSrc;
__gshared const(ubyte)* saveBufCollisionSrc;
__gshared ubyte saveBufCurrentLevelBank;
__gshared ubyte saveBufSamusSolidityIndex;
__gshared ubyte saveBufEnemySolidityIndex;
__gshared ubyte saveBufBeamSolidityIndex;
__gshared ubyte saveBufSamusItems;
__gshared ubyte saveBufSamusBeam;
__gshared ubyte saveBufSamusEnergyTanks;
__gshared ushort saveBufSamusHealth;
__gshared ushort saveBufSamusMaxMissiles;
__gshared ushort saveBufSamusCurMissiles;
__gshared ubyte saveBufSamusFacingDirection;
__gshared ubyte saveBufAcidDamageValue;
__gshared ubyte saveBufSpikeDamageValue;
__gshared ubyte saveBufMetroidCountReal;
__gshared ubyte saveBufCurrentRoomSong;
__gshared ubyte saveBufGameTimeMinutes;
__gshared ubyte saveBufGameTimeHours;
__gshared ubyte saveBufMetroidCountDisplayed;

__gshared ubyte[0x100] respawningBlockArray;
__gshared ubyte[0x200] tiletableArray;
__gshared ubyte[0x100] collisionArray;
__gshared ubyte[0x10][3] projectileArray;
__gshared ubyte[0x10][3] bombArray;

__gshared ubyte[0xA0] unusedDD60;
__gshared ubyte[0x100] mapUpdateBuffer;
__gshared ubyte mapUpdateFlag;

__gshared ubyte inputPressed;
__gshared ubyte inputRisingEdge;
__gshared ubyte vblankDoneFlag;
__gshared ubyte unusedFlag1;
__gshared ubyte oamBufferIndex;
__gshared ubyte frameCounter;
__gshared GameMode gameMode;

__gshared MapUpdate mapUpdate;
__gshared VRAMTransfer vramTransfer;

__gshared void* beamP;
__gshared ubyte beamType;
__gshared ubyte beamWaveIndex;
__gshared ubyte beamFrameCounter;

__gshared ubyte tank1;
__gshared ubyte tank2;
__gshared ubyte tank3;
__gshared ubyte tank4;
__gshared ubyte tank5;

__gshared ubyte collisionEnY;
__gshared ubyte collisionEnX;
__gshared ubyte collisionEnSprite;
__gshared ubyte collisionEnTop;
__gshared ubyte collisionEnBottom;
__gshared ubyte collisionEnLeft;
__gshared ubyte collisionEnRight;
__gshared ubyte collisionEnIce;
__gshared ubyte collisionEnAttr;

__gshared ubyte samusYPixel;
__gshared ubyte samusYScreen;
__gshared ubyte samusXPixel;
__gshared ubyte samusXScreen;

__gshared ubyte spriteYPixel;
__gshared ubyte spriteXPixel;
__gshared ubyte spriteID;
__gshared ubyte spriteAttr;

__gshared ubyte cameraYPixel;
__gshared ubyte cameraYScreen;
__gshared ubyte cameraXPixel;
__gshared ubyte cameraXScreen;

__gshared ubyte mapSourceYPixel;
__gshared ubyte mapSourceYScreen;
__gshared ubyte mapSourceXPixel;
__gshared ubyte mapSourceXScreen;

