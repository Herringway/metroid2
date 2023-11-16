import metroid2.bank00;
import metroid2.data;
import metroid2.external;

import librehome.gameboy;

struct GameSettings {}

void main() {
	gb.entryPoint = &start;
	gb.interruptHandler = &vblank;
	gb.title = "Metroid II: Return of Samus";
	gb.sourceFile = "metroid2.gb";
	gb.saveFile = "metroid2.sav";
	loadData(gb.romData);
	gb.loadSettings!GameSettings();
	gb.run();
}
