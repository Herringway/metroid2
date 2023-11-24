module metroid2.globals;

import librehome.gameboy;

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

__gshared ubyte[0x60] oamScratchpad;
__gshared OAMEntry[16] enSpriteBlobThrower;
__gshared Rectangle hitboxC360;

__gshared ubyte blobThrowerActionTimer;
__gshared ubyte blobThrowerWaitTimer;
__gshared ubyte blobThrowerState;
__gshared ubyte blobThrowerFacingDirection;
__gshared ubyte blobThrowerBlobUnknownVar;

__gshared Actor tempSpriteType;

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
__gshared ubyte enBGCollisionResult;
__gshared ubyte enemySolidityIndex;
struct ScrollHistoryXYPair {
	ubyte y;
	ubyte x;
}
__gshared ScrollHistoryXYPair[3] scrollHistoryA;
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

__gshared ubyte[4] seekSamusTemp;

__gshared ubyte saveLoadSpawnFlagsRequest;

__gshared ubyte scrollEnemiesNumEnemiesLeft;

__gshared ubyte enemyTestPointYPos;
__gshared ubyte enemyTestPointXPos;

__gshared ubyte omegaTempSpriteType;
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
__gshared CollisionType enemyWeaponType;
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

__gshared ubyte[0x80] enemySpawnFlags;
ref ubyte[0x40] enemySpawnFlagsUnsaved() {
	return enemySpawnFlags[0x00 .. 0x40];
}
ref ubyte[0x40] enemySpawnFlagsSaved() {
	return enemySpawnFlags[0x40 .. 0x80];
}

__gshared EnemySlot[16] enemyDataSlots;

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
__gshared NoiseSFX sfxActiveNoise;
__gshared ubyte resumeScrewAttackSoundEffectFlag;
__gshared ubyte[0x60] songProcessingState;
__gshared ubyte songTranspose;
__gshared const(ubyte)[] songInstructionTimerArrayPointer;
__gshared ubyte workingSoundChannel;
__gshared ubyte songChannelEnableSquare1;
__gshared ubyte songChannelEnableSquare2;
__gshared ubyte songChannelEnableWave;
__gshared ubyte songChannelEnableNoise;
__gshared ubyte songOptionsSetFlagWorking;
__gshared const(ubyte)* songWavePatternDataPointer;
alias songSweepWorking = songEnableWorking;
__gshared ubyte songEnableWorking;
__gshared ubyte songSoundLengthWorking;
alias songEnvelopeWorking = songVolumeWorking;
__gshared ubyte songVolumeWorking;
__gshared ushort songFrequencyWorking;
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
//__gshared ubyte songPolynomialCounterWorking;
//__gshared ubyte songCounterControlWorking;
__gshared ubyte songSweepSquare1;
__gshared ubyte songSoundLengthSquare1;
__gshared ubyte songEnvelopeSquare1;
__gshared ushort songFrequencySquare1;

__gshared ubyte songSoundLengthSquare2;
__gshared ubyte songEnvelopeSquare2;
__gshared ushort songFrequencySquare2;

__gshared ubyte songEnableOptionWave;
__gshared ubyte songSoundLengthWave;
__gshared ubyte songVolumeWave;
__gshared ushort songFrequencyWave;

__gshared ubyte songSoundLengthNoise;
__gshared ubyte songEnvelopeNoise;
__gshared ubyte songPolynomialCounterNoise;
__gshared ubyte songCounterControlNoise;

__gshared const(ubyte)* songChannelInstructionPointerSquare1;
__gshared const(ubyte)* songChannelInstructionPointerSquare2;
__gshared const(ubyte)* songChannelInstructionPointerWave;
__gshared const(ubyte)* songChannelInstructionPointerNoise;

__gshared ubyte songSoundChannelEffectTimer;

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
__gshared ChannelSongProcessingState songWorkingState;
__gshared ChannelSongProcessingState songSquare1State;
__gshared ChannelSongProcessingState songSquare2State;
__gshared ChannelSongProcessingState songWaveState;
__gshared ChannelSongProcessingState songNoiseState;

__gshared ubyte songFadeoutTimer;
__gshared ubyte ramCF5D;
__gshared ubyte ramCF5E;
__gshared ubyte ramCF5F;
__gshared ubyte songFrequencyTweakSquare2;

__gshared ubyte[97] songProcessingStateBackup;

__gshared ushort songPlayingBackup;
__gshared ubyte audioPauseControl;
__gshared ubyte audioPauseSoundEffectTimer;
__gshared ubyte songSweepBackupSquare1;
__gshared ubyte sfxVariableFrequencySquare1;
__gshared ushort ramCFE3;
__gshared ubyte sfxRequestLowHealthBeep;
__gshared ubyte sfxRequestWave;
__gshared ubyte sfxPlayingLowHealthBeep;
__gshared ubyte sfxPlayingWave;
__gshared ubyte sfxPlayingBackupLowHealthBeep;
__gshared ubyte sfxTimerWave;
__gshared ubyte sfxLengthWave;
__gshared ubyte ramCFEB;
__gshared ubyte audioChannelOutputStereoFlags;
__gshared ubyte audioChannelOutputStereoFlagsBackup;
__gshared ubyte loudLowHealthBeepTimer;

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
__gshared void* deathAltAnimBase;
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

__gshared CollisionType weaponType;

__gshared ushort doorIndex;

__gshared ubyte queenEatingState;

__gshared ubyte nextEarthquakeTimer;

__gshared Song currentRoomSong;

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

__gshared ushort samusPrevHealth;

__gshared ubyte gameTimeSeconds;

__gshared ubyte activeSaveSlot;
__gshared ubyte titleShowClearOption;

__gshared Song songRequestAfterEarthquake;
__gshared ubyte soundPlayQueenRoar;

__gshared ubyte metroidLCounterDisp;

__gshared ubyte wramUnknownD0A8;

__gshared ubyte[0x20] creditsStarArray;
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
	ubyte directionFlags = 0xFF;
	ubyte counter = 0xFF;
	ubyte state = 0xFF;
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
