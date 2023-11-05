module metroid2.defs;

enum samusJumpArrayBaseOffset = 0x40;
enum samusUnmorphJumpTime = 0x10;

enum ccwTry1 = 0;
enum ccwTry2 = 1;
enum cwTry1 = 2;
enum cwTry2 = 3;

enum ItemFlag {
	bomb = 1 << 0,
	hiJump = 1 << 1,
	screwAttack = 1 << 2,
	spaceJump = 1 << 3,
	springBall = 1 << 4,
	spiderBall = 1 << 5,
	variaSuit = 1 << 6,
	unused = 1 << 7,
}

enum Pad : ubyte {
	a = 1 << 0,
	b = 1 << 1,
	select = 1 << 2,
	start = 1 << 3,
	right = 1 << 4,
	left = 1 << 5,
	up = 1 << 6,
	down = 1 << 7,
}

enum GameMode : ubyte {
	boot = 0,
	title = 1,
	loadA = 2,
	loadB = 3,
	main = 4,
	dead = 5,
	dying = 6,
	gameOver = 7,
	paused = 8,
	saveGame = 9,
	unusedA = 10,
	newGame = 11,
	loadSave = 12,
	none = 13,
	none2 = 14,
	unusedB = 15,
	unusedC = 16,
	unusedD = 17,
	prepareCredits = 18,
	credits = 19,
}

enum Square1SFX {
	nothing = 0x0,
	jumping = 0x1,
	hiJumping = 0x2,
	screwAttacking = 0x3,
	standingTransition = 0x4,
	crouchingTransition = 0x5,
	morphingTransition = 0x6,
	shootingBeam = 0x7,
	shootingMissile = 0x8,
	shootingIceBeam = 0x9,
	shootingPlasmaBeam = 0xA,
	shootingSpazerBeam = 0xB,
	pickedUpMissileDrop = 0xC,
	spiderBall = 0xD,
	pickedUpSmallEnergyDrop = 0xE,
	beamDink = 0xF,
	u10 = 0x10,
	u11 = 0x11,
	u12 = 0x12,
	bombLaid = 0x13,
	u14 = 0x14,
	select = 0x15,
	shootingWaveBeam = 0x16,
	pickedUpLargeEnergyDrop = 0x17,
	samusHealthChange = 0x18,
	noMissileDudShot = 0x19,
	u1A = 0x1A,
	metroidCry = 0x1B,
	saved = 0x1C,
	variaSuitTransformation = 0x1D,
	unpaused = 0x1E,
	u2D = 0x2D,
}

enum Square2SFX {
	nothing0 = 0,
	nothing1 = 1,
	nothing2 = 2,
	metroidQueenCry = 3,
	babyMetroidClearingBlock = 4,
	babyMetroidCry = 5,
	metroidQueenHurtCry = 6,
	u7 = 7,
}

enum NoiseSFX {
	u00 = 0x00,
	u01 = 0x01,
	u02 = 0x02,
	u03 = 0x03,
	u04 = 0x04,
	u05 = 0x05,
	u06 = 0x06,
	u07 = 0x07,
	u08 = 0x08,
	u09 = 0x09,
	u0A = 0x0A,
	u0B = 0x0B,
	u0C = 0x0C,
	u0D = 0x0D,
	u0E = 0x0E,
	u0F = 0x0F,
	u10 = 0x10,
	u11 = 0x11,
	u12 = 0x12,
	u13 = 0x13,
	u14 = 0x14,
	u15 = 0x15,
	u16 = 0x16,
	u17 = 0x17,
	u18 = 0x18,
	u19 = 0x19,
	u1A = 0x1A,
	uFF = 0xFF,
}

enum Song {
	nothing = 0x00,
	babyMetroid = 0x01,
	metroidQueenBattle = 0x02,
	chozoRuins = 0x03,
	mainCaves = 0x04,
	subCaves1 = 0x05,
	subCaves2 = 0x06,
	subCaves3 = 0x07,
	finalCaves = 0x08,
	metroidHive = 0x09,
	itemGet = 0x0A,
	metroidQueenHallway = 0x0B,
	metroidBattle = 0x0C,
	subCaves4 = 0x0D,
	earthquake = 0x0E,
	killedMetroid = 0x0F,
	nothingCopy = 0x10,
	title = 0x11,
	samusFanfare = 0x12,
	reachedTheGunship = 0x13,
	chozoRuinsCopy = 0x14,
	mainCavesNoIntro = 0x15,
	subCaves1NoIntro = 0x16,
	subCaves2NoIntro = 0x17,
	subCaves3NoIntro = 0x18,
	finalCavesCopy = 0x19,
	metroidHiveCopy = 0x1A,
	itemGetCopy = 0x1B,
	metroidQueenHallwayCopy = 0x1C,
	metroidBattleCopy = 0x1D,
	subCaves4NoIntro = 0x1E,
	metroidHiveWithIntro = 0x1F,
	missilePickup = 0x20,
}

enum Song2 {
	itemGet = 1,
	endPlaying = 2,
	endRequest = 3,
	missilePickup = 5,
	fadeOut = 8,
	earthquake = Song.earthquake,
	clear = 0xFF,
}

enum SamusPose {
	standing = 0x00, //pose_standing
	jumping = 0x01, //pose_jump
	spinJumping = 0x02, //pose_spinJump
	running = 0x03, //pose_run
	crouching = 0x04, //pose_crouch
	morphBall = 0x05, //pose_morph
	morphBallJumping = 0x06, //pose_morphJump
	falling = 0x07, //pose_fall
	morphBallFalling = 0x08, //pose_morphFall
	startingToJump = 0x09, //pose_nJumpStart
	startingToSpinJump = 0x0A, //pose_spinStart
	spiderBallRolling = 0x0B, //pose_spiderRoll
	spiderBallFalling = 0x0C, //pose_spiderFall
	spiderBallJumping = 0x0D, //pose_spiderJump
	spiderBall = 0x0E, //pose_spider
	knockBack = 0x0F, //pose_hurt
	morphBallKnockBack = 0x10, //pose_morphHurt
	standingBombed = 0x11, //pose_bombed
	morphBallBombed = 0x12, //pose_morphBombed
	facingScreen = 0x13, //pose_faceScreen
	facingScreen2 = 0x14, //pose_unusedA
	facingScreen3 = 0x15, //pose_unusedB
	facingScreen4 = 0x16, //pose_unusedC
	facingScreen5 = 0x17, //pose_unusedD
	eatenByMetroidQueen = 0x18, //pose_beingEaten
	inMetroidQueenMouth = 0x19, //pose_inMouth
	swallowedByMetroidQueen = 0x1A, //pose_toStomach
	inMetroidQueenStomach = 0x1B, //pose_inStomach
	escapingMetroidQueen = 0x1C, //pose_outStomach
	escapedMetroidQueen = 0x1D, //pose_exitQueen
}

struct EnemySlot {
	align(1):
	ubyte u0;
	ubyte u1;
	ubyte u2;
	ubyte u3;
	ubyte[13] u4;
	ubyte u11;
	ubyte u12;
	ubyte u13;
	ubyte u14;
	ubyte u15;
	ubyte u16;
	ubyte u17;
	ubyte u18;
	ubyte u19;
	ubyte u1A;
	ubyte u1B;
	ubyte u1C;
	ubyte u1D;
	const(void)* u1E;
}

struct MapUpdate {
	ushort destAddr;
	ubyte srcScreen;
	ubyte srcBlock;
	ubyte size;
	void* buffer;
}
struct VRAMTransfer {
	const(void)* src;
	void* dest;
	ushort size;
}

struct GraphicsInfo {
	const(ubyte)[] data;
	ushort destination;
	ushort length;
}

ubyte rr(ubyte value) @safe pure {
	const bit = value & 1;
	value >>= 1;
	value |= (bit << 7);
	return value;
}
ubyte rl(ubyte value) @safe pure {
	const bit = !!(value & 0x80);
	value <<= 1;
	value |= bit;
	return value;
}
ubyte swap(ubyte value) @safe pure {
	return cast(ubyte)((value >> 4) | (value << 4));
}