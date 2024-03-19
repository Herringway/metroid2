import metroid2.bank00;
import metroid2.bank03;
import metroid2.data;
import metroid2.external;

import replatform64;
import replatform64.gameboy;

import d_imgui.imgui_h;
import ImGui = d_imgui;

import std.format;
import std.functional;

struct GameSettings {}

void main() {
	import std.logger;
	(cast(Logger)sharedLog).logLevel = LogLevel.trace;
	gb.entryPoint = &start;
	gb.interruptHandlerVBlank = &vblank;
	gb.title = "Metroid II: Return of Samus";
	gb.sourceFile = "metroid2.gb";
	gb.gameID = "metroid2";
	auto settings = gb.loadSettings!GameSettings();
	gb.debugMenuRenderer = (&debugFunction).toDelegate;
	gb.initialize();
	if (!gb.assetsExist) {
		gb.extractAssets!loadableDataModules(&extractExtraAssets);
	}
	gb.loadAssets!loadableDataModules(&loadExtraData);
	gb.run();
	gb.saveSettings(settings);
}
void debugFunction(const UIState state) {
	import metroid2.defs;
	import metroid2.globals;

	ImGui.SetNextWindowSize(ImGui.ImVec2(400 * state.scaleFactor, state.window.height));
	ImGui.SetNextWindowPos(ImGui.ImVec2(0, 0));
	ImGui.Begin("Debugging", null, ImGuiWindowFlags.NoTitleBar | ImGuiWindowFlags.NoMove | ImGuiWindowFlags.NoResize | ImGuiWindowFlags.NoBringToFrontOnFocus | ImGuiWindowFlags.NoSavedSettings);
	ImGui.InvisibleButton("padding", ImGui.ImVec2(1, ImGui.GetCursorPos().y));
	if (ImGui.TreeNode("Samus")) {
		InputEditable("Pose", samusPose);
		InputEditable("Health", samusCurHealth);
		InputEditable("Energy Tanks", samusEnergyTanks);
		InputEditable("Missiles", samusCurMissiles);
		InputEditable("Missiles Max", samusMaxMissiles);
		InputEditable("Active weapon", samusActiveWeapon);
		InputEditable("Equipped beam", samusBeam);
		InputEditable("Coords", samusX, samusY);
		InputEditable("Fall counter", samusFallArcCounter);
		InputEditable("Jump counter", samusJumpArcCounter);
		InputEditable("Facing direction", samusFacingDirection);
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
		InputEditable("Enemy count", numEnemies.total);
		InputEditable("Active enemy count", numEnemies.active);
		InputEditable("Inactive enemy count", numEnemies.offscreen);
		if (ImGui.TreeNode("Spawn candidates")) {
			static void addEnemySpawns(const(EnemySpawn)[] spawns) {
				foreach (idx, enemy; spawns) {
					if (enemy.spawnNumber == 0xFF) {
						break;
					}
					ImGui.SeparatorText(format!"Spawn %s"(idx));
					InputEditableReadOnly("Spawn Number", enemy.spawnNumber);
					InputEditableReadOnly("Actor", enemy.id);
					InputEditableReadOnly("Coords", enemy.x, enemy.y);
				}
			}
			ImGui.SeparatorText("Top-left");
			addEnemySpawns(loadEnemyGetBankOffset()[cast(ubyte)((topEdge.screen << 4) | leftEdge.screen)]);
			ImGui.SeparatorText("Top-right");
			addEnemySpawns(loadEnemyGetBankOffset()[cast(ubyte)((topEdge.screen << 4) | ((leftEdge.screen + 1) & 0xF))]);
			ImGui.SeparatorText("Bottom-left");
			addEnemySpawns(loadEnemyGetBankOffset()[cast(ubyte)((((topEdge.screen + 1) & 0xF) << 4) | leftEdge.screen)]);
			ImGui.SeparatorText("Bottom-right");
			addEnemySpawns(loadEnemyGetBankOffset()[cast(ubyte)((((topEdge.screen + 1) & 0xF) << 4) | ((leftEdge.screen + 1) & 0xF))]);
			ImGui.TreePop();
		}
		if (ImGui.TreeNode("Spawn flags")) {
			ImGui.SeparatorText("Ephemeral");
			foreach (idx, chunk; cast(ubyte[4][])enemySpawnFlagsUnsaved[]) {
				InputEditable(format!"%02X"(idx * 4), chunk[0], chunk[1], chunk[2], chunk[3]);
			}
			ImGui.SeparatorText("Permanent");
			foreach (idx, chunk; cast(ubyte[4][])enemySpawnFlagsSaved[]) {
				InputEditable(format!"%02X"(idx * 4), chunk[0], chunk[1], chunk[2], chunk[3]);
			}
			ImGui.TreePop();
		}
		foreach (idx, enemy; enemyDataSlots) {
			if ((enemy.status & 0xF) != 0xF) {
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
		if (ImGui.TreeNode("Metroid state")) {
			InputEditable("Metroid fight active", metroidFightActive);
			InputEditable("Metroid state", metroidState);
			InputEditable("Gamma stun", gammaStunCounter);
			ImGui.TreePop();
		}
		if (ImGui.TreeNode("Metroid queen state")) {
			InputEditable("Body coords", queenBodyXScroll, queenBodyY);
			InputEditable("Body height", queenBodyHeight);
			InputEditable("Walk wait timer", queenWalkWaitTimer);
			InputEditable("Walk counter", queenWalkCounter);
			InputEditable("Head coords", queenHeadX, queenHeadY);
			InputEditable("Head bottom Y", queenHeadBottomY);
			InputEditable("Interrupt list", queenInterruptListID);
			InputEditable("Neck movement sum", queenNeckXMovementSum, queenNeckYMovementSum);
			InputEditable("Neck drawing state", queenNeckDrawingState);
			InputEditable("Camera delta", queenCameraDeltaX, queenCameraDeltaY);
			InputEditable("Walk control", queenWalkControl);
			InputEditable("Neck selection", queenNeckSelectionFlag);
			InputEditable("Walk status", queenWalkStatus);
			InputEditable("Neck control", queenNeckControl);
			InputEditable("Neck status", queenNeckStatus);
			InputEditable("Walk speed", queenWalkSpeed);
			InputEditable("State", queenState);
			InputEditable("Camera", queenCameraX, queenCameraY);
			InputEditable("Foot frame", queenFootFrame);
			InputEditable("Foot anim counter", queenFootAnimCounter);
			InputEditable("Head frame next", queenHeadFrameNext);
			InputEditable("Head frame", queenHeadFrame);
			InputEditable("Neck pattern", queenNeckPatternID);
			InputEditable("Delay timer", queenDelayTimer);
			InputEditable("Stun timer", queenStunTimer);
			InputEditable("Stomach bombed", queenStomachBombedFlag);
			InputEditable("Body palette", queenBodyPalette);
			InputEditable("Health", queenHealth);
			InputEditable("Death array index", queenDeathArrayIndex);
			InputEditable("Death anim counter", queenDeathAnimCounter);
			InputEditable("Death bitmask", queenDeathBitmask);
			InputEditable("Projectiles active", queenProjectilesActive);
			InputEditable("Projectile temp direction", queenProjectileTempDirection);
			InputEditable("Projectile chase timer", queenProjectileChaseTimer);
			InputEditable("Low health", queenLowHealthFlag);
			InputEditable("Flash timer", queenFlashTimer);
			InputEditable("Midhealth", queenMidHealthFlag);
			InputEditable("Head dest", queenHeadDest);
			ImGui.TreePop();
		}
		if (ImGui.TreeNode("Arachnus state")) {
			InputEditable("Jump counter", arachnus.jumpCounter);
			InputEditable("Action timer", arachnus.actionTimer);
			InputEditable("Unknown", arachnus.unknownVar);
			InputEditable("Jump status", arachnus.jumpStatus);
			InputEditable("Health", arachnus.health);
			InputEditable("Unknown (6)", arachnus.unk06);
			InputEditable("Unknown (7)", arachnus.unk07);
			ImGui.TreePop();
		}
		if (ImGui.TreeNode("Blob thrower state")) {
			InputEditable("Action timer", blobThrowerActionTimer);
			InputEditable("Wait timer", blobThrowerWaitTimer);
			InputEditable("State", blobThrowerState);
			InputEditable("Direction", blobThrowerFacingDirection);
			InputEditable("Unknown", blobThrowerBlobUnknownVar);
			ImGui.TreePop();
		}
		ImGui.TreePop();
	}
	if (ImGui.TreeNode("Map State")) {
		ImGui.TreePop();
	}
	if (ImGui.TreeNode("Misc State")) {
		ImGui.SeparatorText("Save");
		InputEditable("Save station contact", saveContactFlag);
		InputEditable("Game is loaded from save file", loadingFromFile);
		InputEditable("Save slot", activeSaveSlot);
		ImGui.SeparatorText("Metroid Count");
		InputEditable("Total Metroids left currently displayed", metroidCountDisplayed);
		InputEditable("Total Metroids left", metroidCountReal);
		InputEditable("Metroids left currently displayed", metroidLCounterDisp);
		ImGui.SeparatorText("Earthquake");
		InputEditable("Time until next earthquake", nextEarthquakeTimer);
		InputEditable("Time until earthquake ends", earthquakeTimer);
		ImGui.SeparatorText("Debugging");
		InputEditable("Debug mode", debugFlag);
		InputEditable("Item index", debugItemIndex);
		ImGui.SeparatorText("Misc");
		InputEditable("Door index", doorIndex);
		InputEditable("Varia animation flag", variaAnimationFlag);
		ImGui.TreePop();
	}
	if (ImGui.TreeNode("Audio")) {
		ImGui.SeparatorText("Song");
		InputEditable("Next", songRequest);
		InputEditable("Playing", songPlaying);
		ImGui.SeparatorText("Song interruption");
		InputEditable("Next", songInterruptionRequest);
		InputEditable("Playing", songInterruptionPlaying);
		ImGui.SeparatorText("SFX (Square 1)");
		InputEditable("Next", sfxRequestSquare1);
		InputEditable("Playing", sfxPlayingSquare1);
		ImGui.SeparatorText("SFX (Square 2)");
		InputEditable("Next", sfxRequestSquare2);
		InputEditable("Playing", sfxPlayingSquare2);
		ImGui.SeparatorText("Noise");
		InputEditable("Next", sfxRequestNoise);
		InputEditable("Playing", sfxPlayingNoise);
		ImGui.TreePop();
	}
	ImGui.End();
}