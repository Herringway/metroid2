module metroid2.external;

import metroid2.defs;

import replatform64.gameboy;

GameBoySimple gb;

version(unittest) {
	shared static this() {
		import metroid2.bank00 : vblank;
		import metroid2.bank03 : lcdcInterruptHandler;
		import librehome.backend.common : Backend;
		gb.interruptHandlerSTAT = &lcdcInterruptHandler;
		gb.interruptHandlerVBlank = &vblank;
		gb.initialize(Backend.none);
	}
}

void disableSRAM() {
	gb.disableSRAM();
}
void enableSRAM() {
	gb.enableSRAM();
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
	ubyte[0x40][7] enemySpawnFlags = 0xFF;
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
	return gb.sram!SRAM(0);
}
