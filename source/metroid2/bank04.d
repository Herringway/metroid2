module metroid2.bank04;

import metroid2.audiodata;
import metroid2.defs;
import metroid2.globals;
import metroid2.external;

import std.format;
import std.logger;
import replatform64.gameboy;

immutable ubyte channelSongProcessingStateSize = 9;
immutable ubyte channelAllSongProcessingStateSizes = 45;
immutable ubyte songProcessingStateSize = 97;

immutable ushort[] musicNotes = [
	0x8000,
	0x802C, 0x809C, 0x8106, 0x816B, 0x81C9, 0x8223, 0x8277, 0x82C6, 0x8312, 0x8356, 0x839B, 0x83DA,
	0x8416, 0x844E, 0x8483, 0x84B5, 0x84E5, 0x8511, 0x853B, 0x8563, 0x8589, 0x85AC, 0x85CE, 0x85ED,
	0x860A, 0x8627, 0x8642, 0x865B, 0x8672, 0x8689, 0x869E, 0x86B2, 0x86C4, 0x86D6, 0x86E7, 0x86F7,
	0x8706, 0x8714, 0x8721, 0x872D, 0x8739, 0x8744, 0x874F, 0x8759, 0x8762, 0x876B, 0x8773, 0x877B,
	0x8783, 0x878A, 0x8790, 0x8797, 0x879D, 0x87A2, 0x87A7, 0x87AC, 0x87B1, 0x87B6, 0x87BA, 0x87BE,
	0x87C1, 0x87C4, 0x87C8, 0x87CB, 0x87CE, 0x87D1, 0x87D4, 0x87D6, 0x87D9, 0x87DB, 0x87DD, 0x87DF,
];

//                           _______________________________________________________________________________ BPM (in decimal)
//                          |      _________________________________________________________________________ 0: 1/32. Demisemiquaver
//                          |     |      ___________________________________________________________________ 1: 1/16. Semiquaver
//                          |     |     |      _____________________________________________________________ 2: 1/8. Quaver
//                          |     |     |     |      _______________________________________________________ 3: 1/4. Crochet
//                          |     |     |     |     |      _________________________________________________ 4: 1/2. Minum
//                          |     |     |     |     |     |      ___________________________________________ 5: 1. Semibreve
//                          |     |     |     |     |     |     |      _____________________________________ 6: 3/16. Dotted quaver
//                          |     |     |     |     |     |     |     |      _______________________________ 7: 3/8. Dotted crochet
//                          |     |     |     |     |     |     |     |     |      _________________________ 8: 3/4. Dotted minum
//                          |     |     |     |     |     |     |     |     |     |      ___________________ 9: 1/12. Triplet quaver
//                          |     |     |     |     |     |     |     |     |     |     |      _____________ Ah: 1/6. Triplet crochet
//                          |     |     |     |     |     |     |     |     |     |     |     |      _______ Bh: 1/64. Hemidemisemiquaver
//                          |     |     |     |     |     |     |     |     |     |     |     |     |      _ Ch: 2. Breve
//                          |     |     |     |     |     |     |     |     |     |     |     |     |     |
immutable ubyte[] tempoTable448= [0x01, 0x01, 0x02, 0x04, 0x08, 0x10, 0x03, 0x06, 0x0C, 0x01, 0x03, 0x01, 0x20];
immutable ubyte[] tempoTable224= [0x01, 0x02, 0x04, 0x08, 0x10, 0x20, 0x06, 0x0C, 0x18, 0x02, 0x05, 0x01, 0x40];
immutable ubyte[] tempoTable149= [0x02, 0x03, 0x06, 0x0C, 0x18, 0x30, 0x09, 0x12, 0x24, 0x04, 0x08, 0x01, 0x60];
immutable ubyte[] tempoTable112= [0x02, 0x04, 0x08, 0x10, 0x20, 0x40, 0x0C, 0x18, 0x30, 0x05, 0x0A, 0x01, 0x80];
immutable ubyte[] tempoTable90 = [0x03, 0x05, 0x0A, 0x14, 0x28, 0x50, 0x0F, 0x1E, 0x3C, 0x07, 0x0E, 0x01, 0xA0];
immutable ubyte[] tempoTable75 = [0x03, 0x06, 0x0C, 0x18, 0x30, 0x60, 0x12, 0x24, 0x48, 0x08, 0x10, 0x02, 0xC0];
immutable ubyte[] tempoTable64 = [0x03, 0x07, 0x0E, 0x1C, 0x38, 0x70, 0x15, 0x2A, 0x54, 0x09, 0x12, 0x02, 0xE0];
immutable ubyte[] tempoTable56 = [0x04, 0x08, 0x10, 0x20, 0x40, 0x80, 0x18, 0x30, 0x60, 0x0A, 0x14, 0x02, 0xFF];
immutable ubyte[] tempoTable50 = [0x04, 0x09, 0x12, 0x24, 0x48, 0x90, 0x1B, 0x36, 0x6C, 0x0C, 0x1A, 0x02, 0xFF];

immutable ubyte[][] wavePatterns = [
	[0xee, 0xee, 0xa5, 0xe5, 0xe0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
	[0xcc, 0xcc, 0x82, 0xc3, 0xc0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00],
	[0x77, 0x77, 0x51, 0xa2, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfe, 0xdc, 0xba, 0x98, 0x8a, 0xa8, 0x32, 0x10, 0xfe, 0xed, 0xdb, 0xa9, 0x87, 0x65, 0x31, 0x00, 0x99, 0xaa, 0xbb, 0xcc, 0xbb, 0xaa, 0x77, 0x33, 0x11, 0x34, 0x67, 0x89, 0xaa, 0xa7, 0x87, 0x78, 0xab, 0xef, 0xfe, 0xda, 0x97, 0x43, 0x11, 0x31],
	[0xEE, 0xEE, 0xEE, 0x00, 0x00, 0x00, 0xEE, 0xEE, 0xEE, 0x00, 0x00, 0x00, 0xEE, 0x00, 0xEE, 0x00],
	[0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x00, 0xAA, 0xAA, 0xAA, 0x00, 0x00, 0x00, 0xAA, 0x00, 0xAA, 0x00],
	[0x77, 0x77, 0x77, 0x00, 0x00, 0x00, 0x77, 0x77, 0x77, 0x00, 0x00, 0x00, 0x77, 0x00, 0x77, 0x00],
	[0x44, 0x00, 0x22, 0x00, 0x00, 0x00, 0x22, 0x44, 0x44, 0x00, 0x00, 0x00, 0x33, 0x00, 0x44, 0x00],
	[0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00, 0xFF, 0xFF, 0x00, 0x00],
];

// Sound length
//     00tttttt
//     Sound length = 0.25 * (1 - t/40h) seconds
//
// Envelope
//     vvvvdttt
//     Envelope step length = t/8 * 0.125 seconds
//     d: Envelope direction. 0: Decrease, 1: Increase
//     v: Initial volume
//
// Polynomial counter
//     nnnnwaaa
//     If a = 0:
//         Frequency = 80000h / 2^n hertz
//     Else:
//         Frequency = 40000h / (a * 2^n) hertz
//     w: Counter width. 0: 7 bits, 1: 15 bits
//
// Counter control
//     rs000000
//     r: Restart sound
//     s: Stop output after sound has finished (according to sound length)
//    ___________________ Sound length
//   |      _____________ Envelope
//   |     |      _______ Polynomial counter
//   |     |     |      _ Counter control
//   |     |     |     |
immutable ubyte[4][] songNoiseChannelOptionSets = [
	[0x00, 0x08, 0x00, 0x80],
	[0x00, 0x21, 0x3D, 0x80], //unused
	[0x30, 0x40, 0x31, 0xC0],
	[0x00, 0x31, 0x3E, 0x80],
	[0x35, 0xF7, 0x6E, 0xC0],
	[0x30, 0x61, 0x4B, 0xC0],
	[0x30, 0xC1, 0x6D, 0xC0],
	[0x00, 0x81, 0x4B, 0x80],
	[0x00, 0xF6, 0x6D, 0x80],
	[0x00, 0xB6, 0x6D, 0x80],
	[0x00, 0x77, 0x6D, 0x80],
	[0x00, 0x47, 0x6D, 0x80],
	[0x00, 0x97, 0x6B, 0x80],
	[0x00, 0x77, 0x6B, 0x80],
	[0x00, 0x57, 0x6B, 0x80],
	[0x00, 0x37, 0x6B, 0x80],
	[0x00, 0x80, 0x6D, 0x80],
	[0x00, 0x40, 0x4D, 0x80],
	[0x00, 0x1F, 0x47, 0x80],
	[0x00, 0x40, 0x47, 0x80],
	[0x00, 0x40, 0x46, 0x80],
	[0x00, 0x40, 0x45, 0x80],
	[0x00, 0x40, 0x44, 0x80],
	[0x00, 0x40, 0x43, 0x80],
	[0x00, 0x40, 0x42, 0x80],
	[0x00, 0x40, 0x41, 0x80],
	[0x00, 0x1B, 0x37, 0x80],
	[0x00, 0xA5, 0x27, 0x80],
	[0x00, 0x1F, 0x37, 0x80],
	[0x00, 0x27, 0x46, 0x80],
	[0x00, 0x27, 0x45, 0x80],
	[0x00, 0x1B, 0x6B, 0x80],
	[0x00, 0x1A, 0x6B, 0x80],
	[0x00, 0x19, 0x6B, 0x80],
	[0x00, 0x1F, 0x37, 0x80],
	[0x00, 0x1C, 0x6C, 0x80],
	[0x00, 0x51, 0x4D, 0x80],
	[0x30, 0xF1, 0x6F, 0xC0],
	[0x38, 0xA1, 0x3B, 0xC0],
	[0x38, 0xA1, 0x3A, 0xC0],
	[0x00, 0xF4, 0x7A, 0x80],
	[0x00, 0xF4, 0x7B, 0x80],
];

immutable ubyte[17][5] songSoundChannelEffectTable = [
	[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x08],
	[0x08, 0x10, 0x18, 0x20, 0x28, 0x30, 0x38, 0x40, 0x38, 0x30, 0x28, 0x20, 0x18, 0x10, 0x08, 0x00, 0x00],
	[0x00, 0x05, 0x00, 0x05, 0x00, 0x05, 0x00, 0x05, 0x05, 0x00, 0x05, 0x00, 0x05, 0x00, 0x05, 0x00, 0x01],
	[0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x03],
	[0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x00],
];

void handleAudio() {
	debug(audio) {
		if (audio.audioPauseControl == 1) {
			assert(0);
		} else if (audio.audioPauseControl == 2) {
			audio.audioPauseSoundEffectTimer = 0;
			audio.sfxRequestSquare1 = Square1SFX.unpaused;
		}
		if (audio.audioPauseSoundEffectTimer) {
			switch (--audio.audioPauseSoundEffectTimer) {
				case 0x3F: handleAudioPausedSquare1SFX(&frame3F[0]); break;
				case 0x3D: handleAudioPausedNoiseSFX(&frame3D[0]); break;
				case 0x3A: handleAudioPausedSquare1SFX(&frame3A[0]); break;
				case 0x32: handleAudioPausedNoiseSFX(&frame32[0]); break;
				case 0x2F: handleAudioPausedSquare1SFX(&frame2F[0]); break;
				case 0x27: handleAudioPausedNoiseSFX(&frame27[0]); break;
				case 0x24: handleAudioPausedSquare1SFX(&frame24[0]); break;
				case 0x10: clearNonWaveSoundEffectRequests(); break;
				default:
					audio.audioPauseSoundEffectTimer++;
					clearNonWaveSoundEffectRequests();
					break;
			}
			return;
		}
		handleAudioHandleSongInterruptionRequest();
	}
}

void handleAudioHandleSongInterruptionRequest() {
		switch (audio.songInterruptionRequest) {
			case Song2.nothing:
				handleAudioHandleSongInterruptionPlaying();
				return;
			case Song2.itemGet:
				playSongInterruptionItemGet(Song2.itemGet);
				return;
			case Song2.endRequest:
				startEndingSongInterruption(Song2.endRequest);
				return;
			case Song2.missilePickup:
				playSongInterruptionMissilePickup(Song2.missilePickup);
				return;
			case Song2.fadeOut:
				handleAudioInitiateFadingOutMusic(audio.songInterruptionRequest);
				return;
			case Song2.earthquake:
				playSongInterruptionEarthquake(Song2.earthquake);
				return;
			case Song2.clear:
				clearSongInterruption();
				return;
			default: break;
		}
		handleSongAndSoundEffects();
}

void handleAudioHandleSongInterruptionPlaying() {
	if (!audio.songInterruptionPlaying) {
		handleSongAndSoundEffects();
	} else if (audio.songInterruptionPlaying == Song2.endPlaying) {
	} else if (audio.songInterruptionPlaying == Song2.fadeOut) {
	} else {
		handleSongAndSoundEffects();
	}
}

void handleSongAndSoundEffects() {
	handleSong();
	handleChannelSoundEffectNoise();
	handleChannelSoundEffectSquare1();
	handleChannelSoundEffectSquare2();
	handleChannelSoundEffectWave();
	audio.songRequest = Song.nothing;
	audio.sfxRequestNoise = NoiseSFX.u00;
	audio.sfxRequestSquare1 = Square1SFX.nothing;
	audio.sfxRequestSquare2 = Square2SFX.nothing0;
	audio.sfxRequestFakeWave = 0;
	audio.songInterruptionRequest = Song2.nothing;
	audio.sfxRequestLowHealthBeep = 0;
	audio.audioPauseControl = 0;
}

void clearSongInterruption() {
	audio.songInterruptionRequest = Song2.nothing;
	audio.songInterruptionPlaying = Song2.nothing;
}
void playSongInterruptionItemGet(Song2 a) {
	audio.songInterruptionPlaying = a;
	audio.songRequest = Song.itemGet;
	playSongInterruption();
}
void playSongInterruptionMissilePickup(Song2 a) {
	audio.songInterruptionPlaying = a;
	audio.songRequest = Song.missilePickup;
	playSongInterruption();
}
void playSongInterruptionEarthquake(Song2 a) {
	audio.songInterruptionPlaying = a;
	audio.songRequest = cast(Song)a;
	playSongInterruption();
}
void playSongInterruption() {
	audio.songPlayingBackup = audio.songPlaying;
	if (audio.songInterruptionRequest != Song2.earthquake) {
		audio.sfxPlayingBackupLowHealthBeep = audio.sfxPlayingLowHealthBeep;
		audio.sfxPlayingLowHealthBeep = 0;
	}
	audio.audioChannelOutputStereoFlagsBackup = audio.audioChannelOutputStereoFlags;
	audio.songSweepBackupSquare1 = audio.songState.songSweepSquare1;
	audio.songStateBackup = audio.songState;
	muteSoundChannels();
	audio.songInterruptionRequest = Song2.nothing;
	audio.sfxRequestSquare1 = Square1SFX.nothing;
	audio.sfxPlayingSquare1 = Square1SFX.nothing;
	audio.sfxRequestNoise = NoiseSFX.u00;
	audio.sfxPlayingNoise = NoiseSFX.u00;
	audio.sfxActiveNoise = NoiseSFX.u00;
}

void startEndingSongInterruption(ubyte a) {
	audio.songInterruptionPlaying = cast(Song2)(a - 1);
	audio.songState = audio.songStateBackup;

	gb.AUD1SWEEP = audio.songState.songSweepSquare1;
	gb.AUD1LEN = audio.songState.songSoundLengthSquare1;
	gb.AUD1ENV = audio.songState.songEnvelopeSquare1;
	gb.AUD1LOW = audio.songState.songFrequencySquare1 & 0xFF;
	gb.AUD1HIGH = audio.songState.songFrequencySquare1 >> 8;

	gb.AUD2LEN = audio.songState.songSoundLengthSquare2;
	gb.AUD2ENV = audio.songState.songEnvelopeSquare2;
	gb.AUD2LOW = audio.songState.songFrequencySquare2 & 0xFF;
	gb.AUD2HIGH = audio.songState.songFrequencySquare2 >> 8;

	gb.AUD3ENA = audio.songState.songEnableOptionWave;
	gb.AUD3LEN = audio.songState.songSoundLengthWave;
	gb.AUD3LEVEL = audio.songState.songVolumeWave;
	gb.AUD3LOW = audio.songState.songFrequencyWave & 0xFF;
	gb.AUD3HIGH = audio.songState.songFrequencyWave >> 8;

	gb.AUD4LEN = audio.songState.songSoundLengthNoise;
	gb.AUD4ENV = audio.songState.songEnvelopeNoise;
	gb.AUD4POLY = audio.songState.songPolynomialCounterNoise;
	gb.AUD4GO = audio.songState.songCounterControlNoise;

	audio.songInterruptionRequest = Song2.nothing;
	audio.sfxRequestSquare1 = Square1SFX.clear;
	audio.sfxRequestSquare2 = Square2SFX.invalid;
	audio.sfxRequestNoise = NoiseSFX.uFF;
}

void finishEndingSongInterruption() {
	gb.AUD3ENA = 0;
	writeToWavePatternRAM(audio.songState.songWavePatternDataPointer);
	if (audio.songPlaying != Song.earthquake) {
		audio.sfxPlayingLowHealthBeep = audio.sfxPlayingBackupLowHealthBeep;
	}
	audio.audioChannelOutputStereoFlags = audio.audioChannelOutputStereoFlagsBackup;
	gb.AUDTERM = audio.audioChannelOutputStereoFlagsBackup;
	audio.songState.songSweepSquare1 = audio.songSweepBackupSquare1;
	audio.songInterruptionPlaying = Song2.nothing;
	audio.ramCFEB = 0;
	audio.songPlaying = audio.songPlayingBackup;
}

void handleAudioInitiateFadingOutMusic(Song2 a) {
	audio.songInterruptionPlaying = a;
	audio.songState.songFadeoutTimer = 208;
	audio.songState.ramCF5D = audio.songState.songSquare1State.noteEnvelope;
	audio.songState.ramCF5E = audio.songState.songSquare2State.noteEnvelope;
	audio.songState.ramCF5F = audio.songState.songWaveState.noteVolume;
	handleSongAndSoundEffects();
}

void handleAudioHandleFadingOutMusic() {
	void common(ubyte a) {
		audio.songState.songSquare1State.noteEnvelope = a;
		audio.songState.songSquare2State.noteEnvelope = a;
		audio.songState.songNoiseState.noteEnvelope = a;
		audio.songState.ramCF5D = a;
		audio.songState.ramCF5E = a;
		handleSongAndSoundEffects();
	}
	switch (--audio.songState.songFadeoutTimer) {
		case 160:
			common(101);
			break;
		case 112:
			audio.songState.songChannelEnableNoise = 0;
			audio.songState.songWaveState.noteVolume = 96;
			audio.songState.ramCF5F = 96;
			common(69);
			break;
		case 48:
			common(37);
			break;
		case 16:
			common(19);
			break;
		case 0:
			audio.songPlaying = Song.nothing;
			audio.songInterruptionPlaying = Song2.nothing;
			disableSoundChannels();
			break;
		default:
			handleSongAndSoundEffects();
	}
}

void handleChannelSoundEffectSquare1() {
	if ((audio.sfxRequestSquare1 != Square1SFX.nothing) && (audio.sfxRequestSquare1 < Square1SFX.unpaused + 1)) {
		if (audio.sfxRequestSquare1 == Square1SFX.clear) {
			clearChannelSoundEffectSquare1();
			return;
		}
		if ((audio.sfxPlayingSquare1 != Square1SFX.pickedUpMissileDrop) || (audio.sfxPlayingSquare1 != Square1SFX.samusHealthChange)) {
			if (square1SFXInitPointers[audio.sfxRequestSquare1]()) {
				return;
			}
		}
	}
	if (audio.sfxPlayingSquare1 == Square1SFX.nothing) {
		return;
	}
	if (audio.sfxPlayingSquare1 < Square1SFX.unpaused + 1) {
		square1SFXPlaybackPointers[audio.sfxPlayingSquare1]();
		return;
	}
	audio.sfxPlayingSquare1 = Square1SFX.nothing;
}

void handleChannelSoundEffectSquare2() {
	if ((audio.sfxRequestSquare2 != Square2SFX.nothing0) && (audio.sfxRequestSquare2 < Square2SFX.u7 + 1)) {
		if (audio.sfxRequestSquare2 == Square2SFX.invalid) {
			clearChannelSoundEffectSquare2();
			return;
		}
		if (songSoundEffectInitialisationFunctionPointersSquare2[audio.sfxRequestSquare2]()) {
			return;
		}
	}
	if (audio.sfxPlayingSquare2 == Square2SFX.nothing0) {
		return;
	}
	if (audio.sfxPlayingSquare2 < Square2SFX.u7 + 1) {
		songSoundEffectPlaybackFunctionPointersSquare2[audio.sfxPlayingSquare2]();
		return;
	}
	audio.sfxPlayingSquare2 = Square2SFX.nothing0;
}

void handleChannelSoundEffectNoise() {
	if ((audio.sfxRequestNoise != NoiseSFX.u00) && (audio.sfxRequestNoise < NoiseSFX.u1A + 1)) {
		if (audio.sfxRequestNoise == NoiseSFX.uFF) {
			clearChannelSoundEffectNoise();
			return;
		}
		if (audio.songPlaying == Song.earthquake) {
			return;
		}
		if ((audio.sfxPlayingNoise != NoiseSFX.u0D) && (audio.sfxPlayingNoise != NoiseSFX.u0E) && (audio.sfxPlayingNoise != NoiseSFX.u0F)) {
			if (songSoundEffectInitializationFunctionPointersNoise[audio.sfxRequestNoise]()) {
				return;
			}
		}
	}
	if (audio.sfxPlayingNoise == NoiseSFX.u00) {
		return;
	}
	if (audio.sfxPlayingNoise < NoiseSFX.u1A + 1) {
		songSoundEffectPlaybackFunctionPointersNoise[audio.sfxPlayingNoise]();
		return;
	}
	//playing = 0; // nonsense
}

void handleChannelSoundEffectWave() {
	if (audio.sfxRequestWave == WaveSFX.nothing) { // keep playing sound effect
		if (audio.sfxPlayingWave == WaveSFX.nothing) {
			return;
		}
		if (audio.sfxPlayingWave < WaveSFX.invalid) {
			songSoundEffectPlaybackFunctionPointersWave[audio.sfxPlayingWave]();
		}
	} else if (audio.sfxRequestWave == WaveSFX.clear) { // stop playing sound effect
		gb.AUD3ENA = 0;
		writeToWavePatternRAM(audio.songState.songWavePatternDataPointer);
		audio.sfxActiveWave = WaveSFX.nothing;
		audio.sfxRequestWave = WaveSFX.nothing;
		audio.sfxPlayingWave = WaveSFX.nothing;
		if (audio.songPlaying != Song.earthquake) {
			gb.AUD3ENA = audio.songState.songEnableOptionWave;
			gb.AUD3LEN = audio.songState.songSoundLengthWave;
			gb.AUD3LEVEL = audio.songState.songVolumeWave;
			gb.AUD3LOW = audio.songState.songFrequencyWave & 0xFF;
			gb.AUD3HIGH = audio.songState.songFrequencyWave >> 8;
		}
	} else if (audio.sfxRequestWave >= WaveSFX.invalid) { // ignore illegal sound effect
		return;
	} else { // start new sound effect
		audio.sfxActiveWave = audio.sfxRequestWave;
		audio.sfxPlayingWave = audio.sfxRequestWave;
		songSoundEffectInitialisationFunctionPointersWave[audio.sfxRequestWave]();
	}
}

void handleSong() {
	if (audio.songRequest == Song.nothing) {
		handleSongPlaying();
		return;
	} else if (audio.songRequest == Song.invalid) {
		disableSoundChannels();
		return;
	} else if (audio.songRequest == Song.killedMetroid) {
		clearChannelSoundEffectSquare1();
		clearChannelSoundEffectNoise();
	} else if (audio.songRequest > Song.missilePickup) {
		handleSongPlaying();
		return;
	}
	infof("Now playing: %s", audio.songRequest);
	audio.songPlaying = audio.songRequest;
	audio.audioChannelOutputStereoFlags = songStereoFlags[audio.songRequest - 1];
	gb.NR51 = songStereoFlags[audio.songRequest - 1];
	loadSongHeader(songDataTable[audio.songRequest - 1]);
}

void disableSoundChannels() {
	audio.songState.songChannelEnableSquare1 = 0;
	audio.songState.songChannelEnableSquare2 = 0;
	audio.songState.songChannelEnableWave = 0;
	audio.songState.songChannelEnableNoise = 0;
	disableChannelSquare1();
	disableChannelSquare2();
	disableChannelWave();
	disableChannelNoise();
}

void clearSongPlaying() {
	audio.songPlaying = Song.nothing;
}

void handleSongPlaying() {
	if (!audio.songPlaying) {
		return;
	}
	if (audio.songPlaying > Song.missilePickup) {
		return clearSongPlaying();
	}
	audio.songState.songOptionsSetFlagWorking = 0;
	if (audio.songState.songChannelEnableSquare1) {
		audio.songState.workingSoundChannel = 1;
		audio.songState.songWorkingState.instructionTimer = audio.songState.songSquare1State.instructionTimer;
		if (audio.songState.songSquare1State.instructionTimer == 1) {
			handleSongLoadNextChannelSoundSquare1();
		} else {
			audio.songState.songSquare1State.instructionTimer--;
			if (!audio.sfxActiveSquare1) {
				audio.songState.songWorkingState.effectIndex = audio.songState.songSquare1State.effectIndex;
				if (audio.songState.songWorkingState.effectIndex) {
					handleSongSoundChannelEffect(audio.songState.songFrequencySquare1);
					gb.AUD1LOW = audio.songState.songFrequencyWorking & 0xFF;
					gb.AUD1HIGH = (audio.songState.songFrequencyWorking >> 8) & 0xFF;
				}
			}
		}
	}
	audio.songState.songOptionsSetFlagWorking = 0;
	if (audio.songState.songChannelEnableSquare2) {
		audio.songState.workingSoundChannel = 2;
		audio.songState.songWorkingState.instructionTimer = audio.songState.songSquare2State.instructionTimer;
		if (audio.songState.songSquare2State.instructionTimer == 1) {
			handleSongLoadNextChannelSoundSquare2();
		} else {
			audio.songState.songSquare2State.instructionTimer--;
			if (!audio.sfxActiveSquare2) {
				audio.songState.songWorkingState.effectIndex = audio.songState.songSquare2State.effectIndex;
				if (audio.songState.songWorkingState.effectIndex) {
					handleSongSoundChannelEffect(audio.songState.songFrequencySquare2);
					gb.AUD2LOW = audio.songState.songFrequencyWorking & 0xFF;
					gb.AUD2HIGH = (audio.songState.songFrequencyWorking >> 8) & 0xFF;
				}
			}
		}
	}
	audio.songState.songOptionsSetFlagWorking = 0;
	if (audio.songState.songChannelEnableWave) {
		audio.songState.workingSoundChannel = 3;
		audio.songState.songWorkingState.instructionTimer = audio.songState.songWaveState.instructionTimer;
		if (audio.songState.songWaveState.instructionTimer == 1) {
			handleSongLoadNextChannelSoundWave();
		} else {
			audio.songState.songWaveState.instructionTimer--;
			if (!audio.sfxActiveWave) {
				audio.songState.songWorkingState.effectIndex = audio.songState.songWaveState.effectIndex;
				if (audio.songState.songWorkingState.effectIndex) {
					handleSongSoundChannelEffect(audio.songState.songFrequencyWave);
					gb.NR33 = audio.songState.songFrequencyWorking & 0xFF;
					gb.NR34 = (audio.songState.songFrequencyWorking >> 8) & 0x7F;
				}
			}
		}
	}
	audio.songState.songOptionsSetFlagWorking = 0;
	if (audio.songState.songChannelEnableNoise) {
		audio.songState.workingSoundChannel = 4;
		audio.songState.songWorkingState.instructionTimer = audio.songState.songNoiseState.instructionTimer;
		if (audio.songState.songNoiseState.instructionTimer == 1) {
			handleSongLoadNextChannelSoundNoise();
		} else {
			audio.songState.songNoiseState.instructionTimer--;
			return;
		}
	}
	if (audio.songState.songChannelEnableSquare1) {
		return;
	}
	if (audio.songState.songChannelEnableSquare2) {
		return;
	}
	if (audio.songState.songChannelEnableWave) {
		return;
	}
	if (audio.songState.songChannelEnableNoise) {
		return;
	}
	audio.songPlaying = Song.nothing;
	audio.songInterruptionPlaying = Song2.nothing;
}

ubyte decrementChannelSoundEffectTimerSquare1() {
	if (audio.sfxTimerSquare1) {
		audio.sfxTimerSquare1--;
		return audio.sfxTimerSquare1;
	} else {
		return clearChannelSoundEffectSquare1();
	}
}

ubyte decrementChannelSoundEffectTimerSquare2() {
	if (audio.sfxTimerSquare2) {
		audio.sfxTimerSquare2--;
		return audio.sfxTimerSquare2;
	} else {
		return clearChannelSoundEffectSquare2();
	}
}
ubyte decrementChannelSoundEffectTimerNoise() {
	if (audio.sfxTimerNoise) {
		audio.sfxTimerNoise--;
		return audio.sfxTimerNoise;
	} else {
		return clearChannelSoundEffectNoise();
	}
}

ubyte clearChannelSoundEffectSquare1() {
	audio.sfxPlayingSquare1 = Square1SFX.nothing;
	audio.sfxActiveSquare1 = Square1SFX.nothing;
	return 0;
}

ubyte disableChannelSquare1() {
	gb.AUD1ENV = 8;
	gb.AUD1HIGH = 128;
	return 0;
}

ubyte clearChannelSoundEffectSquare2() {
	audio.sfxPlayingSquare2 = Square2SFX.nothing0;
	audio.sfxActiveSquare2 = Square2SFX.nothing0;
	return 0;
}

ubyte disableChannelSquare2() {
	gb.AUD2ENV = 8;
	gb.AUD2HIGH = 128;
	return 0;
}

ubyte clearChannelSoundEffectWave() {
	audio.sfxActiveWave = 0;
	return 0;
}

ubyte disableChannelWave() {
	gb.AUD3ENA = 0;
	return 0;
}

ubyte clearChannelSoundEffectNoise() {
	audio.sfxPlayingNoise = NoiseSFX.u00;
	audio.sfxActiveNoise = NoiseSFX.u00;
	return 0;
}

ubyte disableChannelNoise() {
	gb.NR42 = 8;
	gb.NR44 = 128;
	return 0;
}

void initializeAudio() {
	gb.NR52 = 0x80;
	gb.NR50 = 0x77;
	gb.NR51 = 0xFF;
	audio = audio.init;
}

void clearNonWaveSoundEffectRequests() {
	audio.sfxRequestSquare1 = Square1SFX.nothing;
	audio.sfxRequestSquare2 = Square2SFX.nothing0;
	audio.sfxRequestFakeWave = 0;
	audio.sfxRequestNoise = NoiseSFX.u00;
	audio.audioPauseControl = 0;
}

void silenceAudio() {
	gb.NR51 = 0xFF;
	audio.sfxRequestSquare1 = Square1SFX.nothing;
	audio.sfxRequestSquare2 = Square2SFX.nothing0;
	audio.sfxRequestFakeWave = 0;
	audio.sfxRequestNoise = NoiseSFX.u00;
	audio.sfxPlayingSquare1 = Square1SFX.nothing;
	audio.sfxPlayingSquare2 = Square2SFX.nothing0;
	audio.sfxPlayingFakeWave = 0;
	audio.sfxPlayingNoise = NoiseSFX.u00;
	audio.songRequest = Song.invalid;
	audio.songPlaying = Song.invalid;
	audio.songInterruptionRequest = Song2.nothing;
	audio.songInterruptionPlaying = Song2.nothing;
	audio.sfxRequestWave = 0;
	audio.sfxPlayingWave = 0;
	audio.audioPauseSoundEffectTimer = 0;
	audio.audioPauseControl = 0;
	muteSoundChannels();
}

void muteSoundChannels() {
	gb.AUD1ENV = 8;
	gb.AUD2ENV = 8;
	gb.NR42 = 8;
	gb.AUD1HIGH = 0x80;
	gb.AUD2HIGH = 0x80;
	gb.NR44 = 0x80;
	gb.NR10 = 0;
	gb.AUD3ENA = 0;
}

void writeToWavePatternRAM(const(ubyte)* data) {
	foreach (idx, d; data[0 .. 16]) {
		gb.waveRAM[idx] = d;
	}
}

void setChannelOptionSetSquare1(const(ubyte)* set) {
	gb.AUD1SWEEP = set[0];
	gb.AUD1LEN = set[1];
	gb.AUD1ENV = set[2];
	gb.AUD1LOW = set[3];
	gb.AUD1HIGH = set[4];
}

void setChannelOptionSetSquare2(const(ubyte)* set) {
	gb.AUD2LEN = set[0];
	gb.AUD2ENV = set[1];
	gb.AUD2LOW = set[2];
	gb.AUD2HIGH = set[3];
}

void SetChannelOptionSetWave(const(ubyte)* set) {
	gb.AUD3ENA = set[0];
	gb.AUD3LEN = set[1];
	gb.AUD3LEVEL = set[2];
	gb.AUD3LOW = set[3];
	gb.AUD3HIGH = set[4];
}

void SetChannelOptionSetNoise(const(ubyte)* set) {
	gb.AUD4LEN = set[0];
	gb.AUD4ENV = set[1];
	gb.AUD4POLY = set[2];
	gb.AUD4GO = set[3];
}

const(ubyte)* audioPause() {
	muteSoundChannels();
	audio.sfxPlayingSquare1 = Square1SFX.nothing;
	audio.sfxPlayingSquare2 = Square2SFX.nothing0;
	audio.sfxPlayingFakeWave = 0;
	audio.sfxPlayingNoise = NoiseSFX.u00;
	audio.audioPauseSoundEffectTimer = 64;
	return &optionSetsPause.frame64[0];
}

void handleAudioPausedNoiseSFX(const(ubyte)* set) {
	SetChannelOptionSetNoise(set);
	clearNonWaveSoundEffectRequests();
}

void handleAudioPausedSquare1SFX(const(ubyte)* set) {
	setChannelOptionSetSquare1(set);
	clearNonWaveSoundEffectRequests();
}

void audioUnpause() {
	audio.audioPauseSoundEffectTimer = 0;
	audio.sfxRequestSquare1 = Square1SFX.unpaused;
	handleAudioHandleSongInterruptionRequest();
}

void handleAudioPaused() {
	switch (--audio.audioPauseSoundEffectTimer) {
		case 63:
			handleAudioPausedSquare1SFX(&optionSetsPause.frame63[0]);
			break;
		case 61:
			handleAudioPausedNoiseSFX(&optionSetsPause.frame61[0]);
			break;
		case 58:
			handleAudioPausedSquare1SFX(&optionSetsPause.frame58[0]);
			break;
		case 50:
			handleAudioPausedNoiseSFX(&optionSetsPause.frame50[0]);
			break;
		case 47:
			handleAudioPausedSquare1SFX(&optionSetsPause.frame47[0]);
			break;
		case 39:
			handleAudioPausedNoiseSFX(&optionSetsPause.frame39[0]);
			break;
		case 36:
			handleAudioPausedSquare1SFX(&optionSetsPause.frame36[0]);
			break;
		case 16:
			audio.audioPauseSoundEffectTimer++;
			clearNonWaveSoundEffectRequests();
			break;
		default:
			clearNonWaveSoundEffectRequests();
			break;
	}
}

void loadSongHeader(const SongHeader header) {
	resetSongSoundChannelOptions();
	if (header.noteOffset & 1) {
		audio.songState.songFrequencyTweakSquare2 = 1;
	}
	audio.songState.songTranspose = header.noteOffset & 0xFE;
	audio.songState.songInstructionTimerArrayPointer = header.tempo;
	audio.songState.songSquare1State.sectionPointer = header.toneSweepChannel;
	audio.songState.songSquare2State.sectionPointer = header.toneChannel;
	audio.songState.songWaveState.sectionPointer = header.waveChannel;
	audio.songState.songNoiseState.sectionPointer = header.noiseChannel;
	audio.songState.songSquare1State.sectionPointers = header.toneSweepChannel;
	audio.songState.songSquare2State.sectionPointers = header.toneChannel;
	audio.songState.songWaveState.sectionPointers = header.waveChannel;
	audio.songState.songNoiseState.sectionPointers = header.noiseChannel;
	if (audio.songState.songSquare1State.sectionPointer.length == 0) {
		audio.songState.songChannelEnableSquare1 = 0;
		gb.AUD1ENV = 0x08;
		gb.AUD1HIGH = 0x80;
	} else {
		audio.songState.songChannelEnableSquare1 = 1;
		audio.songState.songChannelInstructionPointerSquare1 = header.squareTracks[audio.songState.songSquare1State.sectionPointer[0]].ptr;
	}
	if (audio.songState.songSquare2State.sectionPointer.length == 0) {
		audio.songState.songChannelEnableSquare2 = 0;
		gb.AUD2ENV = 0x08;
		gb.AUD2HIGH = 0x80;
	} else {
		audio.songState.songChannelEnableSquare2 = 2;
		audio.songState.songChannelInstructionPointerSquare2 = header.squareTracks[audio.songState.songSquare2State.sectionPointer[0]].ptr;
	}
	if (audio.songState.songWaveState.sectionPointer.length == 0) {
		audio.songState.songChannelEnableWave = 0;
		gb.AUD3ENA = 0;
	} else {
		audio.songState.songChannelEnableWave = 3;
		audio.songState.songChannelInstructionPointerWave = header.waveTracks[audio.songState.songWaveState.sectionPointer[0]].ptr;
	}
	if (audio.songState.songNoiseState.sectionPointer.length == 0) {
		audio.songState.songChannelEnableNoise = 0;
	} else {
		audio.songState.songChannelEnableNoise = 4;
		audio.songState.songChannelInstructionPointerNoise = header.noiseTracks[audio.songState.songNoiseState.sectionPointer[0]].ptr;
	}
	audio.songState.songSquare1State.instructionTimer = 1;
	audio.songState.songSquare2State.instructionTimer = 1;
	audio.songState.songWaveState.instructionTimer = 1;
	audio.songState.songNoiseState.instructionTimer = 1;
}

void handleSongLoadNextChannelSoundSquare1() {
	audio.songState.songWorkingState = audio.songState.songSquare1State;
	loadNextSound(audio.songState.songChannelInstructionPointerSquare1, 1);
	audio.songState.songChannelEnableSquare1 = audio.songState.workingSoundChannel;
	if (audio.songState.songChannelEnableSquare1 == 0) {
		resetChannelOptionsSquare1();
		return;
	}
	audio.songState.songSquare1State = audio.songState.songWorkingState;
	if (audio.songState.songOptionsSetFlagWorking == 1) {
		audio.songState.songSweepSquare1 = audio.songState.songSweepWorking;
		audio.songState.songSoundLengthSquare1 = audio.songState.songSoundLengthWorking;
	}
	audio.songState.songEnvelopeSquare1 = audio.songState.songEnvelopeWorking;
	audio.songState.songFrequencySquare1 = audio.songState.songFrequencyWorking;
	if (!audio.sfxActiveSquare1) {
		gb.NR10 = audio.songState.songSweepSquare1;
		gb.NR11 = audio.songState.songSoundLengthSquare1;
		gb.AUD1ENV = audio.songState.songEnvelopeSquare1;
		gb.AUD1LOW = audio.songState.songFrequencySquare1 & 0xFF;
		gb.AUD1HIGH = audio.songState.songFrequencySquare1 >> 8;
	}
}

void handleSongLoadNextChannelSoundSquare2() {
	audio.songState.songWorkingState = audio.songState.songSquare2State;
	loadNextSound(audio.songState.songChannelInstructionPointerSquare2, 2);
	audio.songState.songChannelEnableSquare2 = audio.songState.workingSoundChannel;
	if (audio.songState.songChannelEnableSquare2 == 0) {
		resetChannelOptionsSquare2();
		return;
	}
	audio.songState.songSquare2State = audio.songState.songWorkingState;
	if (audio.songState.songOptionsSetFlagWorking == 2) {
		audio.songState.songSoundLengthSquare2 = audio.songState.songSoundLengthWorking;
	}
	audio.songState.songEnvelopeSquare2 = audio.songState.songEnvelopeWorking;
	audio.songState.songFrequencySquare2 = audio.songState.songFrequencyWorking;
	if (!audio.sfxActiveSquare2) {
		gb.NR21 = audio.songState.songSoundLengthSquare2;
		if (audio.songState.songFrequencyTweakSquare2 == 1) {
			if (audio.songState.songFrequencySquare2 < 34560) {
				audio.songState.songFrequencySquare2++;
			}
			audio.songState.songFrequencySquare2++;
		}
		gb.AUD2ENV = audio.songState.songEnvelopeSquare2;
		gb.AUD2LOW = audio.songState.songFrequencySquare2 & 0xFF;
		gb.AUD2HIGH = audio.songState.songFrequencySquare2 >> 8;
	}
}

void handleSongLoadNextChannelSoundWave() {
	infof("wav");
	audio.songState.songWorkingState = audio.songState.songWaveState;
	loadNextSound(audio.songState.songChannelInstructionPointerWave, 3);
	audio.songState.songChannelEnableWave = audio.songState.workingSoundChannel;
	if (audio.songState.songChannelEnableWave == 0) {
		resetChannelOptionsWave();
		return;
	}
	audio.songState.songWaveState = audio.songState.songWorkingState;
	audio.songState.songEnableOptionWave = audio.songState.songEnableWorking;
	audio.songState.songSoundLengthWave = audio.songState.songSoundLengthWorking;
	audio.songState.songVolumeWave = audio.songState.songVolumeWorking;
	audio.songState.songFrequencyWave = audio.songState.songFrequencyWorking;
	if (!audio.sfxActiveWave) {
		gb.AUD3ENA = 0;
		gb.AUD3ENA = audio.songState.songEnableOptionWave;
		gb.NR31 = audio.songState.songSoundLengthWave;
		gb.NR32 = audio.songState.songVolumeWave;
		gb.NR33 = audio.songState.songFrequencyWave & 0xFF;
		gb.NR34 = audio.songState.songFrequencyWave >> 8;
	}
}

void handleSongLoadNextChannelSoundNoise() {
	audio.songState.songWorkingState = audio.songState.songNoiseState;
	loadNextSound(audio.songState.songChannelInstructionPointerNoise, 4);
	audio.songState.songChannelEnableNoise = audio.songState.workingSoundChannel;
	if (audio.songState.songChannelEnableNoise == 0) {
		resetChannelOptionsNoise();
		return;
	}
	audio.songState.songNoiseState = audio.songState.songWorkingState;
	if (!audio.sfxActiveNoise) {
		gb.NR41 = audio.songState.songSoundLengthWorking;
		gb.NR42 = audio.songState.songEnvelopeWorking;
		gb.AUD4POLY = audio.songState.songPolynomialCounterWorking;
		audio.songState.songPolynomialCounterNoise = audio.songState.songPolynomialCounterWorking;
		gb.NR44 = audio.songState.songCounterControlWorking;
		audio.songState.songCounterControlNoise = audio.songState.songCounterControlWorking;
	}
}

void loadNextSound(ref const(ubyte)* ptr, ubyte channel) {
	static void mute() {
		if (audio.songState.workingSoundChannel != 3) {
			audio.songState.songEnvelopeWorking = 8;
			audio.songState.songCounterControlWorking = 0x80;
		} else {
			audio.songState.songEnableWorking = 0;
			audio.songState.songVolumeWorking = 0;
		}
	}
	static void instr35Common() {
		if (audio.songInterruptionPlaying == Song2.fadeOut) {
			audio.songState.songEnvelopeWorking = Song2.fadeOut;
		}
		switch (audio.songState.workingSoundChannel) {
			case 1:
				audio.songState.songFrequencyWorking = audio.songState.songFrequencySquare1;
				break;
			case 2:
				audio.songState.songFrequencyWorking = audio.songState.songFrequencySquare2;
				break;
			case 3:
				if (!audio.sfxActiveWave) {
					audio.songState.songEnableWorking = 0x80;
					audio.songState.songFrequencyWorking = audio.songState.songFrequencyWave;
				}
				break;
			default: break;
		}
	}
	static bool nextInstructionList(ref const(ubyte)* ptr) {
		audio.songState.songWorkingState.sectionPointer = audio.songState.songWorkingState.sectionPointer[1 .. $];
		if (audio.songState.songWorkingState.sectionPointer[0] == 0) {
			audio.songState.workingSoundChannel = 0;
			return true;
		}
		if (audio.songState.songWorkingState.sectionPointer[0] == 0x00F0) {
			songInstructionGoto();
		}
		switch (audio.songState.workingSoundChannel) {
			case 1:
			case 2:
				assert(audio.songState.songWorkingState.sectionPointer[0] in songDataTable[audio.songPlaying - 1].squareTracks, format!"Missing pattern %04X"(audio.songState.songWorkingState.sectionPointer[0]));
				ptr = songDataTable[audio.songPlaying - 1].squareTracks[audio.songState.songWorkingState.sectionPointer[0]].ptr;
				break;
			case 3:
				assert(audio.songState.songWorkingState.sectionPointer[0] in songDataTable[audio.songPlaying - 1].waveTracks, format!"Missing pattern %04X"(audio.songState.songWorkingState.sectionPointer[0]));
				ptr = songDataTable[audio.songPlaying - 1].waveTracks[audio.songState.songWorkingState.sectionPointer[0]].ptr;
				break;
			case 4:
				assert(audio.songState.songWorkingState.sectionPointer[0] in songDataTable[audio.songPlaying - 1].noiseTracks, format!"Missing pattern %04X"(audio.songState.songWorkingState.sectionPointer[0]));
				ptr = songDataTable[audio.songPlaying - 1].noiseTracks[audio.songState.songWorkingState.sectionPointer[0]].ptr;
				break;
			default: assert(0);
		}
		return false;
	}
	audio.songState.workingSoundChannel = channel;
	if (ptr[0] == 0) {
		if (nextInstructionList(ptr)) {
			return;
		}
	}
	while (true) {
		infof("%02X", ptr[0]);
		switch (ptr[0]) {
			case 0xF1: songInstructionSetWorkingSoundChannelOptions(ptr); continue;
			case 0xF2: songInstructionSetInstructionTimerArrayPointer(ptr); continue;
			case 0xF3: songInstructionSetMusicNoteOffset(ptr); continue;
			case 0xF4: songInstructionMarkRepeatPoint(ptr); continue;
			case 0xF5: songInstructionRepeat(ptr); continue;
			case 0x00:
				if (nextInstructionList(ptr)) {
					return;
				}
				continue;
			case 0xF6: return silenceAudio();
			case 0x9F: .. case 0xF0:
				audio.songState.songWorkingState.instructionTimer = audio.songState.songInstructionTimerArrayPointer[ptr[0] & 0b01011111];
				audio.songState.songWorkingState.instructionLength = audio.songState.songInstructionTimerArrayPointer[ptr[0] & 0b01011111];
				ptr++;
				continue;
			default:
				audio.songState.songWorkingState.instructionTimer = audio.songState.songWorkingState.instructionLength;
				if (audio.songState.workingSoundChannel == 4) {
					const a = (ptr++)[0];
					if (a == 1) {
						mute();
					} else {
						audio.songState.songSoundLengthWorking = songNoiseChannelOptionSets[a / 4][0];
						audio.songState.songEnvelopeWorking = songNoiseChannelOptionSets[a / 4][1];
						audio.songState.songPolynomialCounterWorking = songNoiseChannelOptionSets[a / 4][2];
						audio.songState.songCounterControlWorking = songNoiseChannelOptionSets[a / 4][3];
					}
					return;
				}
				const cmd = (ptr++)[0];
				switch(cmd) {
					case 1:
						mute();
						return;
					case 3:
						audio.songState.songEnvelopeWorking = 0x66;
						return instr35Common();
					case 5:
						audio.songState.songEnvelopeWorking = 0x46;
						return instr35Common();
					default:
						if ((audio.songState.workingSoundChannel == 3) && !audio.sfxActiveWave) {
							gb.AUDTERM = gb.AUDTERM | 0b01000100;
							audio.songState.songEnableWorking = 0x80;
						}
						ubyte c = cmd;
						if (audio.songState.workingSoundChannel != 4) {
							c += audio.songState.songTranspose;
						}
						audio.songState.songEnvelopeWorking = audio.songState.songWorkingState.noteEnvelope;
						audio.songState.songFrequencyWorking = musicNotes[c / 2];
						return;
				}
		}
	}
}

void songInstructionSetWorkingSoundChannelOptions(ref const(ubyte)* ptr) {
	ptr++;
	audio.songState.songOptionsSetFlagWorking = audio.songState.workingSoundChannel;
	if (audio.songState.workingSoundChannel == 3) {
		songInstructionSetWorkingSoundChannelOptionsWave(ptr);
	} else {
		if (audio.songInterruptionPlaying == Song2.fadeOut) {
			audio.songState.songEnvelopeWorking = (ptr++)[0];
		} else {
			audio.songState.songEnvelopeWorking = (ptr++)[0];
			audio.songState.songWorkingState.noteEnvelope = audio.songState.songEnvelopeWorking;
		}
		audio.songState.songSweepWorking = (ptr++)[0];
		audio.songState.songSoundLengthWorking = ptr[0];
		audio.songState.songWorkingState.effectIndex = audio.songState.songSoundLengthWorking & ~0b11000000;
	}
	if (audio.songState.songWorkingState.effectIndex == 0) {
		audio.songState.songWorkingState.effectIndex = 0; // ?
	}
	ptr++;
}

void songInstructionSetWorkingSoundChannelOptionsWave(ref const(ubyte)* ptr) {
	audio.ramCFE3 = *cast(const(ushort)*)ptr;
	ptr += 2;
	audio.songState.songWavePatternDataPointer = &[0x4113 : wavePatterns[0], 0x4123: wavePatterns[1], 0x416B: wavePatterns[3], 0x417B: wavePatterns[4], 0x418B: wavePatterns[5], 0x419B: wavePatterns[6], 0x41AB: wavePatterns[7]][audio.ramCFE3][0];
	if (audio.songInterruptionPlaying == Song2.fadeOut) {
		audio.songState.songVolumeWorking = ptr[0];
	} else {
		audio.songState.songVolumeWorking = ptr[0];
		audio.songState.songWorkingState.noteVolume = ptr[0];
	}
	if (!audio.sfxActiveWave) {
		gb.AUD3ENA = 0;
		writeToWavePatternRAM(audio.songState.songWavePatternDataPointer);
	}
	audio.songState.songWorkingState.effectIndex = audio.songState.songVolumeWorking & ~0b01100000;
}

void songInstructionSetInstructionTimerArrayPointer(ref const(ubyte)* ptr) {
	ptr++;
	audio.songState.songInstructionTimerArrayPointer = getTempoData(*cast(const(ushort)*)ptr);
	ptr += 2;
}

void songInstructionSetMusicNoteOffset(ref const(ubyte)* ptr) {
	ptr++;
	audio.songState.songTranspose = (ptr++)[0];
}

void songInstructionGoto() {
	const next = audio.songState.songWorkingState.sectionPointer[1];
	audio.songState.songWorkingState.sectionPointer = audio.songState.songWorkingState.sectionPointers[next .. $];
}

void songInstructionMarkRepeatPoint(ref const(ubyte)* ptr) {
	ptr++;
	audio.songState.songWorkingState.repeatCount = (ptr++)[0];
	audio.songState.songWorkingState.repeatPoint = ptr;
}

void songInstructionRepeat(ref const(ubyte)* ptr) {
	if (--audio.songState.songWorkingState.repeatCount == 0) {
		ptr++;
	} else {
		ptr = audio.songState.songWorkingState.repeatPoint;
	}
}

//deprecated("obsolete") void copyChannelSongProcessingState() {
//	assert(0);
//}

void handleSongSoundChannelEffect(ushort bc) {
	static void common(const(ubyte)[] hl, ushort bc) {
		if (audio.songState.songSoundChannelEffectTimer == 0) {
			audio.songState.songSoundChannelEffectTimer = 17;
		}
		audio.songState.songFrequencyWorking = cast(ushort)(hl[--audio.songState.songSoundChannelEffectTimer] + bc) & 0x3FFF;
	}
	static void setFrequency() {
		if (audio.songState.workingSoundChannel == 1) {
			audio.songState.songFrequencySquare1 = audio.songState.songFrequencyWorking;
		} else if (audio.songState.workingSoundChannel == 2) {
			audio.songState.songFrequencySquare2 = audio.songState.songFrequencyWorking;
		} else if (audio.songState.workingSoundChannel == 3) {
			audio.songState.songFrequencyWave = audio.songState.songFrequencyWorking & 0x7FFF;
		}
	}
	switch (audio.songState.songWorkingState.effectIndex) {
		case 2:
			common(songSoundChannelEffectTable[0], bc);
			break;
		case 3:
			common(songSoundChannelEffectTable[1], bc);
			break;
		case 4:
			common(songSoundChannelEffectTable[2], bc);
			break;
		case 6:
			audio.songState.songFrequencyWorking = bc & 0x3FFF;
			setFrequency();
			break;
		case 7:
			audio.songState.songFrequencyWorking = (bc + 4) & 0x3FFF;
			setFrequency();
			break;
		case 8:
			audio.songState.songFrequencyWorking = (bc - 3) & 0x3FFF;
			setFrequency();
			break;
		case 9:
			common(songSoundChannelEffectTable[3], bc);
			break;
		case 10:
			common(songSoundChannelEffectTable[4], bc);
			break;
		default: return;
	}
}
unittest {
	audio = audio.init;
	audio.songState.songWorkingState.effectIndex = 4;
	audio.songState.songSoundChannelEffectTimer = 0;
	handleSongSoundChannelEffect(0x87BA);
	assert(audio.songState.songSoundChannelEffectTimer == 16);
	assert(audio.songState.songFrequencyWorking == 0x7BB);
}

void resetChannelOptionsSquare1() {
	audio.songState.songChannelEnableSquare1 = 0;
	gb.AUD1ENV = 8;
	audio.songState.songEnvelopeSquare1 = 8;
	gb.AUD1HIGH = 0x80;
	audio.songState.songFrequencySquare1 = 0x8000 | (audio.songState.songFrequencySquare1 & 0xFF);
}

void resetChannelOptionsSquare2() {
	audio.songState.songChannelEnableSquare2 = 0;
	gb.AUD2ENV = 8;
	audio.songState.songEnvelopeSquare2 = 8;
	gb.AUD2HIGH = 0x80;
	audio.songState.songFrequencySquare2 = 0x8000 | (audio.songState.songFrequencySquare2 & 0xFF);
}

void resetChannelOptionsWave() {
	audio.songState.songChannelEnableWave = 0;
	gb.AUD3ENA = 0;
	audio.songState.songEnableOptionWave = 0;
}

void resetChannelOptionsNoise() {
	audio.songState.songChannelEnableNoise = 0;
	gb.NR42 = 8;
	audio.songState.songEnvelopeNoise = 8;
	gb.NR44 = 0x80;
	audio.songState.songCounterControlNoise = 0x80;
}

void resetSongSoundChannelOptions() {
	audio.songState.songWorkingState = ChannelSongProcessingState.init;
	audio.songState.songSquare1State = ChannelSongProcessingState.init;
	audio.songState.songSquare2State = ChannelSongProcessingState.init;
	audio.songState.songWaveState = ChannelSongProcessingState.init;
	audio.songState.songNoiseState = ChannelSongProcessingState.init;
	audio.sfxActiveSquare1 = 0;
	audio.sfxActiveSquare2 = 0;
	audio.sfxActiveWave = 0;
	audio.sfxActiveNoise = NoiseSFX.u00;
	audio.songState.songFrequencyTweakSquare2 = 0;
	gb.NR10 = 0;
	gb.AUD3ENA = 0;

	gb.AUD1ENV = 0x08;
	gb.AUD2ENV = 0x08;
	gb.NR42 = 0x08;

	gb.AUD1HIGH = 0x80;
	gb.AUD2HIGH = 0x80;
	gb.NR44 = 0x80;
}

immutable bool function()[] square1SFXInitPointers = [
	Square1SFX.jumping: &square1SfxInit1,
	Square1SFX.hiJumping: &square1SfxInit2,
	Square1SFX.screwAttacking: &square1SfxInit3,
	Square1SFX.standingTransition: &square1SfxInit4,
	Square1SFX.crouchingTransition: &square1SfxInit5,
	Square1SFX.morphingTransition: &square1SfxInit6,
	Square1SFX.shootingBeam: &square1SfxInit7,
	Square1SFX.shootingMissile: &square1SfxInit8,
	Square1SFX.shootingIceBeam: &square1SfxInit9,
	Square1SFX.shootingPlasmaBeam: &square1SfxInitA,
	Square1SFX.shootingSpazerBeam: &square1SfxInitB,
	Square1SFX.pickedUpMissileDrop: &square1SfxInitC,
	Square1SFX.spiderBall: &square1SfxInitD,
	Square1SFX.pickedUpSmallEnergyDrop: &square1SfxInitE,
	Square1SFX.beamDink: &square1SfxInitF,
	Square1SFX.u10: &square1SfxInit10,
	Square1SFX.u11: null,
	Square1SFX.u12: &square1SfxInit12,
	Square1SFX.bombLaid: &square1SfxInit13,
	Square1SFX.u14: &square1SfxInit14,
	Square1SFX.select: &square1SfxInit15,
	Square1SFX.shootingWaveBeam: &square1SfxInit16,
	Square1SFX.pickedUpLargeEnergyDrop: &square1SfxInit17,
	Square1SFX.samusHealthChange: &square1SfxInit18,
	Square1SFX.noMissileDudShot: &square1SfxInit19,
	Square1SFX.u1A: &square1SfxInit1A,
	Square1SFX.metroidCry: &square1SfxInit1B,
	Square1SFX.saved: &square1SfxInit1C,
	Square1SFX.variaSuitTransformation: &square1SfxInit1D,
	Square1SFX.unpaused: &square1SfxInit1E,
];

void decrementChannelSoundEffectTimerSquare1W() { decrementChannelSoundEffectTimerSquare1(); }

immutable void function()[] square1SFXPlaybackPointers = [
	Square1SFX.jumping: &square1SfxPlayback1,
	Square1SFX.hiJumping: &square1SfxPlayback2,
	Square1SFX.screwAttacking: &square1SfxPlayback3,
	Square1SFX.standingTransition: &square1SfxPlayback4,
	Square1SFX.crouchingTransition: &square1SfxPlayback5,
	Square1SFX.morphingTransition: &square1SfxPlayback6,
	Square1SFX.shootingBeam: &square1SfxPlayback7,
	Square1SFX.shootingMissile: &square1SfxPlayback8,
	Square1SFX.shootingIceBeam: &square1SfxPlayback9,
	Square1SFX.shootingPlasmaBeam: &square1SfxPlaybackA,
	Square1SFX.shootingSpazerBeam: &square1SfxPlaybackB,
	Square1SFX.pickedUpMissileDrop: &square1SfxPlaybackC,
	Square1SFX.spiderBall: &square1SfxPlaybackD,
	Square1SFX.pickedUpSmallEnergyDrop: &square1SfxPlaybackE,
	Square1SFX.beamDink: &square1SfxPlaybackF,
	Square1SFX.u10: &square1SfxPlayback10,
	Square1SFX.u11: null,
	Square1SFX.u12: &decrementChannelSoundEffectTimerSquare1W,
	Square1SFX.bombLaid: &decrementChannelSoundEffectTimerSquare1W,
	Square1SFX.u14: &square1SfxPlayback14,
	Square1SFX.select: &square1SfxPlayback15,
	Square1SFX.shootingWaveBeam: &square1SfxPlayback16,
	Square1SFX.pickedUpLargeEnergyDrop: &square1SfxPlayback17,
	Square1SFX.samusHealthChange: &decrementChannelSoundEffectTimerSquare1W,
	Square1SFX.noMissileDudShot: &square1SfxPlayback19,
	Square1SFX.u1A: &square1SfxPlayback1A,
	Square1SFX.metroidCry: &square1SfxPlayback1B,
	Square1SFX.saved: &square1SfxPlayback1C,
	Square1SFX.variaSuitTransformation: &square1SfxPlayback1D,
	Square1SFX.unpaused: &square1SfxPlayback1E,
];

bool square1SfxInit1() {
	if ((audio.sfxPlayingSquare1 == Square1SFX.shootingWaveBeam) || ((audio.sfxPlayingSquare1 >= Square1SFX.shootingBeam) && (audio.sfxPlayingSquare1 <= Square1SFX.shootingSpazerBeam))) {
		return false;
	}
	if (audio.songPlaying == Song.chozoRuins) {
		playSquare1SFX(11, &optionSetsSquare1.jumping0[0]);
		return true;
	}
	playSquare1SFX(50, &optionSetsSquare1.jumping0[0]);
	return true;
}

void square1SfxPlayback1() {
	if (audio.songPlaying == Song.chozoRuins) {
		if (decrementChannelSoundEffectTimerSquare1() == 9) {
			setChannelOptionSetSquare1(&optionSetsSquare1.jumping1[0]);
		}
		return;
	}
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 45: setChannelOptionSetSquare1(&optionSetsSquare1.jumping1[0]); break;
		case 30: setChannelOptionSetSquare1(&optionSetsSquare1.jumping2[0]); break;
		case 24: setChannelOptionSetSquare1(&optionSetsSquare1.jumping3[0]); break;
		case 6: setChannelOptionSetSquare1(&optionSetsSquare1.jumping4[0]); break;
		case 1: setChannelOptionSetSquare1(&optionSetsSquare1.jumping5[0]); break;
		default: break;
	}
}

bool square1SfxInit2() {
	if ((audio.sfxPlayingSquare1 == Square1SFX.shootingWaveBeam) || ((audio.sfxPlayingSquare1 >= Square1SFX.shootingBeam) && (audio.sfxPlayingSquare1 <= Square1SFX.shootingSpazerBeam))) {
		return false;
	}
	if (audio.songPlaying == Song.chozoRuins) {
		playSquare1SFX(9, &optionSetsSquare1.hijumping0[0]);
		return true;
	}
	playSquare1SFX(67, &optionSetsSquare1.hijumping0[0]);
	return true;
}

void square1SfxPlayback2() {
	if (audio.songPlaying == Song.chozoRuins) {
		if (decrementChannelSoundEffectTimerSquare1() == 8) {
			setChannelOptionSetSquare1(&optionSetsSquare1.hijumping1[0]);
		}
		return;
	}
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 65: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping1[0]); break;
		case 45: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping2[0]); break;
		case 43: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping3[0]); break;
		case 24: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping4[0]); break;
		case 21: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping5[0]); break;
		case 4: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping6[0]); break;
		case 1: setChannelOptionSetSquare1(&optionSetsSquare1.hijumping7[0]); break;
		default: break;
	}
}
bool square1SfxInit3() {
	playSquare1SFX(63, &optionSetsSquare1.screwAttacking0[0]);
	return true;
}

void square1SfxPlayback3() {
	if (audio.sfxTimerSquare1 == 0) {
		audio.sfxTimerSquare1 = 16;
	}
	switch (--audio.sfxTimerSquare1) {
		case 59: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking1[0]); break;
		case 55: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking2[0]); break;
		case 51: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking3[0]); break;
		case 47: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking4[0]); break;
		case 43: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking5[0]); break;
		case 39: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking6[0]); break;
		case 35: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking7[0]); break;
		case 31: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking8[0]); break;
		case 27: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttacking9[0]); break;
		case 23: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingA[0]); break;
		case 19: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingB[0]); break;
		case 15: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingA[0]); break;
		case 12: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingB[0]); break;
		case 9: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingC[0]); break;
		case 6: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingD[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.screwAttackingC[0]); break;
		default: break;
	}
}

bool square1SfxInit4() {
	if (audio.sfxPlayingSquare1 <= Square1SFX.screwAttacking) {
		return false;
	}
	playSquare1SFX(10, &optionSetsSquare1.standingTransition0[0]);
	return true;
}

void square1SfxPlayback4() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 6: setChannelOptionSetSquare1(&optionSetsSquare1.standingTransition1[0]); break;
		case 2: setChannelOptionSetSquare1(&optionSetsSquare1.standingTransition2[0]); break;
		default: break;
	}
}

bool square1SfxInit5() {
	playSquare1SFX(10, &optionSetsSquare1.crouchingTransition0[0]);
	return true;
}

void square1SfxPlayback5() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 6: setChannelOptionSetSquare1(&optionSetsSquare1.crouchingTransition1[0]); break;
		case 2: setChannelOptionSetSquare1(&optionSetsSquare1.crouchingTransition2[0]); break;
		default: break;
	}
}

bool square1SfxInit6() {
	playSquare1SFX(14, &optionSetsSquare1.morphing0[0]);
	return true;
}

void square1SfxPlayback6() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 11: setChannelOptionSetSquare1(&optionSetsSquare1.morphing0[0]); break;
		case 8: setChannelOptionSetSquare1(&optionSetsSquare1.morphing1[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.morphing2[0]); break;
		default: break;
	}
}

bool square1SfxInit7() {
	playSquare1SFX(15, &optionSetsSquare1.shootingBeam0[0]);
	return true;
}

void square1SfxPlayback7() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 13: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam1[0]); break;
		case 11: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam1[0]); break;
		case 9: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam2[0]); break;
		case 7: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam2[0]); break;
		case 5: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam3[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam3[0]); break;
		case 1: setChannelOptionSetSquare1(&optionSetsSquare1.shootingBeam4[0]); break;
		default: break;
	}
}

bool square1SfxInit8() {
	playSquare1SFX(49, &optionSetsSquare1.shootingMissile0[0]);
	return true;
}

void square1SfxPlayback8() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 45: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile1[0]); break;
		case 37: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile2[0]); break;
		case 26: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile3[0]); break;
		case 24: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile4[0]); break;
		case 21: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile5[0]); break;
		case 18: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile6[0]); break;
		case 15: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile7[0]); break;
		case 12: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile8[0]); break;
		case 9: setChannelOptionSetSquare1(&optionSetsSquare1.shootingMissile9[0]); break;
		default: break;
	}
}

bool square1SfxInit9() {
	audio.sfxVariableFrequencySquare1 = 0xD0;
	playSquare1SFX(20, &optionSetsSquare1.shootingIceBeam[0]);
	return true;
}

void square1SfxPlayback9() {
	decrementChannelSoundEffectTimerSquare1();
	gb.AUD1LOW = audio.sfxVariableFrequencySquare1;
	audio.sfxVariableFrequencySquare1 = audio.sfxVariableFrequencySquare1; // that's just silly
}

bool square1SfxInitA() {
	audio.sfxVariableFrequencySquare1 = 0xD0;
	playSquare1SFX(20, &optionSetsSquare1.shootingPlasmaBeam[0]);
	return true;
}

void square1SfxPlaybackA() {
	decrementChannelSoundEffectTimerSquare1();
	gb.AUD1LOW = audio.sfxVariableFrequencySquare1;
	audio.sfxVariableFrequencySquare1 = audio.sfxVariableFrequencySquare1; // this is still silly
}

bool square1SfxInitB() {
	audio.sfxVariableFrequencySquare1 = 0xD0;
	playSquare1SFX(20, &optionSetsSquare1.shootingSpazerBeam[0]);
	return true;
}

void square1SfxPlaybackB() {
	decrementChannelSoundEffectTimerSquare1();
	gb.AUD1LOW = audio.sfxVariableFrequencySquare1;
	audio.sfxVariableFrequencySquare1 = audio.sfxVariableFrequencySquare1; // silliness continues
}

bool square1SfxInitC() {
	playSquare1SFX(20, &optionSetsSquare1.pickingUpMissileDrop0[0]);
	return true;
}

void square1SfxPlaybackC() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 13: setChannelOptionSetSquare1(&optionSetsSquare1.pickingUpMissileDrop1[0]); break;
		case 11: setChannelOptionSetSquare1(&optionSetsSquare1.pickingUpMissileDrop2[0]); break;
		case 8: setChannelOptionSetSquare1(&optionSetsSquare1.pickingUpMissileDrop3[0]); break;
		case 5: setChannelOptionSetSquare1(&optionSetsSquare1.pickingUpMissileDrop4[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.pickedUpDropEnd[0]); break;
		default: break;
	}
}

bool square1SfxInitD() {
	playSquare1SFX(13, &optionSetsSquare1.spiderBall0[0]);
	return true;
}

void square1SfxPlaybackD() {
	if (decrementChannelSoundEffectTimerSquare1() == 3) {
		setChannelOptionSetSquare1(&optionSetsSquare1.spiderBall1[0]);
	}
}

bool square1SfxInitE() {
	rememberIfScrewAttackingSfxIsPlaying();
	playSquare1SFX(10, &optionSetsSquare1.pickedUpEnergyDrop0[0]);
	return true;
}

void square1SfxPlaybackE() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 1: maybeResumeScrewAttackingSFX(); break;
		case 8: setChannelOptionSetSquare1(&optionSetsSquare1.pickedUpEnergyDrop1[0]); break;
		case 5: setChannelOptionSetSquare1(&optionSetsSquare1.pickedUpEnergyDrop2[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.pickedUpDropEnd[0]); break;
		default: break;
	}
}

bool square1SfxInitF() {
	playSquare1SFX(5, &optionSetsSquare1.shotMissileDoorWithBeam0[0]);
	return true;
}

void square1SfxPlaybackF() {
	if (decrementChannelSoundEffectTimerSquare1() == 2) {
		setChannelOptionSetSquare1(&optionSetsSquare1.shotMissileDoorWithBeam1[0]);
	}
}

bool square1SfxInit10() {
	playSquare1SFX(22, &optionSetsSquare1.unknown100[0]);
	return true;
}

void square1SfxPlayback10() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 20: setChannelOptionSetSquare1(&optionSetsSquare1.unknown101[0]); break;
		case 18: setChannelOptionSetSquare1(&optionSetsSquare1.unknown102[0]); break;
		case 16: setChannelOptionSetSquare1(&optionSetsSquare1.unknown103[0]); break;
		case 14: setChannelOptionSetSquare1(&optionSetsSquare1.unknown104[0]); break;
		case 12: setChannelOptionSetSquare1(&optionSetsSquare1.unknown105[0]); break;
		case 10: setChannelOptionSetSquare1(&optionSetsSquare1.unknown106[0]); break;
		case 8: setChannelOptionSetSquare1(&optionSetsSquare1.unknown107[0]); break;
		case 6: setChannelOptionSetSquare1(&optionSetsSquare1.unknown108[0]); break;
		case 4: setChannelOptionSetSquare1(&optionSetsSquare1.unknown109[0]); break;
		case 2: setChannelOptionSetSquare1(&optionSetsSquare1.unknown10A[0]); break;
		default: break;
	}
}

bool square1SfxInit12() {
	playSquare1SFX(0, &optionSetsSquare1.unused12[0]);
	return true;
}

bool square1SfxInit13() {
	playSquare1SFX(2, &optionSetsSquare1.bombLaid[0]);
	return true;
}

bool square1SfxInit14() {
	playSquare1SFX(14, &optionSetsSquare1.unused140[0]);
	return true;
}

void square1SfxPlayback14() {
	if (decrementChannelSoundEffectTimerSquare1() == 6) {
		setChannelOptionSetSquare1(&optionSetsSquare1.unused141[0]);
	}
}

bool square1SfxInit15() {
	playSquare1SFX(4, &optionSetsSquare1.optionMissileSelect0[0]);
	return true;
}

void square1SfxPlayback15() {
	if (decrementChannelSoundEffectTimerSquare1() == 2) {
		setChannelOptionSetSquare1(&optionSetsSquare1.optionMissileSelect1[0]);
	}
}

bool square1SfxInit16() {
	playSquare1SFX(29, &optionSetsSquare1.shootingWaveBeam0[0]);
	return true;
}

void square1SfxPlayback16() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 26: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam1[0]); break;
		case 21: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam1[0]); break;
		case 17: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam2[0]); break;
		case 13: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam2[0]); break;
		case 9: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam3[0]); break;
		case 5: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam3[0]); break;
		case 1: setChannelOptionSetSquare1(&optionSetsSquare1.shootingWaveBeam4[0]); break;
		default: break;
	}
}

bool square1SfxInit17() {
	rememberIfScrewAttackingSfxIsPlaying();
	playSquare1SFX(16, &optionSetsSquare1.largeEnergyDrop0[0]);
	return true;
}

void square1SfxPlayback17() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 1: maybeResumeScrewAttackingSFX(); break;
		case 13: setChannelOptionSetSquare1(&optionSetsSquare1.largeEnergyDrop1[0]); break;
		case 10: setChannelOptionSetSquare1(&optionSetsSquare1.largeEnergyDrop2[0]); break;
		case 8: setChannelOptionSetSquare1(&optionSetsSquare1.largeEnergyDrop3[0]); break;
		case 5: setChannelOptionSetSquare1(&optionSetsSquare1.largeEnergyDrop4[0]); break;
		case 2: setChannelOptionSetSquare1(&optionSetsSquare1.largeEnergyDrop4[0]); break;
		default: break;
	}
}

bool square1SfxInit18() {
	if (!audio.samusHealthChangedOptionSetIndex) {
		audio.samusHealthChangedOptionSetIndex = 2;
	}
	switch (audio.samusHealthChangedOptionSetIndex) {
		case 1:
			audio.samusHealthChangedOptionSetIndex--;
			playSquare1SFX(2, &optionSetsSquare1.samusHealthChanged0[0]);
			break;
		case 2:
			audio.samusHealthChangedOptionSetIndex--;
			playSquare1SFX(2, &optionSetsSquare1.samusHealthChanged1[0]);
			break;
		case 0:
		default:
			audio.samusHealthChangedOptionSetIndex = 2;
			break;
	}
	return true;
}

bool square1SfxInit19() {
	playSquare1SFX(4, &optionSetsSquare1.noMissileDudShot0[0]);
	return true;
}

void square1SfxPlayback19() {
	if (decrementChannelSoundEffectTimerSquare1() == 2) {
		setChannelOptionSetSquare1(&optionSetsSquare1.noMissileDudShot1[0]);
	}
}

bool square1SfxInit1A() {
	playSquare1SFX(22, &optionSetsSquare1.unknown1A0[0]);
	return true;
}

void square1SfxPlayback1A() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 20: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A1[0]); break;
		case 18: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A2[0]); break;
		case 16: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A1[0]); break;
		case 14: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A3[0]); break;
		case 12: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A1[0]); break;
		case 10: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A4[0]); break;
		case 8: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A1[0]); break;
		case 6: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A5[0]); break;
		case 4: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A1[0]); break;
		case 2: setChannelOptionSetSquare1(&optionSetsSquare1.unknown1A6[0]); break;
		default: break;
	}
}

bool square1SfxInit1B() {
	audio.sfxVariableFrequencySquare1 = swap(gb.DIV) | 0b11100010;
	playSquare1SFX(48, &optionSetsSquare1.metroidCry[0]);
	return true;
}
void square1SfxPlayback1B() {
	if (decrementChannelSoundEffectTimerSquare1() >= 32) {
		audio.sfxVariableFrequencySquare1 += 6;
		gb.AUD1LOW = audio.sfxVariableFrequencySquare1;
	} else {
		audio.sfxVariableFrequencySquare1--;
		gb.AUD1LOW = audio.sfxVariableFrequencySquare1;
	}
}

bool square1SfxInit1C() {
	playSquare1SFX(15, &optionSetsSquare1.saved0[0]);
	return true;
}

void square1SfxPlayback1C() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 10: setChannelOptionSetSquare1(&optionSetsSquare1.saved1[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.saved2[0]); break;
		default: break;
	}
}

bool square1SfxInit1D() {
	playSquare1SFX(144, &optionSetsSquare1.variaSuitTransformation[0]);
	return true;
}

void square1SfxPlayback1D() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 126: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		case 110: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		case 94: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		case 78: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		case 62: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		case 46: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		case 30: setChannelOptionSetSquare1(&optionSetsSquare1.variaSuitTransformation[0]); break;
		default: break;
	}
}

bool square1SfxInit1E() {
	playSquare1SFX(14, &optionSetsSquare1.unpaused0[0]);
	return true;
}

void square1SfxPlayback1E() {
	switch (decrementChannelSoundEffectTimerSquare1()) {
		case 10: setChannelOptionSetSquare1(&optionSetsSquare1.unpaused1[0]); break;
		case 3: setChannelOptionSetSquare1(&optionSetsSquare1.unpaused2[0]); break;
		default: break;
	}
}

void rememberIfScrewAttackingSfxIsPlaying() {
	if (audio.sfxPlayingSquare1 == Square1SFX.screwAttacking) {
		audio.resumeScrewAttackSoundEffectFlag = cast(ubyte)audio.sfxPlayingSquare1;
	}
}
void maybeResumeScrewAttackingSFX() {
	if ((audio.resumeScrewAttackSoundEffectFlag == 0) || (samusPose != SamusPose.spinJumping) || (samusItems & ItemFlag.screwAttack)) {
		return;
	}
	audio.sfxPlayingSquare1 = Square1SFX.screwAttacking;
	audio.resumeScrewAttackSoundEffectFlag = 0;
}

void playSquare1SFX(ubyte a, const(ubyte)* set) {
	audio.sfxTimerSquare1 = a;
	audio.sfxPlayingSquare1 = audio.sfxRequestSquare1;
	audio.sfxActiveSquare1 = cast(ubyte)audio.sfxRequestSquare1;
	setChannelOptionSetSquare1(set);
}

immutable bool function()[] songSoundEffectInitialisationFunctionPointersSquare2 = [
    Square2SFX.nothing1: null,
    Square2SFX.nothing2: null,
    Square2SFX.metroidQueenCry: &square2SfxInit3,
    Square2SFX.babyMetroidClearingBlock: &square2SfxInit4,
    Square2SFX.babyMetroidCry: &square2SfxInit5,
    Square2SFX.metroidQueenHurtCry: &square2SfxInit6,
    Square2SFX.u7: &square2SfxInit7,
];

void decrementChannelSoundEffectTimerSquare2W() { decrementChannelSoundEffectTimerSquare2(); }

immutable void function()[] songSoundEffectPlaybackFunctionPointersSquare2 = [
    Square2SFX.nothing1: null,
    Square2SFX.nothing2: null,
    Square2SFX.metroidQueenCry: &square2SfxPlayback3,
    Square2SFX.babyMetroidClearingBlock: &square2SfxPlayback4,
    Square2SFX.babyMetroidCry: &square2SfxPlayback5,
    Square2SFX.metroidQueenHurtCry: &square2SfxPlayback6,
    Square2SFX.u7: &decrementChannelSoundEffectTimerSquare2W,
];

bool square2SfxInit3() {
	audio.square2VariableFrequency = swap(gb.DIV) | 0b11100000;
	playSquare2SFX(48, &optionSetsSquare2.metroidQueenCry[0]);
	return true;
}

void square2SfxPlayback3() {
	if (decrementChannelSoundEffectTimerSquare2() & 1) {
		audio.square2VariableFrequency |= 0b00010000;
	} else {
		audio.square2VariableFrequency &= ~0b00010000;
	}
	if (audio.sfxTimerSquare2 < 32) {
		audio.square2VariableFrequency += 3;
		gb.AUD2LOW = audio.square2VariableFrequency;
	} else {
		audio.square2VariableFrequency--;
		gb.AUD2LOW = audio.square2VariableFrequency;
	}
}
alias square2SfxPlayback5 = square2SfxPlayback3;
alias square2SfxPlayback6 = square2SfxPlayback3;

bool square2SfxInit4() {
	audio.square2VariableFrequency = (swap(gb.DIV) | 0b10000000) & ~0b01000000;
	playSquare2SFX(28, &optionSetsSquare2.babyMetroidClearingBlockSquare2[0]);
	return true;
}

void square2SfxPlayback4() {
	switch (decrementChannelSoundEffectTimerSquare2()) {
		case 19:
			audio.square2VariableFrequency = 160;
			break;
		case 12:
			audio.square2VariableFrequency = 144;
			break;
		default:
			audio.square2VariableFrequency += 2;
			gb.AUD2LOW = audio.square2VariableFrequency;
			break;
	}
}

bool square2SfxInit5() {
	audio.square2VariableFrequency = (swap(gb.DIV) | 0b01000000) & ~0b10010100;
	playSquare2SFX(48, &optionSetsSquare2.babyMetroidCrySquare2[0]);
	return true;
}

bool square2SfxInit6() {
	audio.square2VariableFrequency = (swap(gb.DIV) | 0b01000000) & ~0b10000000;
	playSquare2SFX(48, &optionSetsSquare2.metroidQueenHurtCry[0]);
	return true;
}

bool square2SfxInit7() {
	playSquare2SFX(1, &optionSetsSquare2.unknown7[0]);
	return true;
}

void playSquare2SFX(ubyte a, const(ubyte)* set) {
	audio.sfxTimerSquare2 = a;
	audio.sfxPlayingSquare2 = audio.sfxRequestSquare2;
	audio.sfxActiveSquare2 = cast(ubyte)audio.sfxRequestSquare2;
	setChannelOptionSetSquare2(set);
}

immutable bool function()[] songSoundEffectInitializationFunctionPointersNoise = [
    NoiseSFX.u01: &noiseSfxInit1,
    NoiseSFX.u02: &noiseSfxInit2,
    NoiseSFX.u03: &noiseSfxInit3,
    NoiseSFX.u04: &noiseSfxInit4,
    NoiseSFX.u05: &noiseSfxInit5,
    NoiseSFX.u06: &noiseSfxInit6,
    NoiseSFX.u07: &noiseSfxInit7,
    NoiseSFX.u08: &noiseSfxInit8,
    NoiseSFX.u09: &noiseSfxInit9,
    NoiseSFX.u0A: &noiseSfxInitA,
    NoiseSFX.u0B: &noiseSfxInitB,
    NoiseSFX.u0C: &noiseSfxInitC,
    NoiseSFX.u0D: &noiseSfxInitD,
    NoiseSFX.u0E: &noiseSfxInitE,
    NoiseSFX.u0F: &noiseSfxInitF,
    NoiseSFX.u10: &noiseSfxInit10,
    NoiseSFX.u11: &noiseSfxInit11,
    NoiseSFX.u12: &noiseSfxInit12,
    NoiseSFX.u13: &noiseSfxInit13,
    NoiseSFX.u14: &noiseSfxInit14,
    NoiseSFX.u15: &noiseSfxInit15,
    NoiseSFX.u16: &noiseSfxInit16,
    NoiseSFX.u17: &noiseSfxInit17,
    NoiseSFX.u18: &noiseSfxInit18,
    NoiseSFX.u19: &noiseSfxInit19,
    NoiseSFX.u1A: &noiseSfxInit1A,
];

void decrementChannelSoundEffectTimerNoiseW () { decrementChannelSoundEffectTimerNoise(); }

immutable void function()[] songSoundEffectPlaybackFunctionPointersNoise = [
    NoiseSFX.u01: &decrementChannelSoundEffectTimerNoiseW,
    NoiseSFX.u02: &noiseSfxPlayback2,
    NoiseSFX.u03: &decrementChannelSoundEffectTimerNoiseW,
    NoiseSFX.u04: &decrementChannelSoundEffectTimerNoiseW,
    NoiseSFX.u05: &noiseSfxPlayback5,
    NoiseSFX.u06: &noiseSfxPlayback6,
    NoiseSFX.u07: &noiseSfxPlayback7,
    NoiseSFX.u08: &noiseSfxPlayback8,
    NoiseSFX.u09: &noiseSfxPlayback9,
    NoiseSFX.u0A: &noiseSfxPlaybackA,
    NoiseSFX.u0B: &noiseSfxPlaybackB,
    NoiseSFX.u0C: &noiseSfxPlaybackC,
    NoiseSFX.u0D: &noiseSfxPlaybackD,
    NoiseSFX.u0E: &noiseSfxPlaybackE,
    NoiseSFX.u0F: &noiseSfxPlaybackF,
    NoiseSFX.u10: &noiseSfxPlayback10,
    NoiseSFX.u11: &noiseSfxPlayback11,
    NoiseSFX.u12: &noiseSfxPlayback12,
    NoiseSFX.u13: &noiseSfxPlayback13,
    NoiseSFX.u14: &noiseSfxPlayback14,
    NoiseSFX.u15: &noiseSfxPlayback15,
    NoiseSFX.u16: &decrementChannelSoundEffectTimerNoiseW,
    NoiseSFX.u17: &decrementChannelSoundEffectTimerNoiseW,
    NoiseSFX.u18: &noiseSfxPlayback18,
    NoiseSFX.u19: &decrementChannelSoundEffectTimerNoiseW,
    NoiseSFX.u1A: &decrementChannelSoundEffectTimerNoiseW,
];

bool noiseSfxInit1() {
	playNoiseSweepSFX(13, &optionSetsNoise.enemyShot[0]);
	return true;
}

bool noiseSfxInit2() {
	playNoiseSweepSFX(25, &optionSetsNoise.enemyKilled0[0]);
	return true;
}

void noiseSfxPlayback2() {
	if (decrementChannelSoundEffectTimerNoise() == 0xD) {
		SetChannelOptionSetNoise(&optionSetsNoise.enemyKilled1[0]);
	}
}

bool noiseSfxInit3() {
	playNoiseSweepSFX(29, &optionSetsNoise.unknown3[0]);
	return true;
}

bool noiseSfxInit4() {
	playNoiseSweepSFX(8, &optionSetsNoise.shotBlockDestroyed[0]);
	return true;
}

bool noiseSfxInit5() {
	audio.sfxRequestSquare1 = Square1SFX.metroidCry;
	playNoiseSweepSFX(64, &optionSetsNoise.metroidHurt0[0]);
	return true;
}

void noiseSfxPlayback5() {
	if (decrementChannelSoundEffectTimerNoise() == 0x38) {
		SetChannelOptionSetNoise(&optionSetsNoise.metroidHurt1[0]);
	}
}

bool noiseSfxInit6() {
	playNoiseSweepSFX(20, &optionSetsNoise.samusHurt0[0]);
	return true;
}

void noiseSfxPlayback6() {
	switch(decrementChannelSoundEffectTimerNoise()) {
		case 16:
		case 8:
			SetChannelOptionSetNoise(&optionSetsNoise.samusHurt1[0]); break;
		case 12:
			SetChannelOptionSetNoise(&optionSetsNoise.samusHurt0[0]); break;
		default: break;
	}
}

bool noiseSfxInit7() {
	playNoiseSweepSFX(8, &optionSetsNoise.acidDamage0[0]);
	return true;
}

void noiseSfxPlayback7() {
	if (decrementChannelSoundEffectTimerNoise() == 5) {
		SetChannelOptionSetNoise(&optionSetsNoise.samusHurt1[0]);
	}
}

bool noiseSfxInit8() {
	playNoiseSweepSFX(8, &optionSetsNoise.shotMissileDoor0[0]);
	return true;
}

void noiseSfxPlayback8() {
	if (decrementChannelSoundEffectTimerNoise() == 5) {
		SetChannelOptionSetNoise(&optionSetsNoise.shotMissileDoor1[0]);
	}
}

bool noiseSfxInit9() {
	audio.sfxRequestSquare2 = Square2SFX.metroidQueenCry;
	playNoiseSweepSFX(64, &optionSetsNoise.metroidQueenCry0[0]);
	return true;
}

void noiseSfxPlayback9() {
	if (decrementChannelSoundEffectTimerNoise() == 56) {
		SetChannelOptionSetNoise(&optionSetsNoise.metroidQueenCry1[0]);
	}
}

bool noiseSfxInitA() {
	audio.sfxRequestSquare2 = Square2SFX.metroidQueenHurtCry;
	playNoiseSweepSFX(64, &optionSetsNoise.metroidQueenHurtCry0[0]);
	return true;
}

void noiseSfxPlaybackA() {
	if (decrementChannelSoundEffectTimerNoise() == 56) {
		SetChannelOptionSetNoise(&optionSetsNoise.metroidQueenHurtCry1[0]);
	}
}

bool noiseSfxInitB() {
	playNoiseSweepSFX(176, &optionSetsNoise.samusKilled0[0]);
	return true;
}

void noiseSfxPlaybackB() {
	switch (decrementChannelSoundEffectTimerNoise()) {
		case 159: SetChannelOptionSetNoise(&optionSetsNoise.samusKilled1[0]); break;
		case 112: SetChannelOptionSetNoise(&optionSetsNoise.samusKilled2[0]); break;
		case 108: setPolynomialCounter27(); break;
		case 104: setPolynomialCounter35(); break;
		case 100: setPolynomialCounter37(); break;
		case 96: setPolynomialCounter45(); break;
		case 92: setPolynomialCounter47(); break;
		case 88: setPolynomialCounter55(); break;
		case 84: setPolynomialCounter57(); break;
		case 80: setPolynomialCounter65(); break;
		case 76: setPolynomialCounter66(); break;
		case 72: setPolynomialCounter67(); break;
		case 64: SetChannelOptionSetNoise(&optionSetsNoise.samusKilled3[0]); break;
		default: break;
	}
}

void setPolynomialCounter27() {
	gb.AUD4POLY = 0x27;
}
void setPolynomialCounter35() {
	gb.AUD4POLY = 0x35;
}
void setPolynomialCounter37() {
	gb.AUD4POLY = 0x37;
}
void setPolynomialCounter45() {
	gb.AUD4POLY = 0x45;
}
void setPolynomialCounter47() {
	gb.AUD4POLY = 0x47;
}
void setPolynomialCounter55() {
	gb.AUD4POLY = 0x55;
}
void setPolynomialCounter57() {
	gb.AUD4POLY = 0x57;
}
void setPolynomialCounter65() {
	gb.AUD4POLY = 0x65;
}
void setPolynomialCounter66() {
	gb.AUD4POLY = 0x66;
}
void setPolynomialCounter67() {
	gb.AUD4POLY = 0x67;
}

bool noiseSfxInitC() {
	playNoiseSweepSFX(20, &optionSetsNoise.bombDetonated0[0]);
	return true;
}

void noiseSfxPlaybackC() {
	if (decrementChannelSoundEffectTimerNoise() == 12) {
		SetChannelOptionSetNoise(&optionSetsNoise.bombDetonated1[0]);
	}
}

bool noiseSfxInitD() {
	playNoiseSweepSFX(53, &optionSetsNoise.metroidKilled0[0]);
	return true;
}

void noiseSfxPlaybackD() {
	switch (decrementChannelSoundEffectTimerNoise()) {
		case 48: setPolynomialCounter57(); break;
		case 44: setPolynomialCounter35(); break;
		case 39: setPolynomialCounter37(); break;
		case 35: setPolynomialCounter55(); break;
		case 32: setPolynomialCounter47(); break;
		case 29: setPolynomialCounter45(); break;
		case 26: SetChannelOptionSetNoise(&optionSetsNoise.metroidKilled1[0]); break;
		default: break;
	}
}

bool noiseSfxInitE() {
	playNoiseSweepSFX(79, &optionSetsNoise.unknownE0[0]);
	return true;
}

void noiseSfxPlaybackE() {
	switch (decrementChannelSoundEffectTimerNoise()) {
		case 77: setPolynomialCounter65(); break;
		case 74: setPolynomialCounter57(); break;
		case 71: setPolynomialCounter55(); break;
		case 68: setPolynomialCounter47(); break;
		case 65: setPolynomialCounter65(); break;
		case 62: setPolynomialCounter57(); break;
		case 59: setPolynomialCounter55(); break;
		case 57: setPolynomialCounter47(); break;
		case 54: setPolynomialCounter45(); break;
		case 51: setPolynomialCounter37(); break;
		case 48: SetChannelOptionSetNoise(&optionSetsNoise.unknownE1[0]); break;
		default: break;
	}
}

bool noiseSfxInitF() {
	playNoiseSweepSFX(112, &optionSetsNoise.clearedSaveFile0[0]);
	return true;
}

void noiseSfxPlaybackF() {
	switch (decrementChannelSoundEffectTimerNoise()) {
		case 109: setPolynomialCounter67(); break;
		case 106: setPolynomialCounter66(); break;
		case 103: setPolynomialCounter65(); break;
		case 100: setPolynomialCounter57(); break;
		case 97: setPolynomialCounter55(); break;
		case 94: setPolynomialCounter47(); break;
		case 91: setPolynomialCounter45(); break;
		case 89: setPolynomialCounter37(); break;
		case 86: setPolynomialCounter35(); break;
		case 83: setPolynomialCounter27(); break;
		case 80: SetChannelOptionSetNoise(&optionSetsNoise.clearedSaveFile1[0]); break;
		default: break;
	}
}

bool noiseSfxInit10() {
	if ((audio.sfxPlayingNoise != NoiseSFX.u00) || (audio.songState.songChannelEnableNoise != 0)) {
		return false;
	}
	playNoiseSweepSFX(2, &optionSetsNoise.footsteps0[0]);
	return true;
}

void noiseSfxPlayback10() {
	if (decrementChannelSoundEffectTimerNoise() == 1) {
		SetChannelOptionSetNoise(&optionSetsNoise.footsteps1[0]);
	}
}

bool noiseSfxInit11() {
	playNoiseSweepSFX(16, &optionSetsNoise.unknown110[0]);
	return true;
}

alias noiseSfxPlayback12 = noiseSfxPlayback11;
alias noiseSfxPlayback13 = noiseSfxPlayback11;
void noiseSfxPlayback11() {
	if (decrementChannelSoundEffectTimerNoise() == 12) {
		SetChannelOptionSetNoise(&optionSetsNoise.unknown1[0]);
	}
}

bool noiseSfxInit12() {
	playNoiseSweepSFX(16, &optionSetsNoise.unknown120[0]);
	return true;
}

bool noiseSfxInit13() {
	playNoiseSweepSFX(16, &optionSetsNoise.unused130[0]);
	return true;
}

bool noiseSfxInit14() {
	playNoiseSweepSFX(24, &optionSetsNoise.unknown140[0]);
	return true;
}

void noiseSfxPlayback14() {
	switch (decrementChannelSoundEffectTimerNoise()) {
		case 16: SetChannelOptionSetNoise(&optionSetsNoise.unknown141[0]); break;
		case 12: SetChannelOptionSetNoise(&optionSetsNoise.unknown140[0]); break;
		case 8: SetChannelOptionSetNoise(&optionSetsNoise.unknown141[0]); break;
		default: break;
	}
}

bool noiseSfxInit15() {
	playNoiseSweepSFX(48, &optionSetsNoise.unknown150[0]);
	return true;
}

void noiseSfxPlayback15() {
	if (decrementChannelSoundEffectTimerNoise() == 32) {
		SetChannelOptionSetNoise(&optionSetsNoise.unknown151[0]);
	}
}

bool noiseSfxInit16() {
	audio.sfxRequestSquare2 = Square2SFX.babyMetroidClearingBlock;
	playNoiseSweepSFX(8, &optionSetsNoise.babyMetroidClearingBlock[0]);
	return true;
}

bool noiseSfxInit17() {
	audio.sfxRequestSquare2 = Square2SFX.babyMetroidCry;
	playNoiseSweepSFX(64, &optionSetsNoise.babyMetroidCry[0]);
	return true;
}

bool noiseSfxInit18() {
	playNoiseSweepSFX(15, &optionSetsNoise.unknown180[0]);
	return true;
}


void noiseSfxPlayback18() {
	if (decrementChannelSoundEffectTimerNoise() == 12) {
		SetChannelOptionSetNoise(&optionSetsNoise.unknown181[0]);
	}
}

bool noiseSfxInit19() {
	playNoiseSweepSFX(16, &optionSetsNoise.unused19[0]);
	return true;
}

bool noiseSfxInit1A() {
	playNoiseSweepSFX(16, &optionSetsNoise.unknown1A[0]);
	return true;
}

void playNoiseSweepSFX(ubyte a, const(ubyte)* set) {
	audio.sfxTimerNoise = a;
	audio.sfxPlayingNoise = audio.sfxRequestNoise;
	audio.sfxActiveNoise = audio.sfxRequestNoise;
	SetChannelOptionSetNoise(set);
}


immutable void function()[] songSoundEffectInitialisationFunctionPointersWave = [
    WaveSFX.samusHealth10: &waveSFXInit1,
    WaveSFX.samusHealth20: &waveSFXInit2,
    WaveSFX.samusHealth30: &waveSFXInit3,
    WaveSFX.samusHealth40: &waveSFXInit4,
    WaveSFX.samusHealth50: &waveSFXInit5,
];

immutable void function()[] songSoundEffectPlaybackFunctionPointersWave = [
    WaveSFX.samusHealth10: &waveSFXPlayback1,
    WaveSFX.samusHealth20: &waveSFXPlayback2,
    WaveSFX.samusHealth30: &waveSFXPlayback3,
    WaveSFX.samusHealth40: &waveSFXPlayback4,
    WaveSFX.samusHealth50: &waveSFXPlayback5,
];

void waveSFXInit1() {
	gb.AUD3ENA = 0;
	writeToWavePatternRAM(&wavePatterns[4][0]);
	audio.loudLowHealthBeepTimer = 12;
	playWaveSFX(14, &optionSetsWave.healthUnder20_0[0]);
}
alias waveSFXInit2 = waveSFXInit1;

void waveSFXPlayback1() {
	audio.sfxActiveWave = 1;
	switch (--audio.sfxTimerWave) {
		case 10:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				gb.AUD3ENA = 0;
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			SetChannelOptionSetWave(&optionSetsWave.healthUnder20_1[0]);
			break;
		default:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			audio.sfxTimerWave = audio.sfxLengthWave;
			SetChannelOptionSetWave(&optionSetsWave.healthUnder20_0[0]);
			break;
		case 0:
			break;
	}
}
alias waveSFXPlayback2 = waveSFXPlayback1;

void waveSFXInit3() {
	gb.AUD3ENA = 0;
	writeToWavePatternRAM(&wavePatterns[4][0]);
	audio.loudLowHealthBeepTimer = 6;
	playWaveSFX(19, &optionSetsWave.healthUnder30_0[0]);
}
void waveSFXPlayback3() {
	audio.sfxActiveWave = 2;
	switch (--audio.sfxTimerWave) {
		case 9:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				gb.AUD3ENA = 0;
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			SetChannelOptionSetWave(&optionSetsWave.healthUnder30_1[0]);
			break;
		default:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			audio.sfxTimerWave = audio.sfxLengthWave;
			SetChannelOptionSetWave(&optionSetsWave.healthUnder30_0[0]);
			break;
		case 0:
			break;
	}
}

void waveSFXInit4() {
	gb.AUD3ENA = 0;
	writeToWavePatternRAM(&wavePatterns[4][0]);
	audio.loudLowHealthBeepTimer = 6;
	playWaveSFX(22, &optionSetsWave.healthUnder40_0[0]);
}
void waveSFXPlayback4() {
	audio.sfxActiveWave = 3;
	switch (--audio.sfxTimerWave) {
		case 9:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				gb.AUD3ENA = 0;
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			SetChannelOptionSetWave(&optionSetsWave.healthUnder40_1[0]);
			break;
		default:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			audio.sfxTimerWave = audio.sfxLengthWave;
			SetChannelOptionSetWave(&optionSetsWave.healthUnder40_0[0]);
			break;
		case 0:
			break;
	}
}

void waveSFXInit5() {
	gb.AUD3ENA = 0;
	writeToWavePatternRAM(&wavePatterns[4][0]);
	audio.loudLowHealthBeepTimer = 6;
	playWaveSFX(24, &optionSetsWave.healthUnder50_0[0]);
}
void waveSFXPlayback5() {
	audio.sfxActiveWave = 4;
	switch (--audio.sfxTimerWave) {
		case 11:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				gb.AUD3ENA = 0;
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			SetChannelOptionSetWave(&optionSetsWave.healthUnder50_1[0]);
			break;
		default:
			if (audio.loudLowHealthBeepTimer != 0) {
				audio.loudLowHealthBeepTimer--;
				writeToWavePatternRAM(&wavePatterns[4][0]);
			} else {
				writeToWavePatternRAM(&wavePatterns[5][0]);
			}
			audio.sfxTimerWave = audio.sfxLengthWave;
			SetChannelOptionSetWave(&optionSetsWave.healthUnder50_0[0]);
			break;
		case 0:
			break;
	}
}

void playWaveSFX(ubyte length, const(ubyte)* wave) {
	audio.sfxTimerWave = length;
	audio.sfxLengthWave = length;
	SetChannelOptionSetWave(wave);
}

immutable(ubyte)[] getTempoData(ushort originalAddress) @safe {
    enum OriginalTempoOffset {
        table448 = 0x409E,
        table224 = 0x40AB,
        table149 = 0x40B8,
        table112 = 0x40C5,
        table90 = 0x40D2,
        table75 = 0x40DF,
        table64 = 0x40EC,
        table56 = 0x40F9,
        table50 = 0x4106,
    }
    switch (cast(OriginalTempoOffset)originalAddress) {
        case OriginalTempoOffset.table448:
            return tempoTable448;
        case OriginalTempoOffset.table224:
            return tempoTable224;
        case OriginalTempoOffset.table149:
            return tempoTable149;
        case OriginalTempoOffset.table112:
            return tempoTable112;
        case OriginalTempoOffset.table90:
            return tempoTable90;
        case OriginalTempoOffset.table75:
            return tempoTable75;
        case OriginalTempoOffset.table64:
            return tempoTable64;
        case OriginalTempoOffset.table56:
            return tempoTable56;
        case OriginalTempoOffset.table50:
            return tempoTable50;
        default:
			return [];
    }
}
