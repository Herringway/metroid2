module sdl.input;

import bindbc.sdl;

__gshared ubyte input;

__gshared bool dpad;
__gshared bool noneSelected;

void writeJoy(ubyte v) {
	dpad = (v & 0x30) == 0x20;
	noneSelected = (v & 0x30) == 0x30;
}

ubyte readJoy() {
	if (noneSelected) {
		return 0xF;
	}
	if (dpad) {
		return ((~input) >> 4) & 0xF;
	}
	return ~input & 0xF;
}

unittest {
	writeJoy(0x30);
	assert(readJoy() == 0xF);
	writeJoy(0x10);
	assert(readJoy() == 0xF);
	input = 0xF0;
	assert(readJoy() == 0);
	writeJoy(0x20);
	assert(readJoy() == 0xF);
}
