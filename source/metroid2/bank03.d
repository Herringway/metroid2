module metroid2.bank03;

import metroid2.defs;
import metroid2.globals;

immutable ubyte[] enemyDamageTable = [
	0x08, // Tsumari
	0x08, // Tsumari
	0x08, // Tsumari
	0x08, // Tsumari
	0x10, // Skreek
	0x10, // Skreek
	0x10, // Skreek
	0x10, // Skreek
	0x03, // Skreek projectile
	0x10, // Drivel
	0x10, // Drivel
	0x10, // Drivel
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x05, // Small bugs
	0x05, // Small bugs
	0x10, // Hornoad
	0x10, // Hornoad
	0x15, // Senjoo
	0x08, // Gawron
	0x08, // Gawron
	0x00, // Gawron spawner?
	0x00, // Gawron spawner?
	0x12, // Chute leech
	0x12, // Chute leech
	0x12, // Chute leech
	0x15, // (uses same spritemap as 41h autrack)
	0x15, // (uses same spritemap as 4Ah wallfire)
	0x10, // Needler
	0x10, // Needler
	0x10, // Needler
	0x10, // Needler
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x11, // Skorp
	0x11, // Skorp
	0x11, // Skorp
	0x11, // Skorp
	0x10, // Glow fly
	0x10, // Glow fly
	0x10, // Glow fly
	0x10, // Glow fly
	0x13, // Moheek
	0x13, // Moheek
	0x13, // Moheek
	0x13, // Moheek
	0x00, // Rock icicle
	0x08, // Rock icicle
	0x08, // Rock icicle
	0x08, // Rock icicle
	0x12, // Yumee
	0x12, // Yumee
	0x12, // Yumee
	0x12, // Yumee
	0x00, // Yumee spawner?
	0x00, // Yumee spawner?
	0x20, // Octroll
	0x20, // Octroll
	0x20, // Octroll
	0x15, // Autrack
	0x15, // Autrack
	0x15, // Autrack
	0x15, // Autrack
	0x10, // Autrack projectile
	0x15, // Autoad
	0x15, // Autoad
	0x00, // Sideways Autoad (unused)
	0x00, // Sideways Autoad (unused)
	0x15, // Wallfire
	0x15, // Wallfire
	0xFF, // Wallfire
	0x10, // Wallfire projectile
	0x10, // Wallfire projectile
	0x10, // Wallfire projectile
	0x10, // Wallfire projectile
	0x15, // Gunzoo
	0x15, // Gunzoo
	0x15, // Gunzoo
	0x08, // Gunzoo diagonal projectile
	0x08, // Gunzoo diagonal projectile
	0x08, // Gunzoo diagonal projectile
	0x08, // Gunzoo horizontal projectile
	0x08, // Gunzoo horizontal projectile (unused frame)
	0x08, // Gunzoo horizontal projectile
	0x08, // Gunzoo horizontal projectile
	0x08, // Gunzoo horizontal projectile
	0x15, // Autom
	0x15, // Autom
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x15, // Shirk
	0x15, // Shirk
	0xFF, // Septogg
	0xFF, // Septogg
	0x20, // Moto
	0x20, // Moto
	0x20, // Moto
	0x10, // Halzyn
	0x20, // Ramulken
	0x20, // Ramulken
	0x00, // Musical stinger event trigger
	0xFF, // (uses same spritemap as 72h proboscum)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0xFF, // Proboscum
	0x00, // Proboscum
	0x00, // Proboscum
	0xFF, // Missile block
	0x20, // Arachnus
	0x20, // Arachnus
	0x20, // Arachnus
	0x20, // Arachnus
	0x20, // Arachnus
	0x02, // Arachnus projectile
	0x02, // Arachnus projectile
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0xFF, // Plasma beam orb
	0x00, // Plasma beam
	0xFF, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	0x00, // Ice beam
	0xFF, // Wave beam orb
	0x00, // Wave beam
	0xFF, // Spazer beam orb
	0x00, // Spazer beam
	0xFF, // Bombs orb
	0x00, // Bombs
	0xFF, // Screw attack orb
	0x00, // Screw attack
	0xFF, // Varia suit orb
	0x00, // Varia suit
	0xFF, // Hi-jump boots orb
	0x00, // Hi-jump boots
	0xFF, // Space jump orb
	0x00, // Space jump
	0xFF, // (spider ball orb?)
	0x00, // Spider ball
	0xFF, // (spring ball orb?)
	0x00, // Spring ball
	0xFF, // (energy tank orb?)
	0x00, // Energy tank
	0xFF, // (missile tank orb?)
	0x00, // Missile tank
	0x30, // Blob thrower (sprite is written to WRAM)
	0x00, // Energy refill
	0xFF, // Arachnus orb
	0x00, // Missile refill
	0x10, // Blob thrower projectile
	0x10, // Blob thrower projectile
	0xFE, // Metroid
	0x00, // Metroid hatching
	0x00, // (no graphics)
	0x10, // Alpha metroid
	0x10, // Alpha metroid
	0xFF, // Baby metroid egg
	0xFF, // Baby metroid egg
	0xFF, // Baby metroid egg
	0x00, // Baby metroid
	0x00, // Baby metroid
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x15, // Gamma metroid
	0x15, // Gamma metroid projectile
	0x15, // Gamma metroid projectile
	0x15, // Gamma metroid
	0x00, // (no graphics)
	0x00, // Gamma metroid shell
	0x20, // Zeta metroid hatching
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x00, // Zeta metroid
	0x00, // Zeta metroid
	0x00, // Zeta metroid
	0x00, // Zeta metroid
	0x10, // Zeta metroid projectile
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x00, // Omega metroid
	0x00, // Omega metroid
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // (omega metroid projectile?)
	0xFE, // Metroid
	0xFE, // Metroid (hurt)
	0xFF, // Flitt
	0xFF, // Flitt
	0x00, // Stalagtite (unused)
	0x10, // Gravitt
	0x10, // Gravitt
	0x10, // Gravitt
	0x10, // Gravitt
	0x10, // Gravitt
	0x12, // Gullugg
	0x12, // Gullugg
	0x12, // Gullugg
	0x00, // Baby metroid egg preview
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // Small health drop
	0x00, // Small health drop
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Enemy death explosion
	0x00, // Enemy death explosion
	0x00, // Enemy death explosion
	0x00, // Enemy death explosion (extra frame for enemies not dropping small health)
	0x00, // Big energy drop
	0x00, // Big energy drop
	0x00, // Missile drop
	0x00, // Missile drop
	0x40, // Metroid Queen neck (no graphics)
	0x40, // Metroid Queen head left half (no graphics)
	0x20, // Metroid Queen projectile/head right half (no graphics)
	0x40, // Metroid Queen body (no graphics)
	0x00, // (no graphics)
	0x40, // Metroid Queen mouth closed (no graphics)
	0x40, // Metroid Queen mouth open (no graphics)
	0xFF, // Metroid Queen mouth stunned (no graphics)
	0xFF, // Missile door
	0xFF, // (no graphics)
	0xFF, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // Nothing - flitt (no graphics)
	0x00, // ?
];

const Rectangle*[] enemyHitboxes = [
	&hitboxBlock, // Tsumari
	&hitboxBlock, // Tsumari
	&hitboxBlock, // Tsumari
	&hitboxBlock, // Tsumari
	&hitbox6A6F, // Skreek
	&hitbox6A6F, // Skreek
	&hitbox6A6F, // Skreek
	&hitbox6A6F, // Skreek
	&hitboxTile, // Skreek projectile
	&hitbox6A4B, // Drivel
	&hitbox6A7F, // Drivel
	&hitbox6A77, // Drivel
	&hitboxTile, // Drivel projectile
	&hitboxTile, // Drivel projectile
	&hitboxTile, // Drivel projectile
	&hitbox6A43, // Drivel projectile
	&hitbox6A7B, // Drivel projectile
	&hitbox6AA7, // Drivel projectile
	&hitbox6A43, // Small bugs
	&hitbox6A43, // Small bugs
	&hitbox6A6F, // Hornoad
	&hitbox6A6F, // Hornoad
	&hitbox6A6F, // Senjoo
	&hitboxBlock, // Gawron
	&hitboxBlock, // Gawron
	&hitboxPoint, // Gawron spawner?
	&hitboxPoint, // Gawron spawner?
	&hitbox6A47, // Chute leech
	&hitboxBlock, // Chute leech
	&hitbox6A6F, // Chute leech
	&hitboxBlock, // (uses same spritemap as 41h autrack)
	&hitbox6A8F, // (uses same spritemap as 4Ah wallfire)
	&hitboxBlock, // Needler
	&hitboxBlock, // Needler
	&hitboxBlock, // Needler
	&hitboxBlock, // Needler
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitbox6A93, // Skorp
	&hitbox6A93, // Skorp
	&hitbox6A6F, // Skorp
	&hitbox6A6F, // Skorp
	&hitbox6A8F, // Glow fly
	&hitbox6A8F, // Glow fly
	&hitboxBlock, // Glow fly
	&hitboxBlock, // Glow fly
	&hitboxBlock, // Moheek
	&hitboxBlock, // Moheek
	&hitboxBlock, // Moheek
	&hitboxBlock, // Moheek
	&hitboxTile, // Rock icicle
	&hitboxTile, // Rock icicle
	&hitbox6A67, // Rock icicle
	&hitbox6A67, // Rock icicle
	&hitboxBlock, // Yumee
	&hitboxBlock, // Yumee
	&hitbox6A5B, // Yumee
	&hitbox6A5B, // Yumee
	&hitboxPoint, // Yumee spawner?
	&hitboxPoint, // Yumee spawner?
	&hitboxOctroll, // Octroll
	&hitboxOctroll, // Octroll
	&hitboxOctroll, // Octroll
	&hitboxBlock, // Autrack
	&hitboxAutrackMid, // Autrack
	&hitboxAutrackTall, // Autrack
	&hitboxAutrackTall, // Autrack
	&hitbox6A43, // Autrack projectile
	&hitbox6A6F, // Autoad
	&hitbox6A6F, // Autoad
	&hitbox6A93, // Sideways Autoad (unused)
	&hitbox6A93, // Sideways Autoad (unused)
	&hitbox6A8F, // Wallfire
	&hitbox6A8F, // Wallfire
	&hitbox6A8F, // Wallfire
	&hitboxTile, // Wallfire projectile
	&hitboxTile, // Wallfire projectile
	&hitbox6A67, // Wallfire projectile
	&hitbox6AB7, // Wallfire projectile
	&hitbox6A97, // Gunzoo
	&hitbox6A97, // Gunzoo
	&hitbox6A97, // Gunzoo
	&hitboxTile, // Gunzoo diagonal projectile
	&hitbox6A67, // Gunzoo diagonal projectile
	&hitbox6AB7, // Gunzoo diagonal projectile
	&hitboxTile, // Gunzoo horizontal projectile
	&hitboxTile, // Gunzoo horizontal projectile (unused frame)
	&hitbox6A67, // Gunzoo horizontal projectile
	&hitbox6ACF, // Gunzoo horizontal projectile
	&hitbox6ADB, // Gunzoo horizontal projectile
	&hitbox6A97, // Autom
	&hitbox6A97, // Autom
	&hitboxTile, // Autom projectile
	&hitbox6A8F, // Autom projectile
	&hitbox6ACF, // Autom projectile
	&hitbox6ACF, // Autom projectile
	&hitbox6ACF, // Autom projectile
	&hitbox6A97, // Shirk
	&hitbox6A97, // Shirk
	&hitbox6A93, // Septogg
	&hitbox6A93, // Septogg
	&hitbox6A93, // Moto
	&hitbox6A93, // Moto
	&hitbox6A93, // Moto
	&hitbox6A67, // Halzyn
	&hitbox6A6F, // Ramulken
	&hitbox6A6F, // Ramulken
	&hitboxBlock, // Musical stinger event trigger
	&hitbox6A43, // (uses same spritemap as 72h proboscum)
	&hitbox6A43, // (no graphics)
	&hitbox6A43, // (no graphics)
	&hitbox6A43, // (no graphics)
	&hitbox6A47, // Proboscum
	&hitboxPoint, // Proboscum
	&hitboxPoint, // Proboscum
	&hitboxBlock, // Missile block
	&hitboxBlock, // Arachnus
	&hitboxBlock, // Arachnus
	&hitbox6ABB, // Arachnus
	&hitbox6ABB, // Arachnus
	&hitbox6ABB, // Arachnus
	&hitbox6A77, // Arachnus projectile
	&hitbox6A77, // Arachnus projectile
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxBlock, // Plasma beam orb
	&hitboxTile, // Plasma beam
	&hitboxBlock, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	&hitboxTile, // Ice beam
	&hitboxBlock, // Wave beam orb
	&hitboxTile, // Wave beam
	&hitboxBlock, // Spazer beam orb
	&hitboxTile, // Spazer beam
	&hitboxBlock, // Bombs orb
	&hitboxTile, // Bombs
	&hitboxBlock, // Screw attack orb
	&hitboxTile, // Screw attack
	&hitboxBlock, // Varia suit orb
	&hitboxTile, // Varia suit
	&hitboxBlock, // Hi-jump boots orb
	&hitboxTile, // Hi-jump boots
	&hitboxBlock, // Space jump orb
	&hitboxTile, // Space jump
	&hitboxBlock, // (spider ball orb?)
	&hitboxTile, // Spider ball
	&hitboxBlock, // (spring ball orb?)
	&hitboxTile, // Spring ball
	&hitboxBlock, // (energy tank orb?)
	&hitboxTile, // Energy tank
	&hitboxBlock, // (missile tank orb?)
	&hitboxTile, // Missile tank
	&hitboxC360, // Blob thrower (sprite is written to WRAM)
	&hitboxRefill, // Energy refill
	&hitboxBlock, // Arachnus orb
	&hitboxRefill, // Missile refill
	&hitboxTile, // Blob thrower projectile
	&hitboxTile, // Blob thrower projectile
	&hitboxMetroid, // Metroid
	&hitboxAlphaMetroid, // Metroid hatching
	&hitboxAlphaMetroid, // (no graphics)
	&hitboxAlphaMetroid, // Alpha metroid
	&hitboxAlphaMetroid, // Alpha metroid
	&hitbox6A97, // Baby metroid egg
	&hitbox6A97, // Baby metroid egg
	&hitbox6A97, // Baby metroid egg
	&hitboxBlock, // Baby metroid
	&hitboxBlock, // Baby metroid
	&hitboxTile, // (no graphics)
	&hitbox6A5F, // (no graphics)
	&hitbox6A63, // (no graphics)
	&hitbox6A9F, // Gamma metroid
	&hitbox6A9F, // Gamma metroid projectile
	&hitbox6A9F, // Gamma metroid projectile
	&hitbox6AC3, // Gamma metroid
	&hitboxTile, // (no graphics)
	&hitboxPoint, // Gamma metroid shell
	&hitbox6ABB, // Zeta metroid hatching
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitboxTile, // Zeta metroid projectile
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxPoint, // Omega metroid
	&hitboxPoint, // Omega metroid
	&hitboxTile, // Omega metroid projectile
	&hitboxTile, // Omega metroid projectile
	&hitbox6A43, // Omega metroid projectile
	&hitbox6A4F, // Omega metroid projectile
	&hitbox6A53, // Omega metroid projectile
	&hitbox6A57, // Omega metroid projectile
	&hitboxTile, // Omega metroid projectile
	&hitboxTile, // (omega metroid projectile?)
	&hitboxMetroid, // Metroid
	&hitboxMetroid, // Metroid (hurt)
	&hitboxBlock, // Flitt
	&hitboxBlock, // Flitt
	&hitboxPoint, // Stalagtite (unused)
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitbox6A93, // Gullugg
	&hitbox6A93, // Gullugg
	&hitbox6A93, // Gullugg
	&hitboxPoint, // Baby metroid egg preview
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxTile, // Small health drop
	&hitboxTile, // Small health drop
	&hitboxBlock, // Metroid death / missile door / screw attack explosion
	&hitboxBlock, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitboxBlock, // Enemy death explosion
	&hitboxTile, // Enemy death explosion
	&hitbox6A97, // Enemy death explosion
	&hitbox6ABF, // Enemy death explosion (extra frame for enemies not dropping small health)
	&hitboxBlock, // Big energy drop
	&hitboxBlock, // Big energy drop
	&hitboxTile, // Missile drop
	&hitboxTile, // Missile drop
	&hitbox6A8B, // Metroid Queen neck (no graphics)
	&hitbox6AD7, // Metroid Queen head left half (no graphics)
	&hitbox6AAB, // Metroid Queen projectile/head right half (no graphics)
	&hitbox6AE3, // Metroid Queen body (no graphics)
	&hitboxPoint, // (no graphics)
	&hitbox6AD7, // Metroid Queen mouth closed (no graphics)
	&hitbox6ACB, // Metroid Queen mouth open (no graphics)
	&hitbox6ACB, // Metroid Queen mouth stunned (no graphics)
	&hitboxMissileDoor, // Missile door
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // Nothing - flitt (no graphics)
	&hitboxTile, // ?
];


immutable hitboxPoint = Rectangle(0, 0, 0, 0);
immutable hitboxRefill = Rectangle(1, 1, 1, 1);
immutable hitboxTile = Rectangle(-4, 3, -4, 3);
immutable hitbox6A43 = Rectangle(-4, 3, -8, 7);
immutable hitbox6A47 = Rectangle(-4, 3, -12, 11);
immutable hitbox6A4B = Rectangle(-4, 3, -16, 15);
immutable hitbox6A4F = Rectangle(-4, 3, -20, 19);
immutable hitbox6A53 = Rectangle(-4, 3, -24, 23);
immutable hitbox6A57 = Rectangle(-4, 3, -28, 27);
immutable hitbox6A5B = Rectangle(-8, 0, -8, 16);
immutable hitbox6A5F = Rectangle(-4, 3, -12, 3);
immutable hitbox6A63 = Rectangle(-4, 3, -20, 3);
immutable hitbox6A67 = Rectangle(-8, 7, -4, 3);
immutable hitboxBlock = Rectangle(-8, 7, -8, 7);
immutable hitbox6A6F = Rectangle(-8, 7, -12, 11);
immutable hitboxOctroll = Rectangle(-8, 7, -16, 15);
immutable hitbox6A77 = Rectangle(-4, 11, -8, 7);
immutable hitbox6A7B = Rectangle(-12, 3, -12, 11);
immutable hitbox6A7F = Rectangle(-4, 11, -12, 11);
immutable hitbox6A83 = Rectangle(-4, 11, -12, 3);
immutable hitboxMetroid = Rectangle(-11, 9, -12, 11);
immutable hitbox6A8B = Rectangle(0, 15, 0, 7);
immutable hitbox6A8F = Rectangle(-12, 11, -4, 3);
immutable hitbox6A93 = Rectangle(-12, 11, -8, 7);
immutable hitbox6A97 = Rectangle(-12, 11, -12, 11);
immutable hitboxAlphaMetroid = Rectangle(-12, 11, -16, 15);
immutable hitbox6A9F = Rectangle(-12, 11, -20, 19);
immutable hitboxAutrackMid = Rectangle(-16, 7, -8, 7);
immutable hitbox6AA7 = Rectangle(-20, 3, -4, 19);
immutable hitbox6AAB = Rectangle(0, 19, 0, 8);
immutable hitbox6AAF = Rectangle(-4, 19, -12, 3);
immutable hitboxOmegaMetroid = Rectangle(-12, 19, -8, 7);
immutable hitbox6AB7 = Rectangle(-16, 15, -4, 3);
immutable hitbox6ABB = Rectangle(-16, 15, -12, 11);
immutable hitbox6ABF = Rectangle(-16, 15, -16, 15);
immutable hitbox6AC3 = Rectangle(-16, 15, -20, 19);
immutable hitboxAutrackTall = Rectangle(-24, 7, -8, 7);
immutable hitbox6ACB = Rectangle(0, 33, 0, 18);
immutable hitbox6ACF = Rectangle(-20, 19, -4, 3);
immutable hitbox6AD3 = Rectangle(-20, 19, -20, 19);
immutable hitbox6AD7 = Rectangle(0, 39, 0, 31);
immutable hitbox6ADB = Rectangle(-24, 23, -4, 3);
immutable hitboxMissileDoor = Rectangle(-24, 23, -24, 23);
immutable hitbox6AE3 = Rectangle(0, 55, 0, 47);
