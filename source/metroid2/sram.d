module metroid2.sram;

import metroid2.defs;

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
	ubyte samusBeam;
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
__gshared SRAM sram;
