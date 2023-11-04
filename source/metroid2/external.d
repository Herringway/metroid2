module metroid2.external;

__gshared void function() waitNextFrameExternal = () {};
__gshared void function(ubyte) writeJoy = (ubyte) {};
__gshared ubyte function() readJoy = () { return ubyte(0xF); };
alias TilemapFunc = ref ubyte[0x400] function();
private ref ubyte[0x400] defaultTilemapFunc() {
	static ubyte[0x400] buf;
	return buf;
}
__gshared ubyte[] function() vram = () { return cast(ubyte[])[]; };
__gshared TilemapFunc bgTilemap = &defaultTilemapFunc;
__gshared TilemapFunc windowTilemap = &defaultTilemapFunc;
