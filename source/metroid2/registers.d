module metroid2.registers;

__gshared ubyte JOYP; //FF00
__gshared ubyte SB; //FF01
__gshared ubyte SC; //FF02
__gshared ubyte DIV; //FF04
__gshared ubyte TIMA; //FF05
__gshared ubyte TMA; //FF06
__gshared ubyte TAC; //FF07
__gshared ubyte IF; // FF0F
__gshared ubyte LCDC; //FF40
__gshared ubyte STAT; //FF41
__gshared ubyte SCY; //FF42
__gshared ubyte SCX; //FF43
__gshared ubyte LY; //FF44
__gshared ubyte LYC; //FF45
__gshared ubyte BGP; //FF47
__gshared ubyte OBP0; //FF48
__gshared ubyte OBP1; //FF49
__gshared ubyte WY; //FF4A
__gshared ubyte WX; //FF4B
__gshared ubyte IE; //FFFF

debug(loggableRegisters) {
	import std.logger;
	struct RegType(string name) {
		private ubyte value;
		alias this = get;
		void opAssign(ubyte n) {
			infof("%s: Writing %02X", name, n);
			value = n;
		}
		ubyte get() {
			infof("%s: Reading %02X", name, value);
			return value;
		}
	}
} else {
	alias RegType(string _) = ubyte;
}
__gshared RegType!"NR10" NR10; //FF10
alias AUD1SWEEP = NR10;
__gshared RegType!"NR11" NR11; //FF11
alias AUD1LEN = NR11;
__gshared RegType!"NR12" NR12; //FF12
alias AUD1ENV = NR12;
__gshared RegType!"NR13" NR13; //FF13
alias AUD1LOW = NR13;
__gshared RegType!"NR14" NR14; //FF14
alias AUD1HIGH = NR14;
__gshared RegType!"NR21" NR21; //FF16
alias AUD2LEN = NR21;
__gshared RegType!"NR22" NR22; //FF17
alias AUD2ENV = NR22;
__gshared RegType!"NR23" NR23; //FF18
alias AUD2LOW = NR23;
__gshared RegType!"NR24" NR24; //FF19
alias AUD2HIGH = NR24;
__gshared RegType!"NR30" NR30; //FF1A
alias AUD3ENA = NR30;
__gshared RegType!"NR31" NR31; //FF1B
alias AUD3LEN = NR31;
__gshared RegType!"NR32" NR32; //FF1C
alias AUD3LEVEL = NR32;
__gshared RegType!"NR33" NR33; //FF1D
alias AUD3LOW = NR33;
__gshared RegType!"NR34" NR34; //FF1E
alias AUD3HIGH = NR34;
__gshared RegType!"NR41" NR41; //FF20
alias AUD4LEN = NR41;
__gshared RegType!"NR42" NR42; //FF21
alias AUD4ENV = NR42;
__gshared RegType!"NR43" NR43; //FF22
alias AUD4POLY = NR43;
__gshared RegType!"NR44" NR44; //FF23
alias AUD4GO = NR44;
__gshared RegType!"NR50" NR50; //FF24
alias AUDVOL = NR50;
__gshared RegType!"NR51" NR51; //FF25
alias AUDTERM = NR51;
__gshared RegType!"NR52" NR52; //FF26
alias AUDENA = NR52;

__gshared ubyte[16] waveRAM; //FF30
