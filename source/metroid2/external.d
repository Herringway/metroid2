module metroid2.external;

import metroid2.defs;

import librehome.gameboy;

GameBoySimple gb;

void waitNextFrameExternal() {
	gb.wait();
}
void writeJoy(ubyte v) {
	gb.writeJoy(v);
}
ubyte readJoy() {
	return gb.readJoy();
}

ubyte[] vram() {
	return gb.vram;
}
ref ubyte[0x400] bgTilemap() {
	return gb.getBGTilemap();
}
ref ubyte[0x400] windowTilemap() {
	return gb.getWindowTilemap();
}

void disableSRAM() {
	gb.disableSRAM!SRAM(0x2000);
}
void enableSRAM() {
	gb.enableSRAM!SRAM(0x2000);
}

void waitHBlank() {
	//while (STAT & 3) {} // wait for hblank
}

struct SaveFileData {
	ushort samusY;
	ushort samusX;
	ushort cameraY;
	ushort cameraX;
	ubyte enGfxID;
	ubyte bgGfxID;
	ubyte tiletableID;
	ubyte collisionID;
	ubyte currentLevelBank;
	ubyte samusSolidityIndex;
	ubyte enemySolidityIndex;
	ubyte beamSolidityIndex;
	ubyte samusItems;
	CollisionType samusBeam;
	ubyte samusEnergyTanks;
	ushort samusHealth;
	ushort samusMaxMissiles;
	ushort samusCurMissiles;
	ubyte samusFacingDirection;
	ubyte acidDamageValue;
	ubyte spikeDamageValue;
	ubyte metroidCountReal;
	Song currentRoomSong;
	ubyte gameTimeMinutes;
	ubyte gameTimeHours;
	ubyte metroidCountDisplayed;
	ubyte[0x40][7] enemySpawnFlags;
}
struct SaveFile {
	ubyte[8] magic;
	SaveFileData data;
}
struct SRAM {
	SaveFile[3] saves;
	ubyte saveLastSlot;
}

ref SRAM sram() {
	return gb.sram!SRAM();
}
