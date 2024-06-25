module metroid2.data;

import metroid2.audiodata;
import metroid2.external;
import replatform64.backend.common;
import replatform64.assets;
import replatform64.planet;
import std.algorithm.searching;
import std.concurrency;
import std.conv;
import std.format;

void loadExtraData(scope const char[] name, const scope ubyte[] data, scope PlatformBackend) {
	switch(name.findSplit("/")[0]) {
		case "song":
			songDataTable ~= readSongFile(data);
			break;
		default:
			break;
	}
}
SongHeader readSongFile(const(ubyte)[] data) @safe pure {
	SongHeader song;
	song.noteOffset = data[0];
	data = data[1 .. $];
	readArray(data, song.tempo);
	readArray(data, song.toneSweepChannel);
	readArray(data, song.toneChannel);
	readArray(data, song.waveChannel);
	readArray(data, song.noiseChannel);
	readArrays(data, song.squareTracks);
	readArrays(data, song.waveTracks);
	readArrays(data, song.noiseTracks);
	return song;
}
void readArray(T)(ref const(ubyte)[] src, ref T[] dest) {
	const length = (cast(const(uint)[])(src[0 .. uint.sizeof]))[0];
	scope(exit) {
		src = src[uint.sizeof + length * T.sizeof .. $];
	}
	dest = cast(T[])(src[uint.sizeof .. uint.sizeof + length * T.sizeof]);
}
void readArrays(K, V)(ref const(ubyte)[] src, ref V[K] dest) {
	const length = (cast(const(uint)[])(src[0 .. uint.sizeof]))[0];
	src = src[uint.sizeof .. $];
	foreach (i; 0 .. length) {
		K key = (cast(const(K)[])(src[0 .. K.sizeof]))[0];
		src = src[K.sizeof .. $];
		V array;
		readArray(src, array);
		dest[key] = array;
	}
}
void writeArray(T)(ref ubyte[] dest, const T[] array) {
	uint[1] tmp = [cast(uint)array.length];
	dest ~= cast(ubyte[])(tmp[]);
	dest ~= cast(const(ubyte)[])array;
}
void writeArrays(K, V)(ref ubyte[] dest, const V[K] arrays) {
	uint[1] tmp = [cast(uint)arrays.length];
	dest ~= cast(ubyte[])(tmp[]);
	foreach (key, array; arrays) {
		K[1] tmp2 = [key];
		dest ~= cast(ubyte[])(tmp2[]);
		writeArray(dest, array);
	}
}
void extractExtraAssets(scope AddFileFunction addFile, scope ProgressUpdateFunction reportProgress, immutable(ubyte)[] rom) {
	enum entries = 32;
	foreach (songIdx, base; cast(const(ushort)[])(rom[0x11F30 .. 0x11F30 + entries * 2])) {
		SongHeader song;
		decompileSong(song, rom, base);
		ubyte[] songFile;
		songFile ~= song.noteOffset;
		writeArray(songFile, song.tempo);
		writeArray(songFile, song.toneSweepChannel);
		writeArray(songFile, song.toneChannel);
		writeArray(songFile, song.waveChannel);
		writeArray(songFile, song.noiseChannel);
		writeArrays(songFile, song.squareTracks);
		writeArrays(songFile, song.waveTracks);
		writeArrays(songFile, song.noiseTracks);
		debug(verifyextraction) assert(readSongFile(songFile) == song);
		addFile(format!"song/%s.m2song"(songIdx), songFile);
	}
}

@ROMSource(0x015F34, 0xA00)
@Asset("graphics/titlescreen.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsTitleScreen;
@ROMSource(0x016934, 0x300)
@Asset("graphics/credits/font.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsCreditsFont;
@ROMSource(0x016C34, 0x200)
@Asset("graphics/itemFont.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsItemFont;
@ROMSource(0x016E34, 0x100)
@Asset("graphics/credits/numbers.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsCreditsNumbers;
@ROMSource(0x016F34, 0xF00)
@Asset("graphics/credits/spr.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsCreditsSprTiles;
@ROMSource(0x017E34, 0x100)
@Asset("graphics/theEnd.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsTheEnd;

@ROMSource(0x018000, 0x20)
@Asset("graphics/cannon/beam.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsCannonBeam;
@ROMSource(0x018020, 0x20)
@Asset("graphics/cannon/missile.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsCannonMissile;
@ROMSource(0x018040, 0x20)
@Asset("graphics/beam/ice.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsBeamIce;
@ROMSource(0x018060, 0x20)
@Asset("graphics/beam/wave.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsBeamWave;
@ROMSource(0x018080, 0x20)
@Asset("graphics/beam/spazerPlasma.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsBeamSpazerPlasma;
@ROMSource(0x0180A0, 0x70)
@Asset("graphics/spin/spaceTop.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpinSpaceTop;
@ROMSource(0x018110, 0x50)
@Asset("graphics/spin/spaceBottom.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpinSpaceBottom;
@ROMSource(0x018160, 0x70)
@Asset("graphics/spin/screwTop.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpinScrewTop;
@ROMSource(0x0181D0, 0x50)
@Asset("graphics/spin/screwBottom.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpinScrewBottom;
@ROMSource(0x018220, 0x70)
@Asset("graphics/spin/spaceScrewTop.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpinSpaceScrewTop;
@ROMSource(0x018290, 0x50)
@Asset("graphics/spin/spaceScrewBottom.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpinSpaceScrewBottom;
@ROMSource(0x0182E0, 0x20)
@Asset("graphics/springballTop.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpringBallTop;
@ROMSource(0x018300, 0x20)
@Asset("graphics/springballBottom.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSpringBallBottom;
@ROMSource(0x018320, 0xB00)
@Asset("graphics/samus/powerSuit.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSamusPowerSuit;
@ROMSource(0x018E20, 0xB00)
@Asset("graphics/samus/variaSuit.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSamusVariaSuit;
@ROMSource(0x019920, 0x400)
@Asset("graphics/enemies/01.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsEnemiesA;
@ROMSource(0x019D20, 0x400)
@Asset("graphics/enemies/02.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsEnemiesB;
@ROMSource(0x01A120, 0x400)
@Asset("graphics/enemies/03.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsEnemiesC;
@ROMSource(0x01A520, 0x400)
@Asset("graphics/enemies/04.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsEnemiesD;
@ROMSource(0x01A920, 0x400)
@Asset("graphics/enemies/05.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsEnemiesE;
@ROMSource(0x01AD20, 0x400)
@Asset("graphics/enemies/06.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsEnemiesF;
@ROMSource(0x01B120, 0x400)
@Asset("graphics/enemies/arachnus.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsArachnus;
@ROMSource(0x01B520, 0x400)
@Asset("graphics/enemies/surface.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSurfaceSPR;
@ROMSource(0x01C000, 0x800)
@Asset("graphics/bg/plantBubbles.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsPlantBubbles;
@ROMSource(0x01C800, 0x800)
@Asset("graphics/bg/ruinsInside.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsRuinsInside;
@ROMSource(0x01D000, 0x800)
@Asset("graphics/bg/queen.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsQueenBG;
@ROMSource(0x01D800, 0x800)
@Asset("graphics/bg/caveFirst.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsCaveFirst;
@ROMSource(0x01E000, 0x800)
@Asset("graphics/bg/surface.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsSurfaceBG;
@ROMSource(0x01E800, 0x530)
@Asset("graphics/bg/lavaCavesA.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsLavaCavesA;
@ROMSource(0x01ED30, 0x530)
@Asset("graphics/bg/lavaCavesB.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsLavaCavesB;
@ROMSource(0x01F260, 0x530)
@Asset("graphics/bg/lavaCavesC.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsLavaCavesC;
@ROMSource(0x01F790, 0x40 * 16)
@Asset("graphics/items.png", DataType.bpp2Intertwined)
immutable(ubyte[0x40])[] graphicsItems;
@ROMSource(0x020000, 0x80)
@Asset("graphics/bg/queen.png", DataType.bpp2Intertwined)
const(ubyte)[] bgQueenHead;
@ROMSource(0x0219BC, 0x400)
@Asset("graphics/enemies/metroidAlpha.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsMetAlpha;
@ROMSource(0x021DBC, 0x400)
@Asset("graphics/enemies/metroidGamma.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsMetGamma;
@ROMSource(0x0221BC, 0x400)
@Asset("graphics/enemies/metroidZeta.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsMetZeta;
@ROMSource(0x0225BC, 0x400)
@Asset("graphics/enemies/metroidOmega.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsMetOmega;
@ROMSource(0x0229BC, 0x800)
@Asset("graphics/bg/ruinsExternal.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsRuinsExt;
@ROMSource(0x0231BC, 0x800)
@Asset("graphics/bg/finalLab.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsFinalLab;
@ROMSource(0x0239BC, 0x800)
@Asset("graphics/enemies/metroidQueen.png", DataType.bpp2Intertwined)
const(ubyte)[] graphicsQueenSPR;
