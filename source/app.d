import metroid2.bank00;
import metroid2.data;
import metroid2.external;

import librehome;
import librehome.gameboy;

import d_imgui.imgui_h;
import ImGui = d_imgui;

struct GameSettings {}

void main() {
	gb.entryPoint = &start;
	gb.interruptHandler = &vblank;
	gb.title = "Metroid II: Return of Samus";
	gb.sourceFile = "metroid2.gb";
	gb.saveFile = "metroid2.sav";
	loadData(gb.romData);
	gb.loadSettings!GameSettings();
	gb.debugMenuRenderer = &debugFunction;
	gb.run();
}
void debugFunction(const UIState state) {
	import metroid2.defs;
	import metroid2.globals;
	ImGui.SetNextWindowSize(ImGui.ImVec2(state.width, state.height));
	ImGui.SetNextWindowPos(ImGui.ImVec2(state.x, state.y));
	ImGui.Begin("Debugging", null, ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoBringToFrontOnFocus);
	if (ImGui.TreeNode("Samus")) {
		InputEditable("Pose", samusPose);
		InputEditable("Health", samusCurHealth);
		InputEditable("Energy Tanks", samusEnergyTanks);
		InputEditable("Missiles", samusCurMissiles);
		InputEditable("Missiles Max", samusMaxMissiles);
		InputEditable("Active weapon", samusActiveWeapon);
		InputEditable("Equipped beam", samusBeam);
		InputEditable("Coords", samusX, samusY);
		foreach (idx, flagName; ["Bombs", "High Jump Boots", "Screw Attack", "Space Jump", "Spring Ball", "Spider Ball", "Varia Suit", "???"]) {
			const mask = 1 << idx;
			bool flagEnabled = !!(samusItems & mask);
			if (ImGui.Checkbox(flagName, &flagEnabled)) {
				samusItems = cast(ubyte)((samusItems & ~mask) | (flagEnabled * mask));
			}
		}
		ImGui.TreePop();
	}
	ImGui.End();
}