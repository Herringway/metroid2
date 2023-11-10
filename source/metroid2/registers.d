module metroid2.registers;

import metroid2.external;

ref auto JOYP() { return gb.registers.JOYP; }
ref auto SB() { return gb.registers.SB; }
ref auto SC() { return gb.registers.SC; }
ref auto DIV() { return gb.registers.DIV; }
ref auto TIMA() { return gb.registers.TIMA; }
ref auto TMA() { return gb.registers.TMA; }
ref auto TAC() { return gb.registers.TAC; }
ref auto IF() { return gb.registers.IF; }
ref auto LCDC() { return gb.registers.LCDC; }
ref auto STAT() { return gb.registers.STAT; }
ref auto SCY() { return gb.registers.SCY; }
ref auto SCX() { return gb.registers.SCX; }
ref auto LY() { return gb.registers.LY; }
ref auto LYC() { return gb.registers.LYC; }
ref auto BGP() { return gb.registers.BGP; }
ref auto OBP0() { return gb.registers.OBP0; }
ref auto OBP1() { return gb.registers.OBP1; }
ref auto WY() { return gb.registers.WY; }
ref auto WX() { return gb.registers.WX; }
ref auto IE() { return gb.registers.IE; }
ref auto NR10() { return gb.registers.NR10; }
ref auto NR11() { return gb.registers.NR11; }
ref auto NR12() { return gb.registers.NR12; }
ref auto NR13() { return gb.registers.NR13; }
ref auto NR14() { return gb.registers.NR14; }
ref auto NR21() { return gb.registers.NR21; }
ref auto NR22() { return gb.registers.NR22; }
ref auto NR23() { return gb.registers.NR23; }
ref auto NR24() { return gb.registers.NR24; }
ref auto NR30() { return gb.registers.NR30; }
ref auto NR31() { return gb.registers.NR31; }
ref auto NR32() { return gb.registers.NR32; }
ref auto NR33() { return gb.registers.NR33; }
ref auto NR34() { return gb.registers.NR34; }
ref auto NR41() { return gb.registers.NR41; }
ref auto NR42() { return gb.registers.NR42; }
ref auto NR43() { return gb.registers.NR43; }
ref auto NR44() { return gb.registers.NR44; }
ref auto NR50() { return gb.registers.NR50; }
ref auto NR51() { return gb.registers.NR51; }
ref auto NR52() { return gb.registers.NR52; }

ref auto waveRAM() { return gb.registers.waveRAM; };

alias AUD1SWEEP = NR10;
alias AUD1LEN = NR11;
alias AUD1ENV = NR12;
alias AUD1LOW = NR13;
alias AUD1HIGH = NR14;
alias AUD2LEN = NR21;
alias AUD2ENV = NR22;
alias AUD2LOW = NR23;
alias AUD2HIGH = NR24;
alias AUD3ENA = NR30;
alias AUD3LEN = NR31;
alias AUD3LEVEL = NR32;
alias AUD3LOW = NR33;
alias AUD3HIGH = NR34;
alias AUD4LEN = NR41;
alias AUD4ENV = NR42;
alias AUD4POLY = NR43;
alias AUD4GO = NR44;
alias AUDVOL = NR50;
alias AUDTERM = NR51;
alias AUDENA = NR52;
