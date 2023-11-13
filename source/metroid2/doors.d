module metroid2.doors;

import metroid2.defs;

immutable ubyte[][] doorPointerTable = [
	door000, door001, door002, door003, door004, door005, door006, door007, door008, door009, door010, door011, door012, door013, door014, door015,
	door016, door017, door018, door019, door020, door021, door022, door023, door024, door025, door026, door027, door028, door029, door030, door031,
	door032, door033, door034, door035, door036, door037, door038, door039, door040, door041, door042, door043, door044, door045, door046, door047,
	door048, door049, door050, door051, door052, door053, door054, door055, door056, door057, door058, door059, door060, door061, door062, door063,
	door064, door065, door066, door067, door068, door069, door070, door071, door072, door073, door074, door075, door076, door077, door078, door079,
	door080, door081, door082, door083, door084, door085, door086, door087, door088, door089, door090, door091, door092, door093, door094, door095,
	door096, door097, door098, door099, door100, door101, door102, door103, door104, door105, door106, door107, door108, door109, door110, door111,
	door112, door113, door114, door115, door116, door117, door118, door119, door120, door121, door122, door123, door124, door125, door126, door127,
	door128, door129, door130, door131, door132, door133, door134, door135, door136, door137, door138, door139, door140, door141, door142, door143,
	door144, door145, door146, door147, door148, door149, door150, door151, door152, door153, door154, door155, door156, door157, door158, door159,
	door160, door161, door162, door163, door164, door165, door166, door167, door168, door169, door170, door171, door172, door173, door174, door175,
	door176, door177, door178, door179, door180, door181, door182, door183, door184, door185, door186, door187, door188, door189, door190, door191,
	door192, door193, door194, door195, door196, door197, door198, door199, door200, door201, door202, door203, door204, door205, door206, door207,
	door208, door209, door210, door211, door212, door213, door214, door215, door216, door217, door218, door219, door220, door221, door222, door223,
	door224, door225, door226, door227, door228, door229, door230, door231, door232, door233, door234, door235, door236, door237, door238, door239,
	door240, door241, door242, door243, door244, door245, door246, door247, door248, door249, door250, door251, door252, door253, door254, door255,
	door256, door257, door258, door259, door260, door261, door262, door263, door264, door265, door266, door267, door268, door269, door270, door271,
	door272, door273, door274, door275, door276, door277, door278, door279, door280, door281, door282, door283, door284, door285, door286, door287,
	door288, door289, door290, door291, door292, door293, door294, door295, door296, door297, door298, door299, door300, door301, door302, door303,
	door304, door305, door306, door307, door308, door309, door310, door311, door312, door313, door314, door315, door316, door317, door318, door319,
	door320, door321, door322, door323, door324, door325, door326, door327, door328, door329, door330, door331, door332, door333, door334, door335,
	door336, door337, door338, door339, door340, door341, door342, door343, door344, door345, door346, door347, door348, door349, door350, door351,
	door352, door353, door354, door355, door356, door357, door358, door359, door360, door361, door362, door363, door364, door365, door366, door367,
	door368, door369, door370, door371, door372, door373, door374, door375, door376, door377, door378, door379, door380, door381, door382, door383,
	door384, door385, door386, door387, door388, door389, door390, door391, door392, door393, door394, door395, door396, door397, door398, door399,
	door400, door401, door402, door403, door404, door405, door406, door407, door408, door409, door410, door411, door412, door413, door414, door415,
	door416, door417, door418, door419, door420, door421, door422, door423, door424, door425, door426, door427, door428, door429, door430, door431,
	door432, door433, door434, door435, door436, door437, door438, door439, door440, door441, door442, door443, door444, door445, door446, door447,
	door448, door449, door450, door451, door452, door453, door454, door455, door456, door457, door458, door459, door460, door461, door462, door463,
	door464, door465, door466, door467, door468, door469, door470, door471, door472, door473, door474, door475, door476, door477, door478, door479,
	door480, door481, door482, door483, door484, door485, door486, door487, door488, door489, door490, door491, door492, door493, door494, door495,
	door496, door497, door498, door499, door500, door501, door502, door503, door504, door505, door506, door507, null, door509, door510, door511,
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
immutable ubyte[] door010 = doorScript(
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
immutable ubyte[] door011 = doorScript(
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
immutable ubyte[] door012 = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xB, 0xD2),
    END_DOOR,
);
immutable ubyte[] door013 = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xB, 0x58),
    END_DOOR,
);
immutable ubyte[] door014 = doorScript(
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
immutable ubyte[] door015 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x56),
    END_DOOR,
);
immutable ubyte[] door016 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0xA3),
    END_DOOR,
);
immutable ubyte[] door017 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0xC3),
    END_DOOR,
);
immutable ubyte[] door018 = doorScript(
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
immutable ubyte[] door019 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x8F),
    END_DOOR,
);
immutable ubyte[] door020 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xD, 0x6),
    END_DOOR,
);
immutable ubyte[] door021 = doorScript(
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
immutable ubyte[] door022 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0xB2),
    END_DOOR,
);
immutable ubyte[] door023 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xD, 0x7A),
    END_DOOR,
);
immutable ubyte[] door024 = doorScript(
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
immutable ubyte[] door025 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x20),
    END_DOOR,
);
immutable ubyte[] door026 = doorScript(
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
immutable ubyte[] door027 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xF, 0x24),
    END_DOOR,
);
immutable ubyte[] door028 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0x2B),
    END_DOOR,
);
immutable ubyte[] door029 = doorScript(
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
immutable ubyte[] door030 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    SONG(Song.chozoRuins),
    WARP(0xE, 0x66),
    END_DOOR,
);
immutable ubyte[] door031 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xC, 0x7),
    END_DOOR,
);
immutable ubyte[] door032 = doorScript(
    WARP(0xB, 0x19),
    END_DOOR,
);
immutable ubyte[] door033 = doorScript(
    WARP(0xB, 0xF),
    END_DOOR,
);
immutable ubyte[] door034 = doorScript(
    WARP(0xA, 0x12),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door035 = doorScript(
    WARP(0xA, 0x44),
    IF_MET_LESS(0x42, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door036 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF0),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door037 = doorScript(
    WARP(0xC, 0xB2),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door038 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xB, 0x12),
    SONG(Song.subCaves1),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door039 = doorScript(
    WARP(0xC, 0xA0),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door040 = doorScript(
    WARP(0xC, 0xEC),
    IF_MET_LESS(0x12, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door041 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF9),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door042 = doorScript(
    WARP(0xA, 0x4A),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door043 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x56),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door044 = doorScript(
    WARP(0xC, 0x82),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door045 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    SONG(Song.subCaves2),
    WARP(0xC, 0x86),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door046 = doorScript(
    WARP(0xC, 0x4B),
    IF_MET_LESS(0x24, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door047 = doorScript(
    SONG(Song.subCaves4),
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x3B),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door048 = doorScript(
    WARP(0xC, 0x6C),
    END_DOOR,
);
immutable ubyte[] door049 = doorScript(
    WARP(0xC, 0xCB),
    IF_MET_LESS(0x12, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door050 = doorScript(
    WARP(0xB, 0xDF),
    END_DOOR,
);
immutable ubyte[] door051 = doorScript(
    WARP(0xC, 0xEA),
    IF_MET_LESS(0x23, 0x01E1),
    IF_MET_LESS(0x34, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door052 = doorScript(
    WARP(0xB, 0x48),
    END_DOOR,
);
immutable ubyte[] door053 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x50),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x21, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door054 = doorScript(
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
immutable ubyte[] door055 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xF, 0xC),
    END_DOOR,
);
immutable ubyte[] door056 = doorScript(
    WARP(0xC, 0xFC),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door057 = doorScript(
    WARP(0xC, 0xC8),
    END_DOOR,
);
immutable ubyte[] door058 = doorScript(
    WARP(0xC, 0xE7),
    END_DOOR,
);
immutable ubyte[] door059 = doorScript(
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
immutable ubyte[] door060 = doorScript(
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
immutable ubyte[] door061 = doorScript(
    WARP(0xB, 0x5),
    END_DOOR,
);
immutable ubyte[] door062 = doorScript(
    WARP(0xC, 0xE5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door063 = doorScript(
    WARP(0xA, 0xE8),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x14, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door064 = doorScript(
    WARP(0xA, 0xBB),
    END_DOOR,
);
immutable ubyte[] door065 = doorScript(
    WARP(0xA, 0xBC),
    END_DOOR,
);
immutable ubyte[] door066 = doorScript(
    WARP(0xC, 0x1E),
    END_DOOR,
);
immutable ubyte[] door067 = doorScript(
    WARP(0xC, 0xC9),
    END_DOOR,
);
immutable ubyte[] door068 = doorScript(
    WARP(0xC, 0xF7),
    END_DOOR,
);
immutable ubyte[] door069 = doorScript(
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
immutable ubyte[] door070 = doorScript(
    WARP(0xC, 0xD9),
    END_DOOR,
);
immutable ubyte[] door071 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    TILETABLE(0x6),
    WARP(0xC, 0x8E),
    END_DOOR,
);
immutable ubyte[] door072 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0x52),
    END_DOOR,
);
immutable ubyte[] door073 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0x51),
    END_DOOR,
);
immutable ubyte[] door074 = doorScript(
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
immutable ubyte[] door075 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x55),
    IF_MET_LESS(0x34, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door076 = doorScript(
    WARP(0xC, 0xDE),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door077 = doorScript(
    WARP(0xB, 0xCF),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door078 = doorScript(
    WARP(0xC, 0x80),
    END_DOOR,
);
immutable ubyte[] door079 = doorScript(
    WARP(0xB, 0x4F),
    END_DOOR,
);
immutable ubyte[] door080 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    SONG(Song.finalCaves),
    IF_MET_LESS(0x09, 0x018E),
    WARP(0xC, 0x1),
    END_DOOR,
);
immutable ubyte[] door081 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xC, 0x90),
    END_DOOR,
);
immutable ubyte[] door082 = doorScript(
    WARP(0xF, 0x5A),
    END_DOOR,
);
immutable ubyte[] door083 = doorScript(
    WARP(0xA, 0x58),
    END_DOOR,
);
immutable ubyte[] door084 = doorScript(
    WARP(0xC, 0x11),
    END_DOOR,
);
immutable ubyte[] door085 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    ITEM(0x0),
    WARP(0xF, 0x6),
    END_DOOR,
);
immutable ubyte[] door086 = doorScript(
    WARP(0xA, 0xF),
    END_DOOR,
);
immutable ubyte[] door087 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0xC2),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door088 = doorScript(
    WARP(0xC, 0xE0),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door089 = doorScript(
    WARP(0xC, 0x3),
    END_DOOR,
);
immutable ubyte[] door090 = doorScript(
    WARP(0x9, 0xE4),
    END_DOOR,
);
immutable ubyte[] door091 = doorScript(
    WARP(0xC, 0x23),
    END_DOOR,
);
immutable ubyte[] door092 = doorScript(
    WARP(0xB, 0xA8),
    END_DOOR,
);
immutable ubyte[] door093 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x50),
    END_DOOR,
);
immutable ubyte[] door094 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x54),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door095 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x6),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door096 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x85),
    END_DOOR,
);
immutable ubyte[] door097 = doorScript(
    WARP(0xC, 0xF3),
    END_DOOR,
);
immutable ubyte[] door098 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    WARP(0xC, 0x46),
    END_DOOR,
);
immutable ubyte[] door099 = doorScript(
    WARP(0xC, 0x28),
    END_DOOR,
);
immutable ubyte[] door100 = doorScript(
    WARP(0xC, 0x37),
    END_DOOR,
);
immutable ubyte[] door101 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xC, 0xF6),
    END_DOOR,
);
immutable ubyte[] door102 = doorScript(
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
immutable ubyte[] door103 = doorScript(
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
immutable ubyte[] door104 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xC, 0xC2),
    IF_MET_LESS(0x34, 0x01B1),
    END_DOOR,
);
immutable ubyte[] door105 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x2),
    END_DOOR,
);
immutable ubyte[] door106 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x9F),
    END_DOOR,
);
immutable ubyte[] door107 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x14),
    END_DOOR,
);
immutable ubyte[] door108 = doorScript(
    WARP(0xA, 0xF3),
    END_DOOR,
);
immutable ubyte[] door109 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xA, 0x78),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    IF_MET_LESS(0x21, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door110 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    IF_MET_LESS(0x24, 0x018F),
    WARP(0xA, 0xE1),
    IF_MET_LESS(0x34, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door111 = doorScript(
    WARP(0xB, 0x19),
    END_DOOR,
);
immutable ubyte[] door112 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xE5),
    END_DOOR,
);
immutable ubyte[] door113 = doorScript(
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
immutable ubyte[] door114 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xA5),
    END_DOOR,
);
immutable ubyte[] door115 = doorScript(
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
immutable ubyte[] door116 = doorScript(
    WARP(0xC, 0x9A),
    END_DOOR,
);
immutable ubyte[] door117 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xE),
    END_DOOR,
);
immutable ubyte[] door118 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x79),
    END_DOOR,
);
immutable ubyte[] door119 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF4),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door120 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0xF5),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door121 = doorScript(
    WARP(0xC, 0xAE),
    END_DOOR,
);
immutable ubyte[] door122 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesA),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x74),
    IF_MET_LESS(0x09, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door123 = doorScript(
    WARP(0xC, 0x3B),
    END_DOOR,
);
immutable ubyte[] door124 = doorScript(
    WARP(0xC, 0x5E),
    END_DOOR,
);
immutable ubyte[] door125 = doorScript(
    WARP(0xC, 0x9C),
    END_DOOR,
);
immutable ubyte[] door126 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xFC),
    END_DOOR,
);
immutable ubyte[] door127 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    WARP(0x9, 0xAF),
    END_DOOR,
);
immutable ubyte[] door128 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x26),
    END_DOOR,
);
immutable ubyte[] door129 = doorScript(
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
immutable ubyte[] door130 = doorScript(
    WARP(0xB, 0x96),
    IF_MET_LESS(0x12, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door131 = doorScript(
    WARP(0xC, 0x46),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door132 = doorScript(
    WARP(0xC, 0x62),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door133 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xB8),
    END_DOOR,
);
immutable ubyte[] door134 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x93),
    END_DOOR,
);
immutable ubyte[] door135 = doorScript(
    WARP(0xC, 0x9A),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door136 = doorScript(
    WARP(0xC, 0xB8),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door137 = doorScript(
    WARP(0xA, 0xCF),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door138 = doorScript(
    WARP(0xC, 0xA7),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door139 = doorScript(
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
immutable ubyte[] door140 = doorScript(
    WARP(0x9, 0xEF),
    END_DOOR,
);
immutable ubyte[] door141 = doorScript(
    ITEM(0xA),
    WARP(0xC, 0xF3),
    END_DOOR,
);
immutable ubyte[] door142 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door143 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door144 = doorScript(
    WARP(0xB, 0x1F),
    END_DOOR,
);
immutable ubyte[] door145 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xD4),
    END_DOOR,
);
immutable ubyte[] door146 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xC, 0x25),
    END_DOOR,
);
immutable ubyte[] door147 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xC, 0x17),
    END_DOOR,
);
immutable ubyte[] door148 = doorScript(
    WARP(0xC, 0x18),
    END_DOOR,
);
immutable ubyte[] door149 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door150 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door151 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door152 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door153 = doorScript(
    WARP(0xC, 0xE3),
    END_DOOR,
);
immutable ubyte[] door154 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0x8),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door155 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x53),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door156 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x47),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door157 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xA, 0x25),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door158 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    SONG(Song.mainCaves),
    WARP(0xA, 0x41),
    IF_MET_LESS(0x42, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door159 = door158;
immutable ubyte[] door160 = doorScript(
    WARP(0xB, 0x15),
    END_DOOR,
);
immutable ubyte[] door161 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xB, 0xB2),
    END_DOOR,
);
immutable ubyte[] door162 = doorScript(
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
immutable ubyte[] door163 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    WARP(0xB, 0x25),
    END_DOOR,
);
immutable ubyte[] door164 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x48),
    END_DOOR,
);
immutable ubyte[] door165 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xAE),
    END_DOOR,
);
immutable ubyte[] door166 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x59),
    END_DOOR,
);
immutable ubyte[] door167 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.lavaCavesB),
    COLLISION(0x5),
    SOLIDITY(0x5),
    WARP(0xC, 0x44),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door168 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x63),
    END_DOOR,
);
immutable ubyte[] door169 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    WARP(0xA, 0xCF),
    END_DOOR,
);
immutable ubyte[] door170 = doorScript(
    WARP(0xB, 0x13),
    END_DOOR,
);
immutable ubyte[] door171 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xB, 0xAC),
    END_DOOR,
);
immutable ubyte[] door172 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsInside),
    COLLISION(0x1),
    SOLIDITY(0x1),
    TILETABLE(0x1),
    WARP(0xD, 0xA6),
    SONG(Song.chozoRuins),
    END_DOOR,
);
immutable ubyte[] door173 = doorScript(
    WARP(0xB, 0xAF),
    END_DOOR,
);
immutable ubyte[] door174 = doorScript(
    ITEM(0x0),
    WARP(0xB, 0x90),
    END_DOOR,
);
immutable ubyte[] door175 = doorScript(
    WARP(0xA, 0xB3),
    END_DOOR,
);
immutable ubyte[] door176 = doorScript(
    WARP(0xF, 0x7C),
    END_DOOR,
);
immutable ubyte[] door177 = doorScript(
    WARP(0xC, 0x75),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door178 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0xAD),
    END_DOOR,
);
immutable ubyte[] door179 = doorScript(
    WARP(0xB, 0x30),
    END_DOOR,
);
immutable ubyte[] door180 = doorScript(
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
immutable ubyte[] door181 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xF, 0x23),
    END_DOOR,
);
immutable ubyte[] door182 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0xA9),
    END_DOOR,
);
immutable ubyte[] door183 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x37),
    END_DOOR,
);
immutable ubyte[] door184 = doorScript(
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
immutable ubyte[] door185 = doorScript(
    WARP(0xF, 0xC4),
    END_DOOR,
);
immutable ubyte[] door186 = doorScript(
    ITEM(0x0),
    WARP(0xF, 0xF3),
    END_DOOR,
);
immutable ubyte[] door187 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    WARP(0xB, 0xCB),
    IF_MET_LESS(0x34, 0x01B1),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door188 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0xAA),
    END_DOOR,
);
immutable ubyte[] door189 = doorScript(
    WARP(0xB, 0x88),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door190 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x2F),
    END_DOOR,
);
immutable ubyte[] door191 = doorScript(
    WARP(0xB, 0x4F),
    TILETABLE(0x6),
    END_DOOR,
);
immutable ubyte[] door192 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xF, 0xF),
    END_DOOR,
);
immutable ubyte[] door193 = doorScript(
    WARP(0xB, 0xC4),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door194 = doorScript(
    WARP(0xF, 0xDF),
    END_DOOR,
);
immutable ubyte[] door195 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door196 = doorScript(
    WARP(0xB, 0x8B),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door197 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xBC),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door198 = doorScript(
    WARP(0xF, 0xB6),
    END_DOOR,
);
immutable ubyte[] door199 = doorScript(
    WARP(0xA, 0x7A),
    END_DOOR,
);
immutable ubyte[] door200 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x69),
    END_DOOR,
);
immutable ubyte[] door201 = doorScript(
    WARP(0xF, 0x16),
    END_DOOR,
);
immutable ubyte[] door202 = doorScript(
    WARP(0xA, 0x42),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door203 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    TILETABLE(0x2),
    WARP(0xF, 0xD1),
    END_DOOR,
);
immutable ubyte[] door204 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0xFF),
    END_DOOR,
);
immutable ubyte[] door205 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door206 = doorScript(
    WARP(0xC, 0x65),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door207 = doorScript(
    WARP(0xB, 0x64),
    END_DOOR,
);
immutable ubyte[] door208 = doorScript(
    WARP(0xF, 0xE6),
    END_DOOR,
);
immutable ubyte[] door209 = doorScript(
    WARP(0xA, 0x22),
    IF_MET_LESS(0x46, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door210 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x33),
    END_DOOR,
);
immutable ubyte[] door211 = doorScript(
    ITEM(0x0),
    WARP(0xB, 0xDE),
    END_DOOR,
);
immutable ubyte[] door212 = doorScript(
    WARP(0xC, 0xDF),
    IF_MET_LESS(0x09, 0x019B),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door213 = doorScript(
    WARP(0xB, 0x9A),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x14, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door214 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.surfaceBG),
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    COLLISION(0x4),
    SOLIDITY(0x4),
    TILETABLE(0x5),
    WARP(0xF, 0x78),
    END_DOOR,
);
immutable ubyte[] door215 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door216 = doorScript(
    WARP(0xF, 0xCF),
    END_DOOR,
);
immutable ubyte[] door217 = doorScript(
    WARP(0xA, 0x7),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door218 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door219 = doorScript(
    ITEM(0x0),
    WARP(0xA, 0x97),
    END_DOOR,
);
immutable ubyte[] door220 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0xEF),
    END_DOOR,
);
immutable ubyte[] door221 = doorScript(
    ITEM(0x0),
    WARP(0xC, 0x6D),
    END_DOOR,
);
immutable ubyte[] door222 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0xB, 0x10),
    END_DOOR,
);
immutable ubyte[] door223 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x53),
    END_DOOR,
);
immutable ubyte[] door224 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    WARP(0xB, 0x4B),
    END_DOOR,
);
immutable ubyte[] door225 = doorScript(
    WARP(0xA, 0x9A),
    END_DOOR,
);
immutable ubyte[] door226 = doorScript(
    WARP(0xA, 0xB8),
    END_DOOR,
);
immutable ubyte[] door227 = doorScript(
    WARP(0xA, 0xAF),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door228 = doorScript(
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
immutable ubyte[] door229 = doorScript(
    TILETABLE(0x8),
    WARP(0xC, 0xB5),
    END_DOOR,
);
immutable ubyte[] door230 = doorScript(
    WARP(0xA, 0xC8),
    END_DOOR,
);
immutable ubyte[] door231 = door230;
immutable ubyte[] door232 = doorScript(
    WARP(0xA, 0xE5),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x14, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door233 = doorScript(
    WARP(0xB, 0x16),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door234 = doorScript(
    WARP(0xB, 0xCA),
    END_DOOR,
);
immutable ubyte[] door235 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    WARP(0x9, 0x31),
    END_DOOR,
);
immutable ubyte[] door236 = doorScript(
    WARP(0xA, 0x9F),
    END_DOOR,
);
immutable ubyte[] door237 = door236;
immutable ubyte[] door238 = doorScript(
    WARP(0xA, 0x6F),
    IF_MET_LESS(0x23, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door239 = doorScript(
    WARP(0xC, 0x99),
    IF_MET_LESS(0x12, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door240 = doorScript(
    WARP(0xB, 0x1B),
    END_DOOR,
);
immutable ubyte[] door241 = doorScript(
    WARP(0xA, 0xBE),
    END_DOOR,
);
immutable ubyte[] door242 = doorScript(
    WARP(0xB, 0x9B),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x14, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door243 = doorScript(
    WARP(0xE, 0x0),
    END_DOOR,
);
immutable ubyte[] door244 = doorScript(
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
immutable ubyte[] door245 = doorScript(
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
immutable ubyte[] door246 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xE, 0x6),
    END_DOOR,
);
immutable ubyte[] door247 = doorScript(
    WARP(0xB, 0xA0),
    END_DOOR,
);
immutable ubyte[] door248 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves4),
    WARP(0x9, 0x32),
    END_DOOR,
);
immutable ubyte[] door249 = doorScript(
    SONG(0xA), // special
    WARP(0xE, 0x10),
    IF_MET_LESS(0x01, 0x0169),
    END_DOOR,
);
immutable ubyte[] door250 = doorScript(
    WARP(0xE, 0x6),
    END_DOOR,
);
immutable ubyte[] door251 = doorScript(
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
immutable ubyte[] door252 = doorScript(
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
immutable ubyte[] door253 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0x9, 0x74),
    END_DOOR,
);
immutable ubyte[] door254 = doorScript(
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
immutable ubyte[] door255 = doorScript(
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    WARP(0xE, 0x31),
    END_DOOR,
);
immutable ubyte[] door256 = doorScript(
    WARP(0xF, 0xAC),
    END_DOOR,
);
immutable ubyte[] door257 = doorScript(
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
immutable ubyte[] door258 = doorScript(
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
immutable ubyte[] door259 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves1),
    WARP(0x9, 0x67),
    END_DOOR,
);
immutable ubyte[] door260 = doorScript(
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
immutable ubyte[] door261 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    WARP(0x9, 0x2B),
    END_DOOR,
);
immutable ubyte[] door262 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves2),
    WARP(0x9, 0x3B),
    END_DOOR,
);
immutable ubyte[] door263 = doorScript(
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
immutable ubyte[] door264 = doorScript(
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
immutable ubyte[] door265 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.ruinsExt),
    COLLISION(0x6),
    SOLIDITY(0x6),
    TILETABLE(0x9),
    SONG(Song.subCaves3),
    WARP(0x9, 0x8C),
    END_DOOR,
);
immutable ubyte[] door266 = doorScript(
    SONG(Song.finalCaves),
    WARP(0xF, 0xAB),
    END_DOOR,
);
immutable ubyte[] door267 = doorScript(
    WARP(0xE, 0x35),
    END_DOOR,
);
immutable ubyte[] door268 = doorScript(
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
immutable ubyte[] door269 = doorScript(
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
immutable ubyte[] door270 = doorScript(
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
immutable ubyte[] door271 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0xDF),
    END_DOOR,
);
immutable ubyte[] door272 = doorScript(
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
immutable ubyte[] door273 = doorScript(
    WARP(0xF, 0xAD),
    END_DOOR,
);
immutable ubyte[] door274 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    WARP(0xE, 0x97),
    END_DOOR,
);
immutable ubyte[] door275 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    WARP(0xE, 0xB8),
    END_DOOR,
);
immutable ubyte[] door276 = doorScript(
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
immutable ubyte[] door277 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door278 = door277;
immutable ubyte[] door279 = door277;
immutable ubyte[] door280 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door281 = doorScript(
    END_DOOR,
);
immutable ubyte[] door282 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door283 = door282;
immutable ubyte[] door284 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door285 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door286 = doorScript(
    ITEM(0x7),
    END_DOOR,
);
immutable ubyte[] door287 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door288 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door289 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door290 = doorScript(
    ITEM(0x3),
    END_DOOR,
);
immutable ubyte[] door291 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    END_DOOR,
);
immutable ubyte[] door292 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door293 = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    END_DOOR,
);
immutable ubyte[] door294 = door293;
immutable ubyte[] door295 = doorScript(
    ITEM(0x6),
    END_DOOR,
);
immutable ubyte[] door296 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door297 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door298 = doorScript(
    ITEM(0x1),
    END_DOOR,
);
immutable ubyte[] door299 = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door300 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door301 = doorScript(
    ITEM(0x3),
    END_DOOR,
);
immutable ubyte[] door302 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door303 = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door304 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door305 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door306 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door307 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door308 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door309 = doorScript(
    WARP(0xD, 0x1),
    END_DOOR,
);
immutable ubyte[] door310 = doorScript(
    WARP(0xD, 0x12),
    END_DOOR,
);
immutable ubyte[] door311 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door312 = doorScript(
    WARP(0xD, 0x46),
    END_DOOR,
);
immutable ubyte[] door313 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door314 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    SONG(Song.metroidHive),
    WARP(0xD, 0x11),
    END_DOOR,
);
immutable ubyte[] door315 = doorScript(
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
immutable ubyte[] door316 = doorScript(
    ITEM(0x1),
    END_DOOR,
);
immutable ubyte[] door317 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door318 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door319 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door320 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door321 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door322 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xD, 0x10),
    END_DOOR,
);
immutable ubyte[] door323 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door324 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door325 = doorScript(
    ITEM(0x5),
    END_DOOR,
);
immutable ubyte[] door326 = doorScript(
    WARP(0xD, 0x41),
    END_DOOR,
);
immutable ubyte[] door327 = doorScript(
    LOAD_SPR(EnemyTileSet.arachnus),
    END_DOOR,
);
immutable ubyte[] door328 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door329 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door330 = doorScript(
    WARP(0xC, 0x15),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door331 = doorScript(
    WARP(0xC, 0x44),
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door332 = doorScript(
    WARP(0xA, 0x42),
    IF_MET_LESS(0x23, 0x01E1),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door333 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.plantBubbles),
    COLLISION(0x0),
    SOLIDITY(0x0),
    TILETABLE(0x2),
    ITEM(0x0),
    WARP(0xB, 0xCB),
    END_DOOR,
);
immutable ubyte[] door334 = doorScript(
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
immutable ubyte[] door335 = doorScript(
    WARP(0xB, 0x1B),
    END_DOOR,
);
immutable ubyte[] door336 = doorScript(
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
immutable ubyte[] door337 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xF, 0xD4),
    END_DOOR,
);
immutable ubyte[] door338 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    WARP(0xB, 0x74),
    END_DOOR,
);
immutable ubyte[] door339 = doorScript(
    WARP(0xB, 0x5D),
    END_DOOR,
);
immutable ubyte[] door340 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door341 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door342 = door341;
immutable ubyte[] door343 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door344 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door345 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door346 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door347 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door348 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door349 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door350 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door351 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door352 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door353 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door354 = doorScript(
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    END_DOOR,
);
immutable ubyte[] door355 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    END_DOOR,
);
immutable ubyte[] door356 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door357 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    END_DOOR,
);
immutable ubyte[] door358 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.finalLab),
    COLLISION(0x7),
    SOLIDITY(0x7),
    TILETABLE(0x0),
    END_DOOR,
);
immutable ubyte[] door359 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.finalLab),
    COLLISION(0x7),
    SOLIDITY(0x7),
    ITEM(0x2),
    TILETABLE(0x0),
    WARP(0xE, 0xE1),
    END_DOOR,
);
immutable ubyte[] door360 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door361 = doorScript(
    SONG(Song.metroidQueenHallway),
    END_DOOR,
);
immutable ubyte[] door362 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesE),
    END_DOOR,
);
immutable ubyte[] door363 = doorScript(
    WARP(0xD, 0x5C),
    END_DOOR,
);
immutable ubyte[] door364 = door363;
immutable ubyte[] door365 = door363;
immutable ubyte[] door366 = door363;
immutable ubyte[] door367 = door363;
immutable ubyte[] door368 = door363;
immutable ubyte[] door369 = doorScript(
    WARP(0xD, 0x77),
    END_DOOR,
);
immutable ubyte[] door370 = doorScript(
    WARP(0xD, 0x39),
    END_DOOR,
);
immutable ubyte[] door371 = doorScript(
    WARP(0xD, 0x3A),
    END_DOOR,
);
immutable ubyte[] door372 = doorScript(
    WARP(0xD, 0x9),
    END_DOOR,
);
immutable ubyte[] door373 = doorScript(
    WARP(0xD, 0xC8),
    END_DOOR,
);
immutable ubyte[] door374 = doorScript(
    WARP(0xD, 0xB5),
    END_DOOR,
);
immutable ubyte[] door375 = doorScript(
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
immutable ubyte[] door376 = doorScript(
    WARP(0xD, 0xFC),
    END_DOOR,
);
immutable ubyte[] door377 = doorScript(
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
immutable ubyte[] door378 = doorScript(
    WARP(0xD, 0x2D),
    END_DOOR,
);
immutable ubyte[] door379 = doorScript(
    WARP(0xD, 0x2E),
    END_DOOR,
);
immutable ubyte[] door380 = doorScript(
    SONG(Song.metroidHive),
    WARP(0xD, 0x51),
    END_DOOR,
);
immutable ubyte[] door381 = doorScript(
    WARP(0xD, 0x31),
    END_DOOR,
);
immutable ubyte[] door382 = doorScript(
    WARP(0xE, 0xE3),
    END_DOOR,
);
immutable ubyte[] door383 = doorScript(
    ITEM(0x0),
    WARP(0xA, 0x89),
    END_DOOR,
);
immutable ubyte[] door384 = doorScript(
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
immutable ubyte[] door385 = doorScript(
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
immutable ubyte[] door386 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door387 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0xEC),
    END_DOOR,
);
immutable ubyte[] door388 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xA, 0xED),
    END_DOOR,
);
immutable ubyte[] door389 = doorScript(
    WARP(0xC, 0x1F),
    END_DOOR,
);
immutable ubyte[] door390 = doorScript(
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
immutable ubyte[] door391 = doorScript(
    WARP(0xA, 0x83),
    IF_MET_LESS(0x24, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door392 = doorScript(
    WARP(0xA, 0x82),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door393 = doorScript(
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
immutable ubyte[] door394 = doorScript(
    WARP(0xA, 0xC6),
    END_DOOR,
);
immutable ubyte[] door395 = doorScript(
    WARP(0xB, 0x61),
    END_DOOR,
);
immutable ubyte[] door396 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x55),
    IF_MET_LESS(0x12, 0x01E3),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x21, 0x01E3),
    IF_MET_LESS(0x24, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door397 = door396;
immutable ubyte[] door398 = doorScript(
    WARP(0xC, 0x0),
    END_DOOR,
);
immutable ubyte[] door399 = doorScript(
    WARP(0xA, 0xEF),
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E3),
    IF_MET_LESS(0x21, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door400 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xF),
    END_DOOR,
);
immutable ubyte[] door401 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0x75),
    END_DOOR,
);
immutable ubyte[] door402 = doorScript(
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
immutable ubyte[] door403 = doorScript(
    WARP(0xC, 0x96),
    END_DOOR,
);
immutable ubyte[] door404 = doorScript(
    WARP(0xA, 0xAF),
    IF_MET_LESS(0x13, 0x01B1),
    IF_MET_LESS(0x21, 0x01AF),
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door405 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    WARP(0xB, 0x8A),
    END_DOOR,
);
immutable ubyte[] door406 = doorScript(
    WARP(0xA, 0x67),
    END_DOOR,
);
immutable ubyte[] door407 = door406;
immutable ubyte[] door408 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    WARP(0xB, 0x80),
    END_DOOR,
);
immutable ubyte[] door409 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesB),
    WARP(0x9, 0x16),
    END_DOOR,
);
immutable ubyte[] door410 = doorScript(
    WARP(0xB, 0x90),
    END_DOOR,
);
immutable ubyte[] door411 = doorScript(
    TILETABLE(0x6),
    WARP(0xC, 0xDE),
    END_DOOR,
);
immutable ubyte[] door412 = doorScript(
    WARP(0xC, 0xB5),
    IF_MET_LESS(0x09, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door413 = doorScript(
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
immutable ubyte[] door414 = doorScript(
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
immutable ubyte[] door415 = doorScript(
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
immutable ubyte[] door416 = doorScript(
    IF_MET_LESS(0x24, 0x0188),
    IF_MET_LESS(0x34, 0x01E3),
    IF_MET_LESS(0x42, 0x01E2),
    END_DOOR,
);
immutable ubyte[] door417 = doorScript(
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
immutable ubyte[] door418 = doorScript(
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
immutable ubyte[] door419 = doorScript(
    WARP(0xC, 0x11),
    END_DOOR,
);
immutable ubyte[] door420 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    SONG(Song.mainCaves),
    WARP(0xA, 0xC),
    IF_MET_LESS(0x42, 0x01E1),
    IF_MET_LESS(0x46, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door421 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xB, 0x23),
    END_DOOR,
);
immutable ubyte[] door422 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    WARP(0xB, 0x24),
    END_DOOR,
);
immutable ubyte[] door423 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesC),
    WARP(0xB, 0x27),
    END_DOOR,
);
immutable ubyte[] door424 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xB, 0x28),
    END_DOOR,
);
immutable ubyte[] door425 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door426 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door427 = doorScript(
    WARP(0xA, 0x4F),
    IF_MET_LESS(0x23, 0x01E1),
    IF_MET_LESS(0x34, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door428 = doorScript(
    IF_MET_LESS(0x34, 0x01E1),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door429 = doorScript(
    WARP(0xB, 0xF8),
    IF_MET_LESS(0x24, 0x01E3),
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door430 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door431 = doorScript(
    TILETABLE(0x0),
    END_DOOR,
);
immutable ubyte[] door432 = doorScript(
    TILETABLE(0x1),
    END_DOOR,
);
immutable ubyte[] door433 = doorScript(
    TILETABLE(0x2),
    END_DOOR,
);
immutable ubyte[] door434 = doorScript(
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
immutable ubyte[] door435 = doorScript(
    WARP(0xA, 0x53),
    IF_MET_LESS(0x34, 0x01E1),
    IF_MET_LESS(0x42, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door436 = doorScript(
    WARP(0xC, 0x6B),
    IF_MET_LESS(0x24, 0x01E1),
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door437 = doorScript(
    IF_MET_LESS(0x34, 0x01E1),
    IF_MET_LESS(0x42, 0x01E3),
    END_DOOR,
);
immutable ubyte[] door438 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door439 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door440 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door441 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door442 = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    WARP(0xA, 0xF7),
    END_DOOR,
);
immutable ubyte[] door443 = doorScript(
    LOAD_SPR(EnemyTileSet.metZeta),
    END_DOOR,
);
immutable ubyte[] door444 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door445 = doorScript(
    LOAD_SPR(EnemyTileSet.metOmega),
    END_DOOR,
);
immutable ubyte[] door446 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door447 = doorScript(
    END_DOOR,
);
immutable ubyte[] door448 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door449 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door450 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door451 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door452 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door453 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door454 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door455 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesF),
    WARP(0xC, 0xC2),
    END_DOOR,
);
immutable ubyte[] door456 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door457 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door458 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door459 = doorScript(
    ITEM(0x8),
    END_DOOR,
);
immutable ubyte[] door460 = doorScript(
    ITEM(0x8),
    END_DOOR,
);
immutable ubyte[] door461 = doorScript(
    WARP(0xA, 0xC6),
    END_DOOR,
);
immutable ubyte[] door462 = doorScript(
    WARP(0xF, 0xAD),
    END_DOOR,
);
immutable ubyte[] door463 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door464 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door465 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    LOAD_SPR(EnemyTileSet.enemiesA),
    TILETABLE(0x4),
    WARP(0xD, 0x1),
    END_DOOR,
);
immutable ubyte[] door466 = doorScript(
    ITEM(0x9),
    END_DOOR,
);
immutable ubyte[] door467 = doorScript(
    ITEM(0x8),
    END_DOOR,
);
immutable ubyte[] door468 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door469 = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door470 = doorScript(
    ITEM(0x3),
    END_DOOR,
);
immutable ubyte[] door471 = doorScript(
    ITEM(0x4),
    END_DOOR,
);
immutable ubyte[] door472 = doorScript(
    ITEM(0x9),
    END_DOOR,
);
immutable ubyte[] door473 = doorScript(
    ITEM(0x2),
    END_DOOR,
);
immutable ubyte[] door474 = doorScript(
    ITEM(0x1),
    END_DOOR,
);
immutable ubyte[] door475 = doorScript(
    ITEM(0x6),
    END_DOOR,
);
immutable ubyte[] door476 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesD),
    END_DOOR,
);
immutable ubyte[] door477 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door478 = doorScript(
    END_DOOR,
);
immutable ubyte[] door479 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.caveFirst),
    COLLISION(0x3),
    SOLIDITY(0x3),
    TILETABLE(0x4),
    LOAD_SPR(EnemyTileSet.enemiesA),
    WARP(0xA, 0x43),
    END_DOOR,
);
immutable ubyte[] door480 = doorScript(
    WARP(0xB, 0x9D),
    END_DOOR,
);
immutable ubyte[] door481 = doorScript(
    TILETABLE(0x6),
    END_DOOR,
);
immutable ubyte[] door482 = doorScript(
    TILETABLE(0x7),
    END_DOOR,
);
immutable ubyte[] door483 = doorScript(
    TILETABLE(0x8),
    END_DOOR,
);
immutable ubyte[] door484 = doorScript(
    IF_MET_LESS(0x12, 0x01E1),
    IF_MET_LESS(0x13, 0x01E2),
    IF_MET_LESS(0x21, 0x01E1),
    END_DOOR,
);
immutable ubyte[] door485 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door486 = doorScript(
    ITEM(0x0),
    END_DOOR,
);
immutable ubyte[] door487 = doorScript(
    LOAD_SPR(EnemyTileSet.enemiesA),
    END_DOOR,
);
immutable ubyte[] door488 = doorScript(
    LOAD_SPR(EnemyTileSet.metAlpha),
    END_DOOR,
);
immutable ubyte[] door489 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.queenBG),
    COLLISION(0x2),
    SOLIDITY(0x2),
    TILETABLE(0x3),
    COPY_SPR(SpecialDoorCopySrc.queenSpr, SpecialDoorCopyDest.enemySpr, 0x0500),
    END_DOOR,
);
immutable ubyte[] door490 = door489;
immutable ubyte[] door491 = door489;
immutable ubyte[] door492 = doorScript(
    FADEOUT,
    LOAD_BG(BGTileSet.surfaceBG),
    LOAD_SPR(EnemyTileSet.surfaceSPR),
    COLLISION(0x4),
    SOLIDITY(0x4),
    COPY_DATA(SpecialDoorCopySrc.commonItems, SpecialDoorCopyDest.commonItems, 0x0100),
    TILETABLE(0x5),
    END_DOOR,
);
immutable ubyte[] door493 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);
immutable ubyte[] door494 = door493;
immutable ubyte[] door495 = door493;
immutable ubyte[] door496 = doorScript(
    LOAD_SPR(EnemyTileSet.metGamma),
    END_DOOR,
);

immutable ubyte[] door497 = doorScript();
immutable ubyte[] door498 = doorScript();
immutable ubyte[] door499 = doorScript();
immutable ubyte[] door500 = doorScript();
immutable ubyte[] door501 = doorScript();
immutable ubyte[] door502 = doorScript();
immutable ubyte[] door503 = doorScript();
immutable ubyte[] door504 = doorScript();
immutable ubyte[] door505 = doorScript();
immutable ubyte[] door506 = doorScript();
immutable ubyte[] door507 = doorScript();
immutable ubyte[] door509 = doorScript();
immutable ubyte[] door510 = doorScript();
immutable ubyte[] door511 = doorScript();

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
