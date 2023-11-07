module metroid2.bank01;

import metroid2.bank00;
import metroid2.defs;
import metroid2.external;
import metroid2.globals;
import metroid2.registers;
import metroid2.sram;
import libgb;

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
		hudTanks[0 .. samusEnergyTanks] = 0x9C;
		if (samusDispHealth >= 100) {
			hudTanks[0 .. samusDispHealth / 100] = 0x9D;
		}
	} else {
		hudTanks[0] = 0xAA; // E
	}
	const hudBase = (queenRoomFlag == 0x11) ? VRAMDest.queenStatusBar : VRAMDest.statusBar;
	vram()[hudBase + 0] = hudTanks[4];
	vram()[hudBase + 1] = hudTanks[3];
	vram()[hudBase + 2] = hudTanks[2];
	vram()[hudBase + 3] = hudTanks[1];
	vram()[hudBase + 4] = hudTanks[0];
	vram()[hudBase + 5] = 0x9E;
	vram()[hudBase + 6] = ((samusDispHealth % 100) / 10) + 0xA0;
	vram()[hudBase + 7] = (samusDispHealth % 10) + 0xA0;
	vram()[hudBase + 11] = ((samusDispMissiles % 1000) / 100) + 0xA0;
	vram()[hudBase + 12] = ((samusDispMissiles % 100) / 10) + 0xA0;
	vram()[hudBase + 13] = (samusDispMissiles % 10) + 0xA0;
	if (gameMode != GameMode.paused) {
		if (metroidCountShuffleTimer == 0) {
			vram()[hudBase + 18] = ((metroidCountDisplayed % 100) / 10) + 0xA0;
			vram()[hudBase + 19] = (metroidCountDisplayed % 10) + 0xA0;
		} else if (metroidCountShuffleTimer < 0x80) {
			vram()[hudBase + 18] = ((frameCounter % 100) / 10) + 0xA0;
			vram()[hudBase + 19] = (frameCounter % 10) + 0xA0;
		}
	} else if (metroidLCounterDisp) {
		vram()[hudBase + 18] = ((metroidLCounterDisp % 100) / 10) + 0xA0;
		vram()[hudBase + 19] = (metroidLCounterDisp % 10) + 0xA0;
	} else {
		vram()[hudBase + 18] = 0x9E;
		vram()[hudBase + 19] = 0x9E;
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
void debugDrawNumber() {
	assert(0);
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
	auto de = &samusSpriteTable[spriteID][0];
	auto hl = &oamBuffer[oamBufferIndex / 4];
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
		oamBufferIndex += 4;
		de++;
		hl++;
	}
}
void clearUnusedOAMSlots() {
	if (oamBufferIndex < maxOAMPrevFrame) {
		for (int i = oamBufferIndex / 4; i < maxOAMPrevFrame / 4; i++) {
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
		return;
	}
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
	loadScreenSpritePriorityBit();
	spriteXPixel = cast(ubyte)(samusX.pixel - cameraX.pixel + 0x60);
	spriteYPixel = cast(ubyte)(samusY.pixel - cameraY.pixel + 0x62);
	spriteAttr = 0;
	if (acidContactFlag || samusInvulnerableTimer) {
		spriteAttr = 1;
	}
	//drawSamusEarthquakeAdjustment();
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
	0x00,
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

Projectile* getFirstEmptyProjectileSlot() {
	assert(0);
}

void handleProjectiles() {
	//assert(0);
}

void drawProjectiles() {
	projectileIndex = 0;
	while (projectileIndex < 3) {
		if (projectileArray[projectileIndex].type != ProjectileType.invalid) {
			spriteYPixel = projectileArray[projectileIndex].y;
			spriteXPixel = projectileArray[projectileIndex].x;
			spriteAttr = 0;
			if (projectileArray[projectileIndex].type == ProjectileType.missile) {
				spriteID = missileSpriteTileTable[projectileArray[projectileIndex].direction];
				spriteAttr = missileSpriteAttributeTable[projectileArray[projectileIndex].direction];
			} else {
				spriteID = 0x7E;
				if (!(projectileArray[projectileIndex].direction & 3)) {
					spriteID = 0x7F;
				}
			}
			if ((spriteXPixel >= 8) && (spriteXPixel < 164) && (spriteYPixel >= 12) && (spriteYPixel < 148)) {
				oamBuffer[oamBufferIndex].y = spriteYPixel;
				oamBuffer[oamBufferIndex].x = spriteXPixel;
				oamBuffer[oamBufferIndex].tile = spriteID;
				oamBuffer[oamBufferIndex].flags = spriteAttr;
				oamBufferIndex += 4;
				spriteAttr = 0;
			} else {
				projectileArray[projectileIndex].type = ProjectileType.invalid;
			}
		}
	}
}
immutable ubyte[] missileSpriteTileTable = [0x00, 0x98, 0x98, 0x00, 0x99, 0x00, 0x00, 0x00, 0x99];
immutable ubyte[] missileSpriteAttributeTable = [0x00, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x40];

void miscInGameTasks() {
	if (saveMessageCooldownTimer) {
		saveMessageCooldownTimer--;
	}
	if (queenRoomFlag != 0x11) {
		if (!(LCDC & LCDCFlags.windowDisplay)) {
			LCDC |= LCDCFlags.windowDisplay;
		}
		WY = 0x88;
		if (!saveContactFlag) {
			if (itemCollectedCopy && (itemCollectedCopy < 0xB)) {
				WY = 0x80;
			}
		} else {
			WY = 0x80;
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
		//fadeIn();
	}
	if (soundPlayQueenRoar && ((frameCounter & 0x7F) == 0)) {
		sfxRequestNoise = NoiseSFX.u17;
	}
}

void drawNonGameSprite() {
	auto de = &creditsSpritePointerTable[spriteID][0];
	auto hl = &oamBuffer[oamBufferIndex / 4];
	auto b = spriteYPixel;
	auto c = spriteXPixel;
	while (true) {
		if (de.y == metaSpriteEnd) {
			break;
		}
		byte y = de.y;
		if (spriteAttr & OAMFlags.yFlip) {
			y = cast(byte)(-y - 7);
		}
		hl.y = cast(ubyte)(y + spriteYPixel);
		byte x = de.x;
		if (spriteAttr & OAMFlags.xFlip) {
			x = cast(byte)(-x - 7);
		}
		hl.x = cast(ubyte)(x + spriteXPixel);
		hl.tile = de.tile;
		hl.flags = spriteAttr ^ de.flags;
		oamBufferIndex += 4;
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
