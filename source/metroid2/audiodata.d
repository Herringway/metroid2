module metroid2.audiodata;

import metroid2.defs;

struct optionSetsSquare1 {
	alias jumping0 = .jumping0;
	alias jumping1 = .jumping1;
	alias jumping2 = .jumping2;
	alias jumping3 = .jumping3;
	alias jumping4 = .jumping4;
	alias jumping5 = .jumping5;
	alias hijumping0 = .hijumping0;
	alias hijumping1 = .hijumping1;
	alias hijumping2 = .hijumping2;
	alias hijumping3 = .hijumping3;
	alias hijumping4 = .hijumping4;
	alias hijumping5 = .hijumping5;
	alias hijumping6 = .hijumping6;
	alias hijumping7 = .hijumping7;
	alias screwAttacking0 = .screwAttacking0;
	alias screwAttacking1 = .screwAttacking1;
	alias screwAttacking2 = .screwAttacking2;
	alias screwAttacking3 = .screwAttacking3;
	alias screwAttacking4 = .screwAttacking4;
	alias screwAttacking5 = .screwAttacking5;
	alias screwAttacking6 = .screwAttacking6;
	alias screwAttacking7 = .screwAttacking7;
	alias screwAttacking8 = .screwAttacking8;
	alias screwAttacking9 = .screwAttacking9;
	alias screwAttackingA = .screwAttackingA;
	alias screwAttackingB = .screwAttackingB;
	alias screwAttackingC = .screwAttackingC;
	alias screwAttackingD = .screwAttackingD;
	alias standingTransition0 = .standingTransition0;
	alias standingTransition1 = .standingTransition1;
	alias standingTransition2 = .standingTransition2;
	alias crouchingTransition0 = .crouchingTransition0;
	alias crouchingTransition1 = .crouchingTransition1;
	alias crouchingTransition2 = .crouchingTransition2;
	alias morphing0 = .morphing0;
	alias morphing1 = .morphing1;
	alias morphing2 = .morphing2;
	alias shootingBeam0 = .shootingBeam0;
	alias shootingBeam1 = .shootingBeam1;
	alias shootingBeam2 = .shootingBeam2;
	alias shootingBeam3 = .shootingBeam3;
	alias shootingBeam4 = .shootingBeam4;
	alias shootingMissile0 = .shootingMissile0;
	alias shootingMissile1 = .shootingMissile1;
	alias shootingMissile2 = .shootingMissile2;
	alias shootingMissile3 = .shootingMissile3;
	alias shootingMissile4 = .shootingMissile4;
	alias shootingMissile5 = .shootingMissile5;
	alias shootingMissile6 = .shootingMissile6;
	alias shootingMissile7 = .shootingMissile7;
	alias shootingMissile8 = .shootingMissile8;
	alias shootingMissile9 = .shootingMissile9;
	alias shootingIceBeam = .shootingIceBeam;
	alias shootingPlasmaBeam = .shootingPlasmaBeam;
	alias shootingSpazerBeam = .shootingSpazerBeam;
	alias pickingUpMissileDrop0 = .pickingUpMissileDrop0;
	alias pickingUpMissileDrop1 = .pickingUpMissileDrop1;
	alias pickingUpMissileDrop2 = .pickingUpMissileDrop2;
	alias pickingUpMissileDrop3 = .pickingUpMissileDrop3;
	alias pickingUpMissileDrop4 = .pickingUpMissileDrop4;
	alias spiderBall0 = .spiderBall0;
	alias spiderBall1 = .spiderBall1;
	alias pickedUpEnergyDrop0 = .pickedUpEnergyDrop0;
	alias pickedUpEnergyDrop1 = .pickedUpEnergyDrop1;
	alias pickedUpEnergyDrop2 = .pickedUpEnergyDrop2;
	alias pickedUpDropEnd = .pickedUpDropEnd;
	alias shotMissileDoorWithBeam0 = .shotMissileDoorWithBeam0;
	alias shotMissileDoorWithBeam1 = .shotMissileDoorWithBeam1;
	alias unknown100 = .unknown100;
	alias unknown101 = .unknown101;
	alias unknown102 = .unknown102;
	alias unknown103 = .unknown103;
	alias unknown104 = .unknown104;
	alias unknown105 = .unknown105;
	alias unknown106 = .unknown106;
	alias unknown107 = .unknown107;
	alias unknown108 = .unknown108;
	alias unknown109 = .unknown109;
	alias unknown10A = .unknown10A;
	alias unused12 = .unused12;
	alias bombLaid = .bombLaid;
	alias unused140 = .unused140;
	alias unused141 = .unused141;
	alias optionMissileSelect0 = .optionMissileSelect0;
	alias optionMissileSelect1 = .optionMissileSelect1;
	alias shootingWaveBeam0 = .shootingWaveBeam0;
	alias shootingWaveBeam1 = .shootingWaveBeam1;
	alias shootingWaveBeam2 = .shootingWaveBeam2;
	alias shootingWaveBeam3 = .shootingWaveBeam3;
	alias shootingWaveBeam4 = .shootingWaveBeam4;
	alias largeEnergyDrop0 = .largeEnergyDrop0;
	alias largeEnergyDrop1 = .largeEnergyDrop1;
	alias largeEnergyDrop2 = .largeEnergyDrop2;
	alias largeEnergyDrop3 = .largeEnergyDrop3;
	alias largeEnergyDrop4 = .largeEnergyDrop4;
	alias samusHealthChanged0 = .samusHealthChanged0;
	alias samusHealthChanged1 = .samusHealthChanged1;
	alias noMissileDudShot0 = .noMissileDudShot0;
	alias noMissileDudShot1 = .noMissileDudShot1;
	alias unknown1A0 = .unknown1A0;
	alias unknown1A1 = .unknown1A1;
	alias unknown1A2 = .unknown1A2;
	alias unknown1A3 = .unknown1A3;
	alias unknown1A4 = .unknown1A4;
	alias unknown1A5 = .unknown1A5;
	alias unknown1A6 = .unknown1A6;
	alias metroidCry = .metroidCry;
	alias saved0 = .saved0;
	alias saved1 = .saved1;
	alias saved2 = .saved2;
	alias variaSuitTransformation = .variaSuitTransformation;
	alias unpaused0 = .unpaused0;
	alias unpaused1 = .unpaused1;
	alias unpaused2 = .unpaused2;
	alias exampleA = .exampleA;
	alias exampleB = .exampleB;
	alias exampleC = .exampleC;
	alias exampleD = .exampleD;
	alias exampleE = .exampleE;
}
immutable ubyte[] jumping0= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] jumping1= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(3, 0x8),
    FrequencyOptions(0x5C0, 0)
);
immutable ubyte[] jumping2= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x4),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] jumping3= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x3),
    FrequencyOptions(0x5C0, 0)
);
immutable ubyte[] jumping4= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x2),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] jumping5= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x2),
    FrequencyOptions(0x5C0, 0)
);

immutable ubyte[] hijumping0= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] hijumping1= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(3, 0x7),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] hijumping2= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x3),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] hijumping3= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x3),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] hijumping4= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x2),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] hijumping5= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x2),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] hijumping6= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x1),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] hijumping7= script(
    AscendingSweepOptions(6, 2),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x1),
    FrequencyOptions(0x6C0, 0)
);

immutable ubyte[] screwAttacking0= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x7),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] screwAttacking1= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xB),
    FrequencyOptions(0x560, 0)
);
immutable ubyte[] screwAttacking2= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x5C0, 0)
);
immutable ubyte[] screwAttacking3= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x600, 0)
);
immutable ubyte[] screwAttacking4= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x640, 0)
);
immutable ubyte[] screwAttacking5= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xE),
    FrequencyOptions(0x670, 0)
);
immutable ubyte[] screwAttacking6= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xD),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] screwAttacking7= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x6B0, 0)
);
immutable ubyte[] screwAttacking8= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] screwAttacking9= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x8),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] screwAttackingA= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x8),
    FrequencyOptions(0x6D0, 0)
);
immutable ubyte[] screwAttackingB= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x4),
    FrequencyOptions(0x6E0, 0)
);
immutable ubyte[] screwAttackingC= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x5),
    FrequencyOptions(0x6F0, 0)
);
immutable ubyte[] screwAttackingD= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x5),
    FrequencyOptions(0x700, 0)
);

immutable ubyte[] standingTransition0= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x36, 2),
    DescendingEnvelopeOptions(1, 0x9),
    FrequencyOptions(0x4A0, 1)
);
immutable ubyte[] standingTransition1= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x36, 2),
    DescendingEnvelopeOptions(1, 0x7),
    FrequencyOptions(0x4A0, 1)
);
immutable ubyte[] standingTransition2= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x36, 2),
    DescendingEnvelopeOptions(1, 0x5),
    FrequencyOptions(0x4A0, 1)
);

immutable ubyte[] crouchingTransition0= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x26, 1),
    DescendingEnvelopeOptions(1, 0x9),
    FrequencyOptions(0x4A0, 1)
);
immutable ubyte[] crouchingTransition1= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x26, 1),
    DescendingEnvelopeOptions(1, 0x6),
    FrequencyOptions(0x4A0, 1)
);
immutable ubyte[] crouchingTransition2= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x26, 1),
    DescendingEnvelopeOptions(1, 0x4),
    FrequencyOptions(0x4A0, 1)
);

immutable ubyte[] morphing0= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] morphing1= script(
    DescendingSweepOptions(5, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xC),
    FrequencyOptions(0x750, 0)
);
immutable ubyte[] morphing2= script(
    DescendingSweepOptions(5, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0x6),
    FrequencyOptions(0x750, 0)
);

immutable ubyte[] shootingBeam0= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x6D0, 0)
);
immutable ubyte[] shootingBeam1= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(5, 0x9),
    FrequencyOptions(0x680, 0)
);
immutable ubyte[] shootingBeam2= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(5, 0x9),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] shootingBeam3= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(5, 0x8),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] shootingBeam4= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(5, 0x7),
    FrequencyOptions(0x780, 0)
);

immutable ubyte[] shootingMissile0= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] shootingMissile1= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x5A0, 0)
);
immutable ubyte[] shootingMissile2= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(5, 0x5),
    FrequencyOptions(0x7A0, 0)
);
immutable ubyte[] shootingMissile3= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x6),
    FrequencyOptions(0x600, 0)
);
immutable ubyte[] shootingMissile4= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x620, 0)
);
immutable ubyte[] shootingMissile5= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x9),
    FrequencyOptions(0x640, 0)
);
immutable ubyte[] shootingMissile6= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x8),
    FrequencyOptions(0x660, 0)
);
immutable ubyte[] shootingMissile7= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x6),
    FrequencyOptions(0x680, 0)
);
immutable ubyte[] shootingMissile8= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x4),
    FrequencyOptions(0x6A0, 0)
);
immutable ubyte[] shootingMissile9= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0x3),
    FrequencyOptions(0x6C0, 0)
);

immutable ubyte[] shootingIceBeam= script(
    DescendingSweepOptions(7, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x7),
    FrequencyOptions(0x7D0, 0)
);

immutable ubyte[] shootingPlasmaBeam= script(
    AscendingSweepOptions(7, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x600, 0)
);

immutable ubyte[] shootingSpazerBeam= script(
    DescendingSweepOptions(7, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x7D0, 0)
);

immutable ubyte[] pickingUpMissileDrop0= script(
    AscendingSweepOptions(5, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x8),
    FrequencyOptions(0x6A0, 0)
);
immutable ubyte[] pickingUpMissileDrop1= script(
    AscendingSweepOptions(4, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x710, 0)
);
immutable ubyte[] pickingUpMissileDrop2= script(
    AscendingSweepOptions(4, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xB),
    FrequencyOptions(0x740, 0)
);
immutable ubyte[] pickingUpMissileDrop3= script(
    AscendingSweepOptions(4, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x9),
    FrequencyOptions(0x760, 0)
);
immutable ubyte[] pickingUpMissileDrop4= script(
    AscendingSweepOptions(4, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x6),
    FrequencyOptions(0x780, 0)
);

immutable ubyte[] spiderBall0= script(
    DescendingSweepOptions(2, 2),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x600, 0)
);
immutable ubyte[] spiderBall1= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x5),
    FrequencyOptions(0x600, 0)
);

immutable ubyte[] pickedUpEnergyDrop0= script(
    DescendingSweepOptions(1, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xE),
    FrequencyOptions(0x740, 0)
);
immutable ubyte[] pickedUpEnergyDrop1= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xD),
    FrequencyOptions(0x6F0, 0)
);
immutable ubyte[] pickedUpEnergyDrop2= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x9),
    FrequencyOptions(0x6F0, 0)
);

immutable ubyte[] pickedUpDropEnd= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x3),
    FrequencyOptions(0x6F0, 0)
);

immutable ubyte[] shotMissileDoorWithBeam0= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xC),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] shotMissileDoorWithBeam1= script(
    AscendingSweepOptions(0, 0),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0x4),
    FrequencyOptions(0x7D0, 0)
);

immutable ubyte[] unknown100= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x5A0, 0)
);
immutable ubyte[] unknown101= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x5C0, 0)
);
immutable ubyte[] unknown102= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x5F0, 0)
);
immutable ubyte[] unknown103= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x610, 0)
);
immutable ubyte[] unknown104= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x640, 0)
);
immutable ubyte[] unknown105= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x670, 0)
);
immutable ubyte[] unknown106= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x690, 0)
);
immutable ubyte[] unknown107= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x6A0, 0)
);
immutable ubyte[] unknown108= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] unknown109= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x6E0, 0)
);
immutable ubyte[] unknown10A= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x700, 0)
);

immutable ubyte[] unused12= script(
    AscendingSweepOptions(0, 0),
    LengthDutyOptions(0x0, 0),
    AscendingEnvelopeOptions(0, 0x0),
    FrequencyOptions(0x0, 0)
);

immutable ubyte[] bombLaid= script(
    DescendingSweepOptions(6, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x5),
    FrequencyOptions(0x7C0, 0)
);

immutable ubyte[] unused140= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x400, 0)
);
immutable ubyte[] unused141= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x7D0, 0)
);

immutable ubyte[] optionMissileSelect0= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] optionMissileSelect1= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x640, 0)
);

immutable ubyte[] shootingWaveBeam0= script(
    AscendingSweepOptions(6, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x6D0, 0)
);
immutable ubyte[] shootingWaveBeam1= script(
    AscendingSweepOptions(6, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x680, 0)
);
immutable ubyte[] shootingWaveBeam2= script(
    AscendingSweepOptions(6, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x6C0, 0)
);
immutable ubyte[] shootingWaveBeam3= script(
    AscendingSweepOptions(6, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0x8),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] shootingWaveBeam4= script(
    AscendingSweepOptions(7, 1),
    LengthDutyOptions(0x0, 1),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x7A0, 0)
);

immutable ubyte[] largeEnergyDrop0= script(
    DescendingSweepOptions(1, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x740, 0)
);
immutable ubyte[] largeEnergyDrop1= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xE),
    FrequencyOptions(0x710, 0)
);
immutable ubyte[] largeEnergyDrop2= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x710, 0)
);
immutable ubyte[] largeEnergyDrop3= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xA),
    FrequencyOptions(0x710, 0)
);
immutable ubyte[] largeEnergyDrop4= script(
    AscendingSweepOptions(4, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x3),
    FrequencyOptions(0x710, 0)
);

immutable ubyte[] samusHealthChanged0= script(
    AscendingSweepOptions(6, 1),
    LengthDutyOptions(0x3D, 2),
    DescendingEnvelopeOptions(5, 0x5),
    FrequencyOptions(0x750, 0)
);
immutable ubyte[] samusHealthChanged1= script(
    AscendingSweepOptions(0, 0),
    LengthDutyOptions(0x3D, 2),
    DescendingEnvelopeOptions(5, 0x5),
    FrequencyOptions(0x7A0, 0)
);

immutable ubyte[] noMissileDudShot0= script(
    AscendingSweepOptions(4, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x6A0, 0)
);
immutable ubyte[] noMissileDudShot1= script(
    AscendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x6A0, 0)
);

immutable ubyte[] unknown1A0= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x7C0, 0)
);
immutable ubyte[] unknown1A1= script(
    DescendingSweepOptions(1, 3),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x7D0, 0)
);
immutable ubyte[] unknown1A2= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(1, 0xE),
    FrequencyOptions(0x7C4, 0)
);
immutable ubyte[] unknown1A3= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(1, 0xD),
    FrequencyOptions(0x7CC, 0)
);
immutable ubyte[] unknown1A4= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(1, 0xE),
    FrequencyOptions(0x7D0, 0)
);
immutable ubyte[] unknown1A5= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(1, 0xD),
    FrequencyOptions(0x7D8, 0)
);
immutable ubyte[] unknown1A6= script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x38, 0),
    DescendingEnvelopeOptions(1, 0xE),
    FrequencyOptions(0x7DC, 1)
);

immutable ubyte[] metroidCry= script(
    DescendingSweepOptions(7, 4),
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(6, 0xF),
    FrequencyOptions(0x7F0, 0)
);

immutable ubyte[] saved0= script(
    DescendingSweepOptions(4, 5),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x780, 0)
);
immutable ubyte[] saved1= script(
    AscendingSweepOptions(5, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x8),
    FrequencyOptions(0x782, 0)
);
immutable ubyte[] saved2= script(
    AscendingSweepOptions(5, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x5),
    FrequencyOptions(0x782, 0)
);

immutable ubyte[] variaSuitTransformation= script(
    AscendingSweepOptions(4, 3),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(5, 0xA),
    FrequencyOptions(0x200, 0)
);

immutable ubyte[] unpaused0= script(
    AscendingSweepOptions(3, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x700, 0)
);
immutable ubyte[] unpaused1= script(
    AscendingSweepOptions(5, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x7A2, 0)
);
immutable ubyte[] unpaused2= script(
    AscendingSweepOptions(5, 4),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x5),
    FrequencyOptions(0x7A2, 0)
);

immutable ubyte[] exampleA= script(
    AscendingSweepOptions(7, 7),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x600, 0)
);

immutable ubyte[] exampleB= script(
    AscendingSweepOptions(7, 7),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x6A0, 0)
);

immutable ubyte[] exampleC= script(
    AscendingSweepOptions(7, 7),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x700, 0)
);

immutable ubyte[] exampleD= script(
    AscendingSweepOptions(7, 7),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x740, 0)
);

immutable ubyte[] exampleE= script(
    AscendingSweepOptions(7, 7),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(1, 0xF),
    FrequencyOptions(0x790, 0)
);

struct optionSetsNoise {
	alias enemyShot = .enemyShot;
	alias enemyKilled0 = .enemyKilled0;
	alias enemyKilled1 = .enemyKilled1;
	alias unknown3 = .unknown3;
	alias shotBlockDestroyed = .shotBlockDestroyed;
	alias metroidHurt0 = .metroidHurt0;
	alias metroidHurt1 = .metroidHurt1;
	alias samusHurt0 = .samusHurt0;
	alias samusHurt1 = .samusHurt1;
	alias acidDamage1 = .acidDamage1;
	alias acidDamage0 = .acidDamage0;
	alias shotMissileDoor0 = .shotMissileDoor0;
	alias shotMissileDoor1 = .shotMissileDoor1;
	alias metroidQueenCry0 = .metroidQueenCry0;
	alias metroidQueenCry1 = .metroidQueenCry1;
	alias metroidQueenHurtCry0 = .metroidQueenHurtCry0;
	alias metroidQueenHurtCry1 = .metroidQueenHurtCry1;
	alias samusKilled1 = .samusKilled1;
	alias samusKilled2 = .samusKilled2;
	alias samusKilled3 = .samusKilled3;
	alias bombDetonated0 = .bombDetonated0;
	alias bombDetonated1 = .bombDetonated1;
	alias metroidKilled0 = .metroidKilled0;
	alias metroidKilled1 = .metroidKilled1;
	alias unknownE0 = .unknownE0;
	alias unknownE1 = .unknownE1;
	alias clearedSaveFile0 = .clearedSaveFile0;
	alias clearedSaveFile1 = .clearedSaveFile1;
	alias footsteps0 = .footsteps0;
	alias footsteps1 = .footsteps1;
	alias unknown110 = .unknown110;
	alias unknown1 = .unknown1;
	alias unknown120 = .unknown120;
	alias unused130 = .unused130;
	alias unknown140 = .unknown140;
	alias unknown141 = .unknown141;
	alias unknown150 = .unknown150;
	alias unknown151 = .unknown151;
	alias babyMetroidClearingBlock = .babyMetroidClearingBlock;
	alias babyMetroidCry = .babyMetroidCry;
	alias unknown180 = .unknown180;
	alias unknown181 = .unknown181;
	alias unused19 = .unused19;
	alias unknown1A = .unknown1A;
	alias samusKilled0 = .samusKilled0;
}
immutable ubyte[] enemyShot = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(1, 0x0),
    PolynomialCounterOptions(2, 0, 0x6),
    CounterControlOptions(0),
);

immutable ubyte[] enemyKilled0 = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(1, 0x1),
    PolynomialCounterOptions(3, 0, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] enemyKilled1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(1, 0xF),
    PolynomialCounterOptions(6, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] unknown3 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(2, 0xF),
    PolynomialCounterOptions(4, 1, 0x6),
    CounterControlOptions(0),
);

immutable ubyte[] shotBlockDestroyed = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(1, 0x1),
    PolynomialCounterOptions(5, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] metroidHurt0 = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(1, 0x0),
    PolynomialCounterOptions(5, 1, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] metroidHurt1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(4, 0xF),
    PolynomialCounterOptions(5, 0, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] samusHurt0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xF),
    PolynomialCounterOptions(2, 1, 0x4),
    CounterControlOptions(0),

);
alias samusHurt1 = acidDamage1;
immutable ubyte[] acidDamage1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(5, 0x4),
    PolynomialCounterOptions(2, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] acidDamage0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xF),
    PolynomialCounterOptions(2, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] shotMissileDoor0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xF),
    PolynomialCounterOptions(3, 0, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] shotMissileDoor1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(1, 0xF),
    PolynomialCounterOptions(4, 1, 0x5),
    CounterControlOptions(0),
);

immutable ubyte[] metroidQueenCry0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(2, 0xE),
    PolynomialCounterOptions(6, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] metroidQueenCry1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(6, 0xC),
    PolynomialCounterOptions(5, 0, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] metroidQueenHurtCry0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(2, 0xF),
    PolynomialCounterOptions(2, 1, 0x5),
    CounterControlOptions(0),
);

immutable ubyte[] metroidQueenHurtCry1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(4, 0xF),
    PolynomialCounterOptions(4, 0, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] samusKilled1 = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(5, 0x0),
    PolynomialCounterOptions(4, 0, 0x2),
    CounterControlOptions(0),
);

immutable ubyte[] samusKilled2 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(0, 0xF),
    PolynomialCounterOptions(5, 0, 0x1),
    CounterControlOptions(0),
);

immutable ubyte[] samusKilled3 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0x8),
    PolynomialCounterOptions(4, 0, 0x7),
    CounterControlOptions(0),
);

immutable ubyte[] bombDetonated0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xA),
    PolynomialCounterOptions(3, 0, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] bombDetonated1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(1, 0xF),
    PolynomialCounterOptions(4, 0, 0x6),
    CounterControlOptions(0),
);

immutable ubyte[] metroidKilled0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xF),
    PolynomialCounterOptions(4, 0, 0x6),
    CounterControlOptions(0),
);

immutable ubyte[] metroidKilled1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(3, 0xA),
    PolynomialCounterOptions(2, 0, 0x2),
    CounterControlOptions(0),
);

immutable ubyte[] unknownE0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xF),
    PolynomialCounterOptions(2, 0, 0x2),
    CounterControlOptions(0),
);

immutable ubyte[] unknownE1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(5, 0xA),
    PolynomialCounterOptions(3, 0, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] clearedSaveFile0 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(0, 0xF),
    PolynomialCounterOptions(3, 0, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] clearedSaveFile1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(6, 0xF),
    PolynomialCounterOptions(5, 0, 0x6),
    CounterControlOptions(0),
);

immutable ubyte[] footsteps0 = script(
    LengthOptions(0x3D),
    DescendingEnvelopeOptions(7, 0x3),
    PolynomialCounterOptions(2, 1, 0x2),
    CounterControlOptions(1),
);

immutable ubyte[] footsteps1 = script(
    LengthOptions(0x3C),
    DescendingEnvelopeOptions(5, 0x1),
    PolynomialCounterOptions(2, 1, 0x2),
    CounterControlOptions(1),
);

immutable ubyte[] unknown110 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(3, 0x7),
    PolynomialCounterOptions(7, 0, 0x2),
    CounterControlOptions(0),
);

immutable ubyte[] unknown1 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0x9),
    PolynomialCounterOptions(7, 0, 0x7),
    CounterControlOptions(0),
);

immutable ubyte[] unknown120 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0x8),
    PolynomialCounterOptions(4, 0, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] unused130 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0x8),
    PolynomialCounterOptions(3, 0, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] unknown140 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(1, 0x9),
    PolynomialCounterOptions(4, 1, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] unknown141 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(1, 0x9),
    PolynomialCounterOptions(3, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] unknown150 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xA),
    PolynomialCounterOptions(5, 0, 0x5),
    CounterControlOptions(0),
);

immutable ubyte[] unknown151 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(3, 0xC),
    PolynomialCounterOptions(3, 0, 0x5),
    CounterControlOptions(0),
);

immutable ubyte[] babyMetroidClearingBlock = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(3, 0x1),
    PolynomialCounterOptions(1, 0, 0x3),
    CounterControlOptions(0),
);

immutable ubyte[] babyMetroidCry = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0xA),
    PolynomialCounterOptions(5, 1, 0x7),
    CounterControlOptions(0),
);

immutable ubyte[] unknown180 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(1, 0x6),
    PolynomialCounterOptions(7, 1, 0x2),
    CounterControlOptions(0),
);

immutable ubyte[] unknown181 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(0, 0x6),
    PolynomialCounterOptions(1, 0, 0x2),
    CounterControlOptions(0),
);

immutable ubyte[] unused19 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(3, 0xC),
    PolynomialCounterOptions(1, 0, 0x1),
    CounterControlOptions(0),
);

immutable ubyte[] unknown1A = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(4, 0x4),
    PolynomialCounterOptions(2, 1, 0x4),
    CounterControlOptions(0),
);

immutable ubyte[] samusKilled0 = script(
    LengthOptions(0x0),
    AscendingEnvelopeOptions(0, 0x0),
    PolynomialCounterOptions(0, 0, 0x0),
    CounterControlOptions(0),
);

struct optionSetsSquare2 {
	alias metroidQueenCry = .metroidQueenCry;
	alias babyMetroidClearingBlockSquare2 = .babyMetroidClearingBlockSquare2;
	alias babyMetroidCrySquare2 = .babyMetroidCrySquare2;
	alias metroidQueenHurtCry = .metroidQueenHurtCry;
	alias unknown7 = .unknown7;
}
immutable ubyte[] metroidQueenCry = script(
    LengthDutyOptions(0x0, 0),
    DescendingEnvelopeOptions(4, 0xF),
    FrequencyOptions(0x700, 0),
);
immutable ubyte[] babyMetroidClearingBlockSquare2 = script(
    LengthDutyOptions( 0x0, 0),
    DescendingEnvelopeOptions( 7, 0x9),
    FrequencyOptions( 0x790, 0),
);
immutable ubyte[] babyMetroidCrySquare2 = script(
    LengthDutyOptions( 0x0, 1),
    DescendingEnvelopeOptions( 7, 0x5),
    FrequencyOptions( 0x700, 0),
);
immutable ubyte[] metroidQueenHurtCry = script(
    LengthDutyOptions( 0x0, 1),
    DescendingEnvelopeOptions( 7, 0xF),
    FrequencyOptions( 0x700, 0),
);
immutable ubyte[] unknown7 = script(
    LengthDutyOptions( 0x0, 0),
    DescendingEnvelopeOptions( 7, 0x8),
    FrequencyOptions( 0x200, 0),
);

immutable ubyte[][] pausedOptionSets = [
	frame40,
	frame3D,
	frame3F,
	frame3A,
	frame32,
	frame2F,
	frame27,
	frame24,
];
immutable ubyte[] frame40 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(7, 0x8),
    PolynomialCounterOptions(1, 0, 0x3),
    CounterControlOptions(0),
);
immutable ubyte[] frame3D = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(3, 0x8),
    PolynomialCounterOptions(5, 1, 0x5),
    CounterControlOptions(0),
);
immutable ubyte[] frame3F = script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xF),
    FrequencyOptions(0x7C0, 0),
);
immutable ubyte[] frame3A = script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0xC),
    FrequencyOptions(0x7D0, 0),
);
immutable ubyte[] frame32 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(3, 0x5),
    PolynomialCounterOptions(4, 1, 0x5),
    CounterControlOptions(0),
);
immutable ubyte[] frame2F = script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x7),
    FrequencyOptions(0x7D5, 0),
);
immutable ubyte[] frame27 = script(
    LengthOptions(0x0),
    DescendingEnvelopeOptions(6, 0x3),
    PolynomialCounterOptions(3, 1, 0x5),
    CounterControlOptions(0),
);
immutable ubyte[] frame24 = script(
    DescendingSweepOptions(5, 1),
    LengthDutyOptions(0x0, 2),
    DescendingEnvelopeOptions(7, 0x4),
    FrequencyOptions(0x7D9, 0),
);

private ubyte EnvelopeOptions(ubyte a, ubyte b, ubyte c) {
	assert(a < 8);
	assert(b < 2);
	assert(c < 16);
	return cast(ubyte)(a | (b << 3) | (c << 4));
}
private ubyte SweepOptions(ubyte sweeps, ubyte direction, ubyte time) {
	assert(sweeps < 8);
	assert(direction < 2);
	assert(time < 8);
	return cast(ubyte)(sweeps | (direction << 3) | (time << 4));
}
private ubyte[] LengthOptions(ubyte length) {
	assert(length < 64);
	return [length];
}
private ubyte[] DescendingEnvelopeOptions(ubyte sweeps, ubyte initial) {
	return [EnvelopeOptions(sweeps, 0, initial)];
}
private ubyte[] AscendingEnvelopeOptions(ubyte sweeps, ubyte initial) {
	return [EnvelopeOptions(sweeps, 1, initial)];
}
private ubyte[] DescendingSweepOptions(ubyte sweeps, ubyte time) {
	return [EnvelopeOptions(sweeps, 1, time)];
}
private ubyte[] AscendingSweepOptions(ubyte sweeps, ubyte time) {
	return [EnvelopeOptions(sweeps, 0, time)];
}

private ubyte[] PolynomialCounterOptions(ubyte mantissa, ubyte width, ubyte frequency) {
	assert(mantissa < 8);
	assert(width < 2);
	assert(frequency < 16);
	return [cast(ubyte)(mantissa | (width << 3) | (frequency << 4))];
}

private ubyte[] LengthDutyOptions(ubyte length, ubyte duty) {
	assert(length < 64);
	assert(duty < 4);
	return [cast(ubyte)(length | (duty << 6))];
}

private ubyte[] FrequencyOptions(ushort frequency, ubyte stops) {
	assert(frequency < 0x800);
	assert(stops < 2);
	return [frequency & 0xFF, cast(ubyte)(((frequency & 0xFF) >> 8) | (stops << 14) | (1 << 15))];
}

private ubyte[] CounterControlOptions(ubyte stops) {
	assert(stops < 2);
	return [cast(ubyte)((stops << 6) | (1 << 7))];
}

private ubyte[] script(scope ubyte[] delegate()[] commands...) {
	ubyte[] newBuffer;
	foreach (command; commands) {
		newBuffer ~= command();
	}
	return newBuffer;
}

immutable ubyte[] songStereoFlags = [
   Song.babyMetroid: 0xFF,
   Song.metroidQueenBattle: 0xFF,
   Song.chozoRuins: 0xFF,
   Song.mainCaves: 0xFF,
   Song.subCaves1: 0xFF,
   Song.subCaves2: 0xFF,
   Song.subCaves3: 0xFF,
   Song.finalCaves: 0xFF,
   Song.metroidHive: 0xFF,
   Song.itemGet: 0xDB,
   Song.metroidQueenHallway: 0xFF,
   Song.metroidBattle: 0xFF,
   Song.subCaves4: 0xFF,
   Song.earthquake: 0xDE,
   Song.killedMetroid: 0xDE,
   Song.nothingCopy: 0xFF,
   Song.title: 0xFF,
   Song.samusFanfare: 0xDE,
   Song.reachedTheGunship: 0xFF,
   Song.chozoRuinsCopy: 0xFF,
   Song.mainCavesNoIntro: 0xFF,
   Song.subCaves1NoIntro: 0xFF,
   Song.subCaves2NoIntro: 0xFF,
   Song.subCaves3NoIntro: 0xFF,
   Song.finalCavesCopy: 0xFF,
   Song.metroidHiveCopy: 0xFF,
   Song.itemGetCopy: 0xDB,
   Song.metroidQueenHallwayCopy: 0xFF,
   Song.metroidBattleCopy: 0xFF,
   Song.subCaves4NoIntro: 0xFF,
   Song.metroidHiveWithIntro: 0xFF,
   Song.missilePickup: 0xDE,
];

const(SongHeader)[] songDataTable;

void loadSongs(ref const(SongHeader)[] dest, const(ubyte)[] data, size_t entries) {
    import metroid2.bank04;
    static struct OriginalSongHeader {
        align(1):
        ubyte noteOffset;
        ushort tempo;
        ushort toneSweepChannel;
        ushort toneChannel;
        ushort waveChannel;
        ushort noiseChannel;
    }
    import std.logger;
    static const(ubyte)[] decompileTrack(const(ubyte)[] trackData) {
        for (int idx = 0; idx < trackData.length; idx++) {
            switch (trackData[idx]) {
                case 0:
                    return trackData[0 .. idx + 1];
                case 0xF1:
                    idx += 3;
                    break;
                case 0xF2:
                    idx += 2;
                    break;
                case 0xF3:
                case 0xF4:
                    idx++;
                    break;
                default:
                    break;
            }
        }
        return [];
    }
    static const(ushort)[] decompileTracks(ushort start, const(ubyte)[] data, const(ubyte)[] romData, ref const(ubyte)[][ushort] tracks) {
        ushort[] result;
        size_t remaining = size_t.max;
        foreach (track; cast(const(ushort)[])(data[0 .. $ - ($ % 2)])) {
            if (--remaining == 0) {
                // make jumps relative instead of absolute
                result ~= cast(ushort)((track - start) / 2);
                break;
            }
            result ~= track;
            if (track == 0x0000) {
                break;
            }
            if (track == 0x00F0) {
                remaining = 1;
            } else {
                tracks.require(track, decompileTrack(romData[0x10000 - 0x4000 + track .. $]));
            }
        }
        return result;
    }
    dest.reserve(entries);
    foreach (songIdx, base; cast(const(ushort)[])(data[0x11F30 .. 0x11F30 + entries * 2])) {
        SongHeader newHeader;
        const originalHeader = (cast(const(OriginalSongHeader)[])(data[0x10000 - 0x4000 + base .. 0x10000 - 0x4000 + base + OriginalSongHeader.sizeof]))[0];
        newHeader.noteOffset = originalHeader.noteOffset;
        newHeader.tempo = getTempoData(originalHeader.tempo);
        if (newHeader.tempo.length == 0) {
            tracef("Skipping song %s, invalid header", songIdx);
            dest ~= SongHeader.init;
            continue;
        }
        if (originalHeader.toneSweepChannel != 0) {
            newHeader.toneSweepChannel = decompileTracks(originalHeader.toneSweepChannel, data[0x10000 - 0x4000 + originalHeader.toneSweepChannel .. $], data, newHeader.squareTracks);
        }
        if (originalHeader.toneChannel != 0) {
            newHeader.toneChannel = decompileTracks(originalHeader.toneChannel, data[0x10000 - 0x4000 + originalHeader.toneChannel .. $], data, newHeader.squareTracks);
        }
        if (originalHeader.waveChannel != 0) {
            newHeader.waveChannel = decompileTracks(originalHeader.waveChannel, data[0x10000 - 0x4000 + originalHeader.waveChannel .. $], data, newHeader.waveTracks);
        }
        if (originalHeader.noiseChannel != 0) {
            newHeader.noiseChannel = decompileTracks(originalHeader.noiseChannel, data[0x10000 - 0x4000 + originalHeader.noiseChannel .. $], data, newHeader.noiseTracks);
        }
        dest ~= newHeader;
    }
}

struct SongHeader {
	ubyte noteOffset;
	immutable(ubyte)[] tempo;
	const(ushort)[] toneSweepChannel;
	const(ushort)[] toneChannel;
	const(ushort)[] waveChannel;
	const(ushort)[] noiseChannel;
    const(ubyte)[][ushort] squareTracks;
    const(ubyte)[][ushort] waveTracks;
    const(ubyte)[][ushort] noiseTracks;
}
