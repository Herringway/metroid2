import metroid2.bank00;
import metroid2.data;
import metroid2.external;

import librehome;
import librehome.gameboy;

import d_imgui.imgui_h;
import ImGui = d_imgui;

import std.format;

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
	if (ImGui.TreeNode("Enemies")) {
		foreach (idx, enemy; enemyDataSlots) {
			if ((enemy.status & 0xF) == 0) {
				if (ImGui.TreeNode(format!"Enemy %s"(idx))) {
					InputEditable("Status", enemy.status);
					InputEditable("Coords", enemy.x, enemy.y);
					InputEditable("Type", enemy.spriteType);
					InputEditable("Attributes", enemy.baseSpriteAttributes);
					InputEditable("Attributes (2)", enemy.spriteAttributes);
					InputEditable("Stun Counter", enemy.stunCounter);
					InputEditable("Misc var", enemy.misc);
					InputEditable("Direction flags", enemy.directionFlags);
					InputEditable("Counter", enemy.counter);
					InputEditable("State", enemy.state);
					InputEditable("Ice Counter", enemy.iceCounter);
					InputEditable("Health", enemy.health);
					InputEditable("Drop type", enemy.dropType);
					InputEditable("Explosion flag", enemy.explosionFlag);
					InputEditable("Screen", enemy.xScreen, enemy.yScreen);
					InputEditable("Max health", enemy.maxHealth);
					InputEditable("u12", enemy.u12);
					InputEditable("u13", enemy.u13);
					InputEditable("u14", enemy.u14);
					InputEditable("u15", enemy.u15);
					InputEditable("u16", enemy.u16);
					InputEditable("u17", enemy.u17);
					InputEditable("u18", enemy.u18);
					InputEditable("u19", enemy.u19);
					InputEditable("u1A", enemy.u1A);
					InputEditable("u1B", enemy.u1B);
					InputEditable("Spawn flag", enemy.spawnFlag);
					InputEditable("Spawn number", enemy.spawnNumber);
					ImGui.TreePop();
				}
			}
		}
		ImGui.TreePop();
	}
	ImGui.End();
}