module metroid2.doors;

import metroid2.defs;

immutable ubyte[][] doorPointerTable = [
	door000, door001, door002, door003, door004, door005, door006, door007, door008, door009, door00A, door00B, door00C, door00D, door00E, door00F,
	door010, door011, door012, door013, door014, door015, door016, door017, door018, door019, door01A, door01B, door01C, door01D, door01E, door01F,
	door020, door021, door022, door023, door024, door025, door026, door027, door028, door029, door02A, door02B, door02C, door02D, door02E, door02F,
	door030, door031, door032, door033, door034, door035, door036, door037, door038, door039, door03A, door03B, door03C, door03D, door03E, door03F,
	door040, door041, door042, door043, door044, door045, door046, door047, door048, door049, door04A, door04B, door04C, door04D, door04E, door04F,
	door050, door051, door052, door053, door054, door055, door056, door057, door058, door059, door05A, door05B, door05C, door05D, door05E, door05F,
	door060, door061, door062, door063, door064, door065, door066, door067, door068, door069, door06A, door06B, door06C, door06D, door06E, door06F,
	door070, door071, door072, door073, door074, door075, door076, door077, door078, door079, door07A, door07B, door07C, door07D, door07E, door07F,
	door080, door081, door082, door083, door084, door085, door086, door087, door088, door089, door08A, door08B, door08C, door08D, door08E, door08F,
	door090, door091, door092, door093, door094, door095, door096, door097, door098, door099, door09A, door09B, door09C, door09D, door09E, door09F,
	door0A0, door0A1, door0A2, door0A3, door0A4, door0A5, door0A6, door0A7, door0A8, door0A9, door0AA, door0AB, door0AC, door0AD, door0AE, door0AF,
	door0B0, door0B1, door0B2, door0B3, door0B4, door0B5, door0B6, door0B7, door0B8, door0B9, door0BA, door0BB, door0BC, door0BD, door0BE, door0BF,
	door0C0, door0C1, door0C2, door0C3, door0C4, door0C5, door0C6, door0C7, door0C8, door0C9, door0CA, door0CB, door0CC, door0CD, door0CE, door0CF,
	door0D0, door0D1, door0D2, door0D3, door0D4, door0D5, door0D6, door0D7, door0D8, door0D9, door0DA, door0DB, door0DC, door0DD, door0DE, door0DF,
	door0E0, door0E1, door0E2, door0E3, door0E4, door0E5, door0E6, door0E7, door0E8, door0E9, door0EA, door0EB, door0EC, door0ED, door0EE, door0EF,
	door0F0, door0F1, door0F2, door0F3, door0F4, door0F5, door0F6, door0F7, door0F8, door0F9, door0FA, door0FB, door0FC, door0FD, door0FE, door0FF,
	door100, door101, door102, door103, door104, door105, door106, door107, door108, door109, door10A, door10B, door10C, door10D, door10E, door10F,
	door110, door111, door112, door113, door114, door115, door116, door117, door118, door119, door11A, door11B, door11C, door11D, door11E, door11F,
	door120, door121, door122, door123, door124, door125, door126, door127, door128, door129, door12A, door12B, door12C, door12D, door12E, door12F,
	door130, door131, door132, door133, door134, door135, door136, door137, door138, door139, door13A, door13B, door13C, door13D, door13E, door13F,
	door140, door141, door142, door143, door144, door145, door146, door147, door148, door149, door14A, door14B, door14C, door14D, door14E, door14F,
	door150, door151, door152, door153, door154, door155, door156, door157, door158, door159, door15A, door15B, door15C, door15D, door15E, door15F,
	door160, door161, door162, door163, door164, door165, door166, door167, door168, door169, door16A, door16B, door16C, door16D, door16E, door16F,
	door170, door171, door172, door173, door174, door175, door176, door177, door178, door179, door17A, door17B, door17C, door17D, door17E, door17F,
	door180, door181, door182, door183, door184, door185, door186, door187, door188, door189, door18A, door18B, door18C, door18D, door18E, door18F,
	door190, door191, door192, door193, door194, door195, door196, door197, door198, door199, door19A, door19B, door19C, door19D, door19E, door19F,
	door1A0, door1A1, door1A2, door1A3, door1A4, door1A5, door1A6, door1A7, door1A8, door1A9, door1AA, door1AB, door1AC, door1AD, door1AE, door1AF,
	door1B0, door1B1, door1B2, door1B3, door1B4, door1B5, door1B6, door1B7, door1B8, door1B9, door1BA, door1BB, door1BC, door1BD, door1BE, door1BF,
	door1C0, door1C1, door1C2, door1C3, door1C4, door1C5, door1C6, door1C7, door1C8, door1C9, door1CA, door1CB, door1CC, door1CD, door1CE, door1CF,
	door1D0, door1D1, door1D2, door1D3, door1D4, door1D5, door1D6, door1D7, door1D8, door1D9, door1DA, door1DB, door1DC, door1DD, door1DE, door1DF,
	door1E0, door1E1, door1E2, door1E3, door1E4, door1E5, door1E6, door1E7, door1E8, door1E9, door1EA, door1EB, door1EC, door1ED, door1EE, door1EF,
	door1F0, door1F1, door1F2, door1F3, door1F4, door1F5, door1F6, door1F7, door1F8, door1F9, door1FA, door1FB, null, door1FD, door1FE, door1FF,
];

immutable ubyte[] door000 = doorScript(
    END_DOOR,
);

immutable ubyte[] door001 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0xA6),
    END_DOOR,
);
immutable ubyte[] door002 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x4C),
    END_DOOR,
);
immutable ubyte[] door003 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xE, 0xA),
    END_DOOR,
);
immutable ubyte[] door004 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xE, 0xB),
    END_DOOR,
);
immutable ubyte[] door005 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xE, 0x3C),
    END_DOOR,
);
immutable ubyte[] door006 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    ITEM(0x1),
    WARP(0xE, 0x49),
    END_DOOR,
);
immutable ubyte[] door007 = doorScript(
    WARP(0xC, 0x93),
    END_DOOR,
);
immutable ubyte[] door008 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xE, 0x18),
    END_DOOR,
);
immutable ubyte[] door009 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x4D),
    END_DOOR,
);
immutable ubyte[] door00A = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    ITEM(0x2),
    WARP(0xE, 0x99),
    END_DOOR,
);
immutable ubyte[] door00B = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    ITEM(0x0),
    WARP(0xE, 0xA9),
    SONG(Song.chozoRuins),
    END_DOOR,
);
immutable ubyte[] door00C = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xB, 0xD2),
    END_DOOR,
);
immutable ubyte[] door00D = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xB, 0x58),
    END_DOOR,
);
immutable ubyte[] door00E = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    ITEM(0x0),
    SONG(Song.chozoRuins),
    WARP(0xE, 0xCC),
    END_DOOR,
);
immutable ubyte[] door00F = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x56),
    END_DOOR,
);
immutable ubyte[] door010 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0xA3),
    END_DOOR,
);
immutable ubyte[] door011 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0xC3),
    END_DOOR,
);
immutable ubyte[] door012 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    ITEM(0x0),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x50),
    END_DOOR,
);
immutable ubyte[] door013 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x8F),
    END_DOOR,
);
immutable ubyte[] door014 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xD, 0x6),
    END_DOOR,
);
immutable ubyte[] door015 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xD, 0x74),
    END_DOOR,
);
immutable ubyte[] door016 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0xB2),
    END_DOOR,
);
immutable ubyte[] door017 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x7A),
    END_DOOR,
);
immutable ubyte[] door018 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    ITEM(0x0),
    WARP(0xD, 0x58),
    END_DOOR,
);
immutable ubyte[] door019 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x20),
    END_DOOR,
);
immutable ubyte[] door01A = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    ITEM(0x0),
    SONG(Song.chozoRuins),
    WARP(0xE, 0x45),
    END_DOOR,
);
immutable ubyte[] door01B = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xF, 0x24),
    END_DOOR,
);
immutable ubyte[] door01C = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0x2B),
    END_DOOR,
);
immutable ubyte[] door01D = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    ITEM(0x9),
    WARP(0xE, 0x72),
    END_DOOR,
);
immutable ubyte[] door01E = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xE, 0x66),
    END_DOOR,
);
immutable ubyte[] door01F = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xC, 0x7),
    END_DOOR,
);
immutable ubyte[] door020 = doorScript(
    WARP(0xB, 0x19),
    END_DOOR,
);
immutable ubyte[] door021 = doorScript(
    WARP(0xB, 0xF),
    END_DOOR,
);
immutable ubyte[] door022 = doorScript(
    WARP(0xA, 0x12),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door023 = doorScript(
    WARP(0xA, 0x44),
    IF_MET_LESS(0x42, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door024 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF0),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door025 = doorScript(
    WARP(0xC, 0xB2),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door026 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xB, 0x12),
    SONG(Song.subCaves1),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door027 = doorScript(
    WARP(0xC, 0xA0),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door028 = doorScript(
    WARP(0xC, 0xEC),
    IF_MET_LESS(0x12, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door029 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF9),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door02A = doorScript(
    WARP(0xA, 0x4A),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door02B = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x56),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door02C = doorScript(
    WARP(0xC, 0x82),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door02D = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    SONG(Song.subCaves2),
    WARP(0xC, 0x86),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door02E = doorScript(
    WARP(0xC, 0x4B),
    IF_MET_LESS(0x24, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door02F = doorScript(
    SONG(Song.subCaves4),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x3B),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door030 = doorScript(
    WARP(0xC, 0x6C),
    END_DOOR,
);
immutable ubyte[] door031 = doorScript(
    WARP(0xC, 0xCB),
    IF_MET_LESS(0x12, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door032 = doorScript(
    WARP(0xB, 0xDF),
    END_DOOR,
);
immutable ubyte[] door033 = doorScript(
    WARP(0xC, 0xEA),
    IF_MET_LESS(0x23, 0x01E1),
    IF_MET_LESS(0x34, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door034 = doorScript(
    WARP(0xB, 0x48),
    END_DOOR,
);
immutable ubyte[] door035 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x50),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x21, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door036 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    SONG(Song.subCaves3),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x3),
    IF_MET_LESS(0x34, 0x01E1),
    IF_MET_LESS(0x42, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door037 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xF, 0xC),
    END_DOOR,
);
immutable ubyte[] door038 = doorScript(
    WARP(0xC, 0xFC),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door039 = doorScript(
    WARP(0xC, 0xC8),
    END_DOOR,
);
immutable ubyte[] door03A = doorScript(
    WARP(0xC, 0xE7),
    END_DOOR,
);
immutable ubyte[] door03B = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesD),
    SONG(Song.subCaves4),
    WARP(0xB, 0xF0),
    IF_MET_LESS(0x34, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door03C = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesC),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    DAMAGE(0x06, 0x08),
    WARP(0xB, 0x9D),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    IF_MET_LESS(0x21, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door03D = doorScript(
    WARP(0xB, 0x5),
    END_DOOR,
);
immutable ubyte[] door03E = doorScript(
    WARP(0xC, 0xE5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door03F = doorScript(
    WARP(0xA, 0xE8),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x14, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door040 = doorScript(
    WARP(0xA, 0xBB),
    END_DOOR,
);
immutable ubyte[] door041 = doorScript(
    WARP(0xA, 0xBC),
    END_DOOR,
);
immutable ubyte[] door042 = doorScript(
    WARP(0xC, 0x1E),
    END_DOOR,
);
immutable ubyte[] door043 = doorScript(
    WARP(0xC, 0xC9),
    END_DOOR,
);
immutable ubyte[] door044 = doorScript(
    WARP(0xC, 0xF7),
    END_DOOR,
);
immutable ubyte[] door045 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xB, 0x61),
    TILETABLE(0x6),
    IF_MET_LESS(0x11, 0x018B),
    IF_MET_LESS(0x13, 0x01E0),
    END_DOOR,
);
immutable ubyte[] door046 = doorScript(
    WARP(0xC, 0xD9),
    END_DOOR,
);
immutable ubyte[] door047 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    TILETABLE(0x6),
    WARP(0xC, 0x8E),
    END_DOOR,
);
immutable ubyte[] door048 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0x52),
    END_DOOR,
);
immutable ubyte[] door049 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0x51),
    END_DOOR,
);
immutable ubyte[] door04A = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xC),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door04B = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x55),
    IF_MET_LESS(0x34, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door04C = doorScript(
    WARP(0xC, 0xDE),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door04D = doorScript(
    WARP(0xB, 0xCF),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door04E = doorScript(
    WARP(0xC, 0x80),
    END_DOOR,
);
immutable ubyte[] door04F = doorScript(
    WARP(0xB, 0x4F),
    END_DOOR,
);
immutable ubyte[] door050 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    SONG(Song.finalCaves),
    IF_MET_LESS(0x09, 0x018E),
    WARP(0xC, 0x1),
    END_DOOR,
);
immutable ubyte[] door051 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0x90),
    END_DOOR,
);
immutable ubyte[] door052 = doorScript(
    WARP(0xF, 0x5A),
    END_DOOR,
);
immutable ubyte[] door053 = doorScript(
    WARP(0xA, 0x58),
    END_DOOR,
);
immutable ubyte[] door054 = doorScript(
    WARP(0xC, 0x11),
    END_DOOR,
);
immutable ubyte[] door055 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    ITEM(0x0),
    WARP(0xF, 0x6),
    END_DOOR,
);
immutable ubyte[] door056 = doorScript(
    WARP(0xA, 0xF),
    END_DOOR,
);
immutable ubyte[] door057 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0xC2),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door058 = doorScript(
    WARP(0xC, 0xE0),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door059 = doorScript(
    WARP(0xC, 0x3),
    END_DOOR,
);
immutable ubyte[] door05A = doorScript(
    WARP(0x9, 0xE4),
    END_DOOR,
);
immutable ubyte[] door05B = doorScript(
    WARP(0xC, 0x23),
    END_DOOR,
);
immutable ubyte[] door05C = doorScript(
    WARP(0xB, 0xA8),
    END_DOOR,
);
immutable ubyte[] door05D = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x50),
    END_DOOR,
);
immutable ubyte[] door05E = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x54),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door05F = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x6),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door060 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x85),
    END_DOOR,
);
immutable ubyte[] door061 = doorScript(
    WARP(0xC, 0xF3),
    END_DOOR,
);
immutable ubyte[] door062 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    WARP(0xC, 0x46),
    END_DOOR,
);
immutable ubyte[] door063 = doorScript(
    WARP(0xC, 0x28),
    END_DOOR,
);
immutable ubyte[] door064 = doorScript(
    WARP(0xC, 0x37),
    END_DOOR,
);
immutable ubyte[] door065 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xC, 0xF6),
    END_DOOR,
);
immutable ubyte[] door066 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    SONG(Song.mainCaves),
    WARP(0xA, 0xA1),
    IF_MET_LESS(0x24, 0x00E3),
    IF_MET_LESS(0x34, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door067 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0x30),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door068 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xC, 0xC2),
    IF_MET_LESS(0x34, 0x01B1),
    END_DOOR,
);
immutable ubyte[] door069 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x2),
    END_DOOR,
);
immutable ubyte[] door06A = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x9F),
    END_DOOR,
);
immutable ubyte[] door06B = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x14),
    END_DOOR,
);
immutable ubyte[] door06C = doorScript(
    WARP(0xA, 0xF3),
    END_DOOR,
);
immutable ubyte[] door06D = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0x78),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    IF_MET_LESS(0x21, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door06E = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    IF_MET_LESS(0x24, 0x018F),
    WARP(0xA, 0xE1),
    IF_MET_LESS(0x34, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door06F = doorScript(
    WARP(0xB, 0x19),
    END_DOOR,
);
immutable ubyte[] door070 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xE5),
    END_DOOR,
);
immutable ubyte[] door071 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x9),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door072 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xA5),
    END_DOOR,
);
immutable ubyte[] door073 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesC),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0xC8),
    IF_MET_LESS(0x11, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x14, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door074 = doorScript(
    WARP(0xC, 0x9A),
    END_DOOR,
);
immutable ubyte[] door075 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xE),
    END_DOOR,
);
immutable ubyte[] door076 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x79),
    END_DOOR,
);
immutable ubyte[] door077 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF4),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door078 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF5),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door079 = doorScript(
    WARP(0xC, 0xAE),
    END_DOOR,
);
immutable ubyte[] door07A = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x74),
    IF_MET_LESS(0x09, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door07B = doorScript(
    WARP(0xC, 0x3B),
    END_DOOR,
);
immutable ubyte[] door07C = doorScript(
    WARP(0xC, 0x5E),
    END_DOOR,
);
immutable ubyte[] door07D = doorScript(
    WARP(0xC, 0x9C),
    END_DOOR,
);
immutable ubyte[] door07E = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xFC),
    END_DOOR,
);
immutable ubyte[] door07F = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    WARP(0x9, 0xAF),
    END_DOOR,
);
immutable ubyte[] door080 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x26),
    END_DOOR,
);
immutable ubyte[] door081 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    ITEM(0x0),
    SONG(Song.finalCaves),
    WARP(0xC, 0xCD),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door082 = doorScript(
    WARP(0xB, 0x96),
    IF_MET_LESS(0x12, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door083 = doorScript(
    WARP(0xC, 0x46),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door084 = doorScript(
    WARP(0xC, 0x62),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door085 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xB8),
    END_DOOR,
);
immutable ubyte[] door086 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x93),
    END_DOOR,
);
immutable ubyte[] door087 = doorScript(
    WARP(0xC, 0x9A),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door088 = doorScript(
    WARP(0xC, 0xB8),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door089 = doorScript(
    WARP(0xA, 0xCF),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door08A = doorScript(
    WARP(0xC, 0xA7),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door08B = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    DAMAGE(0x02, 0x08),
    WARP(0xA, 0xA5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    IF_MET_LESS(0x21, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door08C = doorScript(
    WARP(0x9, 0xEF),
    END_DOOR,
);
immutable ubyte[] door08D = doorScript(
    ITEM(0xA),
    WARP(0xC, 0xF3),
    END_DOOR,
);
immutable ubyte[] door08E = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door08F = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door090 = doorScript(
    WARP(0xB, 0x1F),
    END_DOOR,
);
immutable ubyte[] door091 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xD4),
    END_DOOR,
);
immutable ubyte[] door092 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xC, 0x25),
    END_DOOR,
);
immutable ubyte[] door093 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xC, 0x17),
    END_DOOR,
);
immutable ubyte[] door094 = doorScript(
    WARP(0xC, 0x18),
    END_DOOR,
);
immutable ubyte[] door095 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door096 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door097 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door098 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door099 = doorScript(
    WARP(0xC, 0xE3),
    END_DOOR,
);
immutable ubyte[] door09A = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0x8),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door09B = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x53),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door09C = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x47),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door09D = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xA, 0x25),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door09E = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    SONG(Song.mainCaves),
    WARP(0xA, 0x41),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door09F = door09E;
immutable ubyte[] door0A0 = doorScript(
    WARP(0xB, 0x15),
    END_DOOR,
);
immutable ubyte[] door0A1 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xB, 0xB2),
    END_DOOR,
);
immutable ubyte[] door0A2 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    SONG(Song.mainCaves),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0x86),
    IF_MET_LESS(0x34, 0x01E1),
    IF_MET_LESS(0x42, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door0A3 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    WARP(0xB, 0x25),
    END_DOOR,
);
immutable ubyte[] door0A4 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x48),
    END_DOOR,
);
immutable ubyte[] door0A5 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xAE),
    END_DOOR,
);
immutable ubyte[] door0A6 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x59),
    END_DOOR,
);
immutable ubyte[] door0A7 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x44),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0A8 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x63),
    END_DOOR,
);
immutable ubyte[] door0A9 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    WARP(0xA, 0xCF),
    END_DOOR,
);
immutable ubyte[] door0AA = doorScript(
    WARP(0xB, 0x13),
    END_DOOR,
);
immutable ubyte[] door0AB = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xB, 0xAC),
    END_DOOR,
);
immutable ubyte[] door0AC = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    WARP(0xD, 0xA6),
    SONG(Song.chozoRuins),
    END_DOOR,
);
immutable ubyte[] door0AD = doorScript(
    WARP(0xB, 0xAF),
    END_DOOR,
);
immutable ubyte[] door0AE = doorScript(
    ITEM(0x0),
    WARP(0xB, 0x90),
    END_DOOR,
);
immutable ubyte[] door0AF = doorScript(
    WARP(0xA, 0xB3),
    END_DOOR,
);
immutable ubyte[] door0B0 = doorScript(
    WARP(0xF, 0x7C),
    END_DOOR,
);
immutable ubyte[] door0B1 = doorScript(
    WARP(0xC, 0x75),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0B2 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0xAD),
    END_DOOR,
);
immutable ubyte[] door0B3 = doorScript(
    WARP(0xB, 0x30),
    END_DOOR,
);
immutable ubyte[] door0B4 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    ITEM(0x0),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x25),
    END_DOOR,
);
immutable ubyte[] door0B5 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xF, 0x23),
    END_DOOR,
);
immutable ubyte[] door0B6 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0xA9),
    END_DOOR,
);
immutable ubyte[] door0B7 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x37),
    END_DOOR,
);
immutable ubyte[] door0B8 = doorScript(
    SONG(Song.mainCaves),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0x65),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    IF_MET_LESS(0x21, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door0B9 = doorScript(
    WARP(0xF, 0xC4),
    END_DOOR,
);
immutable ubyte[] door0BA = doorScript(
    ITEM(0x0),
    WARP(0xF, 0xF3),
    END_DOOR,
);
immutable ubyte[] door0BB = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    WARP(0xB, 0xCB),
    IF_MET_LESS(0x34, 0x01B1),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door0BC = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0xAA),
    END_DOOR,
);
immutable ubyte[] door0BD = doorScript(
    WARP(0xB, 0x88),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door0BE = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x2F),
    END_DOOR,
);
immutable ubyte[] door0BF = doorScript(
    WARP(0xB, 0x4F),
    TILETABLE(0x6),
    END_DOOR,
);
immutable ubyte[] door0C0 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xF, 0xF),
    END_DOOR,
);
immutable ubyte[] door0C1 = doorScript(
    WARP(0xB, 0xC4),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door0C2 = doorScript(
    WARP(0xF, 0xDF),
    END_DOOR,
);
immutable ubyte[] door0C3 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door0C4 = doorScript(
    WARP(0xB, 0x8B),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door0C5 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xBC),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door0C6 = doorScript(
    WARP(0xF, 0xB6),
    END_DOOR,
);
immutable ubyte[] door0C7 = doorScript(
    WARP(0xA, 0x7A),
    END_DOOR,
);
immutable ubyte[] door0C8 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x69),
    END_DOOR,
);
immutable ubyte[] door0C9 = doorScript(
    WARP(0xF, 0x16),
    END_DOOR,
);
immutable ubyte[] door0CA = doorScript(
    WARP(0xA, 0x42),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0CB = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    TILETABLE(0x2),
    WARP(0xF, 0xD1),
    END_DOOR,
);
immutable ubyte[] door0CC = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0xFF),
    END_DOOR,
);
immutable ubyte[] door0CD = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door0CE = doorScript(
    WARP(0xC, 0x65),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0CF = doorScript(
    WARP(0xB, 0x64),
    END_DOOR,
);
immutable ubyte[] door0D0 = doorScript(
    WARP(0xF, 0xE6),
    END_DOOR,
);
immutable ubyte[] door0D1 = doorScript(
    WARP(0xA, 0x22),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0D2 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x33),
    END_DOOR,
);
immutable ubyte[] door0D3 = doorScript(
    ITEM(0x0),
    WARP(0xB, 0xDE),
    END_DOOR,
);
immutable ubyte[] door0D4 = doorScript(
    WARP(0xC, 0xDF),
    IF_MET_LESS(0x09, 0x019B),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0D5 = doorScript(
    WARP(0xB, 0x9A),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door0D6 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.surfaceBG),
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    COLLISION(0x4),
    SOLIDITY(0x4),
    TILETABLE(0x5),
    WARP(0xF, 0x78),
    END_DOOR,
);
immutable ubyte[] door0D7 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door0D8 = doorScript(
    WARP(0xF, 0xCF),
    END_DOOR,
);
immutable ubyte[] door0D9 = doorScript(
    WARP(0xA, 0x7),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door0DA = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door0DB = doorScript(
    ITEM(0x0),
    WARP(0xA, 0x97),
    END_DOOR,
);
immutable ubyte[] door0DC = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xEF),
    END_DOOR,
);
immutable ubyte[] door0DD = doorScript(
    ITEM(0x0),
    WARP(0xC, 0x6D),
    END_DOOR,
);
immutable ubyte[] door0DE = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xB, 0x10),
    END_DOOR,
);
immutable ubyte[] door0DF = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x53),
    END_DOOR,
);
immutable ubyte[] door0E0 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x4B),
    END_DOOR,
);
immutable ubyte[] door0E1 = doorScript(
    WARP(0xA, 0x9A),
    END_DOOR,
);
immutable ubyte[] door0E2 = doorScript(
    WARP(0xA, 0xB8),
    END_DOOR,
);
immutable ubyte[] door0E3 = doorScript(
    WARP(0xA, 0xAF),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0E4 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesC),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    SONG(Song.mainCaves),
    WARP(0xC, 0xAA),
    IF_MET_LESS(0x12, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0E5 = doorScript(
    TILETABLE(0x8),
    WARP(0xC, 0xB5),
    END_DOOR,
);
immutable ubyte[] door0E6 = doorScript(
    WARP(0xA, 0xC8),
    END_DOOR,
);
immutable ubyte[] door0E7 = door0E6;
immutable ubyte[] door0E8 = doorScript(
    WARP(0xA, 0xE5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x14, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0E9 = doorScript(
    WARP(0xB, 0x16),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door0EA = doorScript(
    WARP(0xB, 0xCA),
    END_DOOR,
);
immutable ubyte[] door0EB = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    WARP(0x9, 0x31),
    END_DOOR,
);
immutable ubyte[] door0EC = doorScript(
    WARP(0xA, 0x9F),
    END_DOOR,
);
immutable ubyte[] door0ED = door0EC;
immutable ubyte[] door0EE = doorScript(
    WARP(0xA, 0x6F),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door0EF = doorScript(
    WARP(0xC, 0x99),
    IF_MET_LESS(0x12, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door0F0 = doorScript(
    WARP(0xB, 0x1B),
    END_DOOR,
);
immutable ubyte[] door0F1 = doorScript(
    WARP(0xA, 0xBE),
    END_DOOR,
);
immutable ubyte[] door0F2 = doorScript(
    WARP(0xB, 0x9B),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x14, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door0F3 = doorScript(
    WARP(0xE, 0x0),
    END_DOOR,
);
immutable ubyte[] door0F4 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    LOAD_SPR(EnemyTileSet.enemiesD),
    WARP(0xD, 0x17),
    END_DOOR,
);
immutable ubyte[] door0F5 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    LOAD_SPR(EnemyTileSet.enemiesD),
    WARP(0xD, 0x2C),
    END_DOOR,
);
immutable ubyte[] door0F6 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xE, 0x6),
    END_DOOR,
);
immutable ubyte[] door0F7 = doorScript(
    WARP(0xB, 0xA0),
    END_DOOR,
);
immutable ubyte[] door0F8 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    WARP(0x9, 0x32),
    END_DOOR,
);
immutable ubyte[] door0F9 = doorScript(
    SONG(0xA), // special
    WARP(0xE, 0x10),
    IF_MET_LESS(0x01, 0x0169),
    END_DOOR,
);
immutable ubyte[] door0FA = doorScript(
    WARP(0xE, 0x6),
    END_DOOR,
);
immutable ubyte[] door0FB = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x71),
    END_DOOR,
);
immutable ubyte[] door0FC = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x52),
    END_DOOR,
);
immutable ubyte[] door0FD = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x74),
    END_DOOR,
);
immutable ubyte[] door0FE = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xB1),
    END_DOOR,
);
immutable ubyte[] door0FF = doorScript(
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    WARP(0xE, 0x31),
    END_DOOR,
);
immutable ubyte[] door100 = doorScript(
    WARP(0xF, 0xAC),
    END_DOOR,
);
immutable ubyte[] door101 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesF),
    SONG(Song.subCaves4),
    WARP(0x9, 0xC1),
    END_DOOR,
);
immutable ubyte[] door102 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x57),
    END_DOOR,
);
immutable ubyte[] door103 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves1),
    WARP(0x9, 0x67),
    END_DOOR,
);
immutable ubyte[] door104 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x39),
    END_DOOR,
);
immutable ubyte[] door105 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    WARP(0x9, 0x2B),
    END_DOOR,
);
immutable ubyte[] door106 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    WARP(0x9, 0x3B),
    END_DOOR,
);
immutable ubyte[] door107 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x5D),
    END_DOOR,
);
immutable ubyte[] door108 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesF),
    SONG(Song.subCaves3),
    WARP(0x9, 0x7C),
    END_DOOR,
);
immutable ubyte[] door109 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves3),
    WARP(0x9, 0x8C),
    END_DOOR,
);
immutable ubyte[] door10A = doorScript(
    SONG(Song.finalCaves),
    WARP(0xF, 0xAB),
    END_DOOR,
);
immutable ubyte[] door10B = doorScript(
    WARP(0xE, 0x35),
    END_DOOR,
);
immutable ubyte[] door10C = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesB),
    SONG(Song.subCaves1),
    WARP(0x9, 0xE7),
    END_DOOR,
);
immutable ubyte[] door10D = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesB),
    SONG(Song.subCaves1),
    WARP(0x9, 0xD9),
    END_DOOR,
);
immutable ubyte[] door10E = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves1),
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0xEC),
    END_DOOR,
);
immutable ubyte[] door10F = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0xDF),
    END_DOOR,
);
immutable ubyte[] door110 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    ITEM(0xA),
    SONG(Song.subCaves1),
    WARP(0xC, 0x12),
    END_DOOR,
);
immutable ubyte[] door111 = doorScript(
    WARP(0xF, 0xAD),
    END_DOOR,
);
immutable ubyte[] door112 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    WARP(0xE, 0x97),
    END_DOOR,
);
immutable ubyte[] door113 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xE, 0xB8),
    END_DOOR,
);
immutable ubyte[] door114 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    LOAD_SPR(EnemyTileSet.enemiesD),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x4F),
    END_DOOR,
);
immutable ubyte[] door115 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door116 = door115;
immutable ubyte[] door117 = door115;
immutable ubyte[] door118 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door119 = doorScript(
    END_DOOR,
);
immutable ubyte[] door11A = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door11B = door11A;
immutable ubyte[] door11C = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door11D = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door11E = doorScript(
    ITEM(0x7),
    END_DOOR,
);
immutable ubyte[] door11F = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door120 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door121 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door122 = doorScript(
    ITEM(0x3),
    END_DOOR,
);
immutable ubyte[] door123 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door124 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door125 = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    END_DOOR,
);
immutable ubyte[] door126 = door125;
immutable ubyte[] door127 = doorScript(
    ITEM(0x6),
    END_DOOR,
);
immutable ubyte[] door128 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door129 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door12A = doorScript(
    ITEM(0x1),
    END_DOOR,
);
immutable ubyte[] door12B = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door12C = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door12D = doorScript(
    ITEM(0x3),
    END_DOOR,
);
immutable ubyte[] door12E = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door12F = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door130 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door131 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door132 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door133 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door134 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door135 = doorScript(
    WARP(0xD, 0x1),
    END_DOOR,
);
immutable ubyte[] door136 = doorScript(
    WARP(0xD, 0x12),
    END_DOOR,
);
immutable ubyte[] door137 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door138 = doorScript(
    WARP(0xD, 0x46),
    END_DOOR,
);
immutable ubyte[] door139 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door13A = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    SONG(Song.metroidHive),
    WARP(0xD, 0x11),
    END_DOOR,
);
immutable ubyte[] door13B = doorScript(
    IF_MET_LESS(0x01, 0x019D),
    FADEOUT,
    LOAD_BG(BGTileSet.queenBG),
    COLLISION(0x2),
    SOLIDITY(0x2),
    TILETABLE(0x3),
    COPY_SPR(SpecialDoorCopySrc.queenSpr, SpecialDoorCopyDest.enemySpr, 0x0500),
    WARP(0xF, 0xEF),
    END_DOOR,
);
immutable ubyte[] door13C = doorScript(
    ITEM(0x1),
    END_DOOR,
);
immutable ubyte[] door13D = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door13E = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door13F = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door140 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door141 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door142 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xD, 0x10),
    END_DOOR,
);
immutable ubyte[] door143 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door144 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door145 = doorScript(
    ITEM(0x5),
    END_DOOR,
);
immutable ubyte[] door146 = doorScript(
    WARP(0xD, 0x41),
    END_DOOR,
);
immutable ubyte[] door147 = doorScript(
    LOAD_SPR(EnemyTileSet.arachnus),
    END_DOOR,
);
immutable ubyte[] door148 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door149 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door14A = doorScript(
    WARP(0xC, 0x15),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door14B = doorScript(
    WARP(0xC, 0x44),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door14C = doorScript(
    WARP(0xA, 0x42),
    IF_MET_LESS(0x23, 0x01E1),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door14D = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    TILETABLE(0x2),
    ITEM(0x0),
    WARP(0xB, 0xCB),
    END_DOOR,
);
immutable ubyte[] door14E = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x26),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door14F = doorScript(
    WARP(0xB, 0x1B),
    END_DOOR,
);
immutable ubyte[] door150 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x55),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door151 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xF, 0xD4),
    END_DOOR,
);
immutable ubyte[] door152 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    WARP(0xB, 0x74),
    END_DOOR,
);
immutable ubyte[] door153 = doorScript(
    WARP(0xB, 0x5D),
    END_DOOR,
);
immutable ubyte[] door154 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door155 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door156 = door155;
immutable ubyte[] door157 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door158 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door159 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door15A = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door15B = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door15C = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door15D = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door15E = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door15F = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door160 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door161 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door162 = doorScript(
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    END_DOOR,
);
immutable ubyte[] door163 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door164 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door165 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    END_DOOR,
);
immutable ubyte[] door166 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.finalLab),
    COLLISION(0x7),
    SOLIDITY(0x7),
    TILETABLE(0x0),
    END_DOOR,
);
immutable ubyte[] door167 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.finalLab),
    COLLISION(0x7),
    SOLIDITY(0x7),
    ITEM(0x2),
    TILETABLE(0x0),
    WARP(0xE, 0xE1),
    END_DOOR,
);
immutable ubyte[] door168 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door169 = doorScript(
    SONG(Song.metroidQueenHallway),
    END_DOOR,
);
immutable ubyte[] door16A = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door16B = doorScript(
    WARP(0xD, 0x5C),
    END_DOOR,
);
immutable ubyte[] door16C = door16B;
immutable ubyte[] door16D = door16B;
immutable ubyte[] door16E = door16B;
immutable ubyte[] door16F = door16B;
immutable ubyte[] door170 = door16B;
immutable ubyte[] door171 = doorScript(
    WARP(0xD, 0x77),
    END_DOOR,
);
immutable ubyte[] door172 = doorScript(
    WARP(0xD, 0x39),
    END_DOOR,
);
immutable ubyte[] door173 = doorScript(
    WARP(0xD, 0x3A),
    END_DOOR,
);
immutable ubyte[] door174 = doorScript(
    WARP(0xD, 0x9),
    END_DOOR,
);
immutable ubyte[] door175 = doorScript(
    WARP(0xD, 0xC8),
    END_DOOR,
);
immutable ubyte[] door176 = doorScript(
    WARP(0xD, 0xB5),
    END_DOOR,
);
immutable ubyte[] door177 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.metGamma),
    SONG(Song.subCaves4),
    WARP(0x9, 0x61),
    END_DOOR,
);
immutable ubyte[] door178 = doorScript(
    WARP(0xD, 0xFC),
    END_DOOR,
);
immutable ubyte[] door179 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.metGamma),
    SONG(Song.subCaves4),
    WARP(0x9, 0xD1),
    END_DOOR,
);
immutable ubyte[] door17A = doorScript(
    WARP(0xD, 0x2D),
    END_DOOR,
);
immutable ubyte[] door17B = doorScript(
    WARP(0xD, 0x2E),
    END_DOOR,
);
immutable ubyte[] door17C = doorScript(
    SONG(Song.metroidHive),
    WARP(0xD, 0x51),
    END_DOOR,
);
immutable ubyte[] door17D = doorScript(
    WARP(0xD, 0x31),
    END_DOOR,
);
immutable ubyte[] door17E = doorScript(
    WARP(0xE, 0xE3),
    END_DOOR,
);
immutable ubyte[] door17F = doorScript(
    ITEM(0x0),
    WARP(0xA, 0x89),
    END_DOOR,
);
immutable ubyte[] door180 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.finalLab),
    COLLISION(0x7),
    SOLIDITY(0x7),
    COPY_DATA(SpecialDoorCopySrc.commonItems, SpecialDoorCopyDest.commonItems, 0x0100),
    ITEM(0x2),
    TILETABLE(0x0),
    SONG(Song.finalCaves),
    WARP(0xE, 0xC1),
    END_DOOR,
);
immutable ubyte[] door181 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves3),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x98),
    END_DOOR,
);
immutable ubyte[] door182 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door183 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0xEC),
    END_DOOR,
);
immutable ubyte[] door184 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0xED),
    END_DOOR,
);
immutable ubyte[] door185 = doorScript(
    WARP(0xC, 0x1F),
    END_DOOR,
);
immutable ubyte[] door186 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesC),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0xC5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door187 = doorScript(
    WARP(0xA, 0x83),
    IF_MET_LESS(0x24, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door188 = doorScript(
    WARP(0xA, 0x82),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door189 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesD),
    SONG(Song.subCaves4),
    WARP(0xB, 0xF0),
    IF_MET_LESS(0x24, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door18A = doorScript(
    WARP(0xA, 0xC6),
    END_DOOR,
);
immutable ubyte[] door18B = doorScript(
    WARP(0xB, 0x61),
    END_DOOR,
);
immutable ubyte[] door18C = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x55),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x21, 0x01E3),
    IF_MET_LESS(0x24, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door18D = door18C;
immutable ubyte[] door18E = doorScript(
    WARP(0xC, 0x0),
    END_DOOR,
);
immutable ubyte[] door18F = doorScript(
    WARP(0xA, 0xEF),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door190 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xF),
    END_DOOR,
);
immutable ubyte[] door191 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x75),
    END_DOOR,
);
immutable ubyte[] door192 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesC),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0xC8),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door193 = doorScript(
    WARP(0xC, 0x96),
    END_DOOR,
);
immutable ubyte[] door194 = doorScript(
    WARP(0xA, 0xAF),
    IF_MET_LESS(0x13, 0x01B1),
    IF_MET_LESS(0x21, 0x01AF),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door195 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    WARP(0xB, 0x8A),
    END_DOOR,
);
immutable ubyte[] door196 = doorScript(
    WARP(0xA, 0x67),
    END_DOOR,
);
immutable ubyte[] door197 = door196;
immutable ubyte[] door198 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    WARP(0xB, 0x80),
    END_DOOR,
);
immutable ubyte[] door199 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x16),
    END_DOOR,
);
immutable ubyte[] door19A = doorScript(
    WARP(0xB, 0x90),
    END_DOOR,
);
immutable ubyte[] door19B = doorScript(
    TILETABLE(0x6),
    WARP(0xC, 0xDE),
    END_DOOR,
);
immutable ubyte[] door19C = doorScript(
    WARP(0xC, 0xB5),
    IF_MET_LESS(0x09, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door19D = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.queenBG),
    COLLISION(0x2),
    SOLIDITY(0x2),
    TILETABLE(0x3),
    COPY_SPR(SpecialDoorCopySrc.queenSpr, SpecialDoorCopyDest.enemySpr, 0x0500),
    COPY_DATA(SpecialDoorCopySrc.queenHeadRow1, SpecialDoorCopyDest.screen1, 0x0020),
    COPY_DATA(SpecialDoorCopySrc.queenHeadRow2, SpecialDoorCopyDest.screen1r2, 0x0020),
    COPY_DATA(SpecialDoorCopySrc.queenHeadRow3, SpecialDoorCopyDest.screen1r3, 0x0020),
    COPY_DATA(SpecialDoorCopySrc.queenHeadRow4, SpecialDoorCopyDest.screen1r4, 0x0020),
    ENTER_QUEEN(0xF, 0x0F48, 0x0EAE, 0x0F02, 0x0EDE),
    END_DOOR,
);
immutable ubyte[] door19E = doorScript(
    COPY_DATA(SpecialDoorCopySrc.commonItems, SpecialDoorCopyDest.commonItems, 0x0100),
    IF_MET_LESS(0x00, 0x019F),
    FADEOUT,
    LOAD_BG(BGTileSet.finalLab),
    COLLISION(0x7),
    SOLIDITY(0x7),
    ITEM(0x2),
    ESCAPE_QUEEN,
    TILETABLE(0x0),
    SONG(Song.finalCaves),
    WARP(0xE, 0xC1),
    END_DOOR,
);
immutable ubyte[] door19F = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.surfaceBG),
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    COLLISION(0x4),
    SOLIDITY(0x4),
    EXIT_QUEEN,
    TILETABLE(0x5),
    WARP(0xF, 0xA9),
    END_DOOR,
);
immutable ubyte[] door1A0 = doorScript(
    IF_MET_LESS(0x24, 0x0188),
    IF_MET_LESS(0x34, 0x01E3),
    IF_MET_LESS(0x42, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door1A1 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    TILETABLE(0x6),
    LOAD_SPR(EnemyTileSet.enemiesF),
    IF_MET_LESS(0x11, 0x01CD),
    IF_MET_LESS(0x13, 0x00C7),
    END_DOOR,
);
immutable ubyte[] door1A2 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesC),
    COLLISION(0x5),
    SOLIDITY(0x5),
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0xC5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x14, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door1A3 = doorScript(
    WARP(0xC, 0x11),
    END_DOOR,
);
immutable ubyte[] door1A4 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    SONG(Song.mainCaves),
    WARP(0xA, 0xC),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door1A5 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x23),
    END_DOOR,
);
immutable ubyte[] door1A6 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x24),
    END_DOOR,
);
immutable ubyte[] door1A7 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0x27),
    END_DOOR,
);
immutable ubyte[] door1A8 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xB, 0x28),
    END_DOOR,
);
immutable ubyte[] door1A9 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1AA = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door1AB = doorScript(
    WARP(0xA, 0x4F),
    IF_MET_LESS(0x23, 0x01E1),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door1AC = doorScript(
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door1AD = doorScript(
    WARP(0xB, 0xF8),
    IF_MET_LESS(0x24, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door1AE = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door1AF = doorScript(
    TILETABLE(0x0),
    END_DOOR,
);
immutable ubyte[] door1B0 = doorScript(
    TILETABLE(0x1),
    END_DOOR,
);
immutable ubyte[] door1B1 = doorScript(
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door1B2 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesF),
    SONG(Song.subCaves4),
    WARP(0x9, 0xE2),
    END_DOOR,
);
immutable ubyte[] door1B3 = doorScript(
    WARP(0xA, 0x53),
    IF_MET_LESS(0x34, 0x01E1),
    IF_MET_LESS(0x42, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door1B4 = doorScript(
    WARP(0xC, 0x6B),
    IF_MET_LESS(0x24, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door1B5 = doorScript(
    IF_MET_LESS(0x34, 0x01E1),
    IF_MET_LESS(0x42, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door1B6 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1B7 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1B8 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1B9 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1BA = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xA, 0xF7),
    END_DOOR,
);
immutable ubyte[] door1BB = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    END_DOOR,
);
immutable ubyte[] door1BC = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door1BD = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door1BE = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1BF = doorScript(
    END_DOOR,
);
immutable ubyte[] door1C0 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1C1 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1C2 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1C3 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1C4 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1C5 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1C6 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1C7 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xC2),
    END_DOOR,
);
immutable ubyte[] door1C8 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1C9 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1CA = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door1CB = doorScript(
    ITEM(0x8),
    END_DOOR,
);
immutable ubyte[] door1CC = doorScript(
    ITEM(0x8),
    END_DOOR,
);
immutable ubyte[] door1CD = doorScript(
    WARP(0xA, 0xC6),
    END_DOOR,
);
immutable ubyte[] door1CE = doorScript(
    WARP(0xF, 0xAD),
    END_DOOR,
);
immutable ubyte[] door1CF = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1D0 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1D1 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    LOAD_SPR(EnemyTileSet.enemiesA),
    TILETABLE(0x4),
    WARP(0xD, 0x1),
    END_DOOR,
);
immutable ubyte[] door1D2 = doorScript(
    ITEM(0x9),
    END_DOOR,
);
immutable ubyte[] door1D3 = doorScript(
    ITEM(0x8),
    END_DOOR,
);
immutable ubyte[] door1D4 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door1D5 = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door1D6 = doorScript(
    ITEM(0x3),
    END_DOOR,
);
immutable ubyte[] door1D7 = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door1D8 = doorScript(
    ITEM(0x9),
    END_DOOR,
);
immutable ubyte[] door1D9 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door1DA = doorScript(
    ITEM(0x1),
    END_DOOR,
);
immutable ubyte[] door1DB = doorScript(
    ITEM(0x6),
    END_DOOR,
);
immutable ubyte[] door1DC = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door1DD = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door1DE = doorScript(
    END_DOOR,
);
immutable ubyte[] door1DF = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xA, 0x43),
    END_DOOR,
);
immutable ubyte[] door1E0 = doorScript(
    WARP(0xB, 0x9D),
    END_DOOR,
);
immutable ubyte[] door1E1 = doorScript(
    TILETABLE(0x6),
    END_DOOR,
);
immutable ubyte[] door1E2 = doorScript(
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door1E3 = doorScript(
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door1E4 = doorScript(
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x21, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door1E5 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door1E6 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door1E7 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door1E8 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door1E9 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.queenBG),
    COLLISION(0x2),
    SOLIDITY(0x2),
    TILETABLE(0x3),
    COPY_SPR(SpecialDoorCopySrc.queenSpr, SpecialDoorCopyDest.enemySpr, 0x0500),
    END_DOOR,
);
immutable ubyte[] door1EA = door1E9;
immutable ubyte[] door1EB = door1E9;
immutable ubyte[] door1EC = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.surfaceBG),
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    COLLISION(0x4),
    SOLIDITY(0x4),
    COPY_DATA(SpecialDoorCopySrc.commonItems, SpecialDoorCopyDest.commonItems, 0x0100),
    TILETABLE(0x5),
    END_DOOR,
);
immutable ubyte[] door1ED = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door1EE = door1ED;
immutable ubyte[] door1EF = door1ED;
immutable ubyte[] door1F0 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);

immutable ubyte[] door1F1 = doorScript();
immutable ubyte[] door1F2 = doorScript();
immutable ubyte[] door1F3 = doorScript();
immutable ubyte[] door1F4 = doorScript();
immutable ubyte[] door1F5 = doorScript();
immutable ubyte[] door1F6 = doorScript();
immutable ubyte[] door1F7 = doorScript();
immutable ubyte[] door1F8 = doorScript();
immutable ubyte[] door1F9 = doorScript();
immutable ubyte[] door1FA = doorScript();
immutable ubyte[] door1FB = doorScript();
immutable ubyte[] door1FD = doorScript();
immutable ubyte[] door1FE = doorScript();
immutable ubyte[] door1FF = doorScript();

ubyte[] COPY_DATA(ubyte src, ubyte dest, ushort length) {
	return [DoorCommand.copyData, src, dest, length & 0xFF, length >> 8];
}

ubyte[] COPY_BG(ubyte src, ubyte dest, ushort length) {
	return [DoorCommand.copyBG, src, dest, length & 0xFF, length >> 8];
}

ubyte[] COPY_SPR(ubyte src, ubyte dest, ushort length) {
	return [DoorCommand.copySpr, src, dest, length & 0xFF, length >> 8];
}

ubyte[] TILETABLE(ubyte t) {
	return [DoorCommand.tileTable | (t & 0xF)];
}

ubyte[] COLLISION(ubyte c) {
	return [DoorCommand.collision | (c & 0xF)];
}

ubyte[] SOLIDITY(ubyte s) {
	return [DoorCommand.solidity | (s & 0xF)];
}

ubyte[] WARP(ubyte a, ubyte b) {
	return [DoorCommand.warp | (a & 0xF), b];
}

ubyte[] ESCAPE_QUEEN() {
	return [DoorCommand.escapeQueen];
}

ubyte[] DAMAGE(ubyte a, ubyte b) {
	return [DoorCommand.damage, a, b];
}

ubyte[] EXIT_QUEEN() {
	return [DoorCommand.exitQueen];
}

ubyte[] ENTER_QUEEN(ubyte a, ushort b, ushort c, ushort d, ushort e) {
	return [DoorCommand.enterQueen | (a & 0xF), b & 0xFF, b >> 8, c & 0xFF, c >> 8, d & 0xFF, d >> 8, e & 0xFF,e >> 8];
}

ubyte[] IF_MET_LESS(ubyte a, ushort b) {
	return [DoorCommand.ifMetLess, a, b & 0xFF, b >> 8];
}

ubyte[] FADEOUT() {
	return [DoorCommand.fadeout];
}

ubyte[] LOAD_BG(ubyte bg) {
	return [DoorCommand.loadBG, bg];
}

ubyte[] LOAD_SPR(ubyte spr) {
	return [DoorCommand.loadSpr, spr];
}

ubyte[] SONG(ubyte s) {
	return [DoorCommand.song | (s & 0xF)];
}

ubyte[] ITEM(ubyte i) {
	return [DoorCommand.item | (i & 0xF)];
}

ubyte[] END_DOOR() {
	return [DoorCommand.end];
}

private ubyte[] doorScript(scope ubyte[] delegate()[] commands...) {
	ubyte[] newBuffer;
	foreach (command; commands) {
		newBuffer ~= command();
	}
	return newBuffer;
}
