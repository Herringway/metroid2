module metroid2.bank01;

import metroid2.bank00;
import metroid2.defs;
import metroid2.enemies;
import metroid2.external;
import metroid2.globals;
import librehome.gameboy;

import std.logger;

immutable OAMEntry[][] samusSpriteTable = [
	[
		OAMEntry(-20,-12, 0x00, 0x00),
		OAMEntry(-20, -4, 0x01, 0x00),
		OAMEntry(-20,  4, 0x02, 0x00),
		OAMEntry(-12,-12, 0x10, 0x00),
		OAMEntry(-12, -4, 0x11, 0x00),
		OAMEntry(-12,  4, 0x12, 0x00),
		OAMEntry(-4,-12, 0x20, 0x00),
		OAMEntry(-4, -4, 0x21, 0x00),
		OAMEntry(-4,  4, 0x22, 0x00),
		OAMEntry(4,-12, 0x30, 0x00),
		OAMEntry(4, -4, 0x31, 0x00),
		OAMEntry(4,  4, 0x32, 0x00),
		OAMEntry(12,-12, 0x40, 0x00),
		OAMEntry(12, -4, 0x41, 0x00),
		OAMEntry(12,  4, 0x42, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -8, 0x03, 0x00),
		OAMEntry(-20,  0, 0x04, 0x00),
		OAMEntry(-12, -8, 0x13, 0x00),
		OAMEntry(-12,  0, 0x14, 0x00),
		OAMEntry(-7,  6, 0x09, 0x00),
		OAMEntry(-4, -8, 0x23, 0x00),
		OAMEntry(-4,  0, 0x24, 0x00),
		OAMEntry(4, -8, 0x34, 0x00),
		OAMEntry(4,  0, 0x35, 0x00),
		OAMEntry(12,-16, 0x43, 0x00),
		OAMEntry(12, -8, 0x44, 0x00),
		OAMEntry(12,  0, 0x45, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-26, -2, 0x08, 0x00),
		OAMEntry(-20, -8, 0x17, 0x00),
		OAMEntry(-20,  0, 0x18, 0x00),
		OAMEntry(-12, -8, 0x27, 0x00),
		OAMEntry(-12,  0, 0x28, 0x00),
		OAMEntry(-4, -8, 0x37, 0x00),
		OAMEntry(-4,  0, 0x38, 0x00),
		OAMEntry(4, -8, 0x34, 0x00),
		OAMEntry(4,  0, 0x35, 0x00),
		OAMEntry(12,-16, 0x43, 0x00),
		OAMEntry(12, -8, 0x44, 0x00),
		OAMEntry(12,  0, 0x45, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -4, 0x0A, 0x00),
		OAMEntry(-20,  4, 0x0B, 0x00),
		OAMEntry(-12,-12, 0x19, 0x00),
		OAMEntry(-12, -4, 0x1A, 0x00),
		OAMEntry(-12,  4, 0x1B, 0x00),
		OAMEntry(-4, -4, 0x2A, 0x00),
		OAMEntry(-4,  4, 0x2B, 0x00),
		OAMEntry(4,-12, 0x39, 0x00),
		OAMEntry(4, -4, 0x3A, 0x00),
		OAMEntry(4,  4, 0x3B, 0x00),
		OAMEntry(12,-12, 0x49, 0x00),
		OAMEntry(12, -4, 0x4A, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -7, 0x0E, 0x00),
		OAMEntry(-20,  1, 0x04, 0x00),
		OAMEntry(-12, -7, 0x1E, 0x00),
		OAMEntry(-12,  1, 0x1F, 0x00),
		OAMEntry(-4,-20, 0x2E, 0x00),
		OAMEntry(-4,-12, 0x2F, 0x00),
		OAMEntry(-4, -4, 0x4E, 0x00),
		OAMEntry(4,-20, 0x3E, 0x00),
		OAMEntry(4,-12, 0x3F, 0x00),
		OAMEntry(4, -4, 0x5E, 0x00),
		OAMEntry(4,  4, 0x5F, 0x00),
		OAMEntry(12, -4, 0x6E, 0x00),
		OAMEntry(12,  4, 0x6F, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -4, 0x0D, 0x00),
		OAMEntry(-20,  4, 0x0B, 0x00),
		OAMEntry(-12,-12, 0x1C, 0x00),
		OAMEntry(-12, -4, 0x1D, 0x00),
		OAMEntry(-12,  4, 0x0C, 0x00),
		OAMEntry(-4, -4, 0x2D, 0x00),
		OAMEntry(4, -4, 0x3D, 0x00),
		OAMEntry(12,-12, 0x4C, 0x00),
		OAMEntry(12, -4, 0x4D, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -4, 0x0A, 0x00),
		OAMEntry(-20,  4, 0x0B, 0x00),
		OAMEntry(-12,-12, 0x19, 0x00),
		OAMEntry(-12, -4, 0x1A, 0x00),
		OAMEntry(-12,  4, 0x66, 0x00),
		OAMEntry(-11, 11, 0x09, 0x00),
		OAMEntry(-4, -4, 0x2A, 0x00),
		OAMEntry(-4,  4, 0x2B, 0x00),
		OAMEntry(4,-12, 0x39, 0x00),
		OAMEntry(4, -4, 0x3A, 0x00),
		OAMEntry(4,  4, 0x3B, 0x00),
		OAMEntry(12,-12, 0x49, 0x00),
		OAMEntry(12, -4, 0x4A, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-19, -5, 0x0A, 0x00),
		OAMEntry(-19,  3, 0x0B, 0x00),
		OAMEntry(-11,-13, 0x19, 0x00),
		OAMEntry(-11, -5, 0x1A, 0x00),
		OAMEntry(-11,  3, 0x66, 0x00),
		OAMEntry(-10, 10, 0x09, 0x00),
		OAMEntry(-4,-20, 0x2E, 0x00),
		OAMEntry(-4,-12, 0x2F, 0x00),
		OAMEntry(-4, -4, 0x4E, 0x00),
		OAMEntry(4,-20, 0x3E, 0x00),
		OAMEntry(4,-12, 0x3F, 0x00),
		OAMEntry(4, -4, 0x5E, 0x00),
		OAMEntry(4,  4, 0x5F, 0x00),
		OAMEntry(12, -4, 0x6E, 0x00),
		OAMEntry(12,  4, 0x6F, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -4, 0x0A, 0x00),
		OAMEntry(-20,  4, 0x0B, 0x00),
		OAMEntry(-12,-12, 0x19, 0x00),
		OAMEntry(-12, -4, 0x1A, 0x00),
		OAMEntry(-12,  4, 0x66, 0x00),
		OAMEntry(-11, 11, 0x09, 0x00),
		OAMEntry(-4, -4, 0x2D, 0x00),
		OAMEntry(4, -4, 0x3D, 0x00),
		OAMEntry(12,-12, 0x4C, 0x00),
		OAMEntry(12, -4, 0x4D, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-12, -8, 0x03, 0x00),
		OAMEntry(-12,  0, 0x04, 0x00),
		OAMEntry(-4, -8, 0x13, 0x00),
		OAMEntry(-4,  0, 0x14, 0x00),
		OAMEntry(1,  6, 0x09, 0x00),
		OAMEntry(4,-16, 0x4F, 0x00),
		OAMEntry(4, -8, 0x5C, 0x00),
		OAMEntry(4,  0, 0x5D, 0x00),
		OAMEntry(12,-16, 0x6B, 0x00),
		OAMEntry(12, -8, 0x6C, 0x00),
		OAMEntry(12,  0, 0x6D, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-17, -2, 0x08, 0x00),
		OAMEntry(-12, -8, 0x17, 0x00),
		OAMEntry(-12,  0, 0x18, 0x00),
		OAMEntry(-4, -8, 0x27, 0x00),
		OAMEntry(-4,  0, 0x28, 0x00),
		OAMEntry(4,-16, 0x4F, 0x00),
		OAMEntry(4, -8, 0x5C, 0x00),
		OAMEntry(4,  0, 0x46, 0x00),
		OAMEntry(12,-16, 0x6B, 0x00),
		OAMEntry(12, -8, 0x6C, 0x00),
		OAMEntry(12,  0, 0x6D, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-10, -8, 0x03, 0x00),
		OAMEntry(-10,  0, 0x04, 0x00),
		OAMEntry(-2, -8, 0x13, 0x00),
		OAMEntry(-2,  0, 0x14, 0x00),
		OAMEntry(3,  6, 0x09, 0x00),
		OAMEntry(4, -8, 0x67, 0x00),
		OAMEntry(4,  0, 0x68, 0x00),
		OAMEntry(12,-16, 0x76, 0x00),
		OAMEntry(12, -8, 0x77, 0x00),
		OAMEntry(12,  0, 0x78, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-12, -8, 0x70, 0x00),
		OAMEntry(-12,  0, 0x71, 0x00),
		OAMEntry(-4, -8, 0x72, 0x00),
		OAMEntry(-4,  0, 0x73, 0x00),
		OAMEntry(4,-16, 0x4F, 0x00),
		OAMEntry(4, -8, 0x74, 0x00),
		OAMEntry(4,  0, 0x75, 0x00),
		OAMEntry(12,-16, 0x6B, 0x00),
		OAMEntry(12, -8, 0x6C, 0x00),
		OAMEntry(12,  0, 0x3C, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20,-12, 0x00, 0x00),
		OAMEntry(-20, -4, 0x01, 0x00),
		OAMEntry(-20,  4, 0x02, 0x00),
		OAMEntry(-12,-12, 0x10, 0x00),
		OAMEntry(-12, -4, 0x11, 0x00),
		OAMEntry(-12,  4, 0x12, 0x00),
		OAMEntry(-4,-12, 0x20, 0x00),
		OAMEntry(-4, -4, 0x21, 0x00),
		OAMEntry(-4,  4, 0x22, 0x00),
		OAMEntry(4,-12, 0x30, 0x00),
		OAMEntry(4, -4, 0x31, 0x00),
		OAMEntry(4,  4, 0x32, 0x00),
		OAMEntry(12,-12, 0x40, 0x00),
		OAMEntry(12, -4, 0x41, 0x00),
		OAMEntry(12,  4, 0x42, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20, -8, 0x04, 0x20),
		OAMEntry(-20,  0, 0x06, 0x00),
		OAMEntry(-12, -8, 0x15, 0x00),
		OAMEntry(-12,  0, 0x16, 0x00),
		OAMEntry(-7,-13, 0x09, 0x20),
		OAMEntry(-4, -8, 0x25, 0x00),
		OAMEntry(-4,  0, 0x26, 0x00),
		OAMEntry(4, -8, 0x35, 0x20),
		OAMEntry(4,  0, 0x34, 0x20),
		OAMEntry(12, -8, 0x45, 0x20),
		OAMEntry(12,  0, 0x44, 0x20),
		OAMEntry(12,  8, 0x43, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-26, -6, 0x08, 0x00),
		OAMEntry(-20, -8, 0x47, 0x00),
		OAMEntry(-20,  0, 0x48, 0x00),
		OAMEntry(-12, -8, 0x57, 0x00),
		OAMEntry(-12,  0, 0x58, 0x00),
		OAMEntry(-4, -8, 0x38, 0x20),
		OAMEntry(-4,  0, 0x37, 0x20),
		OAMEntry(4, -8, 0x35, 0x20),
		OAMEntry(4,  0, 0x34, 0x20),
		OAMEntry(12, -8, 0x45, 0x20),
		OAMEntry(12,  0, 0x44, 0x20),
		OAMEntry(12,  8, 0x43, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20,-12, 0x0B, 0x20),
		OAMEntry(-20, -4, 0x0A, 0x20),
		OAMEntry(-12,-12, 0x1B, 0x20),
		OAMEntry(-12, -4, 0x1A, 0x20),
		OAMEntry(-12,  4, 0x19, 0x20),
		OAMEntry(-4,-12, 0x2B, 0x20),
		OAMEntry(-4, -4, 0x2A, 0x20),
		OAMEntry(4,-12, 0x3B, 0x20),
		OAMEntry(4, -4, 0x3A, 0x20),
		OAMEntry(4,  4, 0x39, 0x20),
		OAMEntry(12, -4, 0x4A, 0x20),
		OAMEntry(12,  4, 0x49, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20,-10, 0x04, 0x20),
		OAMEntry(-20, -2, 0x0E, 0x20),
		OAMEntry(-12,-10, 0x1F, 0x20),
		OAMEntry(-12, -2, 0x1E, 0x20),
		OAMEntry(-4, -4, 0x4E, 0x20),
		OAMEntry(-4,  4, 0x2F, 0x20),
		OAMEntry(-4, 12, 0x2E, 0x20),
		OAMEntry(4,-12, 0x5F, 0x20),
		OAMEntry(4, -4, 0x5E, 0x20),
		OAMEntry(4,  4, 0x3F, 0x20),
		OAMEntry(4, 12, 0x3E, 0x20),
		OAMEntry(12,-12, 0x6F, 0x20),
		OAMEntry(12, -4, 0x6E, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20,-12, 0x0B, 0x20),
		OAMEntry(-20, -4, 0x0D, 0x20),
		OAMEntry(-12,-12, 0x0C, 0x20),
		OAMEntry(-12, -4, 0x1D, 0x20),
		OAMEntry(-12,  4, 0x1C, 0x20),
		OAMEntry(-4, -4, 0x2D, 0x20),
		OAMEntry(4, -4, 0x3D, 0x20),
		OAMEntry(12, -4, 0x4D, 0x20),
		OAMEntry(12,  4, 0x4C, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20,-12, 0x0B, 0x20),
		OAMEntry(-20, -4, 0x0D, 0x20),
		OAMEntry(-12,-12, 0x2C, 0x20),
		OAMEntry(-12, -4, 0x1D, 0x20),
		OAMEntry(-12,  4, 0x1C, 0x20),
		OAMEntry(-11,-19, 0x09, 0x20),
		OAMEntry(-4,-12, 0x2B, 0x20),
		OAMEntry(-4, -4, 0x2A, 0x20),
		OAMEntry(4,-12, 0x3B, 0x20),
		OAMEntry(4, -4, 0x3A, 0x20),
		OAMEntry(4,  4, 0x39, 0x20),
		OAMEntry(12, -4, 0x4A, 0x20),
		OAMEntry(12,  4, 0x49, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-19,-11, 0x0B, 0x20),
		OAMEntry(-19, -3, 0x0D, 0x20),
		OAMEntry(-11,-11, 0x2C, 0x20),
		OAMEntry(-11, -3, 0x1D, 0x20),
		OAMEntry(-11,  5, 0x1C, 0x20),
		OAMEntry(-10,-18, 0x09, 0x20),
		OAMEntry(-4, -4, 0x4E, 0x20),
		OAMEntry(-4,  4, 0x2F, 0x20),
		OAMEntry(-4, 12, 0x2E, 0x20),
		OAMEntry(4,-12, 0x5F, 0x20),
		OAMEntry(4, -4, 0x5E, 0x20),
		OAMEntry(4,  4, 0x3F, 0x20),
		OAMEntry(4, 12, 0x3E, 0x20),
		OAMEntry(12,-12, 0x6F, 0x20),
		OAMEntry(12, -4, 0x6E, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-20,-12, 0x0B, 0x20),
		OAMEntry(-20, -4, 0x0D, 0x20),
		OAMEntry(-12,-12, 0x2C, 0x20),
		OAMEntry(-12, -4, 0x1D, 0x20),
		OAMEntry(-12,  4, 0x1C, 0x20),
		OAMEntry(-11,-19, 0x09, 0x20),
		OAMEntry(-4, -4, 0x2D, 0x20),
		OAMEntry(4, -4, 0x3D, 0x20),
		OAMEntry(12, -4, 0x4D, 0x20),
		OAMEntry(12,  4, 0x4C, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-12, -8, 0x04, 0x20),
		OAMEntry(-12,  0, 0x06, 0x00),
		OAMEntry(-4, -8, 0x15, 0x00),
		OAMEntry(-4,  0, 0x16, 0x00),
		OAMEntry(1,-14, 0x09, 0x20),
		OAMEntry(4, -8, 0x5B, 0x20),
		OAMEntry(4,  0, 0x4B, 0x20),
		OAMEntry(4,  8, 0x4F, 0x20),
		OAMEntry(12, -8, 0x6D, 0x20),
		OAMEntry(12,  0, 0x6C, 0x20),
		OAMEntry(12,  8, 0x6B, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-17, -6, 0x08, 0x00),
		OAMEntry(-12, -8, 0x47, 0x00),
		OAMEntry(-12,  0, 0x48, 0x00),
		OAMEntry(-4, -8, 0x57, 0x00),
		OAMEntry(-4,  0, 0x58, 0x00),
		OAMEntry(4, -8, 0x46, 0x20),
		OAMEntry(4,  0, 0x5C, 0x20),
		OAMEntry(4,  8, 0x4F, 0x20),
		OAMEntry(12, -8, 0x6D, 0x20),
		OAMEntry(12,  0, 0x6C, 0x20),
		OAMEntry(12,  8, 0x6B, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-10, -8, 0x04, 0x20),
		OAMEntry(-10,  0, 0x06, 0x00),
		OAMEntry(-2, -8, 0x15, 0x00),
		OAMEntry(-2,  0, 0x16, 0x00),
		OAMEntry(3,-13, 0x09, 0x20),
		OAMEntry(4, -8, 0x7A, 0x20),
		OAMEntry(4,  0, 0x79, 0x20),
		OAMEntry(12, -8, 0x78, 0x20),
		OAMEntry(12,  0, 0x77, 0x20),
		OAMEntry(12,  8, 0x76, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-12, -8, 0x71, 0x20),
		OAMEntry(-12,  0, 0x70, 0x20),
		OAMEntry(-4, -8, 0x73, 0x20),
		OAMEntry(-4,  0, 0x72, 0x20),
		OAMEntry(4, -8, 0x65, 0x20),
		OAMEntry(4,  0, 0x74, 0x20),
		OAMEntry(4,  8, 0x4F, 0x20),
		OAMEntry(12, -8, 0x3C, 0x20),
		OAMEntry(12,  0, 0x6C, 0x20),
		OAMEntry(12,  8, 0x6B, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,-12, 0x50, 0x00),
		OAMEntry(0, -4, 0x51, 0x00),
		OAMEntry(0,  4, 0x52, 0x00),
		OAMEntry(8,-12, 0x60, 0x00),
		OAMEntry(8, -4, 0x61, 0x00),
		OAMEntry(8,  4, 0x62, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -8, 0x56, 0x60),
		OAMEntry(-4,  0, 0x55, 0x60),
		OAMEntry(4, -8, 0x64, 0x60),
		OAMEntry(4,  0, 0x63, 0x60),
		OAMEntry(12, -8, 0x54, 0x60),
		OAMEntry(12,  0, 0x53, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,-12, 0x62, 0x60),
		OAMEntry(0, -4, 0x61, 0x60),
		OAMEntry(0,  4, 0x60, 0x60),
		OAMEntry(8,-12, 0x52, 0x60),
		OAMEntry(8, -4, 0x51, 0x60),
		OAMEntry(8,  4, 0x50, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -8, 0x53, 0x00),
		OAMEntry(-4,  0, 0x54, 0x00),
		OAMEntry(4, -8, 0x63, 0x00),
		OAMEntry(4,  0, 0x64, 0x00),
		OAMEntry(12, -8, 0x55, 0x00),
		OAMEntry(12,  0, 0x56, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x59, 0x00),
		OAMEntry(4,  0, 0x5A, 0x00),
		OAMEntry(12, -8, 0x69, 0x00),
		OAMEntry(12,  0, 0x6A, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x5A, 0x20),
		OAMEntry(3,  0, 0x6A, 0x40),
		OAMEntry(11, -8, 0x59, 0x40),
		OAMEntry(11,  0, 0x69, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x6A, 0x60),
		OAMEntry(4,  0, 0x69, 0x60),
		OAMEntry(12, -8, 0x5A, 0x60),
		OAMEntry(12,  0, 0x59, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x69, 0x40),
		OAMEntry(3,  0, 0x59, 0x20),
		OAMEntry(11, -8, 0x6A, 0x20),
		OAMEntry(11,  0, 0x5A, 0x40),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,-12, 0x52, 0x20),
		OAMEntry(0, -4, 0x51, 0x20),
		OAMEntry(0,  4, 0x50, 0x20),
		OAMEntry(8,-12, 0x62, 0x20),
		OAMEntry(8, -4, 0x61, 0x20),
		OAMEntry(8,  4, 0x60, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -8, 0x55, 0x40),
		OAMEntry(-4,  0, 0x56, 0x40),
		OAMEntry(4, -8, 0x63, 0x40),
		OAMEntry(4,  0, 0x64, 0x40),
		OAMEntry(12, -8, 0x53, 0x40),
		OAMEntry(12,  0, 0x54, 0x40),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,-12, 0x60, 0x40),
		OAMEntry(0, -4, 0x61, 0x40),
		OAMEntry(0,  4, 0x62, 0x40),
		OAMEntry(8,-12, 0x50, 0x40),
		OAMEntry(8, -4, 0x51, 0x40),
		OAMEntry(8,  4, 0x52, 0x40),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -8, 0x54, 0x20),
		OAMEntry(-4,  0, 0x53, 0x20),
		OAMEntry(4, -8, 0x64, 0x20),
		OAMEntry(4,  0, 0x63, 0x20),
		OAMEntry(12, -8, 0x56, 0x20),
		OAMEntry(12,  0, 0x55, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x5A, 0x20),
		OAMEntry(4,  0, 0x59, 0x20),
		OAMEntry(12, -8, 0x6A, 0x20),
		OAMEntry(12,  0, 0x69, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x6A, 0x60),
		OAMEntry(3,  0, 0x5A, 0x00),
		OAMEntry(11, -8, 0x69, 0x00),
		OAMEntry(11,  0, 0x59, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x69, 0x40),
		OAMEntry(4,  0, 0x6A, 0x40),
		OAMEntry(12, -8, 0x59, 0x40),
		OAMEntry(12,  0, 0x5A, 0x40),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x59, 0x00),
		OAMEntry(3,  0, 0x69, 0x60),
		OAMEntry(11, -8, 0x5A, 0x60),
		OAMEntry(11,  0, 0x6A, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -4, 0x7E, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-26, -2, 0x08, 0x00),
		OAMEntry(-20, -8, 0x17, 0x00),
		OAMEntry(-20,  0, 0x18, 0x00),
		OAMEntry(-12, -8, 0x27, 0x00),
		OAMEntry(-12,  0, 0x28, 0x00),
		OAMEntry(-4, -5, 0x2A, 0x00),
		OAMEntry(-4,  3, 0x2B, 0x00),
		OAMEntry(4,-13, 0x39, 0x00),
		OAMEntry(4, -5, 0x3A, 0x00),
		OAMEntry(4,  3, 0x3B, 0x00),
		OAMEntry(12,-13, 0x49, 0x00),
		OAMEntry(12, -5, 0x4A, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-25, -2, 0x08, 0x00),
		OAMEntry(-19, -8, 0x17, 0x00),
		OAMEntry(-19,  0, 0x18, 0x00),
		OAMEntry(-11, -8, 0x27, 0x00),
		OAMEntry(-11,  0, 0x28, 0x00),
		OAMEntry(-4,-21, 0x2E, 0x00),
		OAMEntry(-4,-13, 0x2F, 0x00),
		OAMEntry(-4, -5, 0x4E, 0x00),
		OAMEntry(4,-21, 0x3E, 0x00),
		OAMEntry(4,-13, 0x3F, 0x00),
		OAMEntry(4, -5, 0x5E, 0x00),
		OAMEntry(4,  3, 0x5F, 0x00),
		OAMEntry(12, -5, 0x6E, 0x00),
		OAMEntry(12,  3, 0x6F, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-26, -2, 0x08, 0x00),
		OAMEntry(-20, -8, 0x17, 0x00),
		OAMEntry(-20,  0, 0x18, 0x00),
		OAMEntry(-12, -8, 0x27, 0x00),
		OAMEntry(-12,  0, 0x28, 0x00),
		OAMEntry(-4, -5, 0x2D, 0x00),
		OAMEntry(4, -5, 0x3D, 0x00),
		OAMEntry(12,-13, 0x4C, 0x00),
		OAMEntry(12, -5, 0x4D, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-26, -6, 0x08, 0x00),
		OAMEntry(-20, -8, 0x47, 0x00),
		OAMEntry(-20,  0, 0x48, 0x00),
		OAMEntry(-12, -8, 0x57, 0x00),
		OAMEntry(-12,  0, 0x58, 0x00),
		OAMEntry(-4,-11, 0x2B, 0x20),
		OAMEntry(-4, -3, 0x2A, 0x20),
		OAMEntry(4,-11, 0x3B, 0x20),
		OAMEntry(4, -3, 0x3A, 0x20),
		OAMEntry(4,  5, 0x39, 0x20),
		OAMEntry(12, -3, 0x4A, 0x20),
		OAMEntry(12,  5, 0x49, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-25, -6, 0x08, 0x00),
		OAMEntry(-19, -8, 0x47, 0x00),
		OAMEntry(-19,  0, 0x48, 0x00),
		OAMEntry(-11, -8, 0x57, 0x00),
		OAMEntry(-11,  0, 0x58, 0x00),
		OAMEntry(-4, -3, 0x4E, 0x20),
		OAMEntry(-4,  5, 0x2F, 0x20),
		OAMEntry(-4, 13, 0x2E, 0x20),
		OAMEntry(4,-11, 0x5F, 0x20),
		OAMEntry(4, -3, 0x5E, 0x20),
		OAMEntry(4,  5, 0x3F, 0x20),
		OAMEntry(4, 13, 0x3E, 0x20),
		OAMEntry(12,-11, 0x6F, 0x20),
		OAMEntry(12, -3, 0x6E, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-26, -6, 0x08, 0x00),
		OAMEntry(-20, -8, 0x47, 0x00),
		OAMEntry(-20,  0, 0x48, 0x00),
		OAMEntry(-12, -8, 0x57, 0x00),
		OAMEntry(-12,  0, 0x58, 0x00),
		OAMEntry(-4, -3, 0x2D, 0x20),
		OAMEntry(4, -3, 0x3D, 0x20),
		OAMEntry(12, -3, 0x4D, 0x20),
		OAMEntry(12,  5, 0x4C, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-16, 0x80, 0x00),
		OAMEntry(-16, -8, 0x81, 0x00),
		OAMEntry(-16,  0, 0x81, 0x20),
		OAMEntry(-16,  8, 0x80, 0x20),
		OAMEntry(-8,-16, 0x82, 0x00),
		OAMEntry(-8, -8, 0x83, 0x00),
		OAMEntry(-8,  0, 0x83, 0x20),
		OAMEntry(-8,  8, 0x82, 0x20),
		OAMEntry(0,-16, 0x82, 0x40),
		OAMEntry(0, -8, 0x83, 0x40),
		OAMEntry(0,  0, 0x83, 0x60),
		OAMEntry(0,  8, 0x82, 0x60),
		OAMEntry(8,-16, 0x80, 0x40),
		OAMEntry(8, -8, 0x81, 0x40),
		OAMEntry(8,  0, 0x81, 0x60),
		OAMEntry(8,  8, 0x80, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-8, -8, 0x84, 0x00),
		OAMEntry(-8,  0, 0x84, 0x20),
		OAMEntry(0, -8, 0x84, 0x40),
		OAMEntry(0,  0, 0x84, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-12,-12, 0x8B, 0x00),
		OAMEntry(-12, -4, 0x8C, 0x00),
		OAMEntry(-12,  4, 0x8B, 0x20),
		OAMEntry(-4,-12, 0x8D, 0x00),
		OAMEntry(-4,  4, 0x8D, 0x20),
		OAMEntry(4,-12, 0x8B, 0x40),
		OAMEntry(4, -4, 0x8C, 0x40),
		OAMEntry(4,  4, 0x8B, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -4, 0x8E, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -4, 0x90, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -4, 0x91, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x05, 0x00),
		OAMEntry(4,  0, 0x07, 0x00),
		OAMEntry(12, -8, 0x33, 0x00),
		OAMEntry(12,  0, 0x29, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x07, 0x20),
		OAMEntry(3,  0, 0x29, 0x40),
		OAMEntry(11, -8, 0x05, 0x40),
		OAMEntry(11,  0, 0x33, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x29, 0x60),
		OAMEntry(4,  0, 0x33, 0x60),
		OAMEntry(12, -8, 0x07, 0x60),
		OAMEntry(12,  0, 0x05, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x33, 0x40),
		OAMEntry(3,  0, 0x05, 0x20),
		OAMEntry(11, -8, 0x29, 0x20),
		OAMEntry(11,  0, 0x07, 0x40),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x07, 0x20),
		OAMEntry(4,  0, 0x05, 0x20),
		OAMEntry(12, -8, 0x29, 0x20),
		OAMEntry(12,  0, 0x33, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x29, 0x60),
		OAMEntry(3,  0, 0x07, 0x00),
		OAMEntry(11, -8, 0x33, 0x00),
		OAMEntry(11,  0, 0x05, 0x60),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(4, -8, 0x33, 0x40),
		OAMEntry(4,  0, 0x29, 0x40),
		OAMEntry(12, -8, 0x05, 0x40),
		OAMEntry(12,  0, 0x07, 0x40),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(3, -8, 0x05, 0x00),
		OAMEntry(3,  0, 0x33, 0x60),
		OAMEntry(11, -8, 0x07, 0x60),
		OAMEntry(11,  0, 0x29, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0x9A, 0x00),
		OAMEntry(0,  8, 0x9A, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0x9B, 0x00),
		OAMEntry(0,  8, 0x9B, 0x20),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xED, 0x00),
		OAMEntry(0,  8, 0xEE, 0x00),
		OAMEntry(0, 16, 0xEF, 0x00),
		OAMEntry(0, 24, 0xF5, 0x00),
		OAMEntry(0, 32, 0xF5, 0x00),
		OAMEntry(0, 48, 0xF7, 0x00),
		OAMEntry(0, 56, 0xF8, 0x00),
		OAMEntry(0, 64, 0xF9, 0x00),
		OAMEntry(0, 72, 0xFA, 0x00),
		OAMEntry(0, 80, 0xFB, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xCF, 0x00),
		OAMEntry(0,  8, 0xD1, 0x00),
		OAMEntry(0, 16, 0xC4, 0x00),
		OAMEntry(0, 24, 0xD2, 0x00),
		OAMEntry(0, 32, 0xD2, 0x00),
		OAMEntry(0, 48, 0xD2, 0x00),
		OAMEntry(0, 56, 0xD3, 0x00),
		OAMEntry(0, 64, 0xC0, 0x00),
		OAMEntry(0, 72, 0xD1, 0x00),
		OAMEntry(0, 80, 0xD3, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xC2, 0x80),
		OAMEntry(0,  8, 0xCE, 0x80),
		OAMEntry(0, 16, 0xCC, 0x80),
		OAMEntry(0, 24, 0xCF, 0x80),
		OAMEntry(0, 32, 0xCB, 0x80),
		OAMEntry(0, 40, 0xC4, 0x80),
		OAMEntry(0, 48, 0xD3, 0x80),
		OAMEntry(0, 56, 0xC4, 0x80),
		OAMEntry(0, 64, 0xC3, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0x36, 0x80),
		OAMEntry(0,  8, 0x0F, 0x80),
		OAMEntry(metaSpriteEnd),
	]
];

void vblankUpdateStatusBar() {
	if (queenHeadFrameNext || itemCollected || itemCollectionFlag) {
		return;
	}
	hudTanks[] = 0xAF;
	if (samusEnergyTanks) {
		version(original) {
			hudTanks[0 .. samusEnergyTanks] = 0x9C;
		} else {
			import std.algorithm.comparison : min;
			hudTanks[0 .. min($, samusEnergyTanks)] = 0x9C;
		}
		if (samusDispHealth >= 100) {
			version(original) {
				hudTanks[0 .. samusDispHealth / 100] = 0x9D;
			} else {
				import std.algorithm.comparison : min;
				hudTanks[0 .. min($, samusDispHealth / 100)] = 0x9D;
			}
		}
	} else {
		hudTanks[0] = 0xAA; // E
	}
	const hudBase = (queenRoomFlag == 0x11) ? VRAMDest.queenStatusBar : VRAMDest.statusBar;
	gb.vram[hudBase + 0] = hudTanks[4];
	gb.vram[hudBase + 1] = hudTanks[3];
	gb.vram[hudBase + 2] = hudTanks[2];
	gb.vram[hudBase + 3] = hudTanks[1];
	gb.vram[hudBase + 4] = hudTanks[0];
	gb.vram[hudBase + 5] = 0x9E;
	gb.vram[hudBase + 6] = ((samusDispHealth % 100) / 10) + 0xA0;
	gb.vram[hudBase + 7] = (samusDispHealth % 10) + 0xA0;
	gb.vram[hudBase + 11] = ((samusDispMissiles % 1000) / 100) + 0xA0;
	gb.vram[hudBase + 12] = ((samusDispMissiles % 100) / 10) + 0xA0;
	gb.vram[hudBase + 13] = (samusDispMissiles % 10) + 0xA0;
	if (gameMode != GameMode.paused) {
		if (metroidCountShuffleTimer == 0) {
			gb.vram[hudBase + 18] = ((metroidCountDisplayed % 100) / 10) + 0xA0;
			gb.vram[hudBase + 19] = (metroidCountDisplayed % 10) + 0xA0;
		} else if (--metroidCountShuffleTimer < 0x80) {
			gb.vram[hudBase + 18] = ((frameCounter % 100) / 10) + 0xA0;
			gb.vram[hudBase + 19] = (frameCounter % 10) + 0xA0;
		}
	} else if (metroidLCounterDisp) {
		gb.vram[hudBase + 18] = ((metroidLCounterDisp % 100) / 10) + 0xA0;
		gb.vram[hudBase + 19] = (metroidLCounterDisp % 10) + 0xA0;
	} else {
		gb.vram[hudBase + 18] = 0x9E;
		gb.vram[hudBase + 19] = 0x9E;
	}
}

void adjustHUDValues() {
	// BCD adjustment for health was here
	if (samusDispHealth > samusCurHealth) {
		samusDispHealth--;
		if (sfxPlayingSquare1 && ((frameCounter & 3) == 0)) {
			sfxRequestSquare1 = Square1SFX.samusHealthChange;
		}
	} else if (samusDispHealth < samusCurHealth) {
		samusDispHealth++;
		if (sfxPlayingSquare1 && ((frameCounter & 3) == 0)) {
			sfxRequestSquare1 = Square1SFX.samusHealthChange;
		}
	}
	// BCD adjustment for missiles was here
	if (samusDispMissiles > samusCurMissiles) {
		samusDispMissiles--;
		if (sfxPlayingSquare1 && ((frameCounter & 3) == 0)) {
			sfxRequestSquare1 = Square1SFX.pickedUpMissileDrop;
		}
	} else if (samusDispMissiles < samusCurMissiles) {
		samusDispMissiles++;
		if (sfxPlayingSquare1 && ((frameCounter & 3) == 0)) {
			sfxRequestSquare1 = Square1SFX.pickedUpMissileDrop;
		}
	}
}
void debugDrawNumberTwoDigit(ubyte digits) {
	debugDrawNumberSprite(cast(ubyte)(((digits >> 4) & 0xF) + 0xA0));
	debugDrawNumberOneDigit(digits);
}
void debugDrawNumberOneDigit(ubyte digit) {
	debugDrawNumberSprite(cast(ubyte)((digit & 0xF) + 0xA0));
}
void debugDrawNumberSprite(ubyte tile) {
	version(original) {} else {
		// original did no bounds checking
		if (oamBufferIndex >= oamBuffer.length) {
			return;
		}
	}
	auto hl = &oamBuffer[oamBufferIndex];
	hl.y = spriteYPixel;
	hl.x = spriteXPixel;
	spriteXPixel += 8;
	hl.tile = tile;
	hl.flags = spriteAttr;
	oamBufferIndex++;
}


void drawHUDMetroid() {
	spriteYPixel = 0x98;
	if (queenRoomFlag != 0x11) {
		if (saveContactFlag || (itemCollectedCopy && (itemCollectedCopy < 0xB))) {
			spriteYPixel = 0x90;
		}
	}
	spriteXPixel = 0x80;
	samusScreenSpritePriority = 1;
	spriteID = ((frameCounter & 0x10) >> 4) + 0x3F;
	drawSamusSprite();
}
void drawSamusSprite() {
	version(original) {} else {
		// original did no bounds checking
		if (oamBufferIndex >= oamBuffer.length) {
			return;
		}
	}
	auto de = &samusSpriteTable[spriteID][0];
	auto hl = &oamBuffer[oamBufferIndex];
	while (true) {
		if (de.y == metaSpriteEnd) {
			break;
		}
		hl.y = cast(ubyte)(de.y + spriteYPixel);
		hl.x = cast(ubyte)(de.x + spriteXPixel);
		hl.tile = de.tile;
		hl.flags = de.flags;
		if (spriteAttr) {
			hl.flags |= OAMFlags.palette;
		}
		if (!samusScreenSpritePriority) {
			hl.flags |= OAMFlags.priority;
		}
		oamBufferIndex++;
		de++;
		hl++;
	}
}
void clearUnusedOAMSlots() {
	if (oamBufferIndex < maxOAMPrevFrame) {
		for (int i = oamBufferIndex; i < maxOAMPrevFrame; i++) {
			oamBuffer[i].y = 0; // sprites with a y < 8 will never be rendered
		}
	}
	maxOAMPrevFrame = oamBufferIndex;
}

void clearAllOAM() {
	for (int i = 0; i < oamBuffer.length; i++) {
		oamBuffer[i].y = 0;
	}
}

void drawSamus() {
	if (samusInvulnerableTimer) {
		samusInvulnerableTimer--;
		if (frameCounter & 4) {
			return;
		}
	}
	if (acidContactFlag && (frameCounter & 4)) {
		return;
	}
	drawSamusIgnoreDamageFrames();
}
void drawSamusIgnoreDamageFrames() {
	if (samusPose & 0x80) {
		drawSamusFaceScreen();
	} else {
		const b = samusFacingDirection ? 1 : 2;
		const tmp1 = cutsceneActive ? b : (((inputPressed & (Pad.down | Pad.up | Pad.left | Pad.right)) >> 4) | b);
		switch (samusPose) {
			case SamusPose.standing:
				drawSamusStanding(tmp1);
				break;
			case SamusPose.jumping:
			case SamusPose.falling:
				drawSamusJump(tmp1);
				break;
			case SamusPose.spinJumping:
				drawSamusSpinJump();
				break;
			case SamusPose.running:
				drawSamusRun();
				break;
			case SamusPose.crouching:
				drawSamusCrouch();
				break;
			case SamusPose.morphBall:
			case SamusPose.morphBallJumping:
			case SamusPose.morphBallFalling:
			case SamusPose.morphBallKnockBack:
			case SamusPose.morphBallBombed:
			case SamusPose.eatenByMetroidQueen:
			case SamusPose.inMetroidQueenMouth:
			case SamusPose.swallowedByMetroidQueen:
			case SamusPose.inMetroidQueenStomach:
			case SamusPose.escapingMetroidQueen:
			case SamusPose.escapedMetroidQueen:
				drawSamusMorph();
				break;
			case SamusPose.startingToJump:
			case SamusPose.startingToSpinJump:
				drawSamusJumpStart();
				break;
			case SamusPose.spiderBallRolling:
			case SamusPose.spiderBallFalling:
			case SamusPose.spiderBallJumping:
			case SamusPose.spiderBall:
				drawSamusSpider();
				break;
			case SamusPose.knockBack:
			case SamusPose.standingBombed:
				drawSamusKnockback();
				break;
			case SamusPose.facingScreen:
			case SamusPose.facingScreen2:
			case SamusPose.facingScreen3:
			case SamusPose.facingScreen4:
			case SamusPose.facingScreen5:
				if (!drawSamusFaceScreen()) {
					return;
				}
				break;
			default: assert(0);
		}
	}
	loadScreenSpritePriorityBit();
	spriteXPixel = cast(ubyte)(samusX - cameraX + 0x60);
	samusOnScreenXPos = spriteXPixel;
	spriteYPixel = cast(ubyte)(samusY.pixel - cameraY.pixel + 0x62);
	samusOnScreenYPos = spriteYPixel;
	spriteAttr = 0;
	if (acidContactFlag || samusInvulnerableTimer) {
		spriteAttr = 1;
	}
	drawSamusEarthquakeAdjustment();
	drawSamusSprite();
	spriteAttr = 0;
	samusScreenSpritePriority = 0;
}

void drawSamusKnockback() {
	spriteID = knockbackTable[samusFacingDirection];
}
immutable ubyte[] knockbackTable = [0x16, 0x09];

void drawSamusSpider() {
	spriteID = spiderTable[samusFacingDirection & 1][(samusSpinAnimationTimer & 0b1100) >> 2];
}
immutable ubyte[][] spiderTable = [
	[0x37, 0x38, 0x39, 0x3A],
	[0x3B, 0x3C, 0x3D, 0x3E],
];

void drawSamusMorph() {
	spriteID = morphTable[samusFacingDirection & 1][(samusSpinAnimationTimer & 0b1100) >> 2];
}
immutable ubyte[][] morphTable = [
	[0x1E, 0x1F, 0x20, 0x21],
	[0x26, 0x27, 0x28, 0x29],
];

void drawSamusJump(ubyte val) {
	spriteID = jumpSpriteTable[val];
}
void drawSamusJumpStart() {
	spriteID = 3;
	if (!samusFacingDirection) {
		spriteID = 16;
	}
}
immutable ubyte[] jumpSpriteTable = [ 0x00, 0x09, 0x16, 0x00, 0x00, 0x0A, 0x17, 0x00, 0x00, 0x0C, 0x19, 0x00, 0x00, 0x00, 0x00, 0x00 ];

void drawSamusSpinJump() {
	const spinTable = samusFacingDirection ? spinRightTable : spinLeftTable;
	if (!(samusItems & (ItemFlag.spaceJump | ItemFlag.screwAttack))) {
		spriteID = spinTable[((samusSpinAnimationTimer >> 1) & 0b1100) >> 2];
	} else {
		spriteID = spinTable[(samusSpinAnimationTimer >> 1) & 0b0011];
	}
}

immutable ubyte[] spinRightTable = [ 0x1A, 0x1B, 0x1C, 0x1D];
immutable ubyte[] spinLeftTable = [ 0x22, 0x23, 0x24, 0x25];

bool drawSamusFaceScreen() {
	if (countdownTimer && ((frameCounter & 3) == 0)) { // skip 1 out of every 4 frames
		return false;
	}
	spriteID = 0;
	return true;
}
void drawSamusStanding(ubyte val) {
	spriteID = standingTable[val];
}
immutable ubyte[] standingTable = [0x00, 0x01, 0x0E, 0x00, 0x00, 0x02, 0x0F, 0x00, 0x00, 0x01, 0x0E, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];

void drawSamusCrouch() {
	spriteID = 11;
	if (!samusFacingDirection) {
		spriteID = 24;
	}
}

void drawSamusRun() {
	if (samusAnimationTimer >= 0x30) {
		samusAnimationTimer = 0;
	}
	if (((samusAnimationTimer & 7) == 0) && (sfxRequestNoise == 0)) {
		sfxRequestNoise = NoiseSFX.u10;
	}
	immutable(ubyte[])[] table;
	if (inputPressed & Pad.up) {
		table = runningTableAimingUp;
	} else if (inputPressed & Pad.b) {
		table = runningTableShooting;
	} else {
		table = runningTableNormal;
	}
	spriteID = table[samusFacingDirection & 1][(samusAnimationTimer & 0x30) >> 4];
}
immutable ubyte[][] runningTableNormal = [
	[0x10, 0x11, 0x12, 0x00],
	[0x03, 0x04, 0x05, 0x00],
];
immutable ubyte[][] runningTableShooting = [
	[0x13, 0x14, 0x15, 0x00],
	[0x06, 0x07, 0x08, 0x00],
];
immutable ubyte[][] runningTableAimingUp = [
	[0x2e, 0x2f, 0x30, 0x00],
	[0x2b, 0x2c, 0x2d, 0x00],
];

void handleNewGame() {
	loadingFromFile = 0;
	saveBuf = initialSave;
	gameMode = GameMode.loadA;
}
void handleLoadSave() {
	if (!loadingFromFile) {
		handleNewGame();
		return;
	}
	enableSRAM();
	saveBuf = sram.saves[activeSaveSlot].data;
	disableSRAM();
	loadEnemySaveFlags();
	gameMode = GameMode.loadA;
}

auto initialSave = SaveFileData(
	0x07D4,
	0x0648,
	0x07C0,
	0x0640,
	EnemyTileSet.surfaceSPR,
	BGTileSet.surfaceBG,
	MetatileSet.surface,
	CollisionSet.surface,
	0x0F,
	0x64,
	0x64,
	0x64,
	0x00,
	CollisionType.powerBeam,
	0x00,
	99,
	30,
	30,
	1,
	2,
	8,
	47,
	Song.mainCaves,
	0,
	0,
	39,
);

immutable Square1SFX[] beamSoundTable = [
	CollisionType.powerBeam: Square1SFX.shootingBeam,
	CollisionType.iceBeam: Square1SFX.shootingIceBeam,
	CollisionType.waveBeam: Square1SFX.shootingWaveBeam,
	CollisionType.spazer: Square1SFX.shootingSpazerBeam,
	CollisionType.plasmaBeam: Square1SFX.shootingPlasmaBeam,
	CollisionType.unk5: Square1SFX.shootingBeam,
	CollisionType.unk6: Square1SFX.shootingBeam,
	CollisionType.bombs: Square1SFX.shootingBeam,
	CollisionType.missiles: Square1SFX.shootingMissile,
];

size_t getFirstEmptyProjectileSlot() {
	int result;
	if (samusActiveWeapon == CollisionType.missiles) {
		// missiles only use the last slot, so start looking there
		result = projectileArray.length - 1;
	}
	for (; result < projectileArray.length; result++) {
		if (projectileArray[result].type == CollisionType.nothing) {
			break;
		}
	}
	return result;
}

void handleProjectiles() {
	static void checkEnemies() {
		if (collisionProjectileEnemies()) {
			beamP.type = CollisionType.nothing;
		}
	}
	outerLoop: for (projectileIndex = 0; projectileIndex < projectileArray.length; projectileIndex++) {
		beamP = &projectileArray[projectileIndex];
		beamType = beamP.type;
		weaponType = beamP.type;
		if (beamP.type == CollisionType.nothing) {
			continue;
		}
		ubyte direction = beamP.direction;
		weaponDirection = direction;
		ubyte y = beamP.y;
		ubyte x = beamP.x;
		beamWaveIndex = beamP.waveIndex;
		beamFrameCounter = cast(ubyte)(beamP.frameCounter + 1);
		switch (beamType) {
			case CollisionType.waveBeam:
				ubyte waveSpeed;
				while (true) {
					waveSpeed = waveSpeedTable[beamWaveIndex];
					if (waveSpeed != 0x80) {
						break;
					}
					beamWaveIndex = 0;
				}
				if (!(direction & (BeamDirection.up | BeamDirection.down))) {
					y += waveSpeed;
					beamWaveIndex++;
					if (!(direction & BeamDirection.left)) {
						x += waveBeamSpeed + cameraSpeedRight;
					} else {
						x -= waveBeamSpeed + cameraSpeedLeft;
					}
				} else {
					x+= waveSpeed;
					beamWaveIndex++;
					if (!(direction & BeamDirection.up)) {
						y += waveBeamSpeed + cameraSpeedDown;
					} else {
						y -= waveBeamSpeed + cameraSpeedUp;
					}
				}
				beamP.y = y;
				tileY = cast(ubyte)(y + 4);
				beamP.x = x;
				tileX = cast(ubyte)(x + 4);
				beamP.waveIndex = beamWaveIndex;
				if (!(frameCounter & 1)) {
					 checkEnemies();
					 continue outerLoop;
				}
				const index = getTileIndexProjectile();
				if (index >= beamSolidityIndex) {
					 checkEnemies();
					 continue outerLoop;
				}
				if (index < 4) {
					destroyRespawningBlock();
				} else if (collisionArray[index] & BlockType.shot) {
					destroyBlock(/*0xFF*/);
				}
				continue outerLoop;
			case CollisionType.spazer:
				if (direction & BeamDirection.right) {
					spazerSplitVertically(projectileIndex, x, y);
					x += spazerSpeed + cameraSpeedRight;
				} else if (direction & BeamDirection.left) {
					spazerSplitVertically(projectileIndex, x, y);
					x -= spazerSpeed + cameraSpeedLeft;
				} else if (direction & BeamDirection.up) {
					spazerSplitHorizontally(projectileIndex, x, y);
					y -= spazerSpeed + cameraSpeedUp;
				} else if (direction & BeamDirection.down) {
					spazerSplitHorizontally(projectileIndex, x, y);
					y += spazerSpeed + cameraSpeedDown;
				}
				break;
			case CollisionType.missiles:
				if (missileSpeedTable[beamFrameCounter] == 0xFF) {
					beamFrameCounter--;
				}
				const speed = missileSpeedTable[beamFrameCounter];
				if (direction & BeamDirection.right) {
					x += speed + cameraSpeedRight;
				} else if (direction & BeamDirection.left) {
					x -= speed + cameraSpeedLeft;
				} else if (direction & BeamDirection.up) {
					y -= speed + cameraSpeedUp;
				} else if (direction & BeamDirection.down) {
					y += speed + cameraSpeedDown;
				}
				break;
			default:
				if (direction & BeamDirection.right) {
					x += defaultBeamSpeed + cameraSpeedRight;
					if (beamType == CollisionType.plasmaBeam) {
						x += plasmaBeamSpeed - defaultBeamSpeed;
					}
				} else if (direction & BeamDirection.left) {
					x -= defaultBeamSpeed + cameraSpeedLeft;
					if (beamType == CollisionType.plasmaBeam) {
						x -= plasmaBeamSpeed - defaultBeamSpeed;
					}
				} else if (direction & BeamDirection.up) {
					y -= defaultBeamSpeed + cameraSpeedUp;
					if (beamType == CollisionType.plasmaBeam) {
						y -= plasmaBeamSpeed - defaultBeamSpeed;
					}
				} else if (direction & BeamDirection.down) {
					y += defaultBeamSpeed + cameraSpeedDown;
					if (beamType == CollisionType.plasmaBeam) {
						y += plasmaBeamSpeed - defaultBeamSpeed;
					}
				}
				break;
		}
		beamP.y = y;
		tileY = cast(ubyte)(y + 4);
		beamP.x = x;
		tileX = cast(ubyte)(x + 4);
		beamP.waveIndex = beamWaveIndex;
		beamP.frameCounter = beamFrameCounter;
		if (frameCounter & 1) {
			const index = getTileIndexProjectile();
			if (index < beamSolidityIndex) {
				if (index < 4) {
					destroyRespawningBlock();
				} else if (collisionArray[index] & BlockType.shot) {
					destroyBlock(/*0xFF*/);
				}
				if (beamType == CollisionType.bombs) {
					bombBeamLayBomb(x, y);
				}
				if ((beamType == CollisionType.spazer) || (beamType == CollisionType.plasmaBeam)) {
					continue;
				}
				beamP.type = CollisionType.nothing; //delete projectile
			}
		}
		checkEnemies();
	}
}

immutable ubyte[] waveSpeedTable = [0x00, 0x07, 0x05, 0x02, 0x00, 0xfe, 0xfb, 0xf9, 0x00, 0xf9, 0xfb, 0xfe, 0x00, 0x02, 0x05, 0x07, 0x80];
immutable ubyte[] waveSpeedTableAlt = [0x0A, 0xF6, 0xF6, 0x0A, 0x0A, 0xF6, 0xF6, 0x0A, 0x0A, 0xF6, 0xF6, 0x0A, 0x80];
immutable ubyte[] missileSpeedTable = [0x00, 0x00, 0x01, 0x00, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x00, 0x01, 0x01, 0x01, 0x01, 0x02, 0x01, 0x02, 0x01, 0x02, 0x02, 0x02, 0x02, 0x03, 0x02, 0x02, 0x03, 0x02, 0x03, 0x03, 0x03, 0x03, 0x04, 0xFF];

void spazerSplitVertically(ubyte slot, ref ubyte x, ref ubyte y) {
	if (beamFrameCounter >= 5) {
		return;
	}
	if (slot == 1) {
		return;
	}
	if (slot == 0) {
		y -= 2;
	} else if (slot == 2) {
		y += 2;
	}
}
void spazerSplitHorizontally(ubyte slot, ref ubyte x, ref ubyte y) {
	if (beamFrameCounter >= 5) {
		return;
	}
	if (slot == 1) {
		return;
	}
	if (slot == 0) {
		x -= 2;
	} else if (slot == 2) {
		x += 2;
	}
}

void drawProjectiles() {
	for (projectileIndex = 0; projectileIndex < projectileArray.length; projectileIndex++) {
		if (projectileArray[projectileIndex].type != CollisionType.nothing) {
			spriteYPixel = cast(ubyte)(projectileArray[projectileIndex].y - scrollY);
			spriteXPixel = cast(ubyte)(projectileArray[projectileIndex].x - scrollX);
			spriteAttr = 0;
			if (projectileArray[projectileIndex].type == CollisionType.missiles) {
				spriteID = missileSpriteTileTable[projectileArray[projectileIndex].direction];
				spriteAttr = missileSpriteAttributeTable[projectileArray[projectileIndex].direction];
			} else {
				spriteID = 0x7E;
				if (!(projectileArray[projectileIndex].direction & 3)) {
					spriteID = 0x7F;
				}
			}
			if ((spriteXPixel >= 8) && (spriteXPixel < 164) && (spriteYPixel >= 12) && (spriteYPixel < 148)) {
				version(original) {} else {
					// original did no bounds checking
					if (oamBufferIndex >= oamBuffer.length) {
						return;
					}
				}
				oamBuffer[oamBufferIndex].y = spriteYPixel;
				oamBuffer[oamBufferIndex].x = spriteXPixel;
				oamBuffer[oamBufferIndex].tile = spriteID;
				oamBuffer[oamBufferIndex].flags = spriteAttr;
				oamBufferIndex++;
				spriteAttr = 0;
			} else {
				projectileArray[projectileIndex].type = CollisionType.nothing;
			}
		}
	}
}
immutable ubyte[] missileSpriteTileTable = [0x00, 0x98, 0x98, 0x00, 0x99, 0x00, 0x00, 0x00, 0x99];
immutable ubyte[] missileSpriteAttributeTable = [0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40];
void bombBeamLayBomb(ubyte x, ubyte y) {
	int i;
	for (i = 0; i < bombArray.length; i++) {
		if (bombArray[i].type == 0xFF) {
			goto foundOpen;
		}
	}
	return;
	foundOpen:
	bombArray[i].type = BombType.bomb;
	bombArray[i].timer = 96;
	bombArray[i].y = cast(ubyte)(y + 4);
	bombArray[i].x = cast(ubyte)(x + 4);
	sfxRequestSquare1 = Square1SFX.bombLaid;
}

void drawBombs() {
	for (projectileIndex = 0; projectileIndex < bombArray.length; projectileIndex++) {
		if (bombArray[projectileIndex].type == BombType.invalid) {
			continue;
		}
		bombMapYPixel = bombArray[projectileIndex].y;
		spriteYPixel = cast(ubyte)(bombMapYPixel - scrollY);
		bombMapXPixel = bombArray[projectileIndex].x;
		spriteXPixel = cast(ubyte)(bombMapXPixel - scrollX);
		if ((spriteXPixel < 176) && (spriteYPixel < 176)) {
			if (bombArray[projectileIndex].type == BombType.bomb) {
				spriteID = cast(ubyte)(53 + ((bombArray[projectileIndex].timer & 8) >> 3));
				drawSamusSprite();
			} else {
				if (bombArray[projectileIndex].timer == 8) {
					if (samusPose < SamusPose.eatenByMetroidQueen) {
						bombsSamusAndBGCollision();
					}
					spriteID = cast(ubyte)(49 + bombArray[projectileIndex].timer / 2);
					drawSamusSprite();
					collisionBombEnemies();
					sfxRequestNoise = NoiseSFX.u0C;
				} else {
					spriteID = cast(ubyte)(49 + bombArray[projectileIndex].timer / 2);
					drawSamusSprite();
				}
			}
		} else {
			bombArray[projectileIndex].type = BombType.invalid;
		}
	}
}

void handleBombs() {
	for (projectileIndex = 0; projectileIndex < bombArray.length; projectileIndex++) {
		if (bombArray[projectileIndex].type == BombType.invalid) {
			continue;
		}
		if (--bombArray[projectileIndex].timer == 0) {
			if (bombArray[projectileIndex].type == BombType.explosion) {
				bombArray[projectileIndex].type = BombType.invalid;
			} else {
				bombArray[projectileIndex].type = BombType.explosion;
				bombArray[projectileIndex].timer = 8;
			}
		}
	}
	drawBombs();
}

void bombsSamusAndBGCollision() {
	if ((samusOnScreenYPos - 32 < spriteYPixel) && (samusOnScreenYPos + 32 >= spriteYPixel) && (samusOnScreenXPos - 16 < spriteXPixel) && (samusOnScreenXPos + 16 >= spriteXPixel)) {
		samusAirDirection = 0xFF;
		if (samusOnScreenXPos >= spriteXPixel) {
			samusAirDirection = 0;
			if (samusOnScreenXPos != spriteXPixel) {
				samusAirDirection = 1;
			}
		}
		samusJumpArcCounter = 64;
		samusPose = samusBombPoseTable[samusPose];
	}
	tileY = cast(ubyte)(bombMapYPixel - 16);
	tileX = bombMapXPixel;
	auto tile = getTileIndexProjectile();
	if (tile < 4) {
		destroyRespawningBlock();
	} else if (collisionArray[tile] & BlockType.bomb) {
		destroyBlock(/*0xFF*/);
	}
	tileY = bombMapYPixel;
	tile = getTileIndexProjectile();
	if (tile < 4) {
		destroyRespawningBlock();
	} else if (collisionArray[tile] & BlockType.bomb) {
		destroyBlock(/*0xFF*/);
	}
	tileY = cast(ubyte)(bombMapYPixel + 16);
	tile = getTileIndexProjectile();
	if (tile < 4) {
		destroyRespawningBlock();
	} else if (collisionArray[tile] & BlockType.bomb) {
		destroyBlock(/*0xFF*/);
	}
	tileY = bombMapYPixel;
	tileX = cast(ubyte)(bombMapXPixel + 16);
	tile = getTileIndexProjectile();
	if (tile < 4) {
		destroyRespawningBlock();
	} else if (collisionArray[tile] & BlockType.bomb) {
		destroyBlock(/*0xFF*/);
	}
	tileX = cast(ubyte)(bombMapXPixel - 16);
	tile = getTileIndexProjectile();
	if (tile < 4) {
		destroyRespawningBlock();
	} else if (collisionArray[tile] & BlockType.bomb) {
		destroyBlock(/*0xFF*/);
	}
}

immutable SamusPose[] samusBombPoseTable = [
	SamusPose.standing: SamusPose.standingBombed,
	SamusPose.jumping: SamusPose.standingBombed,
	SamusPose.spinJumping: SamusPose.standingBombed,
	SamusPose.running: SamusPose.standingBombed,
	SamusPose.crouching: SamusPose.standingBombed,
	SamusPose.morphBall: SamusPose.morphBallBombed,
	SamusPose.morphBallJumping: SamusPose.morphBallBombed,
	SamusPose.falling: SamusPose.standingBombed,
	SamusPose.morphBallFalling: SamusPose.morphBallBombed,
	SamusPose.startingToJump: SamusPose.standingBombed,
	SamusPose.startingToSpinJump: SamusPose.standingBombed,
	SamusPose.spiderBallRolling: SamusPose.morphBallBombed,
	SamusPose.spiderBallFalling: SamusPose.morphBallBombed,
	SamusPose.spiderBallJumping: SamusPose.morphBallBombed,
	SamusPose.spiderBall: SamusPose.morphBallBombed,
	SamusPose.knockBack: SamusPose.standingBombed,
	SamusPose.morphBallKnockBack: SamusPose.morphBallBombed,
	SamusPose.standingBombed: SamusPose.standingBombed,
	SamusPose.morphBallBombed: SamusPose.morphBallBombed,
	SamusPose.facingScreen: SamusPose.standingBombed,
	SamusPose.facingScreen2: SamusPose.standing,
	SamusPose.facingScreen3: SamusPose.standing,
	SamusPose.facingScreen4: SamusPose.standing,
	SamusPose.facingScreen5: SamusPose.standing,
	SamusPose.eatenByMetroidQueen: SamusPose.morphBallBombed,
	SamusPose.inMetroidQueenMouth: SamusPose.morphBallBombed,
	SamusPose.swallowedByMetroidQueen: SamusPose.swallowedByMetroidQueen,
	SamusPose.inMetroidQueenStomach: SamusPose.inMetroidQueenStomach,
	SamusPose.escapingMetroidQueen: SamusPose.escapingMetroidQueen,
	SamusPose.escapedMetroidQueen: SamusPose.escapedMetroidQueen,
];

immutable ubyte[2][] samusCannonXOffsetTable = [
	[ 0x00, 0x00 ],
	[ 0x18, 0x1C ],
	[ 0x04, 0x08 ],
	[ 0x10, 0x10 ],
	[ 0x0E, 0x12 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x0D, 0x13 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
	[ 0x10, 0x10 ],
];
immutable ubyte[] samusCannonYOffsetByPose = [
	SamusPose.standing: 0x17,
	SamusPose.jumping: 0x1F,
	SamusPose.spinJumping: 0x00,
	SamusPose.running: 0x14,
	SamusPose.crouching: 0x21,
	SamusPose.morphBall: 0x00,
	SamusPose.morphBallJumping: 0x00,
	SamusPose.falling: 0x1D,
	SamusPose.morphBallFalling: 0x00,
	SamusPose.startingToJump: 0x15,
	SamusPose.startingToSpinJump: 0x15,
	SamusPose.spiderBallRolling: 0x00,
	SamusPose.spiderBallFalling: 0x00,
	SamusPose.spiderBallJumping: 0x00,
	SamusPose.spiderBall: 0x00,
	SamusPose.knockBack: 0x1F,
	SamusPose.morphBallKnockBack: 0x00,
	SamusPose.standingBombed: 0x1F,
	SamusPose.morphBallBombed: 0x00,
];

immutable ubyte[] samusCannonYOffsetByAimDirection = [
    0x00,
    0x00,
    0x00,
    0x00,
    0xF0,
    0x00,
    0x00,
    0x00,
    0x08,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x00,
    0x00,
];

immutable ubyte[] samusShotDirectionPriorityTable = [
    0x00, // ----
    0x01, // ---r
    0x02, // --l-
    0x01, // --lr
    0x04, // -u--
    0x04, // -u-r
    0x04, // -ul-
    0x04, // -ulr
    0x08, // d---
    0x08, // d--r
    0x08, // d-l-
    0x08, // d-lr
    0x08, // du--
    0x08, // du-r
    0x08, // dul-
    0x08, // dulr
];

immutable ubyte[] samusPossibleShotDirections = [
	SamusPose.standing: 0x07,
	SamusPose.jumping: 0x0F,
	SamusPose.spinJumping: 0x00,
	SamusPose.running: 0x07,
	SamusPose.crouching: 0x03,
	SamusPose.morphBall: 0x80,
	SamusPose.morphBallJumping: 0x80,
	SamusPose.falling: 0x0F,
	SamusPose.morphBallFalling: 0x80,
	SamusPose.startingToJump: 0x0F,
	SamusPose.startingToSpinJump: 0x0F,
	SamusPose.spiderBallRolling: 0x80,
	SamusPose.spiderBallFalling: 0x80,
	SamusPose.spiderBallJumping: 0x80,
	SamusPose.spiderBall: 0x80,
	SamusPose.knockBack: 0x0F,
	SamusPose.morphBallKnockBack: 0x80,
	SamusPose.standingBombed: 0x0F,
	SamusPose.morphBallBombed: 0x80,
	SamusPose.facingScreen: 0x00,
	SamusPose.facingScreen2: 0x00,
	SamusPose.facingScreen3: 0x00,
	SamusPose.facingScreen4: 0x00,
	SamusPose.facingScreen5: 0x00,
	SamusPose.eatenByMetroidQueen: 0x00,
	SamusPose.inMetroidQueenMouth: 0x80,
	SamusPose.swallowedByMetroidQueen: 0x00,
	SamusPose.inMetroidQueenStomach: 0x80,
	SamusPose.escapingMetroidQueen: 0x00,
	SamusPose.escapedMetroidQueen: 0x80,
];

void destroyRespawningBlock() {
	int slot;
	for (slot = 0; slot < respawningBlockArray.length; slot++) {
		if (respawningBlockArray[slot].timer == 0) {
			break;
		}
	}
	respawningBlockArray[slot].timer = 1;
	respawningBlockArray[slot].y = tileY;
	respawningBlockArray[slot].x = tileX;
	sfxRequestNoise = NoiseSFX.u04;
}
void handleRespawningBlocks() {
	for (uint i = 0; i < respawningBlockArray.length; i++) {
		if (respawningBlockArray[i].timer == 0) {
			continue;
		}
		respawningBlockArray[i].timer++;
		tileY = respawningBlockArray[i].y;
		if (((tileY - scrollY) & 0xF0) == 0xC0) {
			respawningBlockArray[i].timer = 0;
		}
		tileX = respawningBlockArray[i].x;
		if (((tileX - scrollX) & 0xF0) == 0xD0) {
			respawningBlockArray[i].timer = 0;
		}
		switch (respawningBlockArray[i].timer) {
			case 2: return destroyBlockFrameA();
			case 7: return destroyBlockFrameB();
			case 13: return destroyBlockEmpty();
			case 246: return destroyBlockFrameB();
			case 250: return destroyBlockFrameA();
			case 254: return destroyBlockReform(respawningBlockArray[i].timer);
			default: break;
		}
	}
}
alias destroyBlock = destroyBlockEmpty;
void destroyBlockEmpty() {
	getTilemapAddress();
	tilemapDest &= 0xFFDE; // make sure it's top-left corner
	gb.waitHBlank();
	gb.waitHBlank();
	gb.vram[tilemapDest + 0x00] = 0xFF;
	gb.vram[tilemapDest + 0x01] = 0xFF;
	gb.vram[tilemapDest + 0x20] = 0xFF;
	gb.vram[tilemapDest + 0x21] = 0xFF;
	sfxRequestNoise = NoiseSFX.u04;
}
void destroyBlockReform(ref ubyte timer) {
	timer = 0;
	getTilemapAddress();
	tilemapDest &= 0xFFDE; // make sure it's top-left corner
	gb.waitHBlank();
	gb.waitHBlank();
	gb.vram[tilemapDest + 0x00] = 0x00;
	gb.vram[tilemapDest + 0x01] = 0x01;
	gb.vram[tilemapDest + 0x20] = 0x02;
	gb.vram[tilemapDest + 0x21] = 0x03;
	if (samusInvulnerableTimer) {
		return;
	}
	destroyBlockHurtSamus();
}
void destroyBlockFrameA() {
	getTilemapAddress();
	tilemapDest &= 0xFFDE; // make sure it's top-left corner
	gb.waitHBlank();
	gb.waitHBlank();
	gb.vram[tilemapDest + 0x00] = 0x04;
	gb.vram[tilemapDest + 0x01] = 0x05;
	gb.vram[tilemapDest + 0x20] = 0x06;
	gb.vram[tilemapDest + 0x21] = 0x07;
}
void destroyBlockFrameB() {
	getTilemapAddress();
	tilemapDest &= 0xFFDE; // make sure it's top-left corner
	gb.waitHBlank();
	gb.waitHBlank();
	gb.vram[tilemapDest + 0x00] = 0x08;
	gb.vram[tilemapDest + 0x01] = 0x09;
	gb.vram[tilemapDest + 0x20] = 0x0A;
	gb.vram[tilemapDest + 0x21] = 0x0B;
}
void destroyBlockHurtSamus() {
	if (samusY.pixel + 24 - ((tileY - 16) & 0xF0) >= samusHeightTable[samusPose]) {
		return;
	}
	const x = samusX.pixel + 12 - ((tileX - 8) & 0xF0);
	if (x >= 24) {
		return;
	}
	if (x < 12) {
		samusDamageBoostDirection = 0xFF; // left
	} else {
		samusDamageBoostDirection = 1; // right
	}
	samusHurtFlag = 1;
	samusDamageValue = 2;
	destroyRespawningBlock();
}

immutable ubyte[] samusHeightTable = [
	SamusPose.standing: 0x20,
	SamusPose.jumping: 0x20,
	SamusPose.spinJumping: 0x20,
	SamusPose.running: 0x20,
	SamusPose.crouching: 0x20,
	SamusPose.morphBall: 0x10,
	SamusPose.morphBallJumping: 0x10,
	SamusPose.falling: 0x20,
	SamusPose.morphBallFalling: 0x10,
	SamusPose.startingToJump: 0x20,
	SamusPose.startingToSpinJump: 0x20,
	SamusPose.spiderBallRolling: 0x10,
	SamusPose.spiderBallFalling: 0x10,
	SamusPose.spiderBallJumping: 0x10,
	SamusPose.spiderBall: 0x10,
	SamusPose.knockBack: 0x20,
	SamusPose.morphBallKnockBack: 0x10,
	SamusPose.standingBombed: 0x20,
	SamusPose.morphBallBombed: 0x10,
];

void miscInGameTasks() {
	if (saveMessageCooldownTimer) {
		saveMessageCooldownTimer--;
	}
	if (queenRoomFlag != 0x11) {
		if (!(gb.LCDC & LCDCFlags.windowDisplay)) {
			gb.LCDC = gb.LCDC | LCDCFlags.windowDisplay;
		}
		gb.WY = 0x88;
		if (!saveContactFlag) {
			if (itemCollectedCopy && (itemCollectedCopy < 0xB)) {
				gb.WY = 0x80;
			}
		} else {
			gb.WY = 0x80;
			if (inputRisingEdge & Pad.start) {
				gameMode = GameMode.saveGame;
				saveMessageCooldownTimer = 0xFF;
			}
			if (saveMessageCooldownTimer) {
				spriteYPixel = 0x98;
				spriteXPixel = 0x44;
				spriteID = 0x43;
				drawSamusSprite();
			} else {
				saveContactFlag = 0;
				if (frameCounter & 8) {
					spriteYPixel = 0x98;
					spriteXPixel = 0x44;
					spriteID = 0x42;
					drawSamusSprite();
				}
			}
		}
	}
	if ((frameCounter == 0) && nextEarthquakeTimer && --nextEarthquakeTimer) {
		earthquakeTimer = 0xFF;
		songInterruptionRequest = Song2.earthquake;
		if (metroidCountReal == 1) {
			earthquakeTimer = 0x60;
		}
	}
	if ((samusPose == SamusPose.facingScreen) && (countdownTimer == 0)) {
		if (samusCurHealth < 50) {
			if (samusCurHealth != samusPrevHealth) {
				samusPrevHealth = samusCurHealth;
				sfxRequestLowHealthBeep = ((samusCurHealth % 100) / 10) + 1;
			}
		} else if (!sfxRequestLowHealthBeep) {
			sfxRequestLowHealthBeep = 0xFF;
		}
	}
	if (fadeInTimer) {
		fadeIn();
	}
	if (soundPlayQueenRoar && ((frameCounter & 0x7F) == 0)) {
		sfxRequestNoise = NoiseSFX.u17;
	}
}

immutable ubyte[16][] itemTextPointerTable = [
	fixItemName(" SAVE<>         "),
	fixItemName("     PLASMA BEAM"),
	fixItemName("      ICE BEAM  "),
	fixItemName("     WAVE BEAM  "),
	fixItemName("      SPAZER    "),
	fixItemName("        BOMB    "),
	fixItemName("    SCREW ATTACK"),
	fixItemName("      VARIA     "),
	fixItemName(" HIGH JUMP BOOTS"),
	fixItemName("     SPACE JUMP "),
	fixItemName("    SPIDER BALL "),
	fixItemName("   SPRING BALL  "),
	fixItemName("    ENERGY TANK "),
	fixItemName("    MISSILE TANK"),
	fixItemName("       ENERGY   "),
	fixItemName("      MISSILES  "),
];

void drawEnemies() {
	if (numEnemies.active == 0) {
		return;
	}
	for (int i = 0; i < enemyDataSlots.length; i++) {
		drawEnemy = &enemyDataSlots[i];
		if (enemyDataSlots[i].status == 0) {
			drawEnemySprite(&enemyDataSlots[i]);
		}
	}
}
void drawEnemySprite(EnemySlot* enemy) {
	version(original) {} else {
		// original did no bounds checking
		if (oamBufferIndex >= oamBuffer.length) {
			return;
		}
	}
	drawEnemySpriteGetInfo(enemy);
	auto sprite = (enemySpriteTable[drawEnemySpr] == null) ? &enSpriteBlobThrower[0] : &enemySpriteTable[drawEnemySpr][0];
	auto dest = &oamBuffer[oamBufferIndex];
	while (true) {
		if (sprite.y == metaSpriteEnd) {
			break;
		}
		byte y = sprite.y;
		if (drawEnemyAttr & OAMFlags.yFlip) {
			y = cast(byte)(-sprite.y - 8);
		}
		dest.y = cast(ubyte)(y + drawEnemyYPos);

		byte x = sprite.x;
		if (drawEnemyAttr & OAMFlags.xFlip) {
			x = cast(byte)(-sprite.x - 8);
		}
		dest.x = cast(ubyte)(x + drawEnemyXPos);
		dest.tile = sprite.tile;
		dest.flags = drawEnemyAttr ^ sprite.flags;
		oamBufferIndex++;
		sprite++;
		dest++;
	}
}
void drawEnemySpriteGetInfo(EnemySlot* enemy) {
	drawEnemyYPos = enemy.y;
	drawEnemyXPos = enemy.x;
	drawEnemySpr = enemy.spriteType;
	drawEnemyAttr = (enemy.baseSpriteAttributes ^ enemy.spriteAttributes ^ enemy.stunCounter) & 0xF0;
}

void alphaGetAngle() {
	metroidGetDistanceAndDirection();
	alphaGetAngleFromTable();
}

void metroidGetDistanceAndDirection() {
	byte distance;
	ubyte direction;
	distance = cast(byte)(samusOnScreenYPos - (enemyWorking.y + 16));
	if (distance == 0) {
		direction = 0;
	} else if (distance > 0) {
		direction = 1;
	} else if (distance < 0) {
		distance = cast(byte)-distance;
		direction = 0xFF;
	}
	metroidAbsSamusDistY = distance;
	metroidSamusYDir = direction;

	distance = cast(byte)(samusOnScreenXPos - (enemyWorking.x + 16));
	if (distance == 0) {
		direction = 0;
	} else if (distance > 0) {
		direction = 1;
	} else if (distance < 0) {
		distance = cast(byte)-distance;
		direction = 0xFF;
	}
	metroidAbsSamusDistX = distance;
	metroidSamusXDir = direction;
}
void alphaGetAngleFromTable() {
	static immutable ubyte[] angleTable = [
		0x00, 0x01, 0x02, 0x03,
		0x00, 0x04, 0x05, 0x06, 0x02,
		0x01, 0x07, 0x08, 0x09, 0x02,
		0x00, 0x0A, 0x0B, 0x0C, 0x03,
		0x01, 0x0D, 0x0E, 0x0F, 0x03,
	];
	if (metroidSamusXDir == 0) {
		if (metroidSamusYDir != 1) {
			enemyWorking.state = angleTable[3];
		} else {
			enemyWorking.state = angleTable[2];
		}
	}
	if (metroidSamusYDir == 0) {
		if (metroidSamusXDir != 1) {
			enemyWorking.state = angleTable[1];
		} else {
			enemyWorking.state = angleTable[0];
		}
	}
	if (metroidSamusYDir != 0xFF) {
		if (metroidSamusXDir != 0xFF) {
			metroidAngleTableIndex = 4;
		} else {
			metroidAngleTableIndex = 9;
		}
	} else {
		if (metroidSamusXDir != 0xFF) {
			metroidAngleTableIndex = 14;
		} else {
			metroidAngleTableIndex = 19;
		}
	}
	metroidGetSlopeToSamus();
	alphaConvertSlopeToAngleIndex();
	enemyWorking.state = angleTable[metroidAngleTableIndex];
}

void metroidGetSlopeToSamus() {
	metroidSlopeToSamus = cast(ushort)((metroidAbsSamusDistY * 100) / metroidAbsSamusDistX);
}

void alphaConvertSlopeToAngleIndex() {
	if (metroidSlopeToSamus < 20) {
		metroidAngleTableIndex += 0;
	} else if (metroidSlopeToSamus < 60) {
		metroidAngleTableIndex += 1;
	} else if (metroidSlopeToSamus < 200) {
		metroidAngleTableIndex += 2;
	} else if (metroidSlopeToSamus < 600) {
		metroidAngleTableIndex += 3;
	} else if (metroidSlopeToSamus >= 600) {
		metroidAngleTableIndex += 4;
	}
}

ushort alphaGetSpeedVector() {
	switch (enemyWorking.state) {
		case 0: return 0x0003;
		case 1: return 0x0083;
		case 2: return 0x0300;
		case 3: return 0x8300;
		case 4: return 0x0103;
		case 5: return 0x0202;
		case 6: return 0x0301;
		case 7: return 0x0183;
		case 8: return 0x0282;
		case 9: return 0x0381;
		case 10: return 0x8103;
		case 11: return 0x8202;
		case 12: return 0x8301;
		case 13: return 0x8183;
		case 14: return 0x8282;
		case 15: return 0x8381;
		default: assert(0);
	}
}

void drawNonGameSprite() {
	version(original) {} else {
		// original did no bounds checking
		if (oamBufferIndex >= oamBuffer.length) {
			return;
		}
	}
	auto de = &creditsSpritePointerTable[spriteID][0];
	auto hl = &oamBuffer[oamBufferIndex];
	auto b = spriteYPixel;
	auto c = spriteXPixel;
	while (true) {
		if (de.y == metaSpriteEnd) {
			break;
		}
		byte y = de.y;
		if (spriteAttr & OAMFlags.yFlip) {
			y = cast(byte)(-y - 8);
		}
		hl.y = cast(ubyte)(y + spriteYPixel);
		byte x = de.x;
		if (spriteAttr & OAMFlags.xFlip) {
			x = cast(byte)(-x - 8);
		}
		hl.x = cast(ubyte)(x + spriteXPixel);
		hl.tile = de.tile;
		hl.flags = spriteAttr ^ de.flags;
		oamBufferIndex++;
		de++;
		hl++;
	}
}
immutable OAMEntry[][] creditsSpritePointerTable = [
	[
		OAMEntry(0,  0, 0xF1, 0x00),
		OAMEntry(0,  8, 0xF2, 0x00),
		OAMEntry(0, 16, 0xF3, 0x00),
		OAMEntry(0, 24, 0xF4, 0x00),
		OAMEntry(0, 32, 0xF5, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xF6, 0x00),
		OAMEntry(0,  8, 0xF7, 0x00),
		OAMEntry(0, 16, 0xF8, 0x00),
		OAMEntry(0, 24, 0xF9, 0x00),
		OAMEntry(0, 32, 0xFA, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xED, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xEE, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xEF, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xF0, 0x00),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xEF, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-24,-20, 0x53, 0x80),
		OAMEntry(-24,-12, 0x54, 0x80),
		OAMEntry(-24, -4, 0x55, 0x80),
		OAMEntry(-24,  4, 0x56, 0x80),
		OAMEntry(-24, 12, 0x57, 0x80),
		OAMEntry(-16,-20, 0x58, 0x80),
		OAMEntry(-16,-12, 0x59, 0x80),
		OAMEntry(-16, -4, 0x5A, 0x80),
		OAMEntry(-16,  4, 0x5B, 0x80),
		OAMEntry(-16, 12, 0x5C, 0x80),
		OAMEntry(-8,-16, 0x5D, 0x80),
		OAMEntry(-8, -8, 0x5E, 0x80),
		OAMEntry(-8,  0, 0x5F, 0x80),
		OAMEntry(-8,  8, 0x60, 0x80),
		OAMEntry(0,-20, 0x61, 0x80),
		OAMEntry(0,-12, 0x62, 0x80),
		OAMEntry(0, -4, 0x63, 0x80),
		OAMEntry(0,  4, 0x64, 0x80),
		OAMEntry(0, 12, 0x65, 0x80),
		OAMEntry(8,-20, 0x66, 0x80),
		OAMEntry(8,-12, 0x67, 0x80),
		OAMEntry(8, -4, 0x68, 0x80),
		OAMEntry(8,  4, 0x69, 0x80),
		OAMEntry(8, 12, 0x6A, 0x80),
		OAMEntry(16,-20, 0x6B, 0x80),
		OAMEntry(16,-12, 0x6C, 0x80),
		OAMEntry(16, -4, 0x6D, 0x80),
		OAMEntry(16,  4, 0x6E, 0x80),
		OAMEntry(24,-12, 0x6F, 0x80),
		OAMEntry(24,  3, 0x6F, 0xA0),
		OAMEntry(32,-12, 0x70, 0x80),
		OAMEntry(32,  3, 0x70, 0xA0),
		OAMEntry(40,-20, 0x71, 0x80),
		OAMEntry(40,-12, 0x72, 0x80),
		OAMEntry(40,  3, 0x72, 0xA0),
		OAMEntry(40, 11, 0x71, 0xA0),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-24,-20, 0x00, 0x80),
		OAMEntry(-24,-12, 0x01, 0x80),
		OAMEntry(-24, -4, 0x02, 0x80),
		OAMEntry(-24,  4, 0x03, 0x80),
		OAMEntry(-24, 12, 0x04, 0x80),
		OAMEntry(-16,-20, 0x05, 0x80),
		OAMEntry(-16,-12, 0x06, 0x80),
		OAMEntry(-16, -4, 0x07, 0x80),
		OAMEntry(-16,  4, 0x08, 0x80),
		OAMEntry(-16, 12, 0x09, 0x80),
		OAMEntry(-8,-20, 0x0A, 0x80),
		OAMEntry(-8,-12, 0x0B, 0x80),
		OAMEntry(-8, -4, 0x0C, 0x80),
		OAMEntry(-8,  4, 0x0D, 0x80),
		OAMEntry(-8, 12, 0x0E, 0x80),
		OAMEntry(0, 12, 0x12, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-24,-20, 0x1A, 0x80),
		OAMEntry(-24,-12, 0x1B, 0x80),
		OAMEntry(-24, -4, 0x1C, 0x80),
		OAMEntry(-24,  4, 0x1D, 0x80),
		OAMEntry(-24, 12, 0x1E, 0x80),
		OAMEntry(-16,-20, 0x1F, 0x80),
		OAMEntry(-16,-12, 0x20, 0x80),
		OAMEntry(-16, -4, 0x21, 0x80),
		OAMEntry(-16,  4, 0x22, 0x80),
		OAMEntry(-16, 12, 0x23, 0x80),
		OAMEntry(-8,-20, 0x24, 0x80),
		OAMEntry(-8,-12, 0x25, 0x80),
		OAMEntry(-8, -4, 0x26, 0x80),
		OAMEntry(-8,  4, 0x27, 0x80),
		OAMEntry(-8, 12, 0x28, 0x80),
		OAMEntry(0,-20, 0x29, 0x80),
		OAMEntry(0,-12, 0x2A, 0x80),
		OAMEntry(0, -4, 0x2B, 0x80),
		OAMEntry(0,  4, 0x2C, 0x80),
		OAMEntry(0, 12, 0x2D, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-24,-20, 0x35, 0x80),
		OAMEntry(-24,-12, 0x36, 0x80),
		OAMEntry(-24, -4, 0x37, 0x80),
		OAMEntry(-24,  4, 0x38, 0x80),
		OAMEntry(-24, 12, 0x39, 0x80),
		OAMEntry(-16,-20, 0x3A, 0x80),
		OAMEntry(-16,-12, 0x3B, 0x80),
		OAMEntry(-16, -4, 0x3C, 0x80),
		OAMEntry(-16,  4, 0x3D, 0x80),
		OAMEntry(-16, 12, 0x3E, 0x80),
		OAMEntry(-8,-20, 0x3F, 0x80),
		OAMEntry(-8,-12, 0x40, 0x80),
		OAMEntry(-8, -4, 0x41, 0x80),
		OAMEntry(-8,  4, 0x42, 0x80),
		OAMEntry(-8, 12, 0x43, 0x80),
		OAMEntry(0,-20, 0x44, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,-12, 0x0F, 0x80),
		OAMEntry(0, -4, 0x10, 0x80),
		OAMEntry(0,  4, 0x11, 0x80),
		OAMEntry(8, -8, 0x13, 0x80),
		OAMEntry(8,  0, 0x14, 0x80),
		OAMEntry(16, -8, 0x15, 0x80),
		OAMEntry(16,  0, 0x16, 0x80),
		OAMEntry(24,  0, 0x17, 0x80),
		OAMEntry(32,  0, 0x18, 0x80),
		OAMEntry(40, -1, 0x19, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(8,-12, 0x2E, 0x80),
		OAMEntry(8, -4, 0x2F, 0x80),
		OAMEntry(8,  4, 0x30, 0x80),
		OAMEntry(16, -8, 0x31, 0x80),
		OAMEntry(16,  0, 0x32, 0x80),
		OAMEntry(24, -1, 0x33, 0x80),
		OAMEntry(32, -1, 0x34, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,  0, 0xEF, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32, -8, 0xAA, 0x80),
		OAMEntry(-32,  0, 0xAB, 0x80),
		OAMEntry(-24, -8, 0xAC, 0x80),
		OAMEntry(-24,  0, 0xAD, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-16, 0xAE, 0x80),
		OAMEntry(-16, -8, 0xAF, 0x80),
		OAMEntry(-8,-16, 0xB2, 0x80),
		OAMEntry(-8, -8, 0xB3, 0x80),
		OAMEntry(0,-16, 0xB6, 0x80),
		OAMEntry(8,-16, 0xBA, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,  0, 0xB0, 0x80),
		OAMEntry(-16,  8, 0xB1, 0x80),
		OAMEntry(-8,  0, 0xB4, 0x80),
		OAMEntry(-8,  8, 0xB5, 0x80),
		OAMEntry(0, -8, 0xB7, 0x80),
		OAMEntry(0,  0, 0xB8, 0x80),
		OAMEntry(0,  8, 0xB9, 0x80),
		OAMEntry(8, -8, 0xBB, 0x80),
		OAMEntry(8,  0, 0xBC, 0x80),
		OAMEntry(8,  8, 0xBD, 0x80),
		OAMEntry(16, -8, 0xBE, 0x80),
		OAMEntry(16,  0, 0xBF, 0x80),
		OAMEntry(24, -5, 0xC0, 0x80),
		OAMEntry(24,  3, 0xC1, 0x80),
		OAMEntry(32, -5, 0xC2, 0x80),
		OAMEntry(32,  3, 0xC3, 0x80),
		OAMEntry(40, -8, 0xC4, 0x80),
		OAMEntry(40,  0, 0xC5, 0x80),
		OAMEntry(40,  8, 0xC6, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0, -8, 0x90, 0x80),
		OAMEntry(0,  0, 0x91, 0x80),
		OAMEntry(8, -8, 0x92, 0x80),
		OAMEntry(8,  0, 0x93, 0x80),
		OAMEntry(8,  8, 0x94, 0x80),
		OAMEntry(8, 16, 0x95, 0x80),
		OAMEntry(16,-16, 0x96, 0x80),
		OAMEntry(16, -8, 0x97, 0x80),
		OAMEntry(16,  0, 0x98, 0x80),
		OAMEntry(16,  8, 0x99, 0x80),
		OAMEntry(16, 16, 0x9A, 0x80),
		OAMEntry(24,-24, 0x9B, 0x80),
		OAMEntry(24,-16, 0x9C, 0x80),
		OAMEntry(24, -8, 0x9D, 0x80),
		OAMEntry(24,  0, 0x9E, 0x80),
		OAMEntry(24,  8, 0x9F, 0x80),
		OAMEntry(24, 18, 0xA0, 0x80),
		OAMEntry(32,-24, 0xA1, 0x80),
		OAMEntry(32,-16, 0xA2, 0x80),
		OAMEntry(32, -8, 0xA3, 0x80),
		OAMEntry(32,  0, 0xA4, 0x80),
		OAMEntry(32,  8, 0xA5, 0x80),
		OAMEntry(40,-16, 0xA6, 0x80),
		OAMEntry(40, -8, 0xA7, 0x80),
		OAMEntry(40,  0, 0xA8, 0x80),
		OAMEntry(40,  8, 0xA9, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0,-20, 0x53, 0x80),
		OAMEntry(0,-12, 0x54, 0x80),
		OAMEntry(0, -4, 0x55, 0x80),
		OAMEntry(0,  4, 0x56, 0x80),
		OAMEntry(0, 12, 0x57, 0x80),
		OAMEntry(8,-20, 0x73, 0x80),
		OAMEntry(8,-12, 0x74, 0x80),
		OAMEntry(8, -4, 0x75, 0x80),
		OAMEntry(8,  4, 0x76, 0x80),
		OAMEntry(8, 12, 0x77, 0x80),
		OAMEntry(16,-20, 0x78, 0x80),
		OAMEntry(16,-12, 0x79, 0x80),
		OAMEntry(16, -4, 0x7A, 0x80),
		OAMEntry(16,  4, 0x7B, 0x80),
		OAMEntry(16, 12, 0x7C, 0x80),
		OAMEntry(16, 20, 0x7D, 0x80),
		OAMEntry(24,-28, 0x7E, 0x80),
		OAMEntry(24,-20, 0x7F, 0x80),
		OAMEntry(24,-12, 0x80, 0x80),
		OAMEntry(24, -4, 0x81, 0x80),
		OAMEntry(24,  4, 0x82, 0x80),
		OAMEntry(24, 12, 0x83, 0x80),
		OAMEntry(24, 20, 0x84, 0x80),
		OAMEntry(32,-28, 0x85, 0x80),
		OAMEntry(32,-20, 0x86, 0x80),
		OAMEntry(32,-12, 0x87, 0x80),
		OAMEntry(32, -4, 0x88, 0x80),
		OAMEntry(32,  4, 0x89, 0x80),
		OAMEntry(32, 12, 0x8A, 0x80),
		OAMEntry(40,-20, 0x8B, 0x80),
		OAMEntry(40,-12, 0x8C, 0x80),
		OAMEntry(40, -4, 0x8D, 0x80),
		OAMEntry(40,  4, 0x8E, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-24, 0xC7, 0x80),
		OAMEntry(-16,-16, 0xC8, 0x80),
		OAMEntry(-16, -8, 0xC9, 0x80),
		OAMEntry(-8,-16, 0xCA, 0x80),
		OAMEntry(-8, -8, 0xCB, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32,-16, 0xCC, 0x80),
		OAMEntry(-32, -8, 0xCD, 0x80),
		OAMEntry(-32,  0, 0xAB, 0x80),
		OAMEntry(-24,-16, 0xCE, 0x80),
		OAMEntry(-24, -8, 0xCF, 0x80),
		OAMEntry(-24,  0, 0xAD, 0x80),
		OAMEntry(-16,-16, 0xD0, 0x80),
		OAMEntry(-16, -8, 0xD1, 0x80),
		OAMEntry(-8, -8, 0xD2, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32, -8, 0xE3, 0x80),
		OAMEntry(-32,  0, 0xE4, 0x80),
		OAMEntry(-24, -8, 0xE5, 0x80),
		OAMEntry(-24,  0, 0xE6, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32, -8, 0xE7, 0x80),
		OAMEntry(-32,  0, 0xE8, 0x80),
		OAMEntry(-24, -8, 0xE9, 0x80),
		OAMEntry(-24,  0, 0xEA, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32,-16, 0xD4, 0x80),
		OAMEntry(-32, -8, 0xD5, 0x80),
		OAMEntry(-32,  0, 0xD6, 0x80),
		OAMEntry(-24,-16, 0xD7, 0x80),
		OAMEntry(-24, -8, 0xD8, 0x80),
		OAMEntry(-24,  0, 0xD9, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32, -8, 0xDA, 0x80),
		OAMEntry(-32,  0, 0xDB, 0x80),
		OAMEntry(-24,-16, 0xDC, 0x80),
		OAMEntry(-24, -8, 0xDD, 0x80),
		OAMEntry(-24,  0, 0xDE, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32, -8, 0xDF, 0x80),
		OAMEntry(-32,  0, 0xE0, 0x80),
		OAMEntry(-24, -8, 0xE1, 0x80),
		OAMEntry(-24,  0, 0xE2, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-32, -8, 0xDA, 0x80),
		OAMEntry(-32,  0, 0xDB, 0x80),
		OAMEntry(-24,-16, 0xEB, 0x80),
		OAMEntry(-24, -8, 0xEC, 0x80),
		OAMEntry(-24,  0, 0xED, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -4, 0xEE, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-4, -4, 0xEF, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-8,-16, 0xF0, 0x80),
		OAMEntry(-8, -8, 0xF1, 0x80),
		OAMEntry(-8,  0, 0xF2, 0x80),
		OAMEntry(0,-16, 0xF6, 0x80),
		OAMEntry(0, -8, 0xF7, 0x80),
		OAMEntry(0,  0, 0xF8, 0x80),
		OAMEntry(0,  8, 0xF9, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-8,-16, 0xF3, 0x80),
		OAMEntry(-8, -8, 0xF4, 0x80),
		OAMEntry(-8,  8, 0xF5, 0x80),
		OAMEntry(0,-16, 0xFA, 0x80),
		OAMEntry(0, -8, 0xFB, 0x80),
		OAMEntry(0,  0, 0xFC, 0x80),
		OAMEntry(0,  8, 0xFD, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-16, 0x45, 0x80),
		OAMEntry(-16, -8, 0x46, 0x80),
		OAMEntry(-16,  0, 0x46, 0xA0),
		OAMEntry(-16,  8, 0x45, 0xA0),
		OAMEntry(-8,-16, 0x47, 0x80),
		OAMEntry(-8, -8, 0x48, 0x80),
		OAMEntry(-8,  0, 0x48, 0xA0),
		OAMEntry(-8,  8, 0x47, 0xA0),
		OAMEntry(0,-16, 0x49, 0x80),
		OAMEntry(0, -8, 0x4A, 0x80),
		OAMEntry(0,  0, 0x4A, 0xA0),
		OAMEntry(0,  8, 0x49, 0xA0),
		OAMEntry(8,-16, 0x4B, 0x80),
		OAMEntry(8, -8, 0x4C, 0x80),
		OAMEntry(8,  0, 0x4C, 0xA0),
		OAMEntry(8,  8, 0x4B, 0xA0),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-16, 0x4D, 0x80),
		OAMEntry(-16, -8, 0x4E, 0x80),
		OAMEntry(-16,  0, 0x4E, 0xA0),
		OAMEntry(-16,  8, 0x4D, 0xA0),
		OAMEntry(-8,-16, 0x4F, 0x80),
		OAMEntry(-8, -8, 0x50, 0x80),
		OAMEntry(-8,  0, 0x50, 0xA0),
		OAMEntry(-8,  8, 0x4F, 0xA0),
		OAMEntry(0,-16, 0x4F, 0xC0),
		OAMEntry(0, -8, 0x50, 0xC0),
		OAMEntry(0,  0, 0x50, 0xE0),
		OAMEntry(0,  8, 0x4F, 0xE0),
		OAMEntry(8,-16, 0x4B, 0x80),
		OAMEntry(8, -8, 0x4C, 0x80),
		OAMEntry(8,  0, 0x4C, 0xA0),
		OAMEntry(8,  8, 0x4B, 0xA0),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-16, 0x4B, 0xC0),
		OAMEntry(-16, -8, 0x4C, 0xC0),
		OAMEntry(-16,  0, 0x4C, 0xE0),
		OAMEntry(-16,  8, 0x4B, 0xE0),
		OAMEntry(-8,-16, 0x49, 0xC0),
		OAMEntry(-8, -8, 0x4A, 0xC0),
		OAMEntry(-8,  0, 0x4A, 0xE0),
		OAMEntry(-8,  8, 0x49, 0xE0),
		OAMEntry(0,-16, 0x47, 0xC0),
		OAMEntry(0, -8, 0x48, 0xC0),
		OAMEntry(0,  0, 0x48, 0xE0),
		OAMEntry(0,  8, 0x47, 0xE0),
		OAMEntry(8,-16, 0x45, 0xC0),
		OAMEntry(8, -8, 0x46, 0xC0),
		OAMEntry(8,  0, 0x46, 0xE0),
		OAMEntry(8,  8, 0x45, 0xE0),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(-16,-16, 0x4B, 0xC0),
		OAMEntry(-16, -8, 0x4C, 0xC0),
		OAMEntry(-16,  0, 0x4C, 0xE0),
		OAMEntry(-16,  8, 0x4B, 0xE0),
		OAMEntry(-8,-16, 0x49, 0xC0),
		OAMEntry(-8, -8, 0x4A, 0xC0),
		OAMEntry(-8,  0, 0x4A, 0xE0),
		OAMEntry(-8,  8, 0x49, 0xE0),
		OAMEntry(0,-16, 0x49, 0x80),
		OAMEntry(0, -8, 0x4A, 0x80),
		OAMEntry(0,  0, 0x4A, 0xA0),
		OAMEntry(0,  8, 0x49, 0xA0),
		OAMEntry(8,-16, 0x4B, 0x80),
		OAMEntry(8, -8, 0x4C, 0x80),
		OAMEntry(8,  0, 0x4C, 0xA0),
		OAMEntry(8,  8, 0x4B, 0xA0),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0, 54, 0xFB, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0, 54, 0xFC, 0x80),
		OAMEntry(metaSpriteEnd),
	], [
		OAMEntry(0, 54, 0xFD, 0x80),
		OAMEntry(metaSpriteEnd),
	]
];

void earthquakeAdjustScroll() {
	if (!earthquakeTimer) {
		return;
	}
	scrollY += (earthquakeTimer & 2) - 1;
	if (frameCounter & 1) {
		return;
	}
	if (--earthquakeTimer) {
		return;
	}
	songInterruptionRequest = Song2.nothing;
	if (queenRoomFlag < 0x10) {
		if (songRequestAfterEarthquake) {
			songRequest = songRequestAfterEarthquake;
			currentRoomSong = songRequestAfterEarthquake;
			songRequestAfterEarthquake = Song.nothing;
		} else {
			songInterruptionRequest = Song2.endRequest;
		}
	} else {
		songRequest = Song.babyMetroid; // THE BABY
	}
}

void drawSamusEarthquakeAdjustment() {
	if (earthquakeTimer == 0) {
		return;
	}
	spriteYPixel += ((earthquakeTimer & 4) >> 1) - 1;
}

void fadeIn() {
	bgPalette = fadeTable[(fadeInTimer & 0xF0) >> 4];
	obPalette0 = fadeTable[(fadeInTimer & 0xF0) >> 4];
	if (--fadeInTimer >= 0xE) {
		return;
	}
	fadeInTimer = 0;
}

immutable ubyte[] fadeTable = [0x93, 0xE7, 0xFB];

void saveEnemyFlagsToSRAM() {
	for (int i = 0; i < enemySpawnFlagsSaved.length; i++) {
		ubyte value = enemySpawnFlagsSaved[i];
		switch (value) {
			case 4:
				value = 0xFE;
				goto case;
			case 2:
			case 0xFE:
				saveBuf.enemySpawnFlags[previousLevelBank - 9][i] = value;
				break;
			default: break;
		}
	}
	enableSRAM();
	sram.saves[activeSaveSlot].data.enemySpawnFlags = saveBuf.enemySpawnFlags;
	disableSRAM();
}
void loadEnemySaveFlags() {
	enableSRAM();
	saveBuf.enemySpawnFlags = sram.saves[activeSaveSlot].data.enemySpawnFlags;
	disableSRAM();
}

void handleSaveGame() {
	enableSRAM();
	sram.saves[activeSaveSlot].magic[] = saveMagic;
	sram.saves[activeSaveSlot].data.samusY = samusY;
	sram.saves[activeSaveSlot].data.samusX = samusX;
	sram.saves[activeSaveSlot].data.cameraY = cameraY;
	sram.saves[activeSaveSlot].data.cameraX = cameraX;
	sram.saves[activeSaveSlot].data.enGfxID = saveBuf.enGfxID;
	sram.saves[activeSaveSlot].data.bgGfxID = saveBuf.bgGfxID;
	sram.saves[activeSaveSlot].data.tiletableID = saveBuf.tiletableID;
	sram.saves[activeSaveSlot].data.collisionID = saveBuf.collisionID;
	sram.saves[activeSaveSlot].data.currentLevelBank = saveBuf.currentLevelBank;
	sram.saves[activeSaveSlot].data.samusSolidityIndex = saveBuf.samusSolidityIndex;
	sram.saves[activeSaveSlot].data.enemySolidityIndex = saveBuf.enemySolidityIndex;
	sram.saves[activeSaveSlot].data.beamSolidityIndex = saveBuf.beamSolidityIndex;
	sram.saves[activeSaveSlot].data.samusItems = samusItems;
	sram.saves[activeSaveSlot].data.samusBeam = samusBeam;
	sram.saves[activeSaveSlot].data.samusEnergyTanks = samusEnergyTanks;
	sram.saves[activeSaveSlot].data.samusHealth = samusCurHealth;
	sram.saves[activeSaveSlot].data.samusMaxMissiles = samusMaxMissiles;
	sram.saves[activeSaveSlot].data.samusCurMissiles = samusCurMissiles;
	sram.saves[activeSaveSlot].data.samusFacingDirection = samusFacingDirection;
	sram.saves[activeSaveSlot].data.acidDamageValue = acidDamageValue;
	sram.saves[activeSaveSlot].data.spikeDamageValue = spikeDamageValue;
	sram.saves[activeSaveSlot].data.metroidCountReal = metroidCountReal;
	sram.saves[activeSaveSlot].data.currentRoomSong = currentRoomSong;
	sram.saves[activeSaveSlot].data.gameTimeMinutes = gameTimeMinutes;
	sram.saves[activeSaveSlot].data.gameTimeHours = gameTimeHours;
	sram.saves[activeSaveSlot].data.metroidCountDisplayed = metroidCountDisplayed;
	disableSRAM();
	saveEnemyFlagsToSRAM();
	sfxRequestSquare1 = Square1SFX.saved;
	sfxRequestSquare1 = Square1SFX.saved;
	gameMode = GameMode.main;
}
