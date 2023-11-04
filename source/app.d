import metroid2.bank00;
import metroid2.data;
import metroid2.external;
import sdl.input;

import libgb;
import bindbc.sdl;

import core.thread;
import std.file;
import std.stdio;

Renderer renderer;
void main() {
	SDL_Event event;
	renderer.ppu.vram = new ubyte[](0x10000);
	renderer.init("Metroid II", WindowMode.windowed);

	auto game = new Fiber(&start);

	waitNextFrameExternal = () { Fiber.yield(); };
	metroid2.external.writeJoy = &sdl.input.writeJoy;
	metroid2.external.readJoy = &sdl.input.readJoy;
	vram = () { return renderer.ppu.vram; };
	bgTilemap = &getBGTilemap;
	windowTilemap = &getWindowTilemap;

	const data = cast(ubyte[])read("metroid2.gb");
	loadData(data);

	loop: while (true) {
		while(SDL_PollEvent(&event)) {
			switch (event.type) {
				case SDL_QUIT:
					break loop;
				case SDL_KEYUP:
					if (event.key.keysym.scancode == SDL_SCANCODE_ESCAPE) {
						break loop;
					}
					if (event.key.keysym.scancode == SDL_SCANCODE_P) {
						File("vram.bin", "w").rawWrite(renderer.ppu.vram);
					}
					input &= ~getButtonMask(event.key.keysym.scancode);
					break;
				case SDL_KEYDOWN:
					input |= getButtonMask(event.key.keysym.scancode);
					break;
				default: break;
			}
		}
		game.call(Fiber.Rethrow.yes);
		if (game.state == Fiber.State.TERM) {
			break;
		}
		vblank();
		copyRegisters(renderer.ppu);
		renderer.draw();
	}
}
ref ubyte[0x400] getBGTilemap() @safe {
	return renderer.ppu.vram[0x9800 .. 0x9C00];
}
ref ubyte[0x400] getWindowTilemap() @safe {
	return renderer.ppu.vram[0x9C00 .. 0xA000];
}
ubyte getButtonMask(uint scancode) @safe pure {
	switch (scancode) {
		case SDL_SCANCODE_A: return 1 << 0;
		case SDL_SCANCODE_S: return 1 << 1;
		case SDL_SCANCODE_Q: return 1 << 2;
		case SDL_SCANCODE_W: return 1 << 3;
		case SDL_SCANCODE_RIGHT: return 1 << 4;
		case SDL_SCANCODE_LEFT: return 1 << 5;
		case SDL_SCANCODE_UP: return 1 << 6;
		case SDL_SCANCODE_DOWN: return 1 << 7;
		default: return 0;
	}
}
void copyRegisters(ref PPU ppu) {
	import metroid2.registers;
	ppu.registers.stat = STAT;
	ppu.registers.lcdc = LCDC;
	ppu.registers.scy = SCY;
	ppu.registers.scx = SCX;
	ppu.registers.ly = LY;
	ppu.registers.lyc = LYC;
	ppu.registers.bgp = BGP;
	ppu.registers.obp0 = OBP0;
	ppu.registers.obp1 = OBP1;
	ppu.registers.wy = WY;
	ppu.registers.wx = WX;
}
