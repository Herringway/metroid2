module metroid2.external;

import metroid2.sram;

import libgb;

struct GameSettings {}

GameBoySimple!(GameSettings, sram) gb;

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
	gb.disableSRAM();
}
void enableSRAM() {
	gb.enableSRAM();
}

void waitHBlank() {
	//while (STAT & 3) {} // wait for hblank
}
