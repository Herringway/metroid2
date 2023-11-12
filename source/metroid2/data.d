module metroid2.data;

void loadData(const ubyte[] sourceData) {
	loadDatum(graphicsTitleScreen, sourceData, 0x015F34, 0xA00);
	loadDatum(graphicsCreditsFont, sourceData, 0x016934, 0x300);
	loadDatum(graphicsItemFont, sourceData, 0x016C34, 0x200);
	loadDatum(graphicsCreditsNumbers, sourceData, 0x016E34, 0x100);
	loadDatum(graphicsCreditsSprTiles, sourceData, 0x016F34, 0xF00);
	loadDatum(graphicsTheEnd, sourceData, 0x017E34, 0x100);

	loadDatum(graphicsCannonBeam, sourceData, 0x018000, 0x20);
	loadDatum(graphicsCannonMissile, sourceData, 0x018020, 0x20);
	loadDatum(graphicsBeamIce, sourceData, 0x018040, 0x20);
	loadDatum(graphicsBeamWave, sourceData, 0x018060, 0x20);
	loadDatum(graphicsBeamSpazerPlasma, sourceData, 0x018080, 0x20);
	loadDatum(graphicsSpinSpaceTop, sourceData, 0x0180A0, 0x70);
	loadDatum(graphicsSpinSpaceBottom, sourceData, 0x018110, 0x50);
	loadDatum(graphicsSpinScrewTop, sourceData, 0x018160, 0x70);
	loadDatum(graphicsSpinScrewBottom, sourceData, 0x0181D0, 0x50);
	loadDatum(graphicsSpinSpaceScrewTop, sourceData, 0x018220, 0x70);
	loadDatum(graphicsSpinSpaceScrewBottom, sourceData, 0x018290, 0x50);
	loadDatum(graphicsSpringBallTop, sourceData, 0x0182E0, 0x20);
	loadDatum(graphicsSpringBallBottom, sourceData, 0x018300, 0x20);
	loadDatum(graphicsSamusPowerSuit, sourceData, 0x018320, 0xB00);
	loadDatum(graphicsSamusVariaSuit, sourceData, 0x018E20, 0xB00);
	loadDatum(graphicsEnemiesA, sourceData, 0x019920, 0x400);
	loadDatum(graphicsEnemiesB, sourceData, 0x019D20, 0x400);
	loadDatum(graphicsEnemiesC, sourceData, 0x01A120, 0x400);
	loadDatum(graphicsEnemiesD, sourceData, 0x01A520, 0x400);
	loadDatum(graphicsEnemiesE, sourceData, 0x01A920, 0x400);
	loadDatum(graphicsEnemiesF, sourceData, 0x01AD20, 0x400);
	loadDatum(graphicsArachnus, sourceData, 0x01B120, 0x400);
	loadDatum(graphicsSurfaceSPR, sourceData, 0x01B520, 0x400);

	loadDatum(graphicsPlantBubbles, sourceData, 0x01C000, 0x800);
	loadDatum(graphicsRuinsInside, sourceData, 0x01C800, 0x800);
	loadDatum(graphicsQueenBG, sourceData, 0x01D000, 0x800);
	loadDatum(graphicsCaveFirst, sourceData, 0x01D800, 0x800);
	loadDatum(graphicsSurfaceBG, sourceData, 0x01E000, 0x800);
	loadDatum(graphicsLavaCavesA, sourceData, 0x01E800, 0x530);
	loadDatum(graphicsLavaCavesB, sourceData, 0x01ED30, 0x530);
	loadDatum(graphicsLavaCavesC, sourceData, 0x01F260, 0x530);
	foreach (idx, ref itemGfx; graphicsItems) {
		loadDatum(itemGfx, sourceData, 0x01F790 + idx * 0x40, 0x40);
	}

	loadDatum(bgQueenHead, sourceData, 0x020000, 0x80);
	loadDatum(graphicsMetAlpha, sourceData, 0x0219BC, 0x400);
	loadDatum(graphicsMetGamma, sourceData, 0x021DBC, 0x400);
	loadDatum(graphicsMetZeta, sourceData, 0x0221BC, 0x400);
	loadDatum(graphicsMetOmega, sourceData, 0x0225BC, 0x400);
	loadDatum(graphicsRuinsExt, sourceData, 0x0229BC, 0x800);
	loadDatum(graphicsFinalLab, sourceData, 0x0231BC, 0x800);
	loadDatum(graphicsQueenSPR, sourceData, 0x0239BC, 0x800);
}
void loadDatum(T)(ref T dest, const(ubyte)[] data, size_t offset, size_t length) {
	dest = data[offset .. offset + length];
}

const(ubyte)[] graphicsTitleScreen;
const(ubyte)[] graphicsCreditsFont;
const(ubyte)[] graphicsItemFont;
const(ubyte)[] graphicsCreditsNumbers;
const(ubyte)[] graphicsCreditsSprTiles;
const(ubyte)[] graphicsTheEnd;

const(ubyte)[] graphicsCannonBeam;
const(ubyte)[] graphicsCannonMissile;
const(ubyte)[] graphicsBeamIce;
const(ubyte)[] graphicsBeamWave;
const(ubyte)[] graphicsBeamSpazerPlasma;
const(ubyte)[] graphicsSpinSpaceTop;
const(ubyte)[] graphicsSpinSpaceBottom;
const(ubyte)[] graphicsSpinScrewTop;
const(ubyte)[] graphicsSpinScrewBottom;
const(ubyte)[] graphicsSpinSpaceScrewTop;
const(ubyte)[] graphicsSpinSpaceScrewBottom;
const(ubyte)[] graphicsSpringBallTop;
const(ubyte)[] graphicsSpringBallBottom;
const(ubyte)[] graphicsSamusPowerSuit;
const(ubyte)[] graphicsSamusVariaSuit;
const(ubyte)[] graphicsEnemiesA;
const(ubyte)[] graphicsEnemiesB;
const(ubyte)[] graphicsEnemiesC;
const(ubyte)[] graphicsEnemiesD;
const(ubyte)[] graphicsEnemiesE;
const(ubyte)[] graphicsEnemiesF;
const(ubyte)[] graphicsArachnus;
const(ubyte)[] graphicsSurfaceSPR;
const(ubyte)[] graphicsPlantBubbles;
const(ubyte)[] graphicsRuinsInside;
const(ubyte)[] graphicsQueenBG;
const(ubyte)[] graphicsCaveFirst;
const(ubyte)[] graphicsSurfaceBG;
const(ubyte)[] graphicsLavaCavesA;
const(ubyte)[] graphicsLavaCavesB;
const(ubyte)[] graphicsLavaCavesC;
const(ubyte)[][16] graphicsItems;
const(ubyte)[] bgQueenHead;
const(ubyte)[] graphicsMetAlpha;
const(ubyte)[] graphicsMetGamma;
const(ubyte)[] graphicsMetZeta;
const(ubyte)[] graphicsMetOmega;
const(ubyte)[] graphicsRuinsExt;
const(ubyte)[] graphicsFinalLab;
const(ubyte)[] graphicsQueenSPR;
