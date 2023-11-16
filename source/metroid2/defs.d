module metroid2.defs;

public import librehome.gameboy : Pad;

enum screenWidth = 160;
enum screenHeight = 144;

enum samusJumpArrayBaseOffset = 0x40;
enum samusUnmorphJumpTime = 0x10;

enum ccwTry1 = 0;
enum ccwTry2 = 1;
enum cwTry1 = 2;
enum cwTry2 = 3;

enum metaSpriteEnd = 0xFF;

enum waveBeamSpeed = 2;
enum defaultBeamSpeed = 4;
enum spazerSpeed = 4;
enum plasmaBeamSpeed = 6;

enum ubyte drainsHealth = 0xFE;
enum ubyte solidEnemy = 0xFF;

enum ScrollDirection {
	right = 1 << 4,
	left = 1 << 5,
	up = 1 << 6,
	down = 1 << 7,
}

enum VRAMDest {
	creditsSpriteTiles = 0x8000,

	samus = 0x8000,
	cannon = 0x8080,
	spinTop = 0x8500,
	spinBottom = 0x8600,
	ballTop = 0x8590,
	ballBottom = 0x8690,
	beam = 0x87E0,

	titleTiles = 0x8800,
	enemies = 0x8B00,
	item = 0x8B40,
	itemOrb = 0x8B00,
	itemFont = 0x8C00,
	commonItems = 0x8F00,

	creditsNumbers = 0x8F00,

	theEndTiles = 0x9000,

	bgTiles = 0x9000,
	creditsFont = 0x9200,

	queenFeet = 0x9A00,
	queenStatusBar = 0x9BE0,

	statusBar = 0x9C00,
	itemText = 0x9C20,
}

enum Actor {
	tsumuriRight = 0x00, // Tsumari
	tsumuriLeft = 0x01, // Tsumari
	tsumuri2 = 0x02, // Tsumari
	tsumuri3 = 0x03, // Tsumari
	skreek = 0x04, // Skreek
	skreek2 = 0x05, // Skreek
	skreek3 = 0x06, // Skreek
	skreek4 = 0x07, // Skreek
	skreekSpit = 0x08, // Skreek projectile
	drivel = 0x09, // Drivel
	drivel2 = 0x0A, // Drivel
	drivel3 = 0x0B, // Drivel
	drivelSpit = 0x0C, // Drivel
	drivelSpit2 = 0x0D, // Drivel projectile
	drivelSpit3 = 0x0E, // Drivel projectile
	drivelSpit4 = 0x0F, // Drivel projectile
	drivelSpit5 = 0x10, // Drivel projectile
	drivelSpit6 = 0x11, // Drivel projectile
	smallBug = 0x12, // Small bugs
	smallBug2 = 0x13, // Small bugs
	hornoad = 0x14, // Hornoad
	hornoad2 = 0x15, // Hornoad
	senjoo = 0x16, // Senjoo
	gawron = 0x17, // Gawron
	gawron2 = 0x18, // Gawron
	pipeBug = 0x19, // Pipe bug
	pipeBug2 = 0x1A, // Pipe bug
	chuteLeech = 0x1B, // Chute leech
	chuteLeech2 = 0x1C, // Chute leech
	chuteLeech3 = 0x1D, // Chute leech
	autrackFlipped = 0x1E, // (uses same spritemap as 41h autrack)
	wallfireFlipped = 0x1F, // (uses same spritemap as 4Ah wallfire)
	needlerRight = 0x20, // Needler (facing right)
	needlerLeft = 0x21, // Needler (facing left)
	needler3 = 0x22, // Needler
	needler4 = 0x23, // Needler
	actor24 = 0x24, // Unknown (0x24)
	actor25 = 0x25, // Unknown (0x25)
	actor26 = 0x26, // Unknown (0x26)
	actor27 = 0x27, // Unknown (0x27)
	skorpUp = 0x28, // Skorp (facing up)
	skorpDown = 0x29, // Skorp (facing down)
	skorpRight = 0x2A, // Skorp (facing right)
	skorpLeft = 0x2B, // Skorp (facing left)
	glowflyIdle1 = 0x2C, // Glow fly
	glowflyIdle2 = 0x2D, // Glow fly
	glowflyWindup = 0x2E, // Glow fly
	glowflyMoving = 0x2F, // Glow fly
	moheekRight = 0x30, // Moheek (facing right)
	moheekLeft = 0x31, // Moheek (facing left)
	rockIcicleIdle1 = 0x34, // Rock icicle
	rockIcicleIdle2 = 0x35, // Rock icicle
	rockIcicleMoving1 = 0x36, // Rock icicle
	rockIcicleMoving2 = 0x37, // Rock icicle
	yumee1 = 0x38, // Yumee
	yumee2 = 0x39, // Yumee
	yumee3 = 0x3A, // Yumee
	yumeeSpawner = 0x3C, // Yumee spawner?
	yumeeSpawner2 = 0x3D, // Yumee spawner?
	octroll1 = 0x3E, // Octroll
	octroll = 0x40, // Octroll
	autrack = 0x41, // Autrack
	autrack3 = 0x43, // Autrack
	autrack4 = 0x44, // Autrack
	autrackLaser = 0x45, // Autrack projectile
	autoad = 0x46, // Autoad
	autoad2 = 0x47, // Autoad
	wallfire = 0x4A, // Wallfire
	wallfire2 = 0x4B, // Wallfire
	wallfireDead = 0x4C, // Wallfire
	wallfireShot1 = 0x4D, // Wallfire projectile
	wallfireShot3 = 0x4F, // Wallfire projectile
	wallfireShot4 = 0x50, // Wallfire projectile
	gunzoo = 0x51, // Gunzoo
	gunzoo3 = 0x53, // Gunzoo
	gunzooDiagshot1 = 0x54, // Gunzoo diagonal projectile
	gunzooDiagshot2 = 0x55, // Gunzoo diagonal projectile
	gunzooDiagshot3 = 0x56, // Gunzoo diagonal projectile
	gunzooHShot1 = 0x57, // Gunzoo horizontal projectile
	gunzooHShot3 = 0x59, // Gunzoo horizontal projectile
	gunzooHShot5 = 0x5B, // Gunzoo horizontal projectile
	autom = 0x5C, // Autom
	autom2 = 0x5D, // Autom
	automShot1 = 0x5E, // Autom projectile
	automShot3 = 0x60, // Autom projectile
	shirk = 0x63, // Shirk
	shirk2 = 0x64, // Shirk
	septogg = 0x65, // Septogg
	moto = 0x68, // Moto
	halzyn = 0x6A, // Halzyn
	ramulken = 0x6B, // Ramulken
	metroidStinger = 0x6D, // Metroid music sting trigger
	proboscumFlipped = 0x6E, // (uses same spritemap as 72h proboscum)
	proboscum1 = 0x72, // Proboscum
	proboscum2 = 0x73, // Proboscum
	proboscum3 = 0x74, // Proboscum
	missileBlock = 0x75, // Missile block
	arachnusRoll1 = 0x76, // Arachnus
	arachnusUpright1 = 0x78, // Arachnus
	arachnusUpright2 = 0x79, // Arachnus
	arachnusUpright3 = 0x7A, // Arachnus
	arachnusFireball1 = 0x7B, // Arachnus projectile
	arachnusFireball2 = 0x7C, // Arachnus projectile
	plasmaBeamOrb = 0x80, // Plasma beam
	plasmaBeam = 0x81, // Plasma beam (orbless)
	itemBaseID = 0x81, // Plasma beam
	iceBeamOrb = 0x82, //  bent neck of Queen’s vomiting pose!?
	queenBentNeck = 0x82, //  bent neck of Queen’s vomiting pose!?
	iceBeam = 0x83, // Ice beam orb
	waveBeamOrb = 0x84, //  Wave beam
	waveBeam = 0x85, // Wave beam (orbless)
	spazerOrb = 0x86, //  Spazer
	spazer = 0x87, // Spazer (orbless)
	bombsOrb = 0x88, //  Bombs
	bombs = 0x89, // Bombs (orbless)
	screwAttackOrb = 0x8A, //  Screw Attack
	screwAttack = 0x8B, // Screw Attack (orbless)
	variaSuitOrb = 0x8C, // Hi jump boots orb
	variaSuit = 0x8D, // Hi jump boots (orbless)
	hiJumpBootsOrb = 0x8E, // Hi jump boots orb
	hiJumpBoots = 0x8F, // Hi jump boots (orbless)
	spaceJumpOrb = 0x90, // Space jump
	spaceJump = 0x91, // Space jump (orbless)
	spiderBallOrb = 0x92, // Spider ball
	spiderBall = 0x93, // Spider ball (orbless)
	springBallOrb = 0x94, // Spring ball
	springBall = 0x95, // Spring ball (orbless)
	energyTankOrb = 0x96, // Energy tank
	energyTank = 0x97, // Energy tank (orbless)
	missileTankOrb = 0x98, // Missile tank
	missileTank = 0x99, // Missile tank (orbless)
	blobThrower = 0x9A, // Blob thrower
	energyRefill = 0x9B, // Energy refill
	arachnusOrb = 0x9C, // Arachnus (Orb)
	missileRefill = 0x9D, // Missile refill
	blob1 = 0x9E, // Blob thrower projectile
	blob2 = 0x9F, // Blob thrower projectile
	metroid1 = 0xA0, // Metroid
	alphaFace = 0xA1, // Metroid hatching
	alpha1 = 0xA3, // Alpha metroid
	alphaMetroid = 0xA4, // Alpha metroid
	egg1 = 0xA5, // Baby metroid egg
	egg2 = 0xA6, // Baby metroid egg
	egg3 = 0xA7, // Baby metroid egg
	baby1 = 0xA8, // Baby metroid
	zetaMetroid = 0xAD, // Gamma metroid
	gammaBolt1 = 0xAE, // Gamma metroid projectile
	gammaBolt2 = 0xAF, // Gamma metroid projectile
	gamma2 = 0xB0, // Gamma metroid
	gammaHusk = 0xB2, // Gamma metroid shell
	zeta1 = 0xB3, // Zeta metroid hatching
	zeta4 = 0xB6, // Zeta metroid
	zeta5 = 0xB7, // Zeta metroid
	zeta6 = 0xB8, // Zeta metroid
	zeta8 = 0xBA, // Zeta metroid
	zetaB = 0xBD, // Zeta metroid
	zetaShot = 0xBE, // Zeta metroid projectile
	omega1 = 0xBF, // Omega metroid
	omega2 = 0xC0, // Omega metroid
	omega3 = 0xC1, // Omega metroid
	omega5 = 0xC3, // Omega metroid
	omegaShot1 = 0xC6, // Omega metroid projectile
	omegaShot3 = 0xC8, // Omega metroid projectile
	omegaShot7 = 0xCC, // Omega metroid projectile
	metroid = 0xCE, // Metroid
	metroid3 = 0xCF, // Metroid (hurt)
	flittVanishing = 0xD0, // Flitt
	flittMoving = 0xD1, // Flitt
	gravitt = 0xD3, // Gravitt
	gravitt5 = 0xD7, // Gravitt
	gullugg = 0xD8, // Gullugg
	gullugg3 = 0xDA, // Gullugg
	babyMetroidEggPreview = 0xDB, // Baby metroid egg (preview)
	smallHealth = 0xE0, // Small health drop
	screwExplosionStart = 0xE2, // Metroid death / missile door / screw attack explosion
	screwExplosionEnd = 0xE7, // Metroid death / missile door / screw attack explosion
	normalExplosionStart = 0xE8, // Enemy death explosion
	normalExplosionEnd = 0xEA, // Enemy death explosion
	bigHealth = 0xEC, // Big energy drop
	missileDrop = 0xEE, // Missile drop
	queenNeck = 0xF0, // Metroid Queen neck (no graphics)
	queenHeadLeft = 0xF1, // Metroid Queen head left half (no graphics)
	queenHeadRight = 0xF2, // Metroid Queen projectile/head right half (no graphics)
	queenProjectile = 0xF2, // Metroid Queen projectile/head right half (no graphics)
	queenBody = 0xF3, // Metroid Queen body (no graphics)
	queenMouthClosed = 0xF5, // Metroid Queen mouth closed (no graphics)
	queenMouthOpen = 0xF6, // Metroid Queen mouth open (no graphics)
	queenMouthStunned = 0xF7, // Metroid Queen mouth stunned (no graphics)
	missileDoor = 0xF8, // Missile door
	flittInvisible = 0xFD, // Nothing - flitt (no graphics)
	invalid = 0xFF, // No enemy
}

enum BlockType {
	water = 1 << 0,
	up = 1 << 1,
	down = 1 << 2,
	spike = 1 << 3,
	acid = 1 << 4,
	shot = 1 << 5,
	bomb = 1 << 6,
	save = 1 << 7,
}

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
	clear = 0xFF,
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
	invalid = 0xFF,
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
	noIntroStart = title,
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
	invalid = 0xFF,
}

enum Song2 {
	nothing = 0,
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

enum CollisionSet {
	plantBubbles = 0,
	ruinsInside = 1,
	queen = 2,
	caveFirst = 3,
	surface = 4,
	lavaCaves = 5,
	ruinsExt = 6,
	finalLab = 7,
}

enum MetatileSet {
	finalLab = 0,
	ruinsInside = 1,
	plantBubbles = 2,
	queen = 3,
	caveFirst = 4,
	surface = 5,
	lavaCavesEmpty = 6,
	lavaCavesFull = 7,
	lavaCavesMid = 8,
	ruinsExt = 9,
}

enum BGTileSet {
	caveFirst = 0,
	finalLab = 1,
	lavaCavesA = 2,
	lavaCavesB = 3,
	lavaCavesC = 4,
	plantBubbles = 5,
	queenBG = 6,
	ruinsExt = 7,
	ruinsInside = 8,
	surfaceBG = 9,
}
enum EnemyTileSet {
	arachnus = 0,
	enemiesA = 1,
	enemiesB = 2,
	enemiesC = 3,
	enemiesD = 4,
	enemiesE = 5,
	enemiesF = 6,
	metAlpha = 7,
	metGamma = 8,
	metOmega = 9,
	metZeta = 10,
	surfaceSPR = 11,
}

enum BombType {
	bomb = 1,
	explosion = 2,
	invalid = 0xFF,
}

alias DoorDirection = BeamDirection;
enum BeamDirection {
	right = 1 << 0,
	left = 1 << 1,
	up = 1 << 2,
	down = 1 << 3,
}

enum DoorCommand : ubyte {
	copyData = 0x00,
	copyBG = 0x01,
	copySpr = 0x02,
	tileTable = 0x10,
	collision = 0x20,
	solidity = 0x30,
	warp = 0x40,
	escapeQueen = 0x50,
	damage = 0x60,
	exitQueen = 0x70,
	enterQueen = 0x80,
	ifMetLess = 0x90,
	fadeout = 0xA0,
	loadData = 0xB0,
	loadBG = 0xB1,
	loadSpr = 0xB2,
	song = 0xC0,
	item = 0xD0,
	end = 0xFF,
}

enum SpecialDoorCopySrc {
	queenSpr,
	commonItems,
	queenHeadRow1,
	queenHeadRow2,
	queenHeadRow3,
	queenHeadRow4,
}

enum SpecialDoorCopyDest {
	enemySpr,
	commonItems,
	screen1,
	screen1r2,
	screen1r3,
	screen1r4,
}

enum CollisionType {
	powerBeam = 0,
	iceBeam = 1,
	waveBeam = 2,
	spazer = 3,
	plasmaBeam = 4,
	unk5 = 5,
	unk6 = 6,
	bombs = 7,
	missiles = 8,
	bombExplosion = 9,
	screwAttack = 16,
	contact = 32,
	nothing = 255,
}

enum ItemID {
	plasmaBeam = 0,
	iceBeam = 1,
	waveBeam = 2,
	spazer = 3,
	bombs = 4,
	screwAttack = 5,
	variaSuit = 6,
	hiJumpBoots = 7,
	spaceJump = 8,
	spiderBall = 9,
	springBall = 10,
	energyTank = 11,
	missileTank = 12,
	energyRefill = 13,
	missileRefill = 14,
}

struct EnemySlot {
	align(1):
	ubyte status;
	ubyte y;
	ubyte x;
	Actor spriteType;
	ubyte baseSpriteAttributes;
	ubyte spriteAttributes;
	ubyte stunCounter;
	ubyte misc;
	ubyte directionFlags;
	ubyte counter;
	ubyte state;
	ubyte iceCounter;
	ubyte health;
	ubyte dropType;
	ubyte explosionFlag;
	ubyte yScreen;
	ubyte xScreen;
	ubyte maxHealth;
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
	ubyte spawnFlag;
	ubyte spawnNumber;
	void function() ai;
}

struct MapUpdate {
	ushort destAddr;
	ubyte srcScreen;
	ubyte srcBlock;
	ubyte size;
	MapUpdateBufferEntry* buffer;
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
struct MapUpdateBufferEntry {
	ushort dest;
	ubyte topLeft;
	ubyte topRight;
	ubyte bottomLeft;
	ubyte bottomRight;
}

struct Rectangle {
	byte top;
	byte bottom;
	byte left;
	byte right;
}

struct EnemySpawn {
	ubyte spawnNumber;
	Actor id;
	ubyte x;
	ubyte y;
	void toString(W)(ref W writer) const {
		import std.format : formattedWrite;
		writer.formattedWrite!"%s (at (%s,%s), flag %02X)"(id, x, y, spawnNumber);
	}
}

struct EnemyData {
	ubyte baseSpriteAttributes;
	ubyte spriteAttributes;
	ubyte stunCounter;
	ubyte misc;
	ubyte directionFlags;
	ubyte counter;
	ubyte state;
	ubyte iceCounter;
	ubyte health;
	void function() ai;
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

ubyte[] translateCreditsText(string input) {
	ubyte[] result;
	result.reserve(input.length + 1);
	foreach (char c; input) {
		switch (c) {
			case '\n': result ~= 0xF1; break;
			case '-': result ~= 0x5E; break;
			case ':': result ~= 0x1B; break;
			default: result ~= c;
		}
	}
	result ~= 0xF0; //terminator
	return result;
}

ubyte[] fixItemName(string input) {
	ubyte[] result;
	result.reserve(input.length + 1);
	foreach (char c; input) {
		switch (c) {
			case 'A': .. case 'Z': result ~= cast(ubyte)((c - 'A') + 0xC0); break;
			case ' ': result ~= 0xFF; break;
			case '<': result ~= 0xDE; break;
			case '>': result ~= 0xDF; break;
			default: assert(0, "Unknown character");
		}
	}
	return result;
}

ubyte* screen0() {
	import metroid2.external : vram;
	return &(vram()[0x9800]);
}

ubyte* screen1() {
	import metroid2.external : vram;
	return &(vram()[0x9C00]);
}

const(ubyte)* enGfx(ubyte id) {
	import metroid2.data;
	switch (id) {
		case EnemyTileSet.arachnus: return &graphicsArachnus[0];
		case EnemyTileSet.enemiesA: return &graphicsEnemiesA[0];
		case EnemyTileSet.enemiesB: return &graphicsEnemiesB[0];
		case EnemyTileSet.enemiesC: return &graphicsEnemiesC[0];
		case EnemyTileSet.enemiesD: return &graphicsEnemiesD[0];
		case EnemyTileSet.enemiesE: return &graphicsEnemiesE[0];
		case EnemyTileSet.enemiesF: return &graphicsEnemiesF[0];
		case EnemyTileSet.metAlpha: return &graphicsMetAlpha[0];
		case EnemyTileSet.metGamma: return &graphicsMetGamma[0];
		case EnemyTileSet.metOmega: return &graphicsMetOmega[0];
		case EnemyTileSet.metZeta: return &graphicsMetZeta[0];
		case EnemyTileSet.surfaceSPR: return &graphicsSurfaceSPR[0];
		default: return null;
	}
}
const(ubyte)* bgGfx(ubyte id) {
	import metroid2.data;
	switch (id) {
		case BGTileSet.caveFirst: return &graphicsCaveFirst[0];
		case BGTileSet.finalLab: return &graphicsFinalLab[0];
		case BGTileSet.lavaCavesA: return &graphicsLavaCavesA[0];
		case BGTileSet.lavaCavesB: return &graphicsLavaCavesB[0];
		case BGTileSet.lavaCavesC: return &graphicsLavaCavesC[0];
		case BGTileSet.plantBubbles: return &graphicsPlantBubbles[0];
		case BGTileSet.queenBG: return &graphicsQueenBG[0];
		case BGTileSet.ruinsExt: return &graphicsRuinsExt[0];
		case BGTileSet.ruinsInside: return &graphicsRuinsInside[0];
		case BGTileSet.surfaceBG: return &graphicsSurfaceBG[0];
		default: return null;
	}
}

ubyte pixel(ushort val) @safe pure {
	return val & 0xFF;
}
ubyte screen(ushort val) @safe pure {
	return (val >> 8) & 0xFF;
}
