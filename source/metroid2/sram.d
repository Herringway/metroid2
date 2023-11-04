module metroid2.sram;

struct SRAM {
	ubyte saveLastSlot;
}
__gshared SRAM sram;
