module metroid2.globals;

import replatform64.gameboy;

import metroid2.defs;
import metroid2.external;

__gshared OAMEntry[40] oamBuffer;

__gshared ubyte tileX;
__gshared ubyte tileY;
__gshared ubyte scrollX;
__gshared ubyte scrollY;
__gshared ushort tilemapDest;
__gshared ubyte gameOverLCDCCopy;
__gshared ubyte unknownC227;

__gshared OAMEntry[26] oamScratchpad;
__gshared OAMEntry[16] enSpriteBlobThrower;
__gshared Rectangle hitboxC360;

__gshared ubyte blobThrowerActionTimer;
__gshared ubyte blobThrowerWaitTimer;
__gshared ubyte blobThrowerState;
__gshared ubyte blobThrowerFacingDirection;
__gshared ubyte blobThrowerBlobUnknownVar;

__gshared Actor tempSpriteType;

struct ArachnusState {
	ubyte jumpCounter;
	ubyte actionTimer;
	ubyte unknownVar;
	ubyte jumpStatus;
	ubyte health;
	ubyte unk06;
	ubyte unk07;
}

__gshared ArachnusState arachnus;

__gshared ubyte queenBodyY;
__gshared ubyte queenBodyX;
__gshared ubyte queenBodyHeight;
__gshared ubyte queenWalkWaitTimer;
__gshared ubyte queenWalkCounter;
__gshared const(ubyte)* queenNeckPattern;
__gshared ubyte queenHeadX;
__gshared ubyte queenHeadY;
__gshared InterruptCommand* queenInterruptList;
__gshared ubyte queenHeadBottomY;
__gshared InterruptCommand[4] queenInterruptListBuffer;
__gshared ubyte queenNeckXMovementSum;
__gshared ubyte queenNeckYMovementSum;
__gshared OAMEntry* queenOAMScratchpad;
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
__gshared ushort queenDeathChr;
__gshared ubyte queenDeathBitmask;
__gshared ubyte queenProjectilesActive;
__gshared ubyte queenProjectileTempDirection;
__gshared ubyte queenProjectileChaseTimer;
__gshared Coords[3] queenSamusTargetPoints;
__gshared ubyte* queenDeleteBody;
__gshared ubyte queenProjectileChaseCounter;
__gshared ubyte queenLowHealthFlag;
__gshared ubyte queenFlashTimer;
__gshared ubyte queenMidHealthFlag;
__gshared ubyte queenHeadDest;
__gshared const(ubyte)* queenHeadSrc;

__gshared ubyte loadEnemiesUnusedVar;
__gshared ubyte loadEnemiesOscillator;
__gshared ubyte enBGCollisionResult;
__gshared ubyte enemySolidityIndex;
__gshared Coords[3] scrollHistoryA;
__gshared ubyte samusDirectionFromEnemy;

__gshared ushort bottomEdge;
__gshared ushort topEdge;
__gshared ushort rightEdge;
__gshared ushort leftEdge;

__gshared ubyte metroidBabyTouchingTile;

__gshared ubyte unusedROMBankPlusOne;

__gshared ubyte metroidPostDeathTimer;
__gshared ubyte metroidState;

__gshared ubyte enemyYPosMirror;
__gshared ubyte enemyXPosMirror;

__gshared ubyte samusHurtFlag;
__gshared ubyte samusDamageBoostDirection;
__gshared ubyte samusDamageValue;

struct NumEnemies {
	ubyte total;
	ubyte active;
	ubyte offscreen;
}

__gshared NumEnemies numEnemies;

__gshared ubyte unknownC42D;

__gshared ubyte drawEnemyYPos;
__gshared ubyte drawEnemyXPos;
__gshared Actor drawEnemySpr;
__gshared ubyte drawEnemyAttr;

struct ScrollHistoryB {
	ubyte[2] y;
	ubyte[2] x;
}
__gshared ScrollHistoryB scrollHistoryB;

__gshared ubyte loadSpawnFlagsRequest;

__gshared ubyte zetaXProximityFlag;

__gshared ubyte enemySameEnemyFrameFlag;

__gshared ubyte enemiesLeftToProcess;

__gshared ubyte samusOnSolidSprite;

__gshared ubyte babyTempXPos;
struct SeekSamus {
	ubyte enemyY;
	ubyte enemyX;
	ubyte samusY;
	ubyte samusX;
}
__gshared SeekSamus seekSamusTemp;

__gshared ubyte saveLoadSpawnFlagsRequest;

__gshared ubyte scrollEnemiesNumEnemiesLeft;

__gshared ubyte enemyTestPointYPos;
__gshared ubyte enemyTestPointXPos;

__gshared Actor omegaTempSpriteType;
__gshared EnemySlot* enemyWRAM;

__gshared EnemySlot[] enemyFirstEnemy;
__gshared EnemySlot* drawEnemy;

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


struct EnSprCollision {
	CollisionType weaponType = CollisionType.nothing;
	EnemySlot* enemy;
	ubyte weaponDir = 0xFF;
}
__gshared EnSprCollision enSprCollision;

__gshared ubyte gammaStunCounter;
__gshared ubyte zetaStunCounter;
__gshared CollisionType enemyWeaponType;
__gshared ubyte enemyWeaponDir;

__gshared ubyte omegaWaitCounter;
__gshared ushort omegaSamusPrevHealth;

__gshared ubyte metroidScrewKnockbackDone;
__gshared ubyte larvaHurtAnimCounter;
__gshared ubyte larvaBombState;
__gshared ubyte larvaLatchState;

__gshared ubyte enemyTempSpawnFlag;

__gshared ubyte omegaChaseTimerIndex;

__gshared ubyte hasMovedOffscreen;

__gshared ubyte[0x80] enemySpawnFlags;
ref ubyte[0x40] enemySpawnFlagsUnsaved() {
	return enemySpawnFlags[0x00 .. 0x40];
}
ref ubyte[0x40] enemySpawnFlagsSaved() {
	return enemySpawnFlags[0x40 .. 0x80];
}

__gshared EnemySlot[16] enemyDataSlots;
struct AudioState {
	Square1SFX sfxRequestSquare1;
	Square1SFX sfxPlayingSquare1;
	ubyte sfxTimerSquare1;

	ubyte samusHealthChangedOptionSetIndex;

	Square2SFX sfxRequestSquare2;
	Square2SFX sfxPlayingSquare2;
	ubyte sfxTimerSquare2;
	ubyte square2VariableFrequency;
	ubyte sfxRequestFakeWave;
	ubyte sfxPlayingFakeWave;
	NoiseSFX sfxRequestNoise;
	NoiseSFX sfxPlayingNoise;
	ubyte sfxTimerNoise;
	Song songRequest;
	Song songPlaying;
	Song2 songInterruptionRequest;
	Song2 songInterruptionPlaying;
	ubyte sfxActiveSquare1;
	ubyte sfxActiveSquare2;
	ubyte sfxActiveWave;
	NoiseSFX sfxActiveNoise;
	ubyte resumeScrewAttackSoundEffectFlag;
	SongState songState;
	alias SongProcessingState = songState;
	alias songProcessingStateBackup = songStateBackup;

	SongState songStateBackup;

	Song songPlayingBackup;
	ubyte audioPauseControl;
	ubyte audioPauseSoundEffectTimer;
	ubyte songSweepBackupSquare1;
	ubyte sfxVariableFrequencySquare1;
	ushort ramCFE3;
	ubyte sfxRequestLowHealthBeep;
	ubyte sfxRequestWave;
	ubyte sfxPlayingLowHealthBeep;
	ubyte sfxPlayingWave;
	ubyte sfxPlayingBackupLowHealthBeep;
	ubyte sfxTimerWave;
	ubyte sfxLengthWave;
	ubyte ramCFEB;
	ubyte audioChannelOutputStereoFlags;
	ubyte audioChannelOutputStereoFlagsBackup;
	ubyte loudLowHealthBeepTimer;
}
__gshared AudioState audio;
struct ChannelSongProcessingState {
	const(ushort)[] sectionPointer;
	const(ushort)[] sectionPointers;
	const(ubyte)* repeatPoint;
	ubyte repeatCount;
	ubyte instructionLength;
	alias noteEnvelope = noteVolume;
	ubyte noteVolume;
	ubyte instructionTimer;
	ubyte effectIndex;
}
struct SongState {
	ubyte songTranspose;
	const(ubyte)[] songInstructionTimerArrayPointer;
	ubyte workingSoundChannel;
	ubyte songChannelEnableSquare1;
	ubyte songChannelEnableSquare2;
	ubyte songChannelEnableWave;
	ubyte songChannelEnableNoise;
	ubyte songOptionsSetFlagWorking;
	const(ubyte)* songWavePatternDataPointer;
	alias songSweepWorking = songEnableWorking;
	ubyte songEnableWorking;
	ubyte songSoundLengthWorking;
	alias songEnvelopeWorking = songVolumeWorking;
	ubyte songVolumeWorking;
	ushort songFrequencyWorking;
	ubyte songPolynomialCounterWorking() {
		return songFrequencyWorking & 0xFF;
	}
	void songPolynomialCounterWorking(ubyte v) {
		songFrequencyWorking = (songFrequencyWorking & ~0xFF) | v;
	}
	ubyte songCounterControlWorking() {
		return songFrequencyWorking >> 8;
	}
	void songCounterControlWorking(ubyte v) {
		songFrequencyWorking = (songFrequencyWorking & ~0xFF00) | (v << 8);
	}
	// audioChannelOptions
	ubyte songSweepSquare1;
	ubyte songSoundLengthSquare1;
	ubyte songEnvelopeSquare1;
	ushort songFrequencySquare1;

	ubyte songSoundLengthSquare2;
	ubyte songEnvelopeSquare2;
	ushort songFrequencySquare2;

	ubyte songEnableOptionWave;
	ubyte songSoundLengthWave;
	ubyte songVolumeWave;
	ushort songFrequencyWave;

	ubyte songSoundLengthNoise;
	ubyte songEnvelopeNoise;
	ubyte songPolynomialCounterNoise;
	ubyte songCounterControlNoise;

	const(ubyte)* songChannelInstructionPointerSquare1;
	const(ubyte)* songChannelInstructionPointerSquare2;
	const(ubyte)* songChannelInstructionPointerWave;
	const(ubyte)* songChannelInstructionPointerNoise;

	ubyte songSoundChannelEffectTimer;

	ChannelSongProcessingState songWorkingState;
	ChannelSongProcessingState songSquare1State;
	ChannelSongProcessingState songSquare2State;
	ChannelSongProcessingState songWaveState;
	ChannelSongProcessingState songNoiseState;

	ubyte songFadeoutTimer;
	ubyte ramCF5D;
	ubyte ramCF5E;
	ubyte ramCF5F;
	ubyte songFrequencyTweakSquare2;
}

struct TempMetaTile {
	ubyte topLeft;
	ubyte topRight;
	ubyte bottomLeft;
	ubyte bottomRight;
}
__gshared TempMetaTile tempMetaTile;
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

__gshared ushort prevSamusX;
__gshared ushort prevSamusY;

__gshared ubyte samusFacingDirection;
__gshared ubyte samusTurnAnimTimer;
__gshared ubyte[4] collisionSamusYOffsets;

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

__gshared CollisionType samusActiveWeapon;
__gshared ubyte bankRegMirror;

__gshared ubyte samusInvulnerableTimer;
__gshared ubyte samusEnergyTanks;
__gshared ushort samusCurHealth;
__gshared ushort samusCurMissiles;
__gshared CollisionType samusBeam;
__gshared ubyte samusSolidityIndex;
__gshared ubyte samusScreenSpritePriority;
__gshared ubyte currentLevelBank;
__gshared ubyte deathAnimTimer;
__gshared ushort deathAltAnimBase;
__gshared ubyte samusSpriteCollisionProcessedFlag;
__gshared EnSprCollision collision;

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

__gshared CollisionType itemOrbCollisionType;
__gshared EnemySlot* itemOrbEnemyWRAM;

__gshared ubyte samusSpinAnimationTimer;

__gshared ubyte* creditsTextPointer;
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

__gshared CollisionType weaponType;

__gshared ushort doorIndex;

__gshared ubyte queenEatingState;

__gshared ubyte nextEarthquakeTimer;

__gshared Song currentRoomSong;

__gshared ubyte itemCollectedCopy;
__gshared ubyte unusedItemOrbYPos;
__gshared ubyte unusedItemOrbXPos;

__gshared ubyte metroidCountShuffleTimer;

__gshared SamusCreditsState creditsSamusAnimState;

__gshared ubyte gameTimeMinutes;
__gshared ubyte gameTimeHours;

__gshared ubyte metroidCountDisplayed;

__gshared ubyte fadeInTimer;

__gshared ubyte creditsRunAnimFrame;
__gshared ubyte creditsRunAnimCounter;

__gshared ubyte justStartedTransition;

__gshared ubyte creditsScrollingDone;

__gshared ubyte debugFlag;

__gshared ushort samusPrevHealth;

__gshared ubyte gameTimeSeconds;

__gshared ubyte activeSaveSlot;
__gshared ubyte titleShowClearOption;

__gshared Song songRequestAfterEarthquake;
__gshared ubyte soundPlayQueenRoar;

__gshared ubyte metroidLCounterDisp;

__gshared ubyte wramUnknownD0A8;

__gshared ubyte[2][0x10] creditsStarArray;
__gshared ubyte[0x40] doorScriptBuffer;


__gshared SaveFileData saveBuf;

struct RespawningBlock {
	ubyte timer;
	ubyte y;
	ubyte x;
	ubyte[14] u;
}
__gshared RespawningBlock[0x10] respawningBlockArray;
__gshared ubyte[0x200] tileTableArray;
__gshared ubyte[0x100] collisionArray;
struct Projectile {
	CollisionType type = CollisionType.nothing;
	ubyte direction;
	ubyte y;
	ubyte x;
	ubyte waveIndex;
	ubyte frameCounter;
	ubyte[0xA] u;
}
__gshared Projectile[3] projectileArray;
struct Bomb {
	ubyte type = 0xFF;
	ubyte timer;
	ubyte y;
	ubyte x;
	ubyte[12] u;
}
__gshared Bomb[3] bombArray;

__gshared ubyte[0xA0] unusedDD60;
__gshared MapUpdateBufferEntry[42] mapUpdateBuffer;

__gshared ubyte inputPressed;
__gshared ubyte inputRisingEdge;
__gshared ubyte vblankDoneFlag;
__gshared ubyte unusedFlag1;
__gshared ubyte oamBufferIndex;
__gshared ubyte frameCounter;
__gshared GameMode gameMode;

__gshared MapUpdate mapUpdate;
__gshared VRAMTransfer vramTransfer;

__gshared Projectile* beamP;
__gshared CollisionType beamType;
__gshared ubyte beamWaveIndex;
__gshared ubyte beamFrameCounter;

__gshared ubyte[5] hudTanks;

__gshared ubyte collisionEnY;
__gshared ubyte collisionEnX;
__gshared Actor collisionEnSprite;
__gshared ubyte collisionEnTop;
__gshared ubyte collisionEnBottom;
__gshared ubyte collisionEnLeft;
__gshared ubyte collisionEnRight;
__gshared ubyte collisionEnIce;
__gshared ubyte collisionEnAttr;

__gshared ushort samusY;
__gshared ushort samusX;

__gshared ubyte spriteYPixel;
__gshared ubyte spriteXPixel;
__gshared ubyte spriteID;
__gshared ubyte spriteAttr;

__gshared ushort cameraY;
__gshared ushort cameraX;

__gshared ubyte mapSourceYPixel;
__gshared ubyte mapSourceYScreen;
__gshared ubyte mapSourceXPixel;
__gshared ubyte mapSourceXScreen;

struct EnemyWorking {
	ubyte status = 0xFF;
	ubyte y = 0xFF;
	ubyte x = 0xFF;
	Actor spriteType = Actor.invalid;
	ubyte baseSpriteAttributes = 0xFF;
	ubyte spriteAttributes = 0xFF;
	deprecated("use spriteAttributes") alias attr = spriteAttributes;
	ubyte stunCounter = 0xFF;
	ubyte misc = 0xFF;
	deprecated("use misc") alias generalVar = misc;
	ubyte directionFlags = 0xFF;
	union {
		struct {
			ubyte counter = 0xFF;
			ubyte state = 0xFF;
		}
		ushort counter16;
	}
	ubyte iceCounter = 0xFF;
	ubyte health = 0xFF;
	ubyte dropType = 0xFF;
	ubyte explosionFlag = 0xFF;
	ubyte spawnFlag = 0xFF;
	ubyte spawnNumber = 0xFF;
	void function() ai;
	ubyte yScreen = 0xFF;
	ubyte xScreen = 0xFF;
	ubyte maxHealth = 0xFF;
}
EnemyWorking enemyWorking;

__gshared ubyte enemyFrameCounter;
__gshared EnemySlot* enemyWRAMAddr;

// Temporary state, but stored in SRAM
__gshared ubyte[0x800] creditsTextBuffer;


__gshared bool variaTransferDone;
