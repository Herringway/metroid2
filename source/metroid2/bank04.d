module metroid2.bank04;

import metroid2.audiodata;
import metroid2.defs;
import metroid2.globals;
import metroid2.registers;

import std.format;
import std.logger;

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

immutable ubyte[16][5] songSoundChannelEffectTable = [
	[0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01],
	[0x08, 0x10, 0x18, 0x20, 0x28, 0x30, 0x38, 0x40, 0x38, 0x30, 0x28, 0x20, 0x18, 0x10, 0x08, 0x00],
	[0x00, 0x05, 0x00, 0x05, 0x00, 0x05, 0x00, 0x05, 0x05, 0x00, 0x05, 0x00, 0x05, 0x00, 0x05, 0x00],
	[0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01],
	[0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x03],
];

void handleAudio() {
	debug(audio) {
		if (audioPauseControl == 1) {
			assert(0);
		} else if (audioPauseControl == 2) {
			audioPauseSoundEffectTimer = 0;
			sfxRequestSquare1 = Square1SFX.unpaused;
		}
		if (audioPauseSoundEffectTimer) {
			switch (--audioPauseSoundEffectTimer) {
				case 0x3F: handleAudioPausedSquare1SFX(&frame3F[0]); break;
				case 0x3D: handleAudioPausedNoiseSFX(&frame3D[0]); break;
				case 0x3A: handleAudioPausedSquare1SFX(&frame3A[0]); break;
				case 0x32: handleAudioPausedNoiseSFX(&frame32[0]); break;
				case 0x2F: handleAudioPausedSquare1SFX(&frame2F[0]); break;
				case 0x27: handleAudioPausedNoiseSFX(&frame27[0]); break;
				case 0x24: handleAudioPausedSquare1SFX(&frame24[0]); break;
				case 0x10: clearNonWaveSoundEffectRequests(); break;
				default:
					audioPauseSoundEffectTimer++;
					clearNonWaveSoundEffectRequests();
					break;
			}
			return;
		}
		handleAudioHandleSongInterruptionRequest();
		infof("Frame done");
	}
}

void handleAudioHandleSongInterruptionRequest() {
		switch (songInterruptionRequest) {
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
				handleAudioInitiateFadingOutMusic();
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
	if (!songInterruptionPlaying) {
		handleSongAndSoundEffects();
	} else if (songInterruptionPlaying == Song2.endPlaying) {
	} else if (songInterruptionPlaying == Song2.fadeOut) {
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
	songRequest = Song.nothing;
	sfxRequestNoise = NoiseSFX.u00;
	sfxRequestSquare1 = Square1SFX.nothing;
	sfxRequestSquare2 = Square2SFX.nothing0;
	sfxRequestFakeWave = 0;
	songInterruptionRequest = Song2.nothing;
	sfxRequestLowHealthBeep = 0;
	audioPauseControl = 0;
}

void clearSongInterruption() {
	songInterruptionRequest = Song2.nothing;
	songInterruptionPlaying = Song2.nothing;
}
void playSongInterruptionItemGet(Song2 a) {
	songInterruptionPlaying = a;
	songRequest = Song.itemGet;
	playSongInterruption();
}
void playSongInterruptionMissilePickup(Song2 a) {
	songInterruptionPlaying = a;
	songRequest = Song.missilePickup;
	playSongInterruption();
}
void playSongInterruptionEarthquake(Song2 a) {
	songInterruptionPlaying = a;
	songRequest = cast(Song)a;
	playSongInterruption();
}
void playSongInterruption() {
	assert(0); // TODO
}

void startEndingSongInterruption(ubyte a) {
	assert(0); // TODO
}

void finishEndingSongInterruption() {
	assert(0); // TODO
}

void handleAudioInitiateFadingOutMusic() {
	assert(0); // TODO
}

void handleAudioHandleFadingOutMusic() {
	assert(0); // TODO
}

void handleChannelSoundEffectSquare1() {
	if ((sfxRequestSquare1 != Square1SFX.nothing) && (sfxRequestSquare1 < Square1SFX.unpaused + 1)) {
		if (sfxRequestSquare1 == Square1SFX.clear) {
			clearChannelSoundEffectSquare1();
			return;
		}
		if ((sfxPlayingSquare1 != Square1SFX.pickedUpMissileDrop) || (sfxPlayingSquare1 != Square1SFX.samusHealthChange)) {
			if (square1SFXInitPointers[sfxRequestSquare1]()) {
				return;
			}
		}
	}
	if (sfxPlayingSquare1 == Square1SFX.nothing) {
		return;
	}
	if (sfxPlayingSquare1 < Square1SFX.unpaused + 1) {
		square1SFXPlaybackPointers[sfxPlayingSquare1]();
		return;
	}
	sfxPlayingSquare1 = Square1SFX.nothing;
}

void handleChannelSoundEffectSquare2() {
	if ((sfxRequestSquare2 != Square2SFX.nothing0) && (sfxRequestSquare2 < Square2SFX.u7 + 1)) {
		if (sfxRequestSquare2 == Square2SFX.invalid) {
			clearChannelSoundEffectSquare2();
			return;
		}
		if (songSoundEffectInitialisationFunctionPointersSquare2[sfxRequestSquare2]()) {
			return;
		}
	}
	if (sfxPlayingSquare2 == Square2SFX.nothing0) {
		return;
	}
	if (sfxPlayingSquare2 < Square2SFX.u7 + 1) {
		songSoundEffectPlaybackFunctionPointersSquare2[sfxPlayingSquare2]();
		return;
	}
	sfxPlayingSquare2 = Square2SFX.nothing0;
}

void handleChannelSoundEffectNoise() {
	if ((sfxRequestNoise != NoiseSFX.u00) && (sfxRequestNoise < NoiseSFX.u1A + 1)) {
		if (sfxRequestNoise == NoiseSFX.uFF) {
			clearChannelSoundEffectNoise();
			return;
		}
		if (songPlaying == Song.earthquake) {
			return;
		}
		if ((sfxPlayingNoise != NoiseSFX.u0D) && (sfxPlayingNoise != NoiseSFX.u0E) && (sfxPlayingNoise != NoiseSFX.u0F)) {
			if (songSoundEffectInitializationFunctionPointersNoise[sfxRequestNoise]()) {
				return;
			}
		}
	}
	if (sfxPlayingNoise == NoiseSFX.u00) {
		return;
	}
	if (sfxPlayingNoise < NoiseSFX.u1A + 1) {
		songSoundEffectPlaybackFunctionPointersNoise[sfxPlayingNoise]();
		return;
	}
	//playing = 0; // nonsense
}

void handleChannelSoundEffectWave() {
	if ((sfxRequestWave == 0) || (sfxRequestWave == 0xFF) || (sfxRequestWave >= 6)) {
		return;
	}
	assert(0); // TODO
}

void handleSong() {
	if (songRequest == Song.nothing) {
		handleSongPlaying();
		return;
	} else if (songRequest == Song.invalid) {
		disableSoundChannels();
		return;
	} else if (songRequest == Song.killedMetroid) {
		clearChannelSoundEffectSquare1();
		clearChannelSoundEffectNoise();
	} else if (songRequest > Song.missilePickup) {
		handleSongPlaying();
		return;
	}
	infof("Now playing: %s", songRequest);
	songPlaying = songRequest;
	audioChannelOutputStereoFlags = songStereoFlags[songRequest - 1];
	NR51 = songStereoFlags[songRequest - 1];
	loadSongHeader(songDataTable[songRequest - 1]);
}

void disableSoundChannels() {
	assert(0); // TODO
}

void clearSongPlaying() {
	songPlaying = Song.nothing;
}

void handleSongPlaying() {
	if (!songPlaying) {
		return;
	}
	if (songPlaying > Song.missilePickup) {
		return clearSongPlaying();
	}
	songState.songOptionsSetFlagWorking = 0;
	if (songState.songChannelEnableSquare1) {
		songState.workingSoundChannel = 1;
		songState.songWorkingState.instructionTimer = songState.songSquare1State.instructionTimer;
		if (songState.songSquare1State.instructionTimer == 1) {
			handleSongLoadNextChannelSoundSquare1();
		}
		songState.songSquare1State.instructionTimer--;
		if (!sfxActiveSquare1) {
			songState.songWorkingState.effectIndex = songState.songSquare1State.effectIndex;
			if (songState.songWorkingState.effectIndex) {
				handleSongSoundChannelEffect(songState.songFrequencySquare1);
				AUD1LOW = songState.songFrequencyWorking & 0xFF;
				AUD1HIGH = (songState.songFrequencyWorking >> 8) & 0xFF;
			}
		}
	}
	songState.songOptionsSetFlagWorking = 0;
	if (songState.songChannelEnableSquare2) {
		songState.workingSoundChannel = 2;
		songState.songWorkingState.instructionTimer = songState.songSquare2State.instructionTimer;
		if (songState.songSquare2State.instructionTimer == 1) {
			handleSongLoadNextChannelSoundSquare2();
		}
		songState.songSquare2State.instructionTimer--;
		if (!sfxActiveSquare2) {
			songState.songWorkingState.effectIndex = songState.songSquare2State.effectIndex;
			if (songState.songWorkingState.effectIndex) {
				handleSongSoundChannelEffect(songState.songFrequencySquare2);
				AUD2LOW = songState.songFrequencyWorking & 0xFF;
				AUD2HIGH = (songState.songFrequencyWorking >> 8) & 0xFF;
			}
		}
	}
	songState.songOptionsSetFlagWorking = 0;
	if (songState.songChannelEnableWave) {
		songState.workingSoundChannel = 3;
		songState.songWorkingState.instructionTimer = songState.songWaveState.instructionTimer;
		if (songState.songWaveState.instructionTimer == 1) {
			handleSongLoadNextChannelSoundWave();
		}
		songState.songWaveState.instructionTimer--;
		if (!sfxActiveWave) {
			handleSongSoundChannelEffect(songState.songFrequencyWave);
			NR33 = songState.songFrequencyWorking & 0xFF;
			NR34 = (songState.songFrequencyWorking >> 8) & 0x7F;
		}
	}
	songState.songOptionsSetFlagWorking = 0;
	if (songState.songChannelEnableNoise) {
		songState.workingSoundChannel = 4;
		songState.songWorkingState.instructionTimer = songState.songNoiseState.instructionTimer;
		if (songState.songWaveState.instructionTimer == 1) {
			handleSongLoadNextChannelSoundNoise();
		}
		songState.songNoiseState.instructionTimer--;
		return;
	}
	if (songState.songChannelEnableSquare1) {
		return;
	}
	if (songState.songChannelEnableSquare2) {
		return;
	}
	if (songState.songChannelEnableWave) {
		return;
	}
	if (songState.songChannelEnableNoise) {
		return;
	}
	songPlaying = Song.nothing;
	songInterruptionPlaying = Song2.nothing;
}

ubyte decrementChannelSoundEffectTimerSquare1() {
	if (sfxTimerSquare1) {
		sfxTimerSquare1--;
		return sfxTimerSquare1;
	} else {
		return clearChannelSoundEffectSquare1();
	}
}

ubyte decrementChannelSoundEffectTimerSquare2() {
	if (sfxTimerSquare2) {
		sfxTimerSquare2--;
		return sfxTimerSquare2;
	} else {
		return clearChannelSoundEffectSquare2();
	}
}
ubyte decrementChannelSoundEffectTimerNoise() {
	if (sfxTimerNoise) {
		sfxTimerNoise--;
		return sfxTimerNoise;
	} else {
		return clearChannelSoundEffectNoise();
	}
}

ubyte clearChannelSoundEffectSquare1() {
	sfxPlayingSquare1 = Square1SFX.nothing;
	sfxActiveSquare1 = Square1SFX.nothing;
	return 0;
}

void disableChannelSquare1() {
	assert(0); // TODO
}

ubyte clearChannelSoundEffectSquare2() {
	sfxPlayingSquare2 = Square2SFX.nothing0;
	sfxActiveSquare2 = Square2SFX.nothing0;
	return 0;
}

void disableChannelSquare2() {
	assert(0); // TODO
}

ubyte clearChannelSoundEffectWave() {
	sfxActiveWave = 0;
	return 0;
}

void disableChannelWave() {
	assert(0); // TODO
}

ubyte clearChannelSoundEffectNoise() {
	sfxPlayingNoise = NoiseSFX.u00;
	sfxActiveNoise = NoiseSFX.u00;
	return 0;
}

void disableChannelNoise() {
	assert(0); // TODO
}

void initializeAudio() {
	NR52 = 0x80;
	NR50 = 0x77;
	NR51 = 0xFF;
}

void clearNonWaveSoundEffectRequests() {
	sfxRequestSquare1 = Square1SFX.nothing;
	sfxRequestSquare2 = Square2SFX.nothing0;
	sfxRequestFakeWave = 0;
	sfxRequestNoise = NoiseSFX.u00;
	audioPauseControl = 0;
}

void silenceAudio() {
	NR51 = 0xFF;
	sfxRequestSquare1 = Square1SFX.nothing;
	sfxRequestSquare2 = Square2SFX.nothing0;
	sfxRequestFakeWave = 0;
	sfxRequestNoise = NoiseSFX.u00;
	sfxPlayingSquare1 = Square1SFX.nothing;
	sfxPlayingSquare2 = Square2SFX.nothing0;
	sfxPlayingFakeWave = 0;
	sfxPlayingNoise = NoiseSFX.u00;
	songRequest = Song.invalid;
	songPlaying = Song.invalid;
	songInterruptionRequest = Song2.nothing;
	songInterruptionPlaying = Song2.nothing;
	sfxRequestWave = 0;
	sfxPlayingWave = 0;
	audioPauseSoundEffectTimer = 0;
	audioPauseControl = 0;
}

void muteSoundChannels() {
	assert(0); // TODO
}

void writeToWavePatternRAM(const(ubyte)* data) {
	foreach (idx, d; data[0 .. 16]) {
		waveRAM[idx] = d;
	}
}

void setChannelOptionSetSquare1(const(ubyte)* set) {
	AUD1SWEEP = set[0];
	AUD1LEN = set[1];
	AUD1ENV = set[2];
	AUD1LOW = set[3];
	AUD1HIGH = set[4];
}

void setChannelOptionSetSquare2(const(ubyte)* set) {
	AUD2LEN = set[0];
	AUD2ENV = set[1];
	AUD2LOW = set[2];
	AUD2HIGH = set[3];
}

void SetChannelOptionSetWave(const(ubyte)* set) {
	AUD3ENA = set[0];
	AUD3LEN = set[1];
	AUD3LEVEL = set[2];
	AUD3LOW = set[3];
	AUD3HIGH = set[4];
}

void SetChannelOptionSetNoise(const(ubyte)* set) {
	AUD4LEN = set[0];
	AUD4ENV = set[1];
	AUD4POLY = set[2];
	AUD4GO = set[3];
}

void audioPause() {
	assert(0); // TODO
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
	assert(0); // TODO
}

void handleAudioPaused() {
	assert(0); // TODO
}

void loadSongHeader(const SongHeader header) {
	resetSongSoundChannelOptions();
	if (header.noteOffset & 1) {
		songState.songFrequencyTweakSquare2 = 1;
	}
	songState.songTranspose = header.noteOffset & 0xFE;
	songState.songInstructionTimerArrayPointer = header.tempo;
	songState.songSquare1State.sectionPointer = header.toneSweepChannel;
	songState.songSquare2State.sectionPointer = header.toneChannel;
	songState.songWaveState.sectionPointer = header.waveChannel;
	songState.songNoiseState.sectionPointer = header.noiseChannel;
	songState.songSquare1State.sectionPointers = header.toneSweepChannel;
	songState.songSquare2State.sectionPointers = header.toneChannel;
	songState.songWaveState.sectionPointers = header.waveChannel;
	songState.songNoiseState.sectionPointers = header.noiseChannel;
	if (songState.songSquare1State.sectionPointer.length == 0) {
		songState.songChannelEnableSquare1 = 0;
		AUD1ENV = 0x08;
		AUD1HIGH = 0x80;
	} else {
		songState.songChannelEnableSquare1 = 1;
		songState.songChannelInstructionPointerSquare1 = header.squareTracks[songState.songSquare1State.sectionPointer[0]].ptr;
	}
	if (songState.songSquare2State.sectionPointer.length == 0) {
		songState.songChannelEnableSquare2 = 0;
		AUD2ENV = 0x08;
		AUD2HIGH = 0x80;
	} else {
		songState.songChannelEnableSquare2 = 2;
		songState.songChannelInstructionPointerSquare2 = header.squareTracks[songState.songSquare2State.sectionPointer[0]].ptr;
	}
	if (songState.songWaveState.sectionPointer.length == 0) {
		songState.songChannelEnableWave = 0;
		AUD3ENA = 0;
	} else {
		songState.songChannelEnableWave = 3;
		songState.songChannelInstructionPointerWave = header.waveTracks[songState.songWaveState.sectionPointer[0]].ptr;
	}
	if (songState.songNoiseState.sectionPointer.length == 0) {
		songState.songChannelEnableNoise = 0;
	} else {
		songState.songChannelEnableNoise = 4;
		songState.songChannelInstructionPointerNoise = header.noiseTracks[songState.songNoiseState.sectionPointer[0]].ptr;
	}
	songState.songSquare1State.instructionTimer = 1;
	songState.songSquare2State.instructionTimer = 1;
	songState.songWaveState.instructionTimer = 1;
	songState.songNoiseState.instructionTimer = 1;
}

void handleSongLoadNextChannelSoundSquare1() {
	songState.songWorkingState = songState.songSquare1State;
	loadNextSound(songState.songChannelInstructionPointerSquare1, 1);
	songState.songChannelEnableSquare1 = songState.workingSoundChannel;
	if (songState.songChannelEnableSquare1 == 0) {
		resetChannelOptionsSquare1();
		return;
	}
	songState.songSquare1State = songState.songWorkingState;
	if (songState.songOptionsSetFlagWorking == 1) {
		songState.songSweepSquare1 = songState.songSweepWorking;
		songState.songSoundLengthSquare1 = songState.songSoundLengthWorking;
	}
	songState.songEnvelopeSquare1 = songState.songEnvelopeWorking;
	songState.songFrequencySquare1 = songState.songFrequencyWorking;
	if (!sfxActiveSquare1) {
		NR10 = songState.songSweepSquare1;
		NR11 = songState.songSoundLengthSquare1;
		AUD1ENV = songState.songEnvelopeSquare1;
		AUD1LOW = songState.songFrequencySquare1 & 0xFF;
		AUD1HIGH = songState.songFrequencySquare1 >> 8;
	}
}

void handleSongLoadNextChannelSoundSquare2() {
	songState.songWorkingState = songState.songSquare2State;
	loadNextSound(songState.songChannelInstructionPointerSquare2, 2);
	songState.songChannelEnableSquare2 = songState.workingSoundChannel;
	if (songState.songChannelEnableSquare2 == 0) {
		resetChannelOptionsSquare2();
		return;
	}
	songState.songSquare2State = songState.songWorkingState;
	if (songState.songOptionsSetFlagWorking == 2) {
		songState.songSoundLengthSquare2 = songState.songSoundLengthWorking;
	}
	songState.songEnvelopeSquare2 = songState.songEnvelopeWorking;
	songState.songFrequencySquare2 = songState.songFrequencyWorking;
	if (!sfxActiveSquare2) {
		NR21 = songState.songSoundLengthSquare2;
		if (songState.songFrequencyTweakSquare2 == 1) {
			if (songState.songFrequencySquare2 < 34560) {
				songState.songFrequencySquare2++;
			}
			songState.songFrequencySquare2++;
		}
		AUD2ENV = songState.songEnvelopeSquare2;
		AUD2LOW = songState.songFrequencySquare2 & 0xFF;
		AUD2HIGH = songState.songFrequencySquare2 >> 8;
	}
}

void handleSongLoadNextChannelSoundWave() {
	songState.songWorkingState = songState.songWaveState;
	loadNextSound(songState.songChannelInstructionPointerWave, 3);
	songState.songChannelEnableWave = songState.workingSoundChannel;
	if (songState.songChannelEnableWave == 0) {
		resetChannelOptionsWave();
		return;
	}
	songState.songWaveState = songState.songWaveState;
	songState.songEnableOptionWave = songState.songEnableWorking;
	songState.songSoundLengthWave = songState.songSoundLengthWorking;
	songState.songVolumeWave = songState.songVolumeWorking;
	songState.songFrequencyWave = songState.songFrequencyWorking;
	if (!sfxActiveWave) {
		AUD3ENA = 0;
		AUD3ENA = songState.songEnableOptionWave;
		NR31 = songState.songSoundLengthWave;
		NR32 = songState.songVolumeWave;
		NR33 = songState.songFrequencyWave & 0xFF;
		NR34 = songState.songFrequencyWave >> 8;
	}
}

void handleSongLoadNextChannelSoundNoise() {
	songState.songWorkingState = songState.songNoiseState;
	loadNextSound(songState.songChannelInstructionPointerNoise, 4);
	songState.songChannelEnableNoise = songState.workingSoundChannel;
	if (songState.songChannelEnableNoise == 0) {
		resetChannelOptionsNoise();
		return;
	}
	songState.songNoiseState = songState.songWorkingState;
	if (!sfxActiveNoise) {
		NR41 = songState.songSoundLengthWorking;
		NR42 = songState.songEnvelopeWorking;
		AUD4POLY = songState.songPolynomialCounterWorking;
		songState.songPolynomialCounterNoise = songState.songPolynomialCounterWorking;
		NR44 = songState.songCounterControlWorking;
		songState.songCounterControlNoise = songState.songCounterControlWorking;
	}
}

void loadNextSound(ref const(ubyte)* ptr, ubyte channel) {
	static void mute() {
		if (songState.workingSoundChannel != 3) {
			songState.songEnvelopeWorking = 8;
			songState.songCounterControlWorking = 0x80;
		} else {
			songState.songEnableWorking = 0;
			songState.songVolumeWorking = 0;
		}
	}
	static void instr35Common() {
		if (songInterruptionPlaying == Song2.fadeOut) {
			songState.songEnvelopeWorking = Song2.fadeOut;
		}
		switch (songState.workingSoundChannel) {
			case 1:
				songState.songFrequencyWorking = songState.songFrequencySquare1;
				break;
			case 2:
				songState.songFrequencyWorking = songState.songFrequencySquare2;
				break;
			case 3:
				if (!sfxActiveWave) {
					songState.songEnableWorking = 0x80;
					songState.songFrequencyWorking = songState.songFrequencyWave;
				}
				break;
			default: break;
		}
	}
	songState.workingSoundChannel = channel;
	static void nextInstructionList(ref const(ubyte)* ptr) {
		songState.songWorkingState.sectionPointer = songState.songWorkingState.sectionPointer[1 .. $];
		if (songState.songWorkingState.sectionPointer[0] == 0) {
			songState.workingSoundChannel = 0;
			return;
		}
		if (songState.songWorkingState.sectionPointer[0] == 0x00F0) {
			songInstructionGoto();
		}
		switch (songState.workingSoundChannel) {
			case 1:
			case 2:
				assert(songState.songWorkingState.sectionPointer[0] in songDataTable[songPlaying - 1].squareTracks, format!"Missing pattern %04X"(songState.songWorkingState.sectionPointer[0]));
				ptr = songDataTable[songPlaying - 1].squareTracks[songState.songWorkingState.sectionPointer[0]].ptr;
				break;
			case 3:
				assert(songState.songWorkingState.sectionPointer[0] in songDataTable[songPlaying - 1].waveTracks, format!"Missing pattern %04X"(songState.songWorkingState.sectionPointer[0]));
				ptr = songDataTable[songPlaying - 1].waveTracks[songState.songWorkingState.sectionPointer[0]].ptr;
				break;
			case 4:
				assert(songState.songWorkingState.sectionPointer[0] in songDataTable[songPlaying - 1].noiseTracks, format!"Missing pattern %04X"(songState.songWorkingState.sectionPointer[0]));
				ptr = songDataTable[songPlaying - 1].noiseTracks[songState.songWorkingState.sectionPointer[0]].ptr;
				break;
			default: assert(0);
		}
	}
	if (ptr[0] == 0) {
		nextInstructionList(ptr);
	}
	while (true) {
		infof("%02X", ptr[0]);
		switch (ptr[0]) {
			case 0xF1: songInstructionSetWorkingSoundChannelOptions(ptr); continue;
			case 0xF2: songInstructionSetInstructionTimerArrayPointer(ptr); continue;
			case 0xF3: songInstructionSetMusicNoteOffset(ptr); continue;
			case 0xF4: songInstructionMarkRepeatPoint(ptr); continue;
			case 0xF5: songInstructionRepeat(ptr); continue;
			case 0x00: nextInstructionList(ptr); continue;
			case 0xF6: return silenceAudio();
			case 0x9F: .. case 0xF0:
				songState.songWorkingState.instructionTimer = songState.songInstructionTimerArrayPointer[ptr[0] & 0b01011111];
				songState.songWorkingState.instructionLength = songState.songInstructionTimerArrayPointer[ptr[0] & 0b01011111];
				ptr++;
				continue;
			default:
				songState.songWorkingState.instructionTimer = songState.songWorkingState.instructionLength;
				if (songState.workingSoundChannel == 4) {
					const a = (ptr++)[0];
					if (a == 1) {
						mute();
					} else {
						songState.songSoundLengthWorking = songNoiseChannelOptionSets[a / 4][0];
						songState.songEnvelopeWorking = songNoiseChannelOptionSets[a / 4][1];
						songState.songPolynomialCounterWorking = songNoiseChannelOptionSets[a / 4][2];
						songState.songCounterControlWorking = songNoiseChannelOptionSets[a / 4][3];
					}
					return;
				}
				const cmd = (ptr++)[0];
				switch(cmd) {
					case 1:
						mute();
						return;
					case 3:
						songState.songEnvelopeWorking = 0x66;
						return instr35Common();
					case 5:
						songState.songEnvelopeWorking = 0x46;
						return instr35Common();
					default:
						if ((songState.workingSoundChannel == 3) && !sfxActiveWave) {
							AUDTERM = AUDTERM | 0b01000100;
							songState.songEnableWorking = 0x80;
						}
						ubyte c = cmd;
						if (songState.workingSoundChannel != 4) {
							c += songState.songTranspose;
						}
						songState.songEnvelopeWorking = songState.songWorkingState.noteEnvelope;
						songState.songFrequencyWorking = musicNotes[c / 2];
						return;
				}
		}
	}
}

void songInstructionSetWorkingSoundChannelOptions(ref const(ubyte)* ptr) {
	ptr++;
	songState.songOptionsSetFlagWorking = songState.workingSoundChannel;
	if (songState.workingSoundChannel == 3) {
		songInstructionSetWorkingSoundChannelOptionsWave(ptr);
	} else {
		if (songInterruptionPlaying == Song2.fadeOut) {
			songState.songEnvelopeWorking = (ptr++)[0];
		} else {
			songState.songEnvelopeWorking = (ptr++)[0];
			songState.songWorkingState.noteEnvelope = songState.songEnvelopeWorking;
		}
		songState.songSweepWorking = (ptr++)[0];
		songState.songSoundLengthWorking = (ptr++)[0];
		songState.songWorkingState.effectIndex = songState.songSoundLengthWorking & ~0b11000000;
	}
	if (songState.songWorkingState.effectIndex == 0) {
		songState.songWorkingState.effectIndex = 0; // ?
	}
}

void songInstructionSetWorkingSoundChannelOptionsWave(ref const(ubyte)* ptr) {
	ramCFE3 = *cast(const(ushort)*)ptr;
	ptr += 2;
	songState.songWavePatternDataPointer = &[0x4113 : wavePatterns[0], 0x4123: wavePatterns[1], 0x416B: wavePatterns[3], 0x417B: wavePatterns[4], 0x418B: wavePatterns[5], 0x419B: wavePatterns[6], 0x41AB: wavePatterns[7]][ramCFE3][0];
	if (songInterruptionPlaying == Song2.fadeOut) {
		songState.songVolumeWorking = ptr[0];
	} else {
		songState.songVolumeWorking = ptr[0];
		songState.songWorkingState.noteVolume = ptr[0];
	}
	if (!sfxActiveWave) {
		AUD3ENA = 0;
		writeToWavePatternRAM(songState.songWavePatternDataPointer);
	}
	songState.songWorkingState.effectIndex = songState.songVolumeWorking & ~0b01100000;
}

void songInstructionSetInstructionTimerArrayPointer(ref const(ubyte)* ptr) {
	ptr++;
	songState.songInstructionTimerArrayPointer = getTempoData(*cast(const(ushort)*)ptr);
	ptr += 2;
}

void songInstructionSetMusicNoteOffset(ref const(ubyte)* ptr) {
	ptr++;
	songState.songTranspose = (ptr++)[0];
}

void songInstructionGoto() {
	const next = songState.songWorkingState.sectionPointer[1];
	songState.songWorkingState.sectionPointer = songState.songWorkingState.sectionPointers[next .. $];
}

void songInstructionMarkRepeatPoint(ref const(ubyte)* ptr) {
	ptr++;
	songState.songWorkingState.repeatCount = (ptr++)[0];
	songState.songWorkingState.repeatPoint = ptr;
}

void songInstructionRepeat(ref const(ubyte)* ptr) {
	if (--songState.songWorkingState.repeatCount == 0) {
		ptr++;
	} else {
		ptr = songState.songWorkingState.repeatPoint;
	}
}

void copyChannelSongProcessingState() {
	assert(0); // TODO
}

void handleSongSoundChannelEffect(ushort bc) {
	static void common(const(ubyte)[] hl, ushort bc) {
		if (songState.songSoundChannelEffectTimer == 0) {
			songState.songSoundChannelEffectTimer = 16;
			songState.songFrequencyWorking = 0;
		} else {
			songState.songFrequencyWorking = cast(ushort)(hl[--songState.songSoundChannelEffectTimer] + bc);
		}
	}
	static void setFrequency() {
		if (songState.workingSoundChannel == 1) {
			songState.songFrequencySquare1 = songState.songFrequencyWorking;
		} else if (songState.workingSoundChannel == 2) {
			songState.songFrequencySquare2 = songState.songFrequencyWorking;
		} else if (songState.workingSoundChannel == 3) {
			songState.songFrequencyWave = songState.songFrequencyWorking & 0x7FFF;
		}
	}
	switch (songState.songWorkingState.effectIndex) {
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
			songState.songFrequencyWorking = bc & 0x3FFF;
			setFrequency();
			break;
		case 7:
			songState.songFrequencyWorking = (bc + 4) & 0x3FFF;
			setFrequency();
			break;
		case 8:
			songState.songFrequencyWorking = (bc - 3) & 0x3FFF;
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

void resetChannelOptionsSquare1() {
	songState.songChannelEnableSquare1 = 0;
	AUD1ENV = 8;
	songState.songEnvelopeSquare1 = 8;
	AUD1HIGH = 0x80;
	songState.songFrequencySquare1 = 0x8000 | (songState.songFrequencySquare1 & 0xFF);
}

void resetChannelOptionsSquare2() {
	songState.songChannelEnableSquare2 = 0;
	AUD2ENV = 8;
	songState.songEnvelopeSquare2 = 8;
	AUD2HIGH = 0x80;
	songState.songFrequencySquare2 = 0x8000 | (songState.songFrequencySquare2 & 0xFF);
}

void resetChannelOptionsWave() {
	songState.songChannelEnableWave = 0;
	AUD3ENA = 0;
	songState.songEnableOptionWave = 0;
}

void resetChannelOptionsNoise() {
	songState.songChannelEnableNoise = 0;
	NR42 = 8;
	songState.songEnvelopeNoise = 8;
	NR44 = 0x80;
	songState.songCounterControlNoise = 0x80;
}

void resetSongSoundChannelOptions() {
	songState.songWorkingState = ChannelSongProcessingState.init;
	songState.songSquare1State = ChannelSongProcessingState.init;
	songState.songSquare2State = ChannelSongProcessingState.init;
	songState.songWaveState = ChannelSongProcessingState.init;
	songState.songNoiseState = ChannelSongProcessingState.init;
	sfxActiveSquare1 = 0;
	sfxActiveSquare2 = 0;
	sfxActiveWave = 0;
	sfxActiveNoise = NoiseSFX.u00;
	songState.songFrequencyTweakSquare2 = 0;
	NR10 = 0;
	AUD3ENA = 0;

	AUD1ENV = 0x08;
	AUD2ENV = 0x08;
	NR42 = 0x08;

	AUD1HIGH = 0x80;
	AUD2HIGH = 0x80;
	NR44 = 0x80;
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
	if ((sfxPlayingSquare1 == Square1SFX.shootingWaveBeam) || ((sfxPlayingSquare1 >= Square1SFX.shootingBeam) && (sfxPlayingSquare1 <= Square1SFX.shootingSpazerBeam))) {
		return false;
	}
	if (songPlaying == Song.chozoRuins) {
		playSquare1SFX(11, &optionSetsSquare1.jumping0[0]);
		return true;
	}
	playSquare1SFX(50, &optionSetsSquare1.jumping0[0]);
	return true;
}

void square1SfxPlayback1() {
	if (songPlaying == Song.chozoRuins) {
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
	if ((sfxPlayingSquare1 == Square1SFX.shootingWaveBeam) || ((sfxPlayingSquare1 >= Square1SFX.shootingBeam) && (sfxPlayingSquare1 <= Square1SFX.shootingSpazerBeam))) {
		return false;
	}
	if (songPlaying == Song.chozoRuins) {
		playSquare1SFX(9, &optionSetsSquare1.hijumping0[0]);
		return true;
	}
	playSquare1SFX(67, &optionSetsSquare1.hijumping0[0]);
	return true;
}

void square1SfxPlayback2() {
	if (songPlaying == Song.chozoRuins) {
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
	if (sfxTimerSquare1 == 0) {
		sfxTimerSquare1 = 16;
	}
	switch (--sfxTimerSquare1) {
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
	if (sfxPlayingSquare1 <= Square1SFX.screwAttacking) {
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
	sfxVariableFrequencySquare1 = 0xD0;
	playSquare1SFX(20, &optionSetsSquare1.shootingIceBeam[0]);
	return true;
}

void square1SfxPlayback9() {
	decrementChannelSoundEffectTimerSquare1();
	AUD1LOW = sfxVariableFrequencySquare1;
	sfxVariableFrequencySquare1 = sfxVariableFrequencySquare1; // that's just silly
}

bool square1SfxInitA() {
	sfxVariableFrequencySquare1 = 0xD0;
	playSquare1SFX(20, &optionSetsSquare1.shootingPlasmaBeam[0]);
	return true;
}

void square1SfxPlaybackA() {
	decrementChannelSoundEffectTimerSquare1();
	AUD1LOW = sfxVariableFrequencySquare1;
	sfxVariableFrequencySquare1 = sfxVariableFrequencySquare1; // this is still silly
}

bool square1SfxInitB() {
	sfxVariableFrequencySquare1 = 0xD0;
	playSquare1SFX(20, &optionSetsSquare1.shootingSpazerBeam[0]);
	return true;
}

void square1SfxPlaybackB() {
	decrementChannelSoundEffectTimerSquare1();
	AUD1LOW = sfxVariableFrequencySquare1;
	sfxVariableFrequencySquare1 = sfxVariableFrequencySquare1; // silliness continues
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
	if (!samusHealthChangedOptionSetIndex) {
		samusHealthChangedOptionSetIndex = 2;
	}
	switch (samusHealthChangedOptionSetIndex) {
		case 1:
			samusHealthChangedOptionSetIndex--;
			playSquare1SFX(2, &optionSetsSquare1.samusHealthChanged0[0]);
			break;
		case 2:
			samusHealthChangedOptionSetIndex--;
			playSquare1SFX(2, &optionSetsSquare1.samusHealthChanged1[0]);
			break;
		case 0:
		default:
			samusHealthChangedOptionSetIndex = 2;
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
	sfxVariableFrequencySquare1 = swap(DIV) | 0b11100010;
	playSquare1SFX(48, &optionSetsSquare1.metroidCry[0]);
	return true;
}
void square1SfxPlayback1B() {
	if (decrementChannelSoundEffectTimerSquare1() >= 32) {
		sfxVariableFrequencySquare1 += 6;
		AUD1LOW = sfxVariableFrequencySquare1;
	} else {
		sfxVariableFrequencySquare1--;
		AUD1LOW = sfxVariableFrequencySquare1;
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
	if (sfxPlayingSquare1 == Square1SFX.screwAttacking) {
		resumeScrewAttackSoundEffectFlag = cast(ubyte)sfxPlayingSquare1;
	}
}
void maybeResumeScrewAttackingSFX() {
	if ((resumeScrewAttackSoundEffectFlag == 0) || (samusPose != SamusPose.spinJumping) || (samusItems & ItemFlag.screwAttack)) {
		return;
	}
	sfxPlayingSquare1 = Square1SFX.screwAttacking;
	resumeScrewAttackSoundEffectFlag = 0;
}

void playSquare1SFX(ubyte a, const(ubyte)* set) {
	sfxTimerSquare1 = a;
	sfxPlayingSquare1 = sfxRequestSquare1;
	sfxActiveSquare1 = cast(ubyte)sfxRequestSquare1;
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
	square2VariableFrequency = swap(DIV) | 0b11100000;
	playSquare2SFX(48, &optionSetsSquare2.metroidQueenCry[0]);
	return true;
}

void square2SfxPlayback3() {
	if (decrementChannelSoundEffectTimerSquare2() & 1) {
		square2VariableFrequency |= 0b00010000;
	} else {
		square2VariableFrequency &= ~0b00010000;
	}
	if (sfxTimerSquare2 < 32) {
		square2VariableFrequency += 3;
		AUD2LOW = square2VariableFrequency;
	} else {
		square2VariableFrequency--;
		AUD2LOW = square2VariableFrequency;
	}
}
alias square2SfxPlayback5 = square2SfxPlayback3;
alias square2SfxPlayback6 = square2SfxPlayback3;

bool square2SfxInit4() {
	square2VariableFrequency = (swap(DIV) | 0b10000000) & ~0b01000000;
	playSquare2SFX(28, &optionSetsSquare2.babyMetroidClearingBlockSquare2[0]);
	return true;
}

void square2SfxPlayback4() {
	switch (decrementChannelSoundEffectTimerSquare2()) {
		case 19:
			square2VariableFrequency = 160;
			break;
		case 12:
			square2VariableFrequency = 144;
			break;
		default:
			square2VariableFrequency += 2;
			AUD2LOW = square2VariableFrequency;
			break;
	}
}

bool square2SfxInit5() {
	square2VariableFrequency = (swap(DIV) | 0b01000000) & ~0b10010100;
	playSquare2SFX(48, &optionSetsSquare2.babyMetroidCrySquare2[0]);
	return true;
}

bool square2SfxInit6() {
	square2VariableFrequency = (swap(DIV) | 0b01000000) & ~0b10000000;
	playSquare2SFX(48, &optionSetsSquare2.metroidQueenHurtCry[0]);
	return true;
}

bool square2SfxInit7() {
	playSquare2SFX(1, &optionSetsSquare2.unknown7[0]);
	return true;
}

void playSquare2SFX(ubyte a, const(ubyte)* set) {
	sfxTimerSquare2 = a;
	sfxPlayingSquare2 = sfxRequestSquare2;
	sfxActiveSquare2 = cast(ubyte)sfxRequestSquare2;
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
	sfxRequestSquare1 = Square1SFX.metroidCry;
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
	sfxRequestSquare2 = Square2SFX.metroidQueenCry;
	playNoiseSweepSFX(64, &optionSetsNoise.metroidQueenCry0[0]);
	return true;
}

void noiseSfxPlayback9() {
	if (decrementChannelSoundEffectTimerNoise() == 56) {
		SetChannelOptionSetNoise(&optionSetsNoise.metroidQueenCry1[0]);
	}
}

bool noiseSfxInitA() {
	sfxRequestSquare2 = Square2SFX.metroidQueenHurtCry;
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
	AUD4POLY = 0x27;
}
void setPolynomialCounter35() {
	AUD4POLY = 0x35;
}
void setPolynomialCounter37() {
	AUD4POLY = 0x37;
}
void setPolynomialCounter45() {
	AUD4POLY = 0x45;
}
void setPolynomialCounter47() {
	AUD4POLY = 0x47;
}
void setPolynomialCounter55() {
	AUD4POLY = 0x55;
}
void setPolynomialCounter57() {
	AUD4POLY = 0x57;
}
void setPolynomialCounter65() {
	AUD4POLY = 0x65;
}
void setPolynomialCounter66() {
	AUD4POLY = 0x66;
}
void setPolynomialCounter67() {
	AUD4POLY = 0x67;
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
	if ((sfxPlayingNoise != NoiseSFX.u00) || (songState.songChannelEnableNoise != 0)) {
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
	sfxRequestSquare2 = Square2SFX.babyMetroidClearingBlock;
	playNoiseSweepSFX(8, &optionSetsNoise.babyMetroidClearingBlock[0]);
	return true;
}

bool noiseSfxInit17() {
	sfxRequestSquare2 = Square2SFX.babyMetroidCry;
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
	sfxTimerNoise = a;
	sfxPlayingNoise = sfxRequestNoise;
	sfxActiveNoise = sfxRequestNoise;
	SetChannelOptionSetNoise(set);
}

immutable(ubyte)[] getTempoData(ushort originalAddress) {
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
