module metroid2.enemies;

import metroid2.bank02;
import metroid2.defs;
import metroid2.globals;

immutable ubyte[][][] enemyDataPointers = [
	[
		enemyBank9_00, enemyBank9_01, enemyBank9_02, enemyBank9_03, enemyBank9_04, enemyBank9_05, enemyBank9_06, enemyBank9_07, enemyBank9_08, enemyBank9_09, enemyBank9_0A, enemyBank9_0B, enemyBank9_0C, enemyBank9_0D, enemyBank9_0E, enemyBank9_0F,
		enemyBank9_10, enemyBank9_11, enemyBank9_12, enemyBank9_13, enemyBank9_14, enemyBank9_15, enemyBank9_16, enemyBank9_17, enemyBank9_18, enemyBank9_19, enemyBank9_1A, enemyBank9_1B, enemyBank9_1C, enemyBank9_1D, enemyBank9_1E, enemyBank9_1F,
		enemyBank9_20, enemyBank9_21, enemyBank9_22, enemyBank9_23, enemyBank9_24, enemyBank9_25, enemyBank9_26, enemyBank9_27, enemyBank9_28, enemyBank9_29, enemyBank9_2A, enemyBank9_2B, enemyBank9_2C, enemyBank9_2D, enemyBank9_2E, enemyBank9_2F,
		enemyBank9_30, enemyBank9_31, enemyBank9_32, enemyBank9_33, enemyBank9_34, enemyBank9_35, enemyBank9_36, enemyBank9_37, enemyBank9_38, enemyBank9_39, enemyBank9_3A, enemyBank9_3B, enemyBank9_3C, enemyBank9_3D, enemyBank9_3E, enemyBank9_3F,
		enemyBank9_40, enemyBank9_41, enemyBank9_42, enemyBank9_43, enemyBank9_44, enemyBank9_45, enemyBank9_46, enemyBank9_47, enemyBank9_48, enemyBank9_49, enemyBank9_4A, enemyBank9_4B, enemyBank9_4C, enemyBank9_4D, enemyBank9_4E, enemyBank9_4F,
		enemyBank9_50, enemyBank9_51, enemyBank9_52, enemyBank9_53, enemyBank9_54, enemyBank9_55, enemyBank9_56, enemyBank9_57, enemyBank9_58, enemyBank9_59, enemyBank9_5A, enemyBank9_5B, enemyBank9_5C, enemyBank9_5D, enemyBank9_5E, enemyBank9_5F,
		enemyBank9_60, enemyBank9_61, enemyBank9_62, enemyBank9_63, enemyBank9_64, enemyBank9_65, enemyBank9_66, enemyBank9_67, enemyBank9_68, enemyBank9_69, enemyBank9_6A, enemyBank9_6B, enemyBank9_6C, enemyBank9_6D, enemyBank9_6E, enemyBank9_6F,
		enemyBank9_70, enemyBank9_71, enemyBank9_72, enemyBank9_73, enemyBank9_74, enemyBank9_75, enemyBank9_76, enemyBank9_77, enemyBank9_78, enemyBank9_79, enemyBank9_7A, enemyBank9_7B, enemyBank9_7C, enemyBank9_7D, enemyBank9_7E, enemyBank9_7F,
		enemyBank9_80, enemyBank9_81, enemyBank9_82, enemyBank9_83, enemyBank9_84, enemyBank9_85, enemyBank9_86, enemyBank9_87, enemyBank9_88, enemyBank9_89, enemyBank9_8A, enemyBank9_8B, enemyBank9_8C, enemyBank9_8D, enemyBank9_8E, enemyBank9_8F,
		enemyBank9_90, enemyBank9_91, enemyBank9_92, enemyBank9_93, enemyBank9_94, enemyBank9_95, enemyBank9_96, enemyBank9_97, enemyBank9_98, enemyBank9_99, enemyBank9_9A, enemyBank9_9B, enemyBank9_9C, enemyBank9_9D, enemyBank9_9E, enemyBank9_9F,
		enemyBank9_A0, enemyBank9_A1, enemyBank9_A2, enemyBank9_A3, enemyBank9_A4, enemyBank9_A5, enemyBank9_A6, enemyBank9_A7, enemyBank9_A8, enemyBank9_A9, enemyBank9_AA, enemyBank9_AB, enemyBank9_AC, enemyBank9_AD, enemyBank9_AE, enemyBank9_AF,
		enemyBank9_B0, enemyBank9_B1, enemyBank9_B2, enemyBank9_B3, enemyBank9_B4, enemyBank9_B5, enemyBank9_B6, enemyBank9_B7, enemyBank9_B8, enemyBank9_B9, enemyBank9_BA, enemyBank9_BB, enemyBank9_BC, enemyBank9_BD, enemyBank9_BE, enemyBank9_BF,
		enemyBank9_C0, enemyBank9_C1, enemyBank9_C2, enemyBank9_C3, enemyBank9_C4, enemyBank9_C5, enemyBank9_C6, enemyBank9_C7, enemyBank9_C8, enemyBank9_C9, enemyBank9_CA, enemyBank9_CB, enemyBank9_CC, enemyBank9_CD, enemyBank9_CE, enemyBank9_CF,
		enemyBank9_D0, enemyBank9_D1, enemyBank9_D2, enemyBank9_D3, enemyBank9_D4, enemyBank9_D5, enemyBank9_D6, enemyBank9_D7, enemyBank9_D8, enemyBank9_D9, enemyBank9_DA, enemyBank9_DB, enemyBank9_DC, enemyBank9_DD, enemyBank9_DE, enemyBank9_DF,
		enemyBank9_E0, enemyBank9_E1, enemyBank9_E2, enemyBank9_E3, enemyBank9_E4, enemyBank9_E5, enemyBank9_E6, enemyBank9_E7, enemyBank9_E8, enemyBank9_E9, enemyBank9_EA, enemyBank9_EB, enemyBank9_EC, enemyBank9_ED, enemyBank9_EE, enemyBank9_EF,
		enemyBank9_F0, enemyBank9_F1, enemyBank9_F2, enemyBank9_F3, enemyBank9_F4, enemyBank9_F5, enemyBank9_F6, enemyBank9_F7, enemyBank9_F8, enemyBank9_F9, enemyBank9_FA, enemyBank9_FB, enemyBank9_FC, enemyBank9_FD, enemyBank9_FE, enemyBank9_FF,
	], [
		enemyBankA_00, enemyBankA_01, enemyBankA_02, enemyBankA_03, enemyBankA_04, enemyBankA_05, enemyBankA_06, enemyBankA_07, enemyBankA_08, enemyBankA_09, enemyBankA_0A, enemyBankA_0B, enemyBankA_0C, enemyBankA_0D, enemyBankA_0E, enemyBankA_0F,
		enemyBankA_10, enemyBankA_11, enemyBankA_12, enemyBankA_13, enemyBankA_14, enemyBankA_15, enemyBankA_16, enemyBankA_17, enemyBankA_18, enemyBankA_19, enemyBankA_1A, enemyBankA_1B, enemyBankA_1C, enemyBankA_1D, enemyBankA_1E, enemyBankA_1F,
		enemyBankA_20, enemyBankA_21, enemyBankA_22, enemyBankA_23, enemyBankA_24, enemyBankA_25, enemyBankA_26, enemyBankA_27, enemyBankA_28, enemyBankA_29, enemyBankA_2A, enemyBankA_2B, enemyBankA_2C, enemyBankA_2D, enemyBankA_2E, enemyBankA_2F,
		enemyBankA_30, enemyBankA_31, enemyBankA_32, enemyBankA_33, enemyBankA_34, enemyBankA_35, enemyBankA_36, enemyBankA_37, enemyBankA_38, enemyBankA_39, enemyBankA_3A, enemyBankA_3B, enemyBankA_3C, enemyBankA_3D, enemyBankA_3E, enemyBankA_3F,
		enemyBankA_40, enemyBankA_41, enemyBankA_42, enemyBankA_43, enemyBankA_44, enemyBankA_45, enemyBankA_46, enemyBankA_47, enemyBankA_48, enemyBankA_49, enemyBankA_4A, enemyBankA_4B, enemyBankA_4C, enemyBankA_4D, enemyBankA_4E, enemyBankA_4F,
		enemyBankA_50, enemyBankA_51, enemyBankA_52, enemyBankA_53, enemyBankA_54, enemyBankA_55, enemyBankA_56, enemyBankA_57, enemyBankA_58, enemyBankA_59, enemyBankA_5A, enemyBankA_5B, enemyBankA_5C, enemyBankA_5D, enemyBankA_5E, enemyBankA_5F,
		enemyBankA_60, enemyBankA_61, enemyBankA_62, enemyBankA_63, enemyBankA_64, enemyBankA_65, enemyBankA_66, enemyBankA_67, enemyBankA_68, enemyBankA_69, enemyBankA_6A, enemyBankA_6B, enemyBankA_6C, enemyBankA_6D, enemyBankA_6E, enemyBankA_6F,
		enemyBankA_70, enemyBankA_71, enemyBankA_72, enemyBankA_73, enemyBankA_74, enemyBankA_75, enemyBankA_76, enemyBankA_77, enemyBankA_78, enemyBankA_79, enemyBankA_7A, enemyBankA_7B, enemyBankA_7C, enemyBankA_7D, enemyBankA_7E, enemyBankA_7F,
		enemyBankA_80, enemyBankA_81, enemyBankA_82, enemyBankA_83, enemyBankA_84, enemyBankA_85, enemyBankA_86, enemyBankA_87, enemyBankA_88, enemyBankA_89, enemyBankA_8A, enemyBankA_8B, enemyBankA_8C, enemyBankA_8D, enemyBankA_8E, enemyBankA_8F,
		enemyBankA_90, enemyBankA_91, enemyBankA_92, enemyBankA_93, enemyBankA_94, enemyBankA_95, enemyBankA_96, enemyBankA_97, enemyBankA_98, enemyBankA_99, enemyBankA_9A, enemyBankA_9B, enemyBankA_9C, enemyBankA_9D, enemyBankA_9E, enemyBankA_9F,
		enemyBankA_A0, enemyBankA_A1, enemyBankA_A2, enemyBankA_A3, enemyBankA_A4, enemyBankA_A5, enemyBankA_A6, enemyBankA_A7, enemyBankA_A8, enemyBankA_A9, enemyBankA_AA, enemyBankA_AB, enemyBankA_AC, enemyBankA_AD, enemyBankA_AE, enemyBankA_AF,
		enemyBankA_B0, enemyBankA_B1, enemyBankA_B2, enemyBankA_B3, enemyBankA_B4, enemyBankA_B5, enemyBankA_B6, enemyBankA_B7, enemyBankA_B8, enemyBankA_B9, enemyBankA_BA, enemyBankA_BB, enemyBankA_BC, enemyBankA_BD, enemyBankA_BE, enemyBankA_BF,
		enemyBankA_C0, enemyBankA_C1, enemyBankA_C2, enemyBankA_C3, enemyBankA_C4, enemyBankA_C5, enemyBankA_C6, enemyBankA_C7, enemyBankA_C8, enemyBankA_C9, enemyBankA_CA, enemyBankA_CB, enemyBankA_CC, enemyBankA_CD, enemyBankA_CE, enemyBankA_CF,
		enemyBankA_D0, enemyBankA_D1, enemyBankA_D2, enemyBankA_D3, enemyBankA_D4, enemyBankA_D5, enemyBankA_D6, enemyBankA_D7, enemyBankA_D8, enemyBankA_D9, enemyBankA_DA, enemyBankA_DB, enemyBankA_DC, enemyBankA_DD, enemyBankA_DE, enemyBankA_DF,
		enemyBankA_E0, enemyBankA_E1, enemyBankA_E2, enemyBankA_E3, enemyBankA_E4, enemyBankA_E5, enemyBankA_E6, enemyBankA_E7, enemyBankA_E8, enemyBankA_E9, enemyBankA_EA, enemyBankA_EB, enemyBankA_EC, enemyBankA_ED, enemyBankA_EE, enemyBankA_EF,
		enemyBankA_F0, enemyBankA_F1, enemyBankA_F2, enemyBankA_F3, enemyBankA_F4, enemyBankA_F5, enemyBankA_F6, enemyBankA_F7, enemyBankA_F8, enemyBankA_F9, enemyBankA_FA, enemyBankA_FB, enemyBankA_FC, enemyBankA_FD, enemyBankA_FE, enemyBankA_FF,
	], [
		enemyBankB_00, enemyBankB_01, enemyBankB_02, enemyBankB_03, enemyBankB_04, enemyBankB_05, enemyBankB_06, enemyBankB_07, enemyBankB_08, enemyBankB_09, enemyBankB_0A, enemyBankB_0B, enemyBankB_0C, enemyBankB_0D, enemyBankB_0E, enemyBankB_0F,
		enemyBankB_10, enemyBankB_11, enemyBankB_12, enemyBankB_13, enemyBankB_14, enemyBankB_15, enemyBankB_16, enemyBankB_17, enemyBankB_18, enemyBankB_19, enemyBankB_1A, enemyBankB_1B, enemyBankB_1C, enemyBankB_1D, enemyBankB_1E, enemyBankB_1F,
		enemyBankB_20, enemyBankB_21, enemyBankB_22, enemyBankB_23, enemyBankB_24, enemyBankB_25, enemyBankB_26, enemyBankB_27, enemyBankB_28, enemyBankB_29, enemyBankB_2A, enemyBankB_2B, enemyBankB_2C, enemyBankB_2D, enemyBankB_2E, enemyBankB_2F,
		enemyBankB_30, enemyBankB_31, enemyBankB_32, enemyBankB_33, enemyBankB_34, enemyBankB_35, enemyBankB_36, enemyBankB_37, enemyBankB_38, enemyBankB_39, enemyBankB_3A, enemyBankB_3B, enemyBankB_3C, enemyBankB_3D, enemyBankB_3E, enemyBankB_3F,
		enemyBankB_40, enemyBankB_41, enemyBankB_42, enemyBankB_43, enemyBankB_44, enemyBankB_45, enemyBankB_46, enemyBankB_47, enemyBankB_48, enemyBankB_49, enemyBankB_4A, enemyBankB_4B, enemyBankB_4C, enemyBankB_4D, enemyBankB_4E, enemyBankB_4F,
		enemyBankB_50, enemyBankB_51, enemyBankB_52, enemyBankB_53, enemyBankB_54, enemyBankB_55, enemyBankB_56, enemyBankB_57, enemyBankB_58, enemyBankB_59, enemyBankB_5A, enemyBankB_5B, enemyBankB_5C, enemyBankB_5D, enemyBankB_5E, enemyBankB_5F,
		enemyBankB_60, enemyBankB_61, enemyBankB_62, enemyBankB_63, enemyBankB_64, enemyBankB_65, enemyBankB_66, enemyBankB_67, enemyBankB_68, enemyBankB_69, enemyBankB_6A, enemyBankB_6B, enemyBankB_6C, enemyBankB_6D, enemyBankB_6E, enemyBankB_6F,
		enemyBankB_70, enemyBankB_71, enemyBankB_72, enemyBankB_73, enemyBankB_74, enemyBankB_75, enemyBankB_76, enemyBankB_77, enemyBankB_78, enemyBankB_79, enemyBankB_7A, enemyBankB_7B, enemyBankB_7C, enemyBankB_7D, enemyBankB_7E, enemyBankB_7F,
		enemyBankB_80, enemyBankB_81, enemyBankB_82, enemyBankB_83, enemyBankB_84, enemyBankB_85, enemyBankB_86, enemyBankB_87, enemyBankB_88, enemyBankB_89, enemyBankB_8A, enemyBankB_8B, enemyBankB_8C, enemyBankB_8D, enemyBankB_8E, enemyBankB_8F,
		enemyBankB_90, enemyBankB_91, enemyBankB_92, enemyBankB_93, enemyBankB_94, enemyBankB_95, enemyBankB_96, enemyBankB_97, enemyBankB_98, enemyBankB_99, enemyBankB_9A, enemyBankB_9B, enemyBankB_9C, enemyBankB_9D, enemyBankB_9E, enemyBankB_9F,
		enemyBankB_A0, enemyBankB_A1, enemyBankB_A2, enemyBankB_A3, enemyBankB_A4, enemyBankB_A5, enemyBankB_A6, enemyBankB_A7, enemyBankB_A8, enemyBankB_A9, enemyBankB_AA, enemyBankB_AB, enemyBankB_AC, enemyBankB_AD, enemyBankB_AE, enemyBankB_AF,
		enemyBankB_B0, enemyBankB_B1, enemyBankB_B2, enemyBankB_B3, enemyBankB_B4, enemyBankB_B5, enemyBankB_B6, enemyBankB_B7, enemyBankB_B8, enemyBankB_B9, enemyBankB_BA, enemyBankB_BB, enemyBankB_BC, enemyBankB_BD, enemyBankB_BE, enemyBankB_BF,
		enemyBankB_C0, enemyBankB_C1, enemyBankB_C2, enemyBankB_C3, enemyBankB_C4, enemyBankB_C5, enemyBankB_C6, enemyBankB_C7, enemyBankB_C8, enemyBankB_C9, enemyBankB_CA, enemyBankB_CB, enemyBankB_CC, enemyBankB_CD, enemyBankB_CE, enemyBankB_CF,
		enemyBankB_D0, enemyBankB_D1, enemyBankB_D2, enemyBankB_D3, enemyBankB_D4, enemyBankB_D5, enemyBankB_D6, enemyBankB_D7, enemyBankB_D8, enemyBankB_D9, enemyBankB_DA, enemyBankB_DB, enemyBankB_DC, enemyBankB_DD, enemyBankB_DE, enemyBankB_DF,
		enemyBankB_E0, enemyBankB_E1, enemyBankB_E2, enemyBankB_E3, enemyBankB_E4, enemyBankB_E5, enemyBankB_E6, enemyBankB_E7, enemyBankB_E8, enemyBankB_E9, enemyBankB_EA, enemyBankB_EB, enemyBankB_EC, enemyBankB_ED, enemyBankB_EE, enemyBankB_EF,
		enemyBankB_F0, enemyBankB_F1, enemyBankB_F2, enemyBankB_F3, enemyBankB_F4, enemyBankB_F5, enemyBankB_F6, enemyBankB_F7, enemyBankB_F8, enemyBankB_F9, enemyBankB_FA, enemyBankB_FB, enemyBankB_FC, enemyBankB_FD, enemyBankB_FE, enemyBankB_FF,
	], [
		enemyBankC_00, enemyBankC_01, enemyBankC_02, enemyBankC_03, enemyBankC_04, enemyBankC_05, enemyBankC_06, enemyBankC_07, enemyBankC_08, enemyBankC_09, enemyBankC_0A, enemyBankC_0B, enemyBankC_0C, enemyBankC_0D, enemyBankC_0E, enemyBankC_0F,
		enemyBankC_10, enemyBankC_11, enemyBankC_12, enemyBankC_13, enemyBankC_14, enemyBankC_15, enemyBankC_16, enemyBankC_17, enemyBankC_18, enemyBankC_19, enemyBankC_1A, enemyBankC_1B, enemyBankC_1C, enemyBankC_1D, enemyBankC_1E, enemyBankC_1F,
		enemyBankC_20, enemyBankC_21, enemyBankC_22, enemyBankC_23, enemyBankC_24, enemyBankC_25, enemyBankC_26, enemyBankC_27, enemyBankC_28, enemyBankC_29, enemyBankC_2A, enemyBankC_2B, enemyBankC_2C, enemyBankC_2D, enemyBankC_2E, enemyBankC_2F,
		enemyBankC_30, enemyBankC_31, enemyBankC_32, enemyBankC_33, enemyBankC_34, enemyBankC_35, enemyBankC_36, enemyBankC_37, enemyBankC_38, enemyBankC_39, enemyBankC_3A, enemyBankC_3B, enemyBankC_3C, enemyBankC_3D, enemyBankC_3E, enemyBankC_3F,
		enemyBankC_40, enemyBankC_41, enemyBankC_42, enemyBankC_43, enemyBankC_44, enemyBankC_45, enemyBankC_46, enemyBankC_47, enemyBankC_48, enemyBankC_49, enemyBankC_4A, enemyBankC_4B, enemyBankC_4C, enemyBankC_4D, enemyBankC_4E, enemyBankC_4F,
		enemyBankC_50, enemyBankC_51, enemyBankC_52, enemyBankC_53, enemyBankC_54, enemyBankC_55, enemyBankC_56, enemyBankC_57, enemyBankC_58, enemyBankC_59, enemyBankC_5A, enemyBankC_5B, enemyBankC_5C, enemyBankC_5D, enemyBankC_5E, enemyBankC_5F,
		enemyBankC_60, enemyBankC_61, enemyBankC_62, enemyBankC_63, enemyBankC_64, enemyBankC_65, enemyBankC_66, enemyBankC_67, enemyBankC_68, enemyBankC_69, enemyBankC_6A, enemyBankC_6B, enemyBankC_6C, enemyBankC_6D, enemyBankC_6E, enemyBankC_6F,
		enemyBankC_70, enemyBankC_71, enemyBankC_72, enemyBankC_73, enemyBankC_74, enemyBankC_75, enemyBankC_76, enemyBankC_77, enemyBankC_78, enemyBankC_79, enemyBankC_7A, enemyBankC_7B, enemyBankC_7C, enemyBankC_7D, enemyBankC_7E, enemyBankC_7F,
		enemyBankC_80, enemyBankC_81, enemyBankC_82, enemyBankC_83, enemyBankC_84, enemyBankC_85, enemyBankC_86, enemyBankC_87, enemyBankC_88, enemyBankC_89, enemyBankC_8A, enemyBankC_8B, enemyBankC_8C, enemyBankC_8D, enemyBankC_8E, enemyBankC_8F,
		enemyBankC_90, enemyBankC_91, enemyBankC_92, enemyBankC_93, enemyBankC_94, enemyBankC_95, enemyBankC_96, enemyBankC_97, enemyBankC_98, enemyBankC_99, enemyBankC_9A, enemyBankC_9B, enemyBankC_9C, enemyBankC_9D, enemyBankC_9E, enemyBankC_9F,
		enemyBankC_A0, enemyBankC_A1, enemyBankC_A2, enemyBankC_A3, enemyBankC_A4, enemyBankC_A5, enemyBankC_A6, enemyBankC_A7, enemyBankC_A8, enemyBankC_A9, enemyBankC_AA, enemyBankC_AB, enemyBankC_AC, enemyBankC_AD, enemyBankC_AE, enemyBankC_AF,
		enemyBankC_B0, enemyBankC_B1, enemyBankC_B2, enemyBankC_B3, enemyBankC_B4, enemyBankC_B5, enemyBankC_B6, enemyBankC_B7, enemyBankC_B8, enemyBankC_B9, enemyBankC_BA, enemyBankC_BB, enemyBankC_BC, enemyBankC_BD, enemyBankC_BE, enemyBankC_BF,
		enemyBankC_C0, enemyBankC_C1, enemyBankC_C2, enemyBankC_C3, enemyBankC_C4, enemyBankC_C5, enemyBankC_C6, enemyBankC_C7, enemyBankC_C8, enemyBankC_C9, enemyBankC_CA, enemyBankC_CB, enemyBankC_CC, enemyBankC_CD, enemyBankC_CE, enemyBankC_CF,
		enemyBankC_D0, enemyBankC_D1, enemyBankC_D2, enemyBankC_D3, enemyBankC_D4, enemyBankC_D5, enemyBankC_D6, enemyBankC_D7, enemyBankC_D8, enemyBankC_D9, enemyBankC_DA, enemyBankC_DB, enemyBankC_DC, enemyBankC_DD, enemyBankC_DE, enemyBankC_DF,
		enemyBankC_E0, enemyBankC_E1, enemyBankC_E2, enemyBankC_E3, enemyBankC_E4, enemyBankC_E5, enemyBankC_E6, enemyBankC_E7, enemyBankC_E8, enemyBankC_E9, enemyBankC_EA, enemyBankC_EB, enemyBankC_EC, enemyBankC_ED, enemyBankC_EE, enemyBankC_EF,
		enemyBankC_F0, enemyBankC_F1, enemyBankC_F2, enemyBankC_F3, enemyBankC_F4, enemyBankC_F5, enemyBankC_F6, enemyBankC_F7, enemyBankC_F8, enemyBankC_F9, enemyBankC_FA, enemyBankC_FB, enemyBankC_FC, enemyBankC_FD, enemyBankC_FE, enemyBankC_FF,
	], [
		enemyBankD_00, enemyBankD_01, enemyBankD_02, enemyBankD_03, enemyBankD_04, enemyBankD_05, enemyBankD_06, enemyBankD_07, enemyBankD_08, enemyBankD_09, enemyBankD_0A, enemyBankD_0B, enemyBankD_0C, enemyBankD_0D, enemyBankD_0E, enemyBankD_0F,
		enemyBankD_10, enemyBankD_11, enemyBankD_12, enemyBankD_13, enemyBankD_14, enemyBankD_15, enemyBankD_16, enemyBankD_17, enemyBankD_18, enemyBankD_19, enemyBankD_1A, enemyBankD_1B, enemyBankD_1C, enemyBankD_1D, enemyBankD_1E, enemyBankD_1F,
		enemyBankD_20, enemyBankD_21, enemyBankD_22, enemyBankD_23, enemyBankD_24, enemyBankD_25, enemyBankD_26, enemyBankD_27, enemyBankD_28, enemyBankD_29, enemyBankD_2A, enemyBankD_2B, enemyBankD_2C, enemyBankD_2D, enemyBankD_2E, enemyBankD_2F,
		enemyBankD_30, enemyBankD_31, enemyBankD_32, enemyBankD_33, enemyBankD_34, enemyBankD_35, enemyBankD_36, enemyBankD_37, enemyBankD_38, enemyBankD_39, enemyBankD_3A, enemyBankD_3B, enemyBankD_3C, enemyBankD_3D, enemyBankD_3E, enemyBankD_3F,
		enemyBankD_40, enemyBankD_41, enemyBankD_42, enemyBankD_43, enemyBankD_44, enemyBankD_45, enemyBankD_46, enemyBankD_47, enemyBankD_48, enemyBankD_49, enemyBankD_4A, enemyBankD_4B, enemyBankD_4C, enemyBankD_4D, enemyBankD_4E, enemyBankD_4F,
		enemyBankD_50, enemyBankD_51, enemyBankD_52, enemyBankD_53, enemyBankD_54, enemyBankD_55, enemyBankD_56, enemyBankD_57, enemyBankD_58, enemyBankD_59, enemyBankD_5A, enemyBankD_5B, enemyBankD_5C, enemyBankD_5D, enemyBankD_5E, enemyBankD_5F,
		enemyBankD_60, enemyBankD_61, enemyBankD_62, enemyBankD_63, enemyBankD_64, enemyBankD_65, enemyBankD_66, enemyBankD_67, enemyBankD_68, enemyBankD_69, enemyBankD_6A, enemyBankD_6B, enemyBankD_6C, enemyBankD_6D, enemyBankD_6E, enemyBankD_6F,
		enemyBankD_70, enemyBankD_71, enemyBankD_72, enemyBankD_73, enemyBankD_74, enemyBankD_75, enemyBankD_76, enemyBankD_77, enemyBankD_78, enemyBankD_79, enemyBankD_7A, enemyBankD_7B, enemyBankD_7C, enemyBankD_7D, enemyBankD_7E, enemyBankD_7F,
		enemyBankD_80, enemyBankD_81, enemyBankD_82, enemyBankD_83, enemyBankD_84, enemyBankD_85, enemyBankD_86, enemyBankD_87, enemyBankD_88, enemyBankD_89, enemyBankD_8A, enemyBankD_8B, enemyBankD_8C, enemyBankD_8D, enemyBankD_8E, enemyBankD_8F,
		enemyBankD_90, enemyBankD_91, enemyBankD_92, enemyBankD_93, enemyBankD_94, enemyBankD_95, enemyBankD_96, enemyBankD_97, enemyBankD_98, enemyBankD_99, enemyBankD_9A, enemyBankD_9B, enemyBankD_9C, enemyBankD_9D, enemyBankD_9E, enemyBankD_9F,
		enemyBankD_A0, enemyBankD_A1, enemyBankD_A2, enemyBankD_A3, enemyBankD_A4, enemyBankD_A5, enemyBankD_A6, enemyBankD_A7, enemyBankD_A8, enemyBankD_A9, enemyBankD_AA, enemyBankD_AB, enemyBankD_AC, enemyBankD_AD, enemyBankD_AE, enemyBankD_AF,
		enemyBankD_B0, enemyBankD_B1, enemyBankD_B2, enemyBankD_B3, enemyBankD_B4, enemyBankD_B5, enemyBankD_B6, enemyBankD_B7, enemyBankD_B8, enemyBankD_B9, enemyBankD_BA, enemyBankD_BB, enemyBankD_BC, enemyBankD_BD, enemyBankD_BE, enemyBankD_BF,
		enemyBankD_C0, enemyBankD_C1, enemyBankD_C2, enemyBankD_C3, enemyBankD_C4, enemyBankD_C5, enemyBankD_C6, enemyBankD_C7, enemyBankD_C8, enemyBankD_C9, enemyBankD_CA, enemyBankD_CB, enemyBankD_CC, enemyBankD_CD, enemyBankD_CE, enemyBankD_CF,
		enemyBankD_D0, enemyBankD_D1, enemyBankD_D2, enemyBankD_D3, enemyBankD_D4, enemyBankD_D5, enemyBankD_D6, enemyBankD_D7, enemyBankD_D8, enemyBankD_D9, enemyBankD_DA, enemyBankD_DB, enemyBankD_DC, enemyBankD_DD, enemyBankD_DE, enemyBankD_DF,
		enemyBankD_E0, enemyBankD_E1, enemyBankD_E2, enemyBankD_E3, enemyBankD_E4, enemyBankD_E5, enemyBankD_E6, enemyBankD_E7, enemyBankD_E8, enemyBankD_E9, enemyBankD_EA, enemyBankD_EB, enemyBankD_EC, enemyBankD_ED, enemyBankD_EE, enemyBankD_EF,
		enemyBankD_F0, enemyBankD_F1, enemyBankD_F2, enemyBankD_F3, enemyBankD_F4, enemyBankD_F5, enemyBankD_F6, enemyBankD_F7, enemyBankD_F8, enemyBankD_F9, enemyBankD_FA, enemyBankD_FB, enemyBankD_FC, enemyBankD_FD, enemyBankD_FE, enemyBankD_FF,
	], [
		enemyBankE_00, enemyBankE_01, enemyBankE_02, enemyBankE_03, enemyBankE_04, enemyBankE_05, enemyBankE_06, enemyBankE_07, enemyBankE_08, enemyBankE_09, enemyBankE_0A, enemyBankE_0B, enemyBankE_0C, enemyBankE_0D, enemyBankE_0E, enemyBankE_0F,
		enemyBankE_10, enemyBankE_11, enemyBankE_12, enemyBankE_13, enemyBankE_14, enemyBankE_15, enemyBankE_16, enemyBankE_17, enemyBankE_18, enemyBankE_19, enemyBankE_1A, enemyBankE_1B, enemyBankE_1C, enemyBankE_1D, enemyBankE_1E, enemyBankE_1F,
		enemyBankE_20, enemyBankE_21, enemyBankE_22, enemyBankE_23, enemyBankE_24, enemyBankE_25, enemyBankE_26, enemyBankE_27, enemyBankE_28, enemyBankE_29, enemyBankE_2A, enemyBankE_2B, enemyBankE_2C, enemyBankE_2D, enemyBankE_2E, enemyBankE_2F,
		enemyBankE_30, enemyBankE_31, enemyBankE_32, enemyBankE_33, enemyBankE_34, enemyBankE_35, enemyBankE_36, enemyBankE_37, enemyBankE_38, enemyBankE_39, enemyBankE_3A, enemyBankE_3B, enemyBankE_3C, enemyBankE_3D, enemyBankE_3E, enemyBankE_3F,
		enemyBankE_40, enemyBankE_41, enemyBankE_42, enemyBankE_43, enemyBankE_44, enemyBankE_45, enemyBankE_46, enemyBankE_47, enemyBankE_48, enemyBankE_49, enemyBankE_4A, enemyBankE_4B, enemyBankE_4C, enemyBankE_4D, enemyBankE_4E, enemyBankE_4F,
		enemyBankE_50, enemyBankE_51, enemyBankE_52, enemyBankE_53, enemyBankE_54, enemyBankE_55, enemyBankE_56, enemyBankE_57, enemyBankE_58, enemyBankE_59, enemyBankE_5A, enemyBankE_5B, enemyBankE_5C, enemyBankE_5D, enemyBankE_5E, enemyBankE_5F,
		enemyBankE_60, enemyBankE_61, enemyBankE_62, enemyBankE_63, enemyBankE_64, enemyBankE_65, enemyBankE_66, enemyBankE_67, enemyBankE_68, enemyBankE_69, enemyBankE_6A, enemyBankE_6B, enemyBankE_6C, enemyBankE_6D, enemyBankE_6E, enemyBankE_6F,
		enemyBankE_70, enemyBankE_71, enemyBankE_72, enemyBankE_73, enemyBankE_74, enemyBankE_75, enemyBankE_76, enemyBankE_77, enemyBankE_78, enemyBankE_79, enemyBankE_7A, enemyBankE_7B, enemyBankE_7C, enemyBankE_7D, enemyBankE_7E, enemyBankE_7F,
		enemyBankE_80, enemyBankE_81, enemyBankE_82, enemyBankE_83, enemyBankE_84, enemyBankE_85, enemyBankE_86, enemyBankE_87, enemyBankE_88, enemyBankE_89, enemyBankE_8A, enemyBankE_8B, enemyBankE_8C, enemyBankE_8D, enemyBankE_8E, enemyBankE_8F,
		enemyBankE_90, enemyBankE_91, enemyBankE_92, enemyBankE_93, enemyBankE_94, enemyBankE_95, enemyBankE_96, enemyBankE_97, enemyBankE_98, enemyBankE_99, enemyBankE_9A, enemyBankE_9B, enemyBankE_9C, enemyBankE_9D, enemyBankE_9E, enemyBankE_9F,
		enemyBankE_A0, enemyBankE_A1, enemyBankE_A2, enemyBankE_A3, enemyBankE_A4, enemyBankE_A5, enemyBankE_A6, enemyBankE_A7, enemyBankE_A8, enemyBankE_A9, enemyBankE_AA, enemyBankE_AB, enemyBankE_AC, enemyBankE_AD, enemyBankE_AE, enemyBankE_AF,
		enemyBankE_B0, enemyBankE_B1, enemyBankE_B2, enemyBankE_B3, enemyBankE_B4, enemyBankE_B5, enemyBankE_B6, enemyBankE_B7, enemyBankE_B8, enemyBankE_B9, enemyBankE_BA, enemyBankE_BB, enemyBankE_BC, enemyBankE_BD, enemyBankE_BE, enemyBankE_BF,
		enemyBankE_C0, enemyBankE_C1, enemyBankE_C2, enemyBankE_C3, enemyBankE_C4, enemyBankE_C5, enemyBankE_C6, enemyBankE_C7, enemyBankE_C8, enemyBankE_C9, enemyBankE_CA, enemyBankE_CB, enemyBankE_CC, enemyBankE_CD, enemyBankE_CE, enemyBankE_CF,
		enemyBankE_D0, enemyBankE_D1, enemyBankE_D2, enemyBankE_D3, enemyBankE_D4, enemyBankE_D5, enemyBankE_D6, enemyBankE_D7, enemyBankE_D8, enemyBankE_D9, enemyBankE_DA, enemyBankE_DB, enemyBankE_DC, enemyBankE_DD, enemyBankE_DE, enemyBankE_DF,
		enemyBankE_E0, enemyBankE_E1, enemyBankE_E2, enemyBankE_E3, enemyBankE_E4, enemyBankE_E5, enemyBankE_E6, enemyBankE_E7, enemyBankE_E8, enemyBankE_E9, enemyBankE_EA, enemyBankE_EB, enemyBankE_EC, enemyBankE_ED, enemyBankE_EE, enemyBankE_EF,
		enemyBankE_F0, enemyBankE_F1, enemyBankE_F2, enemyBankE_F3, enemyBankE_F4, enemyBankE_F5, enemyBankE_F6, enemyBankE_F7, enemyBankE_F8, enemyBankE_F9, enemyBankE_FA, enemyBankE_FB, enemyBankE_FC, enemyBankE_FD, enemyBankE_FE, enemyBankE_FF,
	], [
		enemyBankF_00, enemyBankF_01, enemyBankF_02, enemyBankF_03, enemyBankF_04, enemyBankF_05, enemyBankF_06, enemyBankF_07, enemyBankF_08, enemyBankF_09, enemyBankF_0A, enemyBankF_0B, enemyBankF_0C, enemyBankF_0D, enemyBankF_0E, enemyBankF_0F,
		enemyBankF_10, enemyBankF_11, enemyBankF_12, enemyBankF_13, enemyBankF_14, enemyBankF_15, enemyBankF_16, enemyBankF_17, enemyBankF_18, enemyBankF_19, enemyBankF_1A, enemyBankF_1B, enemyBankF_1C, enemyBankF_1D, enemyBankF_1E, enemyBankF_1F,
		enemyBankF_20, enemyBankF_21, enemyBankF_22, enemyBankF_23, enemyBankF_24, enemyBankF_25, enemyBankF_26, enemyBankF_27, enemyBankF_28, enemyBankF_29, enemyBankF_2A, enemyBankF_2B, enemyBankF_2C, enemyBankF_2D, enemyBankF_2E, enemyBankF_2F,
		enemyBankF_30, enemyBankF_31, enemyBankF_32, enemyBankF_33, enemyBankF_34, enemyBankF_35, enemyBankF_36, enemyBankF_37, enemyBankF_38, enemyBankF_39, enemyBankF_3A, enemyBankF_3B, enemyBankF_3C, enemyBankF_3D, enemyBankF_3E, enemyBankF_3F,
		enemyBankF_40, enemyBankF_41, enemyBankF_42, enemyBankF_43, enemyBankF_44, enemyBankF_45, enemyBankF_46, enemyBankF_47, enemyBankF_48, enemyBankF_49, enemyBankF_4A, enemyBankF_4B, enemyBankF_4C, enemyBankF_4D, enemyBankF_4E, enemyBankF_4F,
		enemyBankF_50, enemyBankF_51, enemyBankF_52, enemyBankF_53, enemyBankF_54, enemyBankF_55, enemyBankF_56, enemyBankF_57, enemyBankF_58, enemyBankF_59, enemyBankF_5A, enemyBankF_5B, enemyBankF_5C, enemyBankF_5D, enemyBankF_5E, enemyBankF_5F,
		enemyBankF_60, enemyBankF_61, enemyBankF_62, enemyBankF_63, enemyBankF_64, enemyBankF_65, enemyBankF_66, enemyBankF_67, enemyBankF_68, enemyBankF_69, enemyBankF_6A, enemyBankF_6B, enemyBankF_6C, enemyBankF_6D, enemyBankF_6E, enemyBankF_6F,
		enemyBankF_70, enemyBankF_71, enemyBankF_72, enemyBankF_73, enemyBankF_74, enemyBankF_75, enemyBankF_76, enemyBankF_77, enemyBankF_78, enemyBankF_79, enemyBankF_7A, enemyBankF_7B, enemyBankF_7C, enemyBankF_7D, enemyBankF_7E, enemyBankF_7F,
		enemyBankF_80, enemyBankF_81, enemyBankF_82, enemyBankF_83, enemyBankF_84, enemyBankF_85, enemyBankF_86, enemyBankF_87, enemyBankF_88, enemyBankF_89, enemyBankF_8A, enemyBankF_8B, enemyBankF_8C, enemyBankF_8D, enemyBankF_8E, enemyBankF_8F,
		enemyBankF_90, enemyBankF_91, enemyBankF_92, enemyBankF_93, enemyBankF_94, enemyBankF_95, enemyBankF_96, enemyBankF_97, enemyBankF_98, enemyBankF_99, enemyBankF_9A, enemyBankF_9B, enemyBankF_9C, enemyBankF_9D, enemyBankF_9E, enemyBankF_9F,
		enemyBankF_A0, enemyBankF_A1, enemyBankF_A2, enemyBankF_A3, enemyBankF_A4, enemyBankF_A5, enemyBankF_A6, enemyBankF_A7, enemyBankF_A8, enemyBankF_A9, enemyBankF_AA, enemyBankF_AB, enemyBankF_AC, enemyBankF_AD, enemyBankF_AE, enemyBankF_AF,
		enemyBankF_B0, enemyBankF_B1, enemyBankF_B2, enemyBankF_B3, enemyBankF_B4, enemyBankF_B5, enemyBankF_B6, enemyBankF_B7, enemyBankF_B8, enemyBankF_B9, enemyBankF_BA, enemyBankF_BB, enemyBankF_BC, enemyBankF_BD, enemyBankF_BE, enemyBankF_BF,
		enemyBankF_C0, enemyBankF_C1, enemyBankF_C2, enemyBankF_C3, enemyBankF_C4, enemyBankF_C5, enemyBankF_C6, enemyBankF_C7, enemyBankF_C8, enemyBankF_C9, enemyBankF_CA, enemyBankF_CB, enemyBankF_CC, enemyBankF_CD, enemyBankF_CE, enemyBankF_CF,
		enemyBankF_D0, enemyBankF_D1, enemyBankF_D2, enemyBankF_D3, enemyBankF_D4, enemyBankF_D5, enemyBankF_D6, enemyBankF_D7, enemyBankF_D8, enemyBankF_D9, enemyBankF_DA, enemyBankF_DB, enemyBankF_DC, enemyBankF_DD, enemyBankF_DE, enemyBankF_DF,
		enemyBankF_E0, enemyBankF_E1, enemyBankF_E2, enemyBankF_E3, enemyBankF_E4, enemyBankF_E5, enemyBankF_E6, enemyBankF_E7, enemyBankF_E8, enemyBankF_E9, enemyBankF_EA, enemyBankF_EB, enemyBankF_EC, enemyBankF_ED, enemyBankF_EE, enemyBankF_EF,
		enemyBankF_F0, enemyBankF_F1, enemyBankF_F2, enemyBankF_F3, enemyBankF_F4, enemyBankF_F5, enemyBankF_F6, enemyBankF_F7, enemyBankF_F8, enemyBankF_F9, enemyBankF_FA, enemyBankF_FB, enemyBankF_FC, enemyBankF_FD, enemyBankF_FE, enemyBankF_FF,
	]
];


immutable ubyte[] enemyBank9_00 = [ 0xFF ];
immutable ubyte[] enemyBank9_01 = [ 0x65,0x99,0x88,0x18, 0xFF ];
immutable ubyte[] enemyBank9_02 = [ 0x67,0x97,0x48,0x18, 0xFF ];
immutable ubyte[] enemyBank9_03 = [ 0xFF ];
immutable ubyte[] enemyBank9_04 = [ 0xFF ];
immutable ubyte[] enemyBank9_05 = [ 0xFF ];
immutable ubyte[] enemyBank9_06 = [ 0xFF ];
immutable ubyte[] enemyBank9_07 = [ 0xFF ];
immutable ubyte[] enemyBank9_08 = [ 0xFF ];
immutable ubyte[] enemyBank9_09 = [ 0xFF ];
immutable ubyte[] enemyBank9_0A = [ 0xFF ];
immutable ubyte[] enemyBank9_0B = [ 0xFF ];
immutable ubyte[] enemyBank9_0C = [ 0xFF ];
immutable ubyte[] enemyBank9_0D = [ 0xFF ];
immutable ubyte[] enemyBank9_0E = [ 0xFF ];
immutable ubyte[] enemyBank9_0F = [ 0xFF ];
immutable ubyte[] enemyBank9_10 = [ 0xFF ];
immutable ubyte[] enemyBank9_11 = [ 0xFF ];
immutable ubyte[] enemyBank9_12 = [ 0xFF ];
immutable ubyte[] enemyBank9_13 = [ 0xFF ];
immutable ubyte[] enemyBank9_14 = [ 0xFF ];
immutable ubyte[] enemyBank9_15 = [ 0xFF ];
immutable ubyte[] enemyBank9_16 = [ 0xFF ];
immutable ubyte[] enemyBank9_17 = [ 0xFF ];
immutable ubyte[] enemyBank9_18 = [ 0xFF ];
immutable ubyte[] enemyBank9_19 = [ 0x1F,0x9A,0x00,0x88, 0xFF ];
immutable ubyte[] enemyBank9_1A = [ 0x1D,0x1B,0x60,0x9C, 0x1E,0x1B,0xA0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_1B = [ 0x1C,0x9A,0xA0,0x88, 0xFF ];
immutable ubyte[] enemyBank9_1C = [ 0x16,0x16,0x70,0x60, 0x17,0x16,0x98,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_1D = [ 0xFF ];
immutable ubyte[] enemyBank9_1E = [ 0xFF ];
immutable ubyte[] enemyBank9_1F = [ 0xFF ];
immutable ubyte[] enemyBank9_20 = [ 0x1D,0x68,0xC0,0x98, 0xFF ];
immutable ubyte[] enemyBank9_21 = [ 0x1E,0x6B,0xF8,0xA0, 0xFF ];
immutable ubyte[] enemyBank9_22 = [ 0x60,0x97,0x78,0xB8, 0xFF ];
immutable ubyte[] enemyBank9_23 = [ 0x1F,0x68,0x30,0x96, 0xFF ];
immutable ubyte[] enemyBank9_24 = [ 0xFF ];
immutable ubyte[] enemyBank9_25 = [ 0xFF ];
immutable ubyte[] enemyBank9_26 = [ 0x66,0x99,0xC8,0x18, 0xFF ];
immutable ubyte[] enemyBank9_27 = [ 0x23,0x12,0xA0,0xC0, 0x24,0x12,0xC0,0x70, 0x25,0x12,0xE0,0x20, 0xFF ];
immutable ubyte[] enemyBank9_28 = [ 0xFF ];
immutable ubyte[] enemyBank9_29 = [ 0xFF ];
immutable ubyte[] enemyBank9_2A = [ 0xFF ];
immutable ubyte[] enemyBank9_2B = [ 0xFF ];
immutable ubyte[] enemyBank9_2C = [ 0x18,0x16,0x98,0x40, 0x19,0x16,0x98,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_2D = [ 0xFF ];
immutable ubyte[] enemyBank9_2E = [ 0xFF ];
immutable ubyte[] enemyBank9_2F = [ 0xFF ];
immutable ubyte[] enemyBank9_30 = [ 0x25,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_31 = [ 0xFF ];
immutable ubyte[] enemyBank9_32 = [ 0xFF ];
immutable ubyte[] enemyBank9_33 = [ 0x20,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_34 = [ 0xFF ];
immutable ubyte[] enemyBank9_35 = [ 0xFF ];
immutable ubyte[] enemyBank9_36 = [ 0x26,0x16,0x50,0x80, 0xFF ];
immutable ubyte[] enemyBank9_37 = [ 0x21,0x12,0x60,0x60, 0x22,0x12,0x80,0x10, 0xFF ];
immutable ubyte[] enemyBank9_38 = [ 0xFF ];
immutable ubyte[] enemyBank9_39 = [ 0xFF ];
immutable ubyte[] enemyBank9_3A = [ 0xFF ];
immutable ubyte[] enemyBank9_3B = [ 0xFF ];
immutable ubyte[] enemyBank9_3C = [ 0x1A,0x16,0x98,0x40, 0x1B,0x16,0x98,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_3D = [ 0xFF ];
immutable ubyte[] enemyBank9_3E = [ 0xFF ];
immutable ubyte[] enemyBank9_3F = [ 0xFF ];
immutable ubyte[] enemyBank9_40 = [ 0x26,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_41 = [ 0xFF ];
immutable ubyte[] enemyBank9_42 = [ 0xFF ];
immutable ubyte[] enemyBank9_43 = [ 0x21,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_44 = [ 0xFF ];
immutable ubyte[] enemyBank9_45 = [ 0xFF ];
immutable ubyte[] enemyBank9_46 = [ 0x28,0x16,0x50,0x80, 0x27,0x16,0x60,0x00, 0xFF ];
immutable ubyte[] enemyBank9_47 = [ 0xFF ];
immutable ubyte[] enemyBank9_48 = [ 0xFF ];
immutable ubyte[] enemyBank9_49 = [ 0xFF ];
immutable ubyte[] enemyBank9_4A = [ 0xFF ];
immutable ubyte[] enemyBank9_4B = [ 0xFF ];
immutable ubyte[] enemyBank9_4C = [ 0x14,0x1B,0xA8,0x9C, 0x15,0x16,0xF8,0x50, 0xFF ];
immutable ubyte[] enemyBank9_4D = [ 0xFF ];
immutable ubyte[] enemyBank9_4E = [ 0x12,0x1B,0x30,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_4F = [ 0xFF ];
immutable ubyte[] enemyBank9_50 = [ 0x27,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_51 = [ 0xFF ];
immutable ubyte[] enemyBank9_52 = [ 0xFF ];
immutable ubyte[] enemyBank9_53 = [ 0x22,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_54 = [ 0xFF ];
immutable ubyte[] enemyBank9_55 = [ 0xFF ];
immutable ubyte[] enemyBank9_56 = [ 0x29,0x16,0x60,0x00, 0xFF ];
immutable ubyte[] enemyBank9_57 = [ 0xFF ];
immutable ubyte[] enemyBank9_58 = [ 0xFF ];
immutable ubyte[] enemyBank9_59 = [ 0xFF ];
immutable ubyte[] enemyBank9_5A = [ 0xFF ];
immutable ubyte[] enemyBank9_5B = [ 0xFF ];
immutable ubyte[] enemyBank9_5C = [ 0x0F,0x9B,0x90,0x74, 0x26,0x12,0xB8,0x88, 0xFF ];
immutable ubyte[] enemyBank9_5D = [ 0xFF ];
immutable ubyte[] enemyBank9_5E = [ 0x11,0x16,0xB0,0x50, 0xFF ];
immutable ubyte[] enemyBank9_5F = [ 0x10,0x16,0x50,0x80, 0xFF ];
immutable ubyte[] enemyBank9_60 = [ 0x28,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_61 = [ 0xFF ];
immutable ubyte[] enemyBank9_62 = [ 0xFF ];
immutable ubyte[] enemyBank9_63 = [ 0x23,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_64 = [ 0x2E,0x1B,0xD8,0xCC, 0xFF ];
immutable ubyte[] enemyBank9_65 = [ 0x2C,0x1B,0x30,0xCC, 0x2D,0x1B,0xB0,0xCC, 0xFF ];
immutable ubyte[] enemyBank9_66 = [ 0x2A,0x21,0x10,0xA8, 0x2B,0x20,0x30,0x68, 0xFF ];
immutable ubyte[] enemyBank9_67 = [ 0x24,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_68 = [ 0xFF ];
immutable ubyte[] enemyBank9_69 = [ 0x25,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_6A = [ 0x28,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_6B = [ 0x18,0x12,0x40,0x40, 0x19,0x12,0x80,0x58, 0x1A,0x12,0xC0,0x94, 0xFF ];
immutable ubyte[] enemyBank9_6C = [ 0x1B,0x12,0x40,0x94, 0x1C,0x12,0x80,0x58, 0x1D,0x12,0xC0,0x44, 0xFF ];
immutable ubyte[] enemyBank9_6D = [ 0x27,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_6E = [ 0xFF ];
immutable ubyte[] enemyBank9_6F = [ 0xFF ];
immutable ubyte[] enemyBank9_70 = [ 0x29,0x6A,0x80,0x40, 0xFF ];
immutable ubyte[] enemyBank9_71 = [ 0xFF ];
immutable ubyte[] enemyBank9_72 = [ 0xFF ];
immutable ubyte[] enemyBank9_73 = [ 0x0F,0x9D,0x18,0x88, 0xFF ];
immutable ubyte[] enemyBank9_74 = [ 0xFF ];
immutable ubyte[] enemyBank9_75 = [ 0xFF ];
immutable ubyte[] enemyBank9_76 = [ 0xFF ];
immutable ubyte[] enemyBank9_77 = [ 0x33,0xD3,0xF0,0xA4, 0xFF ];
immutable ubyte[] enemyBank9_78 = [ 0x34,0xD3,0xC0,0xA4, 0xFF ];
immutable ubyte[] enemyBank9_79 = [ 0xFF ];
immutable ubyte[] enemyBank9_7A = [ 0xFF ];
immutable ubyte[] enemyBank9_7B = [ 0xFF ];
immutable ubyte[] enemyBank9_7C = [ 0xFF ];
immutable ubyte[] enemyBank9_7D = [ 0x1E,0x6E,0xB8,0x40, 0x1F,0x6E,0xC0,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_7E = [ 0xFF ];
immutable ubyte[] enemyBank9_7F = [ 0xFF ];
immutable ubyte[] enemyBank9_80 = [ 0x2A,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_81 = [ 0xFF ];
immutable ubyte[] enemyBank9_82 = [ 0xFF ];
immutable ubyte[] enemyBank9_83 = [ 0x16,0x6A,0xB8,0xB0, 0xFF ];
immutable ubyte[] enemyBank9_84 = [ 0x1C,0x12,0x80,0x80, 0x61,0x99,0xE8,0xE8, 0xFF ];
immutable ubyte[] enemyBank9_85 = [ 0xFF ];
immutable ubyte[] enemyBank9_86 = [ 0xFF ];
immutable ubyte[] enemyBank9_87 = [ 0xFF ];
immutable ubyte[] enemyBank9_88 = [ 0xFF ];
immutable ubyte[] enemyBank9_89 = [ 0x29,0x12,0xB8,0x40, 0x2A,0x12,0xB8,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_8A = [ 0xFF ];
immutable ubyte[] enemyBank9_8B = [ 0xFF ];
immutable ubyte[] enemyBank9_8C = [ 0xFF ];
immutable ubyte[] enemyBank9_8D = [ 0x62,0x99,0x48,0xA8, 0x20,0x6E,0xB8,0x3C, 0x21,0x6E,0xB8,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_8E = [ 0xFF ];
immutable ubyte[] enemyBank9_8F = [ 0xFF ];
immutable ubyte[] enemyBank9_90 = [ 0x2B,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_91 = [ 0xFF ];
immutable ubyte[] enemyBank9_92 = [ 0xFF ];
immutable ubyte[] enemyBank9_93 = [ 0x15,0x6A,0xB8,0x80, 0xFF ];
immutable ubyte[] enemyBank9_94 = [ 0x1B,0x12,0xA8,0x70, 0xFF ];
immutable ubyte[] enemyBank9_95 = [ 0xFF ];
immutable ubyte[] enemyBank9_96 = [ 0x31,0xD3,0xF0,0xA4, 0xFF ];
immutable ubyte[] enemyBank9_97 = [ 0x32,0xD3,0x40,0xA4, 0xFF ];
immutable ubyte[] enemyBank9_98 = [ 0xFF ];
immutable ubyte[] enemyBank9_99 = [ 0x35,0xD3,0xC0,0xA4, 0xFF ];
immutable ubyte[] enemyBank9_9A = [ 0x36,0xD3,0x88,0xA4, 0xFF ];
immutable ubyte[] enemyBank9_9B = [ 0xFF ];
immutable ubyte[] enemyBank9_9C = [ 0xFF ];
immutable ubyte[] enemyBank9_9D = [ 0x22,0x6E,0xB8,0x48, 0x23,0x6E,0xC0,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_9E = [ 0xFF ];
immutable ubyte[] enemyBank9_9F = [ 0xFF ];
immutable ubyte[] enemyBank9_A0 = [ 0x2C,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_A1 = [ 0xFF ];
immutable ubyte[] enemyBank9_A2 = [ 0xFF ];
immutable ubyte[] enemyBank9_A3 = [ 0x14,0x6A,0xB8,0x80, 0xFF ];
immutable ubyte[] enemyBank9_A4 = [ 0x1A,0x12,0xB0,0x50, 0xFF ];
immutable ubyte[] enemyBank9_A5 = [ 0xFF ];
immutable ubyte[] enemyBank9_A6 = [ 0x0F,0x9D,0x28,0x98, 0xFF ];
immutable ubyte[] enemyBank9_A7 = [ 0xFF ];
immutable ubyte[] enemyBank9_A8 = [ 0xFF ];
immutable ubyte[] enemyBank9_A9 = [ 0xFF ];
immutable ubyte[] enemyBank9_AA = [ 0xFF ];
immutable ubyte[] enemyBank9_AB = [ 0xFF ];
immutable ubyte[] enemyBank9_AC = [ 0xFF ];
immutable ubyte[] enemyBank9_AD = [ 0xFF ];
immutable ubyte[] enemyBank9_AE = [ 0xFF ];
immutable ubyte[] enemyBank9_AF = [ 0xFF ];
immutable ubyte[] enemyBank9_B0 = [ 0x2D,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBank9_B1 = [ 0xFF ];
immutable ubyte[] enemyBank9_B2 = [ 0xFF ];
immutable ubyte[] enemyBank9_B3 = [ 0x13,0x6A,0xB8,0x80, 0xFF ];
immutable ubyte[] enemyBank9_B4 = [ 0x19,0x12,0xA8,0x70, 0xFF ];
immutable ubyte[] enemyBank9_B5 = [ 0xFF ];
immutable ubyte[] enemyBank9_B6 = [ 0xFF ];
immutable ubyte[] enemyBank9_B7 = [ 0xFF ];
immutable ubyte[] enemyBank9_B8 = [ 0x27,0xD8,0x48,0x80, 0x0E,0x9D,0x48,0x97, 0xFF ];
immutable ubyte[] enemyBank9_B9 = [ 0x28,0xD8,0x48,0x80, 0xFF ];
immutable ubyte[] enemyBank9_BA = [ 0x29,0xD8,0x48,0x80, 0xFF ];
immutable ubyte[] enemyBank9_BB = [ 0x2A,0xD8,0x48,0x80, 0xFF ];
immutable ubyte[] enemyBank9_BC = [ 0x2B,0xD8,0x48,0x80, 0x0F,0x9B,0x48,0x94, 0xFF ];
immutable ubyte[] enemyBank9_BD = [ 0xFF ];
immutable ubyte[] enemyBank9_BE = [ 0xFF ];
immutable ubyte[] enemyBank9_BF = [ 0xFF ];
immutable ubyte[] enemyBank9_C0 = [ 0x2E,0x6A,0x80,0x40, 0xFF ];
immutable ubyte[] enemyBank9_C1 = [ 0xFF ];
immutable ubyte[] enemyBank9_C2 = [ 0xFF ];
immutable ubyte[] enemyBank9_C3 = [ 0x12,0x6A,0xB8,0x80, 0xFF ];
immutable ubyte[] enemyBank9_C4 = [ 0x18,0x12,0xA8,0x70, 0xFF ];
immutable ubyte[] enemyBank9_C5 = [ 0xFF ];
immutable ubyte[] enemyBank9_C6 = [ 0xFF ];
immutable ubyte[] enemyBank9_C7 = [ 0xFF ];
immutable ubyte[] enemyBank9_C8 = [ 0x19,0x1B,0xE0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_C9 = [ 0x1A,0x1B,0x40,0x9C, 0x1B,0x1B,0xC0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_CA = [ 0x1C,0x1B,0x40,0x9C, 0x1D,0x1B,0xC0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_CB = [ 0x1E,0x1B,0x40,0x9C, 0x1F,0x1B,0xC0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_CC = [ 0x20,0x1B,0x80,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_CD = [ 0x21,0x1B,0x20,0x9C, 0x22,0xD8,0x60,0x80, 0xFF ];
immutable ubyte[] enemyBank9_CE = [ 0x23,0xD8,0x00,0x80, 0x24,0xD8,0x60,0x80, 0xFF ];
immutable ubyte[] enemyBank9_CF = [ 0xFF ];
immutable ubyte[] enemyBank9_D0 = [ 0x2F,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBank9_D1 = [ 0xFF ];
immutable ubyte[] enemyBank9_D2 = [ 0xFF ];
immutable ubyte[] enemyBank9_D3 = [ 0x1F,0x6A,0xB8,0x80, 0xFF ];
immutable ubyte[] enemyBank9_D4 = [ 0x17,0x12,0x88,0x80, 0xFF ];
immutable ubyte[] enemyBank9_D5 = [ 0xFF ];
immutable ubyte[] enemyBank9_D6 = [ 0x13,0xD8,0x98,0x80, 0x14,0x1B,0xF0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_D7 = [ 0x15,0x1B,0x40,0x9C, 0x16,0x1B,0xC0,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_D8 = [ 0x17,0x1B,0x00,0x9C, 0x18,0x1B,0x50,0x9C, 0xFF ];
immutable ubyte[] enemyBank9_D9 = [ 0xFF ];
immutable ubyte[] enemyBank9_DA = [ 0xFF ];
immutable ubyte[] enemyBank9_DB = [ 0xFF ];
immutable ubyte[] enemyBank9_DC = [ 0xFF ];
immutable ubyte[] enemyBank9_DD = [ 0xFF ];
immutable ubyte[] enemyBank9_DE = [ 0xFF ];
immutable ubyte[] enemyBank9_DF = [ 0xFF ];
immutable ubyte[] enemyBank9_E0 = [ 0x30,0x6A,0x80,0x40, 0xFF ];
immutable ubyte[] enemyBank9_E1 = [ 0xFF ];
immutable ubyte[] enemyBank9_E2 = [ 0xFF ];
immutable ubyte[] enemyBank9_E3 = [ 0x10,0x6A,0xF0,0x60, 0xFF ];
immutable ubyte[] enemyBank9_E4 = [ 0xFF ];
immutable ubyte[] enemyBank9_E5 = [ 0x10,0x1B,0xB8,0xBC, 0xFF ];
immutable ubyte[] enemyBank9_E6 = [ 0x11,0x1B,0x00,0xBC, 0x12,0xD8,0x40,0x60, 0xFF ];
immutable ubyte[] enemyBank9_E7 = [ 0xFF ];
immutable ubyte[] enemyBank9_E8 = [ 0xFF ];
immutable ubyte[] enemyBank9_E9 = [ 0xFF ];
immutable ubyte[] enemyBank9_EA = [ 0xFF ];
immutable ubyte[] enemyBank9_EB = [ 0xFF ];
immutable ubyte[] enemyBank9_EC = [ 0xFF ];
immutable ubyte[] enemyBank9_ED = [ 0x26,0x1B,0xB8,0xBC, 0xFF ];
immutable ubyte[] enemyBank9_EE = [ 0x25,0x1B,0x58,0xAC, 0xFF ];
immutable ubyte[] enemyBank9_EF = [ 0xFF ];
immutable ubyte[] enemyBank9_F0 = [ 0xFF ];
immutable ubyte[] enemyBank9_F1 = [ 0xFF ];
immutable ubyte[] enemyBank9_F2 = [ 0xFF ];
immutable ubyte[] enemyBank9_F3 = [ 0x63,0x99,0x20,0xB0, 0xFF ];
immutable ubyte[] enemyBank9_F4 = [ 0xFF ];
immutable ubyte[] enemyBank9_F5 = [ 0xFF ];
immutable ubyte[] enemyBank9_F6 = [ 0xFF ];
immutable ubyte[] enemyBank9_F7 = [ 0xFF ];
immutable ubyte[] enemyBank9_F8 = [ 0xFF ];
immutable ubyte[] enemyBank9_F9 = [ 0xFF ];
immutable ubyte[] enemyBank9_FA = [ 0xFF ];
immutable ubyte[] enemyBank9_FB = [ 0xFF ];
immutable ubyte[] enemyBank9_FC = [ 0xFF ];
immutable ubyte[] enemyBank9_FD = [ 0xFF ];
immutable ubyte[] enemyBank9_FE = [ 0xFF ];
immutable ubyte[] enemyBank9_FF = [ 0xFF ];
immutable ubyte[] enemyBankA_00 = [ 0x14,0x12,0xD8,0x80, 0xFF ];
immutable ubyte[] enemyBankA_01 = [ 0xFF ];
immutable ubyte[] enemyBankA_02 = [ 0xFF ];
immutable ubyte[] enemyBankA_03 = [ 0xFF ];
immutable ubyte[] enemyBankA_04 = [ 0xFF ];
immutable ubyte[] enemyBankA_05 = [ 0xFF ];
immutable ubyte[] enemyBankA_06 = [ 0xFF ];
immutable ubyte[] enemyBankA_07 = [ 0xFF ];
immutable ubyte[] enemyBankA_08 = [ 0x1B,0x34,0x80,0x30, 0xFF ];
immutable ubyte[] enemyBankA_09 = [ 0x1C,0x31,0x90,0xB8, 0xFF ];
immutable ubyte[] enemyBankA_0A = [ 0x1D,0x30,0x90,0xB8, 0xFF ];
immutable ubyte[] enemyBankA_0B = [ 0x1F,0x34,0x78,0x30, 0x1E,0x31,0x80,0x80, 0x20,0x34,0xA8,0x30, 0xFF ];
immutable ubyte[] enemyBankA_0C = [ 0xFF ];
immutable ubyte[] enemyBankA_0D = [ 0xFF ];
immutable ubyte[] enemyBankA_0E = [ 0xFF ];
immutable ubyte[] enemyBankA_0F = [ 0xFF ];
immutable ubyte[] enemyBankA_10 = [ 0xFF ];
immutable ubyte[] enemyBankA_11 = [ 0x16,0x31,0x80,0x68, 0x17,0x30,0x90,0xC0, 0xFF ];
immutable ubyte[] enemyBankA_12 = [ 0xFF ];
immutable ubyte[] enemyBankA_13 = [ 0xFF ];
immutable ubyte[] enemyBankA_14 = [ 0xFF ];
immutable ubyte[] enemyBankA_15 = [ 0xFF ];
immutable ubyte[] enemyBankA_16 = [ 0x0F,0x9B,0x18,0x88, 0xFF ];
immutable ubyte[] enemyBankA_17 = [ 0x40,0xA4,0x98,0xA0, 0xFF ];
immutable ubyte[] enemyBankA_18 = [ 0xFF ];
immutable ubyte[] enemyBankA_19 = [ 0xFF ];
immutable ubyte[] enemyBankA_1A = [ 0x21,0x31,0x80,0x80, 0x22,0x12,0xC0,0x64, 0xFF ];
immutable ubyte[] enemyBankA_1B = [ 0x23,0x30,0x60,0x88, 0xFF ];
immutable ubyte[] enemyBankA_1C = [ 0xFF ];
immutable ubyte[] enemyBankA_1D = [ 0xFF ];
immutable ubyte[] enemyBankA_1E = [ 0xFF ];
immutable ubyte[] enemyBankA_1F = [ 0xFF ];
immutable ubyte[] enemyBankA_20 = [ 0xFF ];
immutable ubyte[] enemyBankA_21 = [ 0x18,0x34,0x48,0x10, 0xFF ];
immutable ubyte[] enemyBankA_22 = [ 0x10,0x34,0x90,0x80, 0xFF ];
immutable ubyte[] enemyBankA_23 = [ 0xFF ];
immutable ubyte[] enemyBankA_24 = [ 0xFF ];
immutable ubyte[] enemyBankA_25 = [ 0xFF ];
immutable ubyte[] enemyBankA_26 = [ 0xFF ];
immutable ubyte[] enemyBankA_27 = [ 0xFF ];
immutable ubyte[] enemyBankA_28 = [ 0xFF ];
immutable ubyte[] enemyBankA_29 = [ 0xFF ];
immutable ubyte[] enemyBankA_2A = [ 0x24,0x31,0x88,0x28, 0xFF ];
immutable ubyte[] enemyBankA_2B = [ 0xFF ];
immutable ubyte[] enemyBankA_2C = [ 0xFF ];
immutable ubyte[] enemyBankA_2D = [ 0xFF ];
immutable ubyte[] enemyBankA_2E = [ 0xFF ];
immutable ubyte[] enemyBankA_2F = [ 0xFF ];
immutable ubyte[] enemyBankA_30 = [ 0xFF ];
immutable ubyte[] enemyBankA_31 = [ 0x35,0x04,0x00,0x68, 0xFF ];
immutable ubyte[] enemyBankA_32 = [ 0x13,0x30,0x40,0x40, 0x14,0x31,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankA_33 = [ 0xFF ];
immutable ubyte[] enemyBankA_34 = [ 0xFF ];
immutable ubyte[] enemyBankA_35 = [ 0xFF ];
immutable ubyte[] enemyBankA_36 = [ 0x41,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankA_37 = [ 0x0F,0x9D,0xE8,0x78, 0xFF ];
immutable ubyte[] enemyBankA_38 = [ 0xFF ];
immutable ubyte[] enemyBankA_39 = [ 0xFF ];
immutable ubyte[] enemyBankA_3A = [ 0x25,0x30,0x88,0xC7, 0xFF ];
immutable ubyte[] enemyBankA_3B = [ 0xFF ];
immutable ubyte[] enemyBankA_3C = [ 0xFF ];
immutable ubyte[] enemyBankA_3D = [ 0xFF ];
immutable ubyte[] enemyBankA_3E = [ 0xFF ];
immutable ubyte[] enemyBankA_3F = [ 0xFF ];
immutable ubyte[] enemyBankA_40 = [ 0x10,0x6A,0xB0,0xC0, 0xFF ];
immutable ubyte[] enemyBankA_41 = [ 0xFF ];
immutable ubyte[] enemyBankA_42 = [ 0x16,0x34,0x80,0x70, 0x17,0x12,0xA0,0x80, 0xFF ];
immutable ubyte[] enemyBankA_43 = [ 0x15,0x31,0x80,0x58, 0xFF ];
immutable ubyte[] enemyBankA_44 = [ 0x0B,0x12,0xF0,0xA0, 0xFF ];
immutable ubyte[] enemyBankA_45 = [ 0x0C,0x14,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankA_46 = [ 0x0D,0x12,0x80,0xA8, 0xFF ];
immutable ubyte[] enemyBankA_47 = [ 0xFF ];
immutable ubyte[] enemyBankA_48 = [ 0xFF ];
immutable ubyte[] enemyBankA_49 = [ 0xFF ];
immutable ubyte[] enemyBankA_4A = [ 0xFF ];
immutable ubyte[] enemyBankA_4B = [ 0xFF ];
immutable ubyte[] enemyBankA_4C = [ 0xFF ];
immutable ubyte[] enemyBankA_4D = [ 0xFF ];
immutable ubyte[] enemyBankA_4E = [ 0xFF ];
immutable ubyte[] enemyBankA_4F = [ 0xFF ];
immutable ubyte[] enemyBankA_50 = [ 0x12,0x12,0x78,0x64, 0x13,0x12,0x98,0x94, 0xFF ];
immutable ubyte[] enemyBankA_51 = [ 0xFF ];
immutable ubyte[] enemyBankA_52 = [ 0xFF ];
immutable ubyte[] enemyBankA_53 = [ 0xFF ];
immutable ubyte[] enemyBankA_54 = [ 0x10,0x34,0x68,0x20, 0x11,0x34,0x88,0x20, 0x12,0x34,0xF8,0x80, 0xFF ];
immutable ubyte[] enemyBankA_55 = [ 0xFF ];
immutable ubyte[] enemyBankA_56 = [ 0xFF ];
immutable ubyte[] enemyBankA_57 = [ 0xFF ];
immutable ubyte[] enemyBankA_58 = [ 0xFF ];
immutable ubyte[] enemyBankA_59 = [ 0xFF ];
immutable ubyte[] enemyBankA_5A = [ 0xFF ];
immutable ubyte[] enemyBankA_5B = [ 0xFF ];
immutable ubyte[] enemyBankA_5C = [ 0xFF ];
immutable ubyte[] enemyBankA_5D = [ 0xFF ];
immutable ubyte[] enemyBankA_5E = [ 0xFF ];
immutable ubyte[] enemyBankA_5F = [ 0xFF ];
immutable ubyte[] enemyBankA_60 = [ 0x15,0x12,0x98,0x74, 0xFF ];
immutable ubyte[] enemyBankA_61 = [ 0xFF ];
immutable ubyte[] enemyBankA_62 = [ 0xFF ];
immutable ubyte[] enemyBankA_63 = [ 0xFF ];
immutable ubyte[] enemyBankA_64 = [ 0xFF ];
immutable ubyte[] enemyBankA_65 = [ 0x13,0x34,0x30,0xA0, 0x14,0x34,0x58,0x90, 0x15,0x12,0xB8,0x54, 0xFF ];
immutable ubyte[] enemyBankA_66 = [ 0x18,0x2C,0x64,0xFF, 0xFF ];
immutable ubyte[] enemyBankA_67 = [ 0xFF ];
immutable ubyte[] enemyBankA_68 = [ 0xFF ];
immutable ubyte[] enemyBankA_69 = [ 0xFF ];
immutable ubyte[] enemyBankA_6A = [ 0xFF ];
immutable ubyte[] enemyBankA_6B = [ 0xFF ];
immutable ubyte[] enemyBankA_6C = [ 0xFF ];
immutable ubyte[] enemyBankA_6D = [ 0xFF ];
immutable ubyte[] enemyBankA_6E = [ 0xFF ];
immutable ubyte[] enemyBankA_6F = [ 0xFF ];
immutable ubyte[] enemyBankA_70 = [ 0xFF ];
immutable ubyte[] enemyBankA_71 = [ 0xFF ];
immutable ubyte[] enemyBankA_72 = [ 0xFF ];
immutable ubyte[] enemyBankA_73 = [ 0xFF ];
immutable ubyte[] enemyBankA_74 = [ 0x16,0x12,0x80,0x5C, 0x17,0x34,0x90,0x80, 0x18,0x34,0xC8,0xA0, 0xFF ];
immutable ubyte[] enemyBankA_75 = [ 0xFF ];
immutable ubyte[] enemyBankA_76 = [ 0xFF ];
immutable ubyte[] enemyBankA_77 = [ 0x60,0x75,0x88,0x98, 0x61,0x75,0x88,0xA8, 0xFF ];
immutable ubyte[] enemyBankA_78 = [ 0xFF ];
immutable ubyte[] enemyBankA_79 = [ 0xFF ];
immutable ubyte[] enemyBankA_7A = [ 0xFF ];
immutable ubyte[] enemyBankA_7B = [ 0xFF ];
immutable ubyte[] enemyBankA_7C = [ 0xFF ];
immutable ubyte[] enemyBankA_7D = [ 0xFF ];
immutable ubyte[] enemyBankA_7E = [ 0xFF ];
immutable ubyte[] enemyBankA_7F = [ 0xFF ];
immutable ubyte[] enemyBankA_80 = [ 0x12,0x30,0xF0,0xC8, 0x13,0x34,0xF8,0xE0, 0xFF ];
immutable ubyte[] enemyBankA_81 = [ 0x10,0x34,0x78,0x30, 0x11,0x34,0x88,0xA0, 0xFF ];
immutable ubyte[] enemyBankA_82 = [ 0xFF ];
immutable ubyte[] enemyBankA_83 = [ 0xFF ];
immutable ubyte[] enemyBankA_84 = [ 0x19,0x34,0x88,0x20, 0x1A,0x34,0x90,0x80, 0x1B,0x34,0xA8,0x90, 0xFF ];
immutable ubyte[] enemyBankA_85 = [ 0x1C,0x12,0x30,0xDC, 0x1D,0x34,0x48,0x80, 0x1E,0x34,0x90,0x70, 0xFF ];
immutable ubyte[] enemyBankA_86 = [ 0xFF ];
immutable ubyte[] enemyBankA_87 = [ 0xFF ];
immutable ubyte[] enemyBankA_88 = [ 0xFF ];
immutable ubyte[] enemyBankA_89 = [ 0xFF ];
immutable ubyte[] enemyBankA_8A = [ 0xFF ];
immutable ubyte[] enemyBankA_8B = [ 0xFF ];
immutable ubyte[] enemyBankA_8C = [ 0xFF ];
immutable ubyte[] enemyBankA_8D = [ 0xFF ];
immutable ubyte[] enemyBankA_8E = [ 0xFF ];
immutable ubyte[] enemyBankA_8F = [ 0xFF ];
immutable ubyte[] enemyBankA_90 = [ 0x14,0x2A,0x18,0x60, 0x15,0x34,0x88,0x20, 0xFF ];
immutable ubyte[] enemyBankA_91 = [ 0xFF ];
immutable ubyte[] enemyBankA_92 = [ 0xFF ];
immutable ubyte[] enemyBankA_93 = [ 0xFF ];
immutable ubyte[] enemyBankA_94 = [ 0xFF ];
immutable ubyte[] enemyBankA_95 = [ 0xFF ];
immutable ubyte[] enemyBankA_96 = [ 0xFF ];
immutable ubyte[] enemyBankA_97 = [ 0x1C,0x12,0x88,0xC8, 0x1D,0x12,0xA8,0xA8, 0x1E,0x12,0xB0,0x40, 0xFF ];
immutable ubyte[] enemyBankA_98 = [ 0xFF ];
immutable ubyte[] enemyBankA_99 = [ 0xFF ];
immutable ubyte[] enemyBankA_9A = [ 0xFF ];
immutable ubyte[] enemyBankA_9B = [ 0xFF ];
immutable ubyte[] enemyBankA_9C = [ 0xFF ];
immutable ubyte[] enemyBankA_9D = [ 0xFF ];
immutable ubyte[] enemyBankA_9E = [ 0xFF ];
immutable ubyte[] enemyBankA_9F = [ 0xFF ];
immutable ubyte[] enemyBankA_A0 = [ 0x1A,0x34,0xC0,0x90, 0xFF ];
immutable ubyte[] enemyBankA_A1 = [ 0x19,0x2B,0xF8,0x80, 0xFF ];
immutable ubyte[] enemyBankA_A2 = [ 0xFF ];
immutable ubyte[] enemyBankA_A3 = [ 0xFF ];
immutable ubyte[] enemyBankA_A4 = [ 0xFF ];
immutable ubyte[] enemyBankA_A5 = [ 0xFF ];
immutable ubyte[] enemyBankA_A6 = [ 0xFF ];
immutable ubyte[] enemyBankA_A7 = [ 0x1F,0x12,0x40,0xBC, 0xFF ];
immutable ubyte[] enemyBankA_A8 = [ 0xFF ];
immutable ubyte[] enemyBankA_A9 = [ 0xFF ];
immutable ubyte[] enemyBankA_AA = [ 0xFF ];
immutable ubyte[] enemyBankA_AB = [ 0xFF ];
immutable ubyte[] enemyBankA_AC = [ 0xFF ];
immutable ubyte[] enemyBankA_AD = [ 0xFF ];
immutable ubyte[] enemyBankA_AE = [ 0xFF ];
immutable ubyte[] enemyBankA_AF = [ 0xFF ];
immutable ubyte[] enemyBankA_B0 = [ 0x1B,0x2C,0x30,0x78, 0xFF ];
immutable ubyte[] enemyBankA_B1 = [ 0xFF ];
immutable ubyte[] enemyBankA_B2 = [ 0xFF ];
immutable ubyte[] enemyBankA_B3 = [ 0xFF ];
immutable ubyte[] enemyBankA_B4 = [ 0xFF ];
immutable ubyte[] enemyBankA_B5 = [ 0xFF ];
immutable ubyte[] enemyBankA_B6 = [ 0xFF ];
immutable ubyte[] enemyBankA_B7 = [ 0xFF ];
immutable ubyte[] enemyBankA_B8 = [ 0xFF ];
immutable ubyte[] enemyBankA_B9 = [ 0xFF ];
immutable ubyte[] enemyBankA_BA = [ 0xFF ];
immutable ubyte[] enemyBankA_BB = [ 0xFF ];
immutable ubyte[] enemyBankA_BC = [ 0xFF ];
immutable ubyte[] enemyBankA_BD = [ 0xFF ];
immutable ubyte[] enemyBankA_BE = [ 0xFF ];
immutable ubyte[] enemyBankA_BF = [ 0xFF ];
immutable ubyte[] enemyBankA_C0 = [ 0x1F,0x29,0xA8,0xF8, 0xFF ];
immutable ubyte[] enemyBankA_C1 = [ 0x1C,0x31,0x50,0x48, 0x1D,0x31,0x70,0x58, 0x1E,0x34,0x78,0x20, 0xFF ];
immutable ubyte[] enemyBankA_C2 = [ 0xFF ];
immutable ubyte[] enemyBankA_C3 = [ 0xFF ];
immutable ubyte[] enemyBankA_C4 = [ 0xFF ];
immutable ubyte[] enemyBankA_C5 = [ 0xFF ];
immutable ubyte[] enemyBankA_C6 = [ 0x20,0x29,0x78,0x18, 0x21,0x28,0xB0,0xF8, 0xFF ];
immutable ubyte[] enemyBankA_C7 = [ 0x1E,0x29,0x50,0x28, 0x1F,0x28,0x90,0x98, 0xFF ];
immutable ubyte[] enemyBankA_C8 = [ 0xFF ];
immutable ubyte[] enemyBankA_C9 = [ 0xFF ];
immutable ubyte[] enemyBankA_CA = [ 0xFF ];
immutable ubyte[] enemyBankA_CB = [ 0xFF ];
immutable ubyte[] enemyBankA_CC = [ 0xFF ];
immutable ubyte[] enemyBankA_CD = [ 0xFF ];
immutable ubyte[] enemyBankA_CE = [ 0xFF ];
immutable ubyte[] enemyBankA_CF = [ 0xFF ];
immutable ubyte[] enemyBankA_D0 = [ 0x20,0x34,0x88,0x20, 0xFF ];
immutable ubyte[] enemyBankA_D1 = [ 0xFF ];
immutable ubyte[] enemyBankA_D2 = [ 0xFF ];
immutable ubyte[] enemyBankA_D3 = [ 0xFF ];
immutable ubyte[] enemyBankA_D4 = [ 0xFF ];
immutable ubyte[] enemyBankA_D5 = [ 0xFF ];
immutable ubyte[] enemyBankA_D6 = [ 0x22,0x2A,0x18,0x70, 0x23,0x2A,0x58,0xD0, 0xFF ];
immutable ubyte[] enemyBankA_D7 = [ 0x24,0x28,0x70,0xF8, 0x25,0x28,0xC0,0xB8, 0xFF ];
immutable ubyte[] enemyBankA_D8 = [ 0xFF ];
immutable ubyte[] enemyBankA_D9 = [ 0xFF ];
immutable ubyte[] enemyBankA_DA = [ 0xFF ];
immutable ubyte[] enemyBankA_DB = [ 0xFF ];
immutable ubyte[] enemyBankA_DC = [ 0xFF ];
immutable ubyte[] enemyBankA_DD = [ 0xFF ];
immutable ubyte[] enemyBankA_DE = [ 0xFF ];
immutable ubyte[] enemyBankA_DF = [ 0xFF ];
immutable ubyte[] enemyBankA_E0 = [ 0xFF ];
immutable ubyte[] enemyBankA_E1 = [ 0x21,0x28,0xB0,0xD8, 0x22,0x28,0xD0,0xC8, 0xFF ];
immutable ubyte[] enemyBankA_E2 = [ 0xFF ];
immutable ubyte[] enemyBankA_E3 = [ 0xFF ];
immutable ubyte[] enemyBankA_E4 = [ 0xFF ];
immutable ubyte[] enemyBankA_E5 = [ 0xFF ];
immutable ubyte[] enemyBankA_E6 = [ 0xFF ];
immutable ubyte[] enemyBankA_E7 = [ 0xFF ];
immutable ubyte[] enemyBankA_E8 = [ 0xFF ];
immutable ubyte[] enemyBankA_E9 = [ 0xFF ];
immutable ubyte[] enemyBankA_EA = [ 0xFF ];
immutable ubyte[] enemyBankA_EB = [ 0xFF ];
immutable ubyte[] enemyBankA_EC = [ 0xFF ];
immutable ubyte[] enemyBankA_ED = [ 0xFF ];
immutable ubyte[] enemyBankA_EE = [ 0xFF ];
immutable ubyte[] enemyBankA_EF = [ 0xFF ];
immutable ubyte[] enemyBankA_F0 = [ 0xFF ];
immutable ubyte[] enemyBankA_F1 = [ 0xFF ];
immutable ubyte[] enemyBankA_F2 = [ 0xFF ];
immutable ubyte[] enemyBankA_F3 = [ 0xFF ];
immutable ubyte[] enemyBankA_F4 = [ 0xFF ];
immutable ubyte[] enemyBankA_F5 = [ 0x44,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankA_F6 = [ 0x26,0x2C,0x40,0x80, 0x27,0x2C,0x40,0xC0, 0xFF ];
immutable ubyte[] enemyBankA_F7 = [ 0xFF ];
immutable ubyte[] enemyBankA_F8 = [ 0x45,0xAD,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankA_F9 = [ 0xFF ];
immutable ubyte[] enemyBankA_FA = [ 0xFF ];
immutable ubyte[] enemyBankA_FB = [ 0xFF ];
immutable ubyte[] enemyBankA_FC = [ 0xFF ];
immutable ubyte[] enemyBankA_FD = [ 0xFF ];
immutable ubyte[] enemyBankA_FE = [ 0xFF ];
immutable ubyte[] enemyBankA_FF = [ 0xFF ];
immutable ubyte[] enemyBankB_00 = [ 0xFF ];
immutable ubyte[] enemyBankB_01 = [ 0x42,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_02 = [ 0xFF ];
immutable ubyte[] enemyBankB_03 = [ 0xFF ];
immutable ubyte[] enemyBankB_04 = [ 0x4E,0xAD,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_05 = [ 0xFF ];
immutable ubyte[] enemyBankB_06 = [ 0xFF ];
immutable ubyte[] enemyBankB_07 = [ 0xFF ];
immutable ubyte[] enemyBankB_08 = [ 0xFF ];
immutable ubyte[] enemyBankB_09 = [ 0xFF ];
immutable ubyte[] enemyBankB_0A = [ 0xFF ];
immutable ubyte[] enemyBankB_0B = [ 0xFF ];
immutable ubyte[] enemyBankB_0C = [ 0xFF ];
immutable ubyte[] enemyBankB_0D = [ 0x11,0x12,0xD0,0x88, 0xFF ];
immutable ubyte[] enemyBankB_0E = [ 0x12,0x12,0x40,0x90, 0x13,0x12,0x98,0x80, 0xFF ];
immutable ubyte[] enemyBankB_0F = [ 0xFF ];
immutable ubyte[] enemyBankB_10 = [ 0xFF ];
immutable ubyte[] enemyBankB_11 = [ 0xFF ];
immutable ubyte[] enemyBankB_12 = [ 0xFF ];
immutable ubyte[] enemyBankB_13 = [ 0x15,0x1B,0x90,0xEC, 0x16,0x12,0xD0,0x90, 0x17,0x1B,0xE8,0xEC, 0xFF ];
immutable ubyte[] enemyBankB_14 = [ 0x1A,0x1B,0xE0,0xEC, 0xFF ];
immutable ubyte[] enemyBankB_15 = [ 0x1C,0x1B,0x60,0xEC, 0xFF ];
immutable ubyte[] enemyBankB_16 = [ 0x20,0x19,0xD0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_17 = [ 0x21,0x1A,0x30,0xF0, 0x22,0x19,0xB0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_18 = [ 0x23,0x1A,0x70,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_19 = [ 0xFF ];
immutable ubyte[] enemyBankB_1A = [ 0xFF ];
immutable ubyte[] enemyBankB_1B = [ 0x27,0x12,0x90,0xDC, 0x28,0x12,0xB0,0x8C, 0xFF ];
immutable ubyte[] enemyBankB_1C = [ 0x0F,0x9B,0x28,0x48, 0x29,0xD8,0x38,0x8C, 0x2A,0xD8,0x78,0xAC, 0x2B,0xD8,0xB8,0x90, 0xFF ];
immutable ubyte[] enemyBankB_1D = [ 0x2C,0xD8,0x38,0xBC, 0x2D,0xD8,0x78,0x98, 0x2E,0x12,0xF0,0x98, 0xFF ];
immutable ubyte[] enemyBankB_1E = [ 0x2F,0xD8,0x13,0x70, 0x31,0xD8,0x70,0x90, 0x32,0xD8,0xA0,0x50, 0xFF ];
immutable ubyte[] enemyBankB_1F = [ 0xFF ];
immutable ubyte[] enemyBankB_20 = [ 0xFF ];
immutable ubyte[] enemyBankB_21 = [ 0xFF ];
immutable ubyte[] enemyBankB_22 = [ 0x40,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_23 = [ 0xFF ];
immutable ubyte[] enemyBankB_24 = [ 0x30,0x65,0x48,0x98, 0x31,0x65,0x78,0xA0, 0x32,0x65,0xA8,0x90, 0xFF ];
immutable ubyte[] enemyBankB_25 = [ 0x33,0x65,0x38,0xA0, 0x34,0x65,0x68,0x90, 0x35,0x65,0x98,0xA0, 0xFF ];
immutable ubyte[] enemyBankB_26 = [ 0xFF ];
immutable ubyte[] enemyBankB_27 = [ 0xFF ];
immutable ubyte[] enemyBankB_28 = [ 0x2E,0x3C,0xD0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_29 = [ 0x2F,0x3D,0x30,0xF0, 0x30,0x3C,0xB0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_2A = [ 0x31,0x3D,0x30,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_2B = [ 0xFF ];
immutable ubyte[] enemyBankB_2C = [ 0xFF ];
immutable ubyte[] enemyBankB_2D = [ 0xFF ];
immutable ubyte[] enemyBankB_2E = [ 0x41,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_2F = [ 0xFF ];
immutable ubyte[] enemyBankB_30 = [ 0xFF ];
immutable ubyte[] enemyBankB_31 = [ 0xFF ];
immutable ubyte[] enemyBankB_32 = [ 0xFF ];
immutable ubyte[] enemyBankB_33 = [ 0xFF ];
immutable ubyte[] enemyBankB_34 = [ 0xFF ];
immutable ubyte[] enemyBankB_35 = [ 0xFF ];
immutable ubyte[] enemyBankB_36 = [ 0xFF ];
immutable ubyte[] enemyBankB_37 = [ 0xFF ];
immutable ubyte[] enemyBankB_38 = [ 0xFF ];
immutable ubyte[] enemyBankB_39 = [ 0x43,0xA4,0x80,0x90, 0xFF ];
immutable ubyte[] enemyBankB_3A = [ 0xFF ];
immutable ubyte[] enemyBankB_3B = [ 0x44,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_3C = [ 0xFF ];
immutable ubyte[] enemyBankB_3D = [ 0xFF ];
immutable ubyte[] enemyBankB_3E = [ 0xFF ];
immutable ubyte[] enemyBankB_3F = [ 0xFF ];
immutable ubyte[] enemyBankB_40 = [ 0x1E,0x40,0xA0,0xC0, 0x1F,0x40,0xE0,0xB0, 0xFF ];
immutable ubyte[] enemyBankB_41 = [ 0x20,0x40,0x40,0x80, 0x21,0x40,0xC8,0x80, 0xFF ];
immutable ubyte[] enemyBankB_42 = [ 0x22,0x40,0x70,0xD0, 0x23,0x40,0xF0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_43 = [ 0x24,0x40,0x60,0xC0, 0x25,0x40,0x80,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_44 = [ 0xFF ];
immutable ubyte[] enemyBankB_45 = [ 0x45,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_46 = [ 0xFF ];
immutable ubyte[] enemyBankB_47 = [ 0xFF ];
immutable ubyte[] enemyBankB_48 = [ 0xFF ];
immutable ubyte[] enemyBankB_49 = [ 0xFF ];
immutable ubyte[] enemyBankB_4A = [ 0xFF ];
immutable ubyte[] enemyBankB_4B = [ 0xFF ];
immutable ubyte[] enemyBankB_4C = [ 0xFF ];
immutable ubyte[] enemyBankB_4D = [ 0xFF ];
immutable ubyte[] enemyBankB_4E = [ 0xFF ];
immutable ubyte[] enemyBankB_4F = [ 0xFF ];
immutable ubyte[] enemyBankB_50 = [ 0xFF ];
immutable ubyte[] enemyBankB_51 = [ 0x16,0x09,0xA0,0x98, 0x17,0x04,0xD0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_52 = [ 0x0C,0x04,0x08,0xE8, 0x14,0x09,0x90,0x98, 0xFF ];
immutable ubyte[] enemyBankB_53 = [ 0x15,0x04,0x08,0xE8, 0x12,0x09,0x80,0x98, 0x13,0x04,0xFF,0xE8, 0xFF ];
immutable ubyte[] enemyBankB_54 = [ 0x10,0x04,0x68,0xE8, 0x11,0x09,0x70,0x98, 0xFF ];
immutable ubyte[] enemyBankB_55 = [ 0xFF ];
immutable ubyte[] enemyBankB_56 = [ 0xFF ];
immutable ubyte[] enemyBankB_57 = [ 0x47,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_58 = [ 0xFF ];
immutable ubyte[] enemyBankB_59 = [ 0xFF ];
immutable ubyte[] enemyBankB_5A = [ 0xFF ];
immutable ubyte[] enemyBankB_5B = [ 0xFF ];
immutable ubyte[] enemyBankB_5C = [ 0xFF ];
immutable ubyte[] enemyBankB_5D = [ 0xFF ];
immutable ubyte[] enemyBankB_5E = [ 0xFF ];
immutable ubyte[] enemyBankB_5F = [ 0xFF ];
immutable ubyte[] enemyBankB_60 = [ 0xFF ];
immutable ubyte[] enemyBankB_61 = [ 0xFF ];
immutable ubyte[] enemyBankB_62 = [ 0x18,0x68,0x40,0xC8, 0x19,0x68,0xC0,0xB8, 0xFF ];
immutable ubyte[] enemyBankB_63 = [ 0x1A,0x68,0x40,0xA8, 0x1B,0x68,0x80,0xB8, 0xFF ];
immutable ubyte[] enemyBankB_64 = [ 0xFF ];
immutable ubyte[] enemyBankB_65 = [ 0xFF ];
immutable ubyte[] enemyBankB_66 = [ 0x49,0xA0,0x80,0xB6, 0xFF ];
immutable ubyte[] enemyBankB_67 = [ 0xFF ];
immutable ubyte[] enemyBankB_68 = [ 0xFF ];
immutable ubyte[] enemyBankB_69 = [ 0xFF ];
immutable ubyte[] enemyBankB_6A = [ 0xFF ];
immutable ubyte[] enemyBankB_6B = [ 0x2D,0x6A,0x80,0x40, 0x2E,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankB_6C = [ 0x2F,0x6A,0x80,0x40, 0x30,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankB_6D = [ 0x31,0x6A,0x80,0x40, 0x32,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankB_6E = [ 0x33,0x6A,0x80,0x40, 0x34,0x6A,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankB_6F = [ 0xFF ];
immutable ubyte[] enemyBankB_70 = [ 0xFF ];
immutable ubyte[] enemyBankB_71 = [ 0xFF ];
immutable ubyte[] enemyBankB_72 = [ 0xFF ];
immutable ubyte[] enemyBankB_73 = [ 0xFF ];
immutable ubyte[] enemyBankB_74 = [ 0xFF ];
immutable ubyte[] enemyBankB_75 = [ 0xFF ];
immutable ubyte[] enemyBankB_76 = [ 0x4A,0xB3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_77 = [ 0xFF ];
immutable ubyte[] enemyBankB_78 = [ 0xFF ];
immutable ubyte[] enemyBankB_79 = [ 0xFF ];
immutable ubyte[] enemyBankB_7A = [ 0xFF ];
immutable ubyte[] enemyBankB_7B = [ 0xFF ];
immutable ubyte[] enemyBankB_7C = [ 0xFF ];
immutable ubyte[] enemyBankB_7D = [ 0xFF ];
immutable ubyte[] enemyBankB_7E = [ 0xFF ];
immutable ubyte[] enemyBankB_7F = [ 0xFF ];
immutable ubyte[] enemyBankB_80 = [ 0xFF ];
immutable ubyte[] enemyBankB_81 = [ 0xFF ];
immutable ubyte[] enemyBankB_82 = [ 0xFF ];
immutable ubyte[] enemyBankB_83 = [ 0xFF ];
immutable ubyte[] enemyBankB_84 = [ 0xFF ];
immutable ubyte[] enemyBankB_85 = [ 0xFF ];
immutable ubyte[] enemyBankB_86 = [ 0xFF ];
immutable ubyte[] enemyBankB_87 = [ 0xFF ];
immutable ubyte[] enemyBankB_88 = [ 0xFF ];
immutable ubyte[] enemyBankB_89 = [ 0x32,0x3C,0xA0,0xE0, 0x33,0x3D,0xFF,0xE0, 0xFF ];
immutable ubyte[] enemyBankB_8A = [ 0x34,0x3C,0x68,0xE0, 0xFF ];
immutable ubyte[] enemyBankB_8B = [ 0xFF ];
immutable ubyte[] enemyBankB_8C = [ 0xFF ];
immutable ubyte[] enemyBankB_8D = [ 0x4C,0xB3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_8E = [ 0xFF ];
immutable ubyte[] enemyBankB_8F = [ 0xFF ];
immutable ubyte[] enemyBankB_90 = [ 0xFF ];
immutable ubyte[] enemyBankB_91 = [ 0xFF ];
immutable ubyte[] enemyBankB_92 = [ 0xFF ];
immutable ubyte[] enemyBankB_93 = [ 0xFF ];
immutable ubyte[] enemyBankB_94 = [ 0xFF ];
immutable ubyte[] enemyBankB_95 = [ 0xFF ];
immutable ubyte[] enemyBankB_96 = [ 0xFF ];
immutable ubyte[] enemyBankB_97 = [ 0x30,0x30,0x68,0xA8, 0x31,0x31,0xC0,0x80, 0xFF ];
immutable ubyte[] enemyBankB_98 = [ 0x2E,0x31,0x40,0x80, 0x2F,0x30,0xB0,0x58, 0xFF ];
immutable ubyte[] enemyBankB_99 = [ 0x2C,0x31,0x40,0x80, 0x2D,0x30,0xB0,0x58, 0xFF ];
immutable ubyte[] enemyBankB_9A = [ 0x2A,0x31,0x40,0x98, 0x2B,0x30,0x88,0x98, 0xFF ];
immutable ubyte[] enemyBankB_9B = [ 0x12,0x28,0xA0,0xD8, 0x13,0x28,0xD8,0xC8, 0xFF ];
immutable ubyte[] enemyBankB_9C = [ 0x10,0x28,0x20,0xA8, 0x11,0x28,0x68,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_9D = [ 0xFF ];
immutable ubyte[] enemyBankB_9E = [ 0x18,0x68,0x40,0xC8, 0x19,0x68,0xC0,0xB8, 0xFF ];
immutable ubyte[] enemyBankB_9F = [ 0x1A,0x68,0x40,0xA8, 0xFF ];
immutable ubyte[] enemyBankB_A0 = [ 0xFF ];
immutable ubyte[] enemyBankB_A1 = [ 0xFF ];
immutable ubyte[] enemyBankB_A2 = [ 0xFF ];
immutable ubyte[] enemyBankB_A3 = [ 0xFF ];
immutable ubyte[] enemyBankB_A4 = [ 0xFF ];
immutable ubyte[] enemyBankB_A5 = [ 0xFF ];
immutable ubyte[] enemyBankB_A6 = [ 0xFF ];
immutable ubyte[] enemyBankB_A7 = [ 0x46,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_A8 = [ 0xFF ];
immutable ubyte[] enemyBankB_A9 = [ 0x35,0x12,0xA0,0xB4, 0x36,0x12,0xA8,0xD4, 0x37,0x12,0xAC,0xFC, 0xFF ];
immutable ubyte[] enemyBankB_AA = [ 0xFF ];
immutable ubyte[] enemyBankB_AB = [ 0x4F,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_AC = [ 0xFF ];
immutable ubyte[] enemyBankB_AD = [ 0xFF ];
immutable ubyte[] enemyBankB_AE = [ 0xFF ];
immutable ubyte[] enemyBankB_AF = [ 0xFF ];
immutable ubyte[] enemyBankB_B0 = [ 0xFF ];
immutable ubyte[] enemyBankB_B1 = [ 0xFF ];
immutable ubyte[] enemyBankB_B2 = [ 0xFF ];
immutable ubyte[] enemyBankB_B3 = [ 0xFF ];
immutable ubyte[] enemyBankB_B4 = [ 0xFF ];
immutable ubyte[] enemyBankB_B5 = [ 0xFF ];
immutable ubyte[] enemyBankB_B6 = [ 0xFF ];
immutable ubyte[] enemyBankB_B7 = [ 0xFF ];
immutable ubyte[] enemyBankB_B8 = [ 0x18,0x12,0xA0,0xAC, 0x19,0x12,0xA8,0xD4, 0x1A,0x12,0xC0,0xFC, 0xFF ];
immutable ubyte[] enemyBankB_B9 = [ 0xFF ];
immutable ubyte[] enemyBankB_BA = [ 0x10,0x1B,0x90,0xBE, 0x11,0x1B,0xD0,0xDE, 0xFF ];
immutable ubyte[] enemyBankB_BB = [ 0x12,0x1B,0x10,0xAE, 0x13,0x1B,0x70,0xBE, 0x14,0x1B,0xC0,0xDE, 0xFF ];
immutable ubyte[] enemyBankB_BC = [ 0x15,0x1B,0x40,0xDE, 0x16,0x1B,0x80,0xBE, 0x17,0x1B,0xB0,0xDE, 0xFF ];
immutable ubyte[] enemyBankB_BD = [ 0xFF ];
immutable ubyte[] enemyBankB_BE = [ 0x50,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_BF = [ 0xFF ];
immutable ubyte[] enemyBankB_C0 = [ 0x1C,0x12,0x80,0x80, 0x1D,0x3D,0xA0,0xF0, 0xFF ];
immutable ubyte[] enemyBankB_C1 = [ 0x1A,0x3C,0x08,0xF0, 0x1B,0x2C,0xF0,0xC8, 0xFF ];
immutable ubyte[] enemyBankB_C2 = [ 0x18,0x28,0x80,0xE8, 0x19,0x28,0xB0,0xE8, 0xFF ];
immutable ubyte[] enemyBankB_C3 = [ 0x16,0x31,0x58,0xA8, 0x17,0x30,0x78,0xB8, 0xFF ];
immutable ubyte[] enemyBankB_C4 = [ 0x51,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_C5 = [ 0xFF ];
immutable ubyte[] enemyBankB_C6 = [ 0xFF ];
immutable ubyte[] enemyBankB_C7 = [ 0xFF ];
immutable ubyte[] enemyBankB_C8 = [ 0x1B,0xD8,0x80,0x90, 0x1C,0x12,0xA0,0x2C, 0x1D,0x12,0xB0,0x70, 0xFF ];
immutable ubyte[] enemyBankB_C9 = [ 0xFF ];
immutable ubyte[] enemyBankB_CA = [ 0x52,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_CB = [ 0x2B,0x12,0xC0,0xF8, 0x2C,0x12,0xC8,0xAC, 0xFF ];
immutable ubyte[] enemyBankB_CC = [ 0xFF ];
immutable ubyte[] enemyBankB_CD = [ 0xFF ];
immutable ubyte[] enemyBankB_CE = [ 0xFF ];
immutable ubyte[] enemyBankB_CF = [ 0xFF ];
immutable ubyte[] enemyBankB_D0 = [ 0xFF ];
immutable ubyte[] enemyBankB_D1 = [ 0xFF ];
immutable ubyte[] enemyBankB_D2 = [ 0xFF ];
immutable ubyte[] enemyBankB_D3 = [ 0xFF ];
immutable ubyte[] enemyBankB_D4 = [ 0xFF ];
immutable ubyte[] enemyBankB_D5 = [ 0xFF ];
immutable ubyte[] enemyBankB_D6 = [ 0xFF ];
immutable ubyte[] enemyBankB_D7 = [ 0xFF ];
immutable ubyte[] enemyBankB_D8 = [ 0xFF ];
immutable ubyte[] enemyBankB_D9 = [ 0x53,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_DA = [ 0xFF ];
immutable ubyte[] enemyBankB_DB = [ 0x2D,0x12,0x78,0x3C, 0x2E,0x12,0xB0,0x78, 0xFF ];
immutable ubyte[] enemyBankB_DC = [ 0xFF ];
immutable ubyte[] enemyBankB_DD = [ 0xFF ];
immutable ubyte[] enemyBankB_DE = [ 0xFF ];
immutable ubyte[] enemyBankB_DF = [ 0x54,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_E0 = [ 0xFF ];
immutable ubyte[] enemyBankB_E1 = [ 0xFF ];
immutable ubyte[] enemyBankB_E2 = [ 0xFF ];
immutable ubyte[] enemyBankB_E3 = [ 0x0F,0x9B,0x48,0xA8, 0xFF ];
immutable ubyte[] enemyBankB_E4 = [ 0x55,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_E5 = [ 0xFF ];
immutable ubyte[] enemyBankB_E6 = [ 0xFF ];
immutable ubyte[] enemyBankB_E7 = [ 0xFF ];
immutable ubyte[] enemyBankB_E8 = [ 0xFF ];
immutable ubyte[] enemyBankB_E9 = [ 0xFF ];
immutable ubyte[] enemyBankB_EA = [ 0xFF ];
immutable ubyte[] enemyBankB_EB = [ 0xFF ];
immutable ubyte[] enemyBankB_EC = [ 0x56,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankB_ED = [ 0xFF ];
immutable ubyte[] enemyBankB_EE = [ 0xFF ];
immutable ubyte[] enemyBankB_EF = [ 0xFF ];
immutable ubyte[] enemyBankB_F0 = [ 0xFF ];
immutable ubyte[] enemyBankB_F1 = [ 0x30,0xD1,0x50,0xA0, 0x31,0xD1,0xB0,0x70, 0xFF ];
immutable ubyte[] enemyBankB_F2 = [ 0x2D,0xD1,0x00,0x78, 0x2E,0xD1,0x50,0x80, 0x2F,0xD1,0xA0,0xA0, 0xFF ];
immutable ubyte[] enemyBankB_F3 = [ 0x2A,0xD1,0x00,0xD0, 0x2B,0xD1,0x50,0x90, 0x2C,0xD1,0xA0,0xB0, 0xFF ];
immutable ubyte[] enemyBankB_F4 = [ 0x27,0xD1,0x00,0xD0, 0x28,0xD1,0x30,0x90, 0x29,0xD1,0x70,0xC0, 0xFF ];
immutable ubyte[] enemyBankB_F5 = [ 0x20,0xD0,0x60,0xA0, 0x21,0xD0,0x90,0xA0, 0x22,0xD0,0xC0,0x90, 0x23,0xD0,0xE0,0x68, 0xFF ];
immutable ubyte[] enemyBankB_F6 = [ 0x24,0xD0,0x10,0x88, 0x25,0xD0,0x50,0x98, 0x26,0xD0,0x90,0xA0, 0x27,0xD0,0xD0,0xB0, 0xFF ];
immutable ubyte[] enemyBankB_F7 = [ 0x28,0xD0,0x00,0xA0, 0x29,0xD0,0x30,0x90, 0x2A,0xD0,0x80,0xA8, 0x2B,0xD0,0xC0,0x98, 0xFF ];
immutable ubyte[] enemyBankB_F8 = [ 0x2C,0xD0,0x00,0x90, 0x2D,0xD0,0x40,0x90, 0x2E,0xD0,0x80,0xA0, 0x2F,0xD0,0xB0,0xA8, 0xFF ];
immutable ubyte[] enemyBankB_F9 = [ 0x10,0x40,0xC0,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_FA = [ 0x11,0x40,0x08,0xD8, 0x12,0x40,0xA0,0xD8, 0x13,0x40,0xFF,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_FB = [ 0x14,0x40,0x90,0xD8, 0x15,0x40,0xF8,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_FC = [ 0x16,0x40,0x70,0xD8, 0x17,0x40,0xFF,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_FD = [ 0x18,0x40,0x90,0xD8, 0x19,0x40,0xF8,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_FE = [ 0x1A,0x40,0x90,0xD8, 0x1B,0x40,0xF0,0xD8, 0xFF ];
immutable ubyte[] enemyBankB_FF = [ 0x1C,0x40,0x40,0xD8, 0x1D,0x40,0x80,0xD8, 0xFF ];
immutable ubyte[] enemyBankC_00 = [ 0xFF ];
immutable ubyte[] enemyBankC_01 = [ 0xFF ];
immutable ubyte[] enemyBankC_02 = [ 0x20,0x20,0x80,0x58, 0x21,0x21,0xA0,0xD8, 0xFF ];
immutable ubyte[] enemyBankC_03 = [ 0xFF ];
immutable ubyte[] enemyBankC_04 = [ 0xFF ];
immutable ubyte[] enemyBankC_05 = [ 0x24,0x12,0x88,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_06 = [ 0x36,0x12,0x78,0xD4, 0x37,0x12,0xC8,0xCC, 0xFF ];
immutable ubyte[] enemyBankC_07 = [ 0xFF ];
immutable ubyte[] enemyBankC_08 = [ 0xFF ];
immutable ubyte[] enemyBankC_09 = [ 0xFF ];
immutable ubyte[] enemyBankC_0A = [ 0x10,0x12,0xB0,0x84, 0x11,0x12,0xB8,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_0B = [ 0xFF ];
immutable ubyte[] enemyBankC_0C = [ 0xFF ];
immutable ubyte[] enemyBankC_0D = [ 0x16,0x12,0x88,0xBC, 0x17,0x12,0xA8,0xC4, 0xFF ];
immutable ubyte[] enemyBankC_0E = [ 0x16,0x12,0x88,0xBC, 0x17,0x12,0xA8,0xC4, 0xFF ];
immutable ubyte[] enemyBankC_0F = [ 0xFF ];
immutable ubyte[] enemyBankC_10 = [ 0x14,0x12,0x40,0x40, 0x15,0x12,0xC0,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_11 = [ 0xFF ];
immutable ubyte[] enemyBankC_12 = [ 0x22,0x20,0x60,0x60, 0x23,0x21,0xA0,0xD8, 0xFF ];
immutable ubyte[] enemyBankC_13 = [ 0x60,0x93,0x48,0xC8, 0xFF ];
immutable ubyte[] enemyBankC_14 = [ 0xFF ];
immutable ubyte[] enemyBankC_15 = [ 0x25,0x12,0x88,0x4C, 0x26,0x12,0xA0,0x54, 0x27,0x12,0xA8,0xA8, 0xFF ];
immutable ubyte[] enemyBankC_16 = [ 0x38,0x12,0xA0,0x40, 0x39,0x12,0xB0,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_17 = [ 0xFF ];
immutable ubyte[] enemyBankC_18 = [ 0xFF ];
immutable ubyte[] enemyBankC_19 = [ 0xFF ];
immutable ubyte[] enemyBankC_1A = [ 0x12,0x12,0x88,0x3C, 0x13,0x12,0xB8,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_1B = [ 0xFF ];
immutable ubyte[] enemyBankC_1C = [ 0x18,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankC_1D = [ 0x14,0x12,0x88,0x4C, 0x15,0x12,0xA8,0x54, 0xFF ];
immutable ubyte[] enemyBankC_1E = [ 0x14,0x12,0x88,0x4C, 0x15,0x12,0xA8,0x54, 0xFF ];
immutable ubyte[] enemyBankC_1F = [ 0xFF ];
immutable ubyte[] enemyBankC_20 = [ 0xFF ];
immutable ubyte[] enemyBankC_21 = [ 0x1A,0x00,0x80,0x80, 0x1B,0x12,0xB0,0xAC, 0xFF ];
immutable ubyte[] enemyBankC_22 = [ 0x24,0x20,0x40,0x28, 0x25,0x21,0x50,0x88, 0x26,0x12,0xB8,0xA8, 0xFF ];
immutable ubyte[] enemyBankC_23 = [ 0xFF ];
immutable ubyte[] enemyBankC_24 = [ 0xFF ];
immutable ubyte[] enemyBankC_25 = [ 0x28,0x12,0x88,0x40, 0x29,0x12,0xB8,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_26 = [ 0x3A,0x12,0x80,0x40, 0x3B,0x12,0x90,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_27 = [ 0xFF ];
immutable ubyte[] enemyBankC_28 = [ 0xFF ];
immutable ubyte[] enemyBankC_29 = [ 0xFF ];
immutable ubyte[] enemyBankC_2A = [ 0x14,0x12,0x80,0x3C, 0x15,0x12,0x80,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_2B = [ 0xFF ];
immutable ubyte[] enemyBankC_2C = [ 0xFF ];
immutable ubyte[] enemyBankC_2D = [ 0xFF ];
immutable ubyte[] enemyBankC_2E = [ 0xFF ];
immutable ubyte[] enemyBankC_2F = [ 0xFF ];
immutable ubyte[] enemyBankC_30 = [ 0xFF ];
immutable ubyte[] enemyBankC_31 = [ 0x1C,0x01,0x70,0x40, 0x1D,0x00,0x80,0x80, 0x1E,0x01,0x90,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_32 = [ 0xFF ];
immutable ubyte[] enemyBankC_33 = [ 0xFF ];
immutable ubyte[] enemyBankC_34 = [ 0xFF ];
immutable ubyte[] enemyBankC_35 = [ 0x2A,0x12,0x88,0x40, 0x2B,0x12,0xB8,0xB4, 0xFF ];
immutable ubyte[] enemyBankC_36 = [ 0x3C,0x12,0xA0,0x4C, 0x3D,0x12,0xA8,0x84, 0xFF ];
immutable ubyte[] enemyBankC_37 = [ 0x14,0x12,0xA0,0x7C, 0x15,0x12,0xB0,0xA4, 0xFF ];
immutable ubyte[] enemyBankC_38 = [ 0x41,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankC_39 = [ 0xFF ];
immutable ubyte[] enemyBankC_3A = [ 0x16,0x12,0xA0,0x3C, 0x17,0x12,0xA0,0x8C, 0xFF ];
immutable ubyte[] enemyBankC_3B = [ 0xFF ];
immutable ubyte[] enemyBankC_3C = [ 0x19,0x6A,0x80,0x60, 0xFF ];
immutable ubyte[] enemyBankC_3D = [ 0xFF ];
immutable ubyte[] enemyBankC_3E = [ 0xFF ];
immutable ubyte[] enemyBankC_3F = [ 0xFF ];
immutable ubyte[] enemyBankC_40 = [ 0xFF ];
immutable ubyte[] enemyBankC_41 = [ 0xFF ];
immutable ubyte[] enemyBankC_42 = [ 0xFF ];
immutable ubyte[] enemyBankC_43 = [ 0x35,0x2C,0x40,0xC8, 0xFF ];
immutable ubyte[] enemyBankC_44 = [ 0xFF ];
immutable ubyte[] enemyBankC_45 = [ 0x2C,0x12,0x90,0x3C, 0x2D,0x12,0xB0,0x8C, 0xFF ];
immutable ubyte[] enemyBankC_46 = [ 0x13,0x12,0x88,0xA4, 0xFF ];
immutable ubyte[] enemyBankC_47 = [ 0x16,0x12,0xA0,0x3C, 0x17,0x12,0xB0,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_48 = [ 0xFF ];
immutable ubyte[] enemyBankC_49 = [ 0xFF ];
immutable ubyte[] enemyBankC_4A = [ 0xFF ];
immutable ubyte[] enemyBankC_4B = [ 0xFF ];
immutable ubyte[] enemyBankC_4C = [ 0xFF ];
immutable ubyte[] enemyBankC_4D = [ 0x35,0x68,0x58,0xB8, 0xFF ];
immutable ubyte[] enemyBankC_4E = [ 0xFF ];
immutable ubyte[] enemyBankC_4F = [ 0xFF ];
immutable ubyte[] enemyBankC_50 = [ 0xFF ];
immutable ubyte[] enemyBankC_51 = [ 0xFF ];
immutable ubyte[] enemyBankC_52 = [ 0xFF ];
immutable ubyte[] enemyBankC_53 = [ 0x36,0x2C,0x40,0x48, 0x37,0x2C,0x40,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_54 = [ 0x26,0x12,0xB0,0x80, 0xFF ];
immutable ubyte[] enemyBankC_55 = [ 0xFF ];
immutable ubyte[] enemyBankC_56 = [ 0x11,0x68,0x80,0x18, 0xFF ];
immutable ubyte[] enemyBankC_57 = [ 0x18,0x12,0xA0,0x3C, 0x19,0x12,0xB0,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_58 = [ 0xFF ];
immutable ubyte[] enemyBankC_59 = [ 0xFF ];
immutable ubyte[] enemyBankC_5A = [ 0xFF ];
immutable ubyte[] enemyBankC_5B = [ 0xFF ];
immutable ubyte[] enemyBankC_5C = [ 0x1A,0x6A,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankC_5D = [ 0x36,0x68,0xA0,0xD8, 0xFF ];
immutable ubyte[] enemyBankC_5E = [ 0xFF ];
immutable ubyte[] enemyBankC_5F = [ 0xFF ];
immutable ubyte[] enemyBankC_60 = [ 0xFF ];
immutable ubyte[] enemyBankC_61 = [ 0x27,0x12,0xB0,0x94, 0xFF ];
immutable ubyte[] enemyBankC_62 = [ 0xFF ];
immutable ubyte[] enemyBankC_63 = [ 0x38,0x2C,0x40,0xC8, 0x39,0x31,0x80,0x58, 0x3A,0x31,0x80,0xD8, 0xFF ];
immutable ubyte[] enemyBankC_64 = [ 0x23,0x12,0xB8,0xAC, 0xFF ];
immutable ubyte[] enemyBankC_65 = [ 0x1B,0x12,0xB0,0x98, 0xFF ];
immutable ubyte[] enemyBankC_66 = [ 0xFF ];
immutable ubyte[] enemyBankC_67 = [ 0x1A,0x12,0xA0,0x34, 0x1B,0x12,0xA8,0x84, 0xFF ];
immutable ubyte[] enemyBankC_68 = [ 0xFF ];
immutable ubyte[] enemyBankC_69 = [ 0xFF ];
immutable ubyte[] enemyBankC_6A = [ 0xFF ];
immutable ubyte[] enemyBankC_6B = [ 0xFF ];
immutable ubyte[] enemyBankC_6C = [ 0xFF ];
immutable ubyte[] enemyBankC_6D = [ 0x37,0x68,0xB8,0x88, 0x38,0x6B,0xC0,0x80, 0xFF ];
immutable ubyte[] enemyBankC_6E = [ 0xFF ];
immutable ubyte[] enemyBankC_6F = [ 0xFF ];
immutable ubyte[] enemyBankC_70 = [ 0xFF ];
immutable ubyte[] enemyBankC_71 = [ 0x28,0x12,0xB8,0x94, 0x29,0x01,0xC1,0x30, 0xFF ];
immutable ubyte[] enemyBankC_72 = [ 0xFF ];
immutable ubyte[] enemyBankC_73 = [ 0x3B,0x2C,0x40,0x90, 0xFF ];
immutable ubyte[] enemyBankC_74 = [ 0xFF ];
immutable ubyte[] enemyBankC_75 = [ 0x1A,0x12,0x90,0xC0, 0xFF ];
immutable ubyte[] enemyBankC_76 = [ 0xFF ];
immutable ubyte[] enemyBankC_77 = [ 0xFF ];
immutable ubyte[] enemyBankC_78 = [ 0xFF ];
immutable ubyte[] enemyBankC_79 = [ 0xFF ];
immutable ubyte[] enemyBankC_7A = [ 0xFF ];
immutable ubyte[] enemyBankC_7B = [ 0xFF ];
immutable ubyte[] enemyBankC_7C = [ 0xFF ];
immutable ubyte[] enemyBankC_7D = [ 0xFF ];
immutable ubyte[] enemyBankC_7E = [ 0xFF ];
immutable ubyte[] enemyBankC_7F = [ 0xFF ];
immutable ubyte[] enemyBankC_80 = [ 0xFF ];
immutable ubyte[] enemyBankC_81 = [ 0x2A,0x01,0xB8,0x50, 0x2B,0x12,0xC0,0xA0, 0xFF ];
immutable ubyte[] enemyBankC_82 = [ 0xFF ];
immutable ubyte[] enemyBankC_83 = [ 0x3C,0x28,0x80,0xC8, 0xFF ];
immutable ubyte[] enemyBankC_84 = [ 0xFF ];
immutable ubyte[] enemyBankC_85 = [ 0x18,0x12,0xA0,0x54, 0x19,0x12,0xA0,0x94, 0xFF ];
immutable ubyte[] enemyBankC_86 = [ 0xFF ];
immutable ubyte[] enemyBankC_87 = [ 0x1D,0x6A,0x80,0xB0, 0xFF ];
immutable ubyte[] enemyBankC_88 = [ 0x40,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankC_89 = [ 0xFF ];
immutable ubyte[] enemyBankC_8A = [ 0xFF ];
immutable ubyte[] enemyBankC_8B = [ 0x1D,0x6A,0x80,0xB0, 0xFF ];
immutable ubyte[] enemyBankC_8C = [ 0xFF ];
immutable ubyte[] enemyBankC_8D = [ 0xFF ];
immutable ubyte[] enemyBankC_8E = [ 0xFF ];
immutable ubyte[] enemyBankC_8F = [ 0xFF ];
immutable ubyte[] enemyBankC_90 = [ 0xFF ];
immutable ubyte[] enemyBankC_91 = [ 0xFF ];
immutable ubyte[] enemyBankC_92 = [ 0xFF ];
immutable ubyte[] enemyBankC_93 = [ 0xFF ];
immutable ubyte[] enemyBankC_94 = [ 0xFF ];
immutable ubyte[] enemyBankC_95 = [ 0xFF ];
immutable ubyte[] enemyBankC_96 = [ 0xFF ];
immutable ubyte[] enemyBankC_97 = [ 0x1C,0x6A,0x80,0x40, 0xFF ];
immutable ubyte[] enemyBankC_98 = [ 0x0F,0x9B,0xE8,0x78, 0xFF ];
immutable ubyte[] enemyBankC_99 = [ 0x22,0x6A,0x80,0xC8, 0xFF ];
immutable ubyte[] enemyBankC_9A = [ 0x32,0x2C,0x20,0x68, 0x33,0x2C,0x60,0xF0, 0xFF ];
immutable ubyte[] enemyBankC_9B = [ 0x1C,0x6A,0x80,0x40, 0xFF ];
immutable ubyte[] enemyBankC_9C = [ 0xFF ];
immutable ubyte[] enemyBankC_9D = [ 0xFF ];
immutable ubyte[] enemyBankC_9E = [ 0xFF ];
immutable ubyte[] enemyBankC_9F = [ 0xFF ];
immutable ubyte[] enemyBankC_A0 = [ 0xFF ];
immutable ubyte[] enemyBankC_A1 = [ 0x10,0x31,0x70,0x57, 0x11,0x30,0xB9,0x90, 0xFF ];
immutable ubyte[] enemyBankC_A2 = [ 0x21,0x01,0x60,0xB8, 0x22,0x00,0x80,0x58, 0xFF ];
immutable ubyte[] enemyBankC_A3 = [ 0x1C,0x12,0xA0,0x84, 0x1D,0x12,0x90,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_A4 = [ 0xFF ];
immutable ubyte[] enemyBankC_A5 = [ 0xFF ];
immutable ubyte[] enemyBankC_A6 = [ 0xFF ];
immutable ubyte[] enemyBankC_A7 = [ 0xFF ];
immutable ubyte[] enemyBankC_A8 = [ 0xFF ];
immutable ubyte[] enemyBankC_A9 = [ 0x20,0x6A,0xA8,0x30, 0xFF ];
immutable ubyte[] enemyBankC_AA = [ 0x34,0x2C,0x20,0x68, 0xFF ];
immutable ubyte[] enemyBankC_AB = [ 0xFF ];
immutable ubyte[] enemyBankC_AC = [ 0xFF ];
immutable ubyte[] enemyBankC_AD = [ 0xFF ];
immutable ubyte[] enemyBankC_AE = [ 0xFF ];
immutable ubyte[] enemyBankC_AF = [ 0xFF ];
immutable ubyte[] enemyBankC_B0 = [ 0xFF ];
immutable ubyte[] enemyBankC_B1 = [ 0x19,0x30,0x90,0x87, 0x1A,0x12,0xB0,0xAC, 0xFF ];
immutable ubyte[] enemyBankC_B2 = [ 0x23,0x00,0x60,0xD7, 0x24,0x01,0x80,0x77, 0xFF ];
immutable ubyte[] enemyBankC_B3 = [ 0x1E,0x12,0x90,0x3C, 0x1F,0x12,0x90,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_B4 = [ 0xFF ];
immutable ubyte[] enemyBankC_B5 = [ 0xFF ];
immutable ubyte[] enemyBankC_B6 = [ 0xFF ];
immutable ubyte[] enemyBankC_B7 = [ 0xFF ];
immutable ubyte[] enemyBankC_B8 = [ 0xFF ];
immutable ubyte[] enemyBankC_B9 = [ 0xFF ];
immutable ubyte[] enemyBankC_BA = [ 0x35,0x2C,0xA0,0x78, 0xFF ];
immutable ubyte[] enemyBankC_BB = [ 0x34,0x2C,0x90,0x28, 0x35,0x2C,0xB0,0x70, 0x36,0x2C,0x90,0x98, 0xFF ];
immutable ubyte[] enemyBankC_BC = [ 0xFF ];
immutable ubyte[] enemyBankC_BD = [ 0xFF ];
immutable ubyte[] enemyBankC_BE = [ 0xFF ];
immutable ubyte[] enemyBankC_BF = [ 0xFF ];
immutable ubyte[] enemyBankC_C0 = [ 0xFF ];
immutable ubyte[] enemyBankC_C1 = [ 0xFF ];
immutable ubyte[] enemyBankC_C2 = [ 0x25,0x01,0x90,0x37, 0x26,0x00,0xA7,0x78, 0xFF ];
immutable ubyte[] enemyBankC_C3 = [ 0x30,0x12,0x90,0x3C, 0x31,0x12,0x90,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_C4 = [ 0xFF ];
immutable ubyte[] enemyBankC_C5 = [ 0xFF ];
immutable ubyte[] enemyBankC_C6 = [ 0x14,0x2A,0x48,0xF0, 0x15,0x2B,0x68,0x70, 0xFF ];
immutable ubyte[] enemyBankC_C7 = [ 0xFF ];
immutable ubyte[] enemyBankC_C8 = [ 0xFF ];
immutable ubyte[] enemyBankC_C9 = [ 0x1C,0x6A,0x50,0xB0, 0xFF ];
immutable ubyte[] enemyBankC_CA = [ 0x36,0x2C,0x20,0x68, 0xFF ];
immutable ubyte[] enemyBankC_CB = [ 0x37,0x2C,0x20,0x50, 0x38,0x2C,0x20,0x70, 0x39,0x2C,0x40,0xB0, 0xFF ];
immutable ubyte[] enemyBankC_CC = [ 0xFF ];
immutable ubyte[] enemyBankC_CD = [ 0xFF ];
immutable ubyte[] enemyBankC_CE = [ 0xFF ];
immutable ubyte[] enemyBankC_CF = [ 0xFF ];
immutable ubyte[] enemyBankC_D0 = [ 0xFF ];
immutable ubyte[] enemyBankC_D1 = [ 0x1E,0x20,0x70,0x58, 0x1F,0x21,0x80,0xD8, 0xFF ];
immutable ubyte[] enemyBankC_D2 = [ 0x27,0x01,0x88,0x77, 0x28,0x00,0xB0,0x98, 0xFF ];
immutable ubyte[] enemyBankC_D3 = [ 0x32,0x12,0x90,0x3C, 0x33,0x12,0x90,0xBC, 0xFF ];
immutable ubyte[] enemyBankC_D4 = [ 0xFF ];
immutable ubyte[] enemyBankC_D5 = [ 0xFF ];
immutable ubyte[] enemyBankC_D6 = [ 0xFF ];
immutable ubyte[] enemyBankC_D7 = [ 0xFF ];
immutable ubyte[] enemyBankC_D8 = [ 0xFF ];
immutable ubyte[] enemyBankC_D9 = [ 0x1A,0x6A,0xB0,0x50, 0xFF ];
immutable ubyte[] enemyBankC_DA = [ 0xFF ];
immutable ubyte[] enemyBankC_DB = [ 0x3A,0x2C,0xB0,0x70, 0x3B,0x2C,0x90,0x98, 0xFF ];
immutable ubyte[] enemyBankC_DC = [ 0xFF ];
immutable ubyte[] enemyBankC_DD = [ 0xFF ];
immutable ubyte[] enemyBankC_DE = [ 0xFF ];
immutable ubyte[] enemyBankC_DF = [ 0xFF ];
immutable ubyte[] enemyBankC_E0 = [ 0xFF ];
immutable ubyte[] enemyBankC_E1 = [ 0x1D,0x12,0xB0,0x4C, 0xFF ];
immutable ubyte[] enemyBankC_E2 = [ 0x29,0x01,0x88,0x77, 0x2A,0x00,0x98,0x37, 0xFF ];
immutable ubyte[] enemyBankC_E3 = [ 0x34,0x12,0x90,0x3C, 0x35,0x12,0x90,0x84, 0xFF ];
immutable ubyte[] enemyBankC_E4 = [ 0xFF ];
immutable ubyte[] enemyBankC_E5 = [ 0xFF ];
immutable ubyte[] enemyBankC_E6 = [ 0xFF ];
immutable ubyte[] enemyBankC_E7 = [ 0xFF ];
immutable ubyte[] enemyBankC_E8 = [ 0xFF ];
immutable ubyte[] enemyBankC_E9 = [ 0xFF ];
immutable ubyte[] enemyBankC_EA = [ 0xFF ];
immutable ubyte[] enemyBankC_EB = [ 0xFF ];
immutable ubyte[] enemyBankC_EC = [ 0xFF ];
immutable ubyte[] enemyBankC_ED = [ 0x28,0x2A,0x98,0x70, 0xFF ];
immutable ubyte[] enemyBankC_EE = [ 0xFF ];
immutable ubyte[] enemyBankC_EF = [ 0xFF ];
immutable ubyte[] enemyBankC_F0 = [ 0xFF ];
immutable ubyte[] enemyBankC_F1 = [ 0xFF ];
immutable ubyte[] enemyBankC_F2 = [ 0xFF ];
immutable ubyte[] enemyBankC_F3 = [ 0xFF ];
immutable ubyte[] enemyBankC_F4 = [ 0xFF ];
immutable ubyte[] enemyBankC_F5 = [ 0xFF ];
immutable ubyte[] enemyBankC_F6 = [ 0xFF ];
immutable ubyte[] enemyBankC_F7 = [ 0xFF ];
immutable ubyte[] enemyBankC_F8 = [ 0xFF ];
immutable ubyte[] enemyBankC_F9 = [ 0xFF ];
immutable ubyte[] enemyBankC_FA = [ 0xFF ];
immutable ubyte[] enemyBankC_FB = [ 0xFF ];
immutable ubyte[] enemyBankC_FC = [ 0xFF ];
immutable ubyte[] enemyBankC_FD = [ 0x0C,0x2A,0x88,0x50, 0xFF ];
immutable ubyte[] enemyBankC_FE = [ 0xFF ];
immutable ubyte[] enemyBankC_FF = [ 0xFF ];
immutable ubyte[] enemyBankD_00 = [ 0x47,0xCE,0xA0,0xE0, 0xFF ];
immutable ubyte[] enemyBankD_01 = [ 0xFF ];
immutable ubyte[] enemyBankD_02 = [ 0xFF ];
immutable ubyte[] enemyBankD_03 = [ 0xFF ];
immutable ubyte[] enemyBankD_04 = [ 0x0F,0x9B,0x18,0xE8, 0x46,0xA4,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankD_05 = [ 0xFF ];
immutable ubyte[] enemyBankD_06 = [ 0xFF ];
immutable ubyte[] enemyBankD_07 = [ 0xFF ];
immutable ubyte[] enemyBankD_08 = [ 0xFF ];
immutable ubyte[] enemyBankD_09 = [ 0xFF ];
immutable ubyte[] enemyBankD_0A = [ 0xFF ];
immutable ubyte[] enemyBankD_0B = [ 0xFF ];
immutable ubyte[] enemyBankD_0C = [ 0xFF ];
immutable ubyte[] enemyBankD_0D = [ 0xFF ];
immutable ubyte[] enemyBankD_0E = [ 0xFF ];
immutable ubyte[] enemyBankD_0F = [ 0xFF ];
immutable ubyte[] enemyBankD_10 = [ 0x40,0xCE,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankD_11 = [ 0xFF ];
immutable ubyte[] enemyBankD_12 = [ 0xFF ];
immutable ubyte[] enemyBankD_13 = [ 0xFF ];
immutable ubyte[] enemyBankD_14 = [ 0xFF ];
immutable ubyte[] enemyBankD_15 = [ 0xFF ];
immutable ubyte[] enemyBankD_16 = [ 0xFF ];
immutable ubyte[] enemyBankD_17 = [ 0xFF ];
immutable ubyte[] enemyBankD_18 = [ 0x60,0x99,0xB8,0xE8, 0x1D,0x4A,0xE4,0xD8, 0xFF ];
immutable ubyte[] enemyBankD_19 = [ 0x1C,0x4A,0xB4,0xC0, 0xFF ];
immutable ubyte[] enemyBankD_1A = [ 0x61,0x99,0x48,0xE8, 0xFF ];
immutable ubyte[] enemyBankD_1B = [ 0x11,0x1F,0xBC,0xE8, 0xFF ];
immutable ubyte[] enemyBankD_1C = [ 0xFF ];
immutable ubyte[] enemyBankD_1D = [ 0xFF ];
immutable ubyte[] enemyBankD_1E = [ 0xFF ];
immutable ubyte[] enemyBankD_1F = [ 0xFF ];
immutable ubyte[] enemyBankD_20 = [ 0xFF ];
immutable ubyte[] enemyBankD_21 = [ 0xFF ];
immutable ubyte[] enemyBankD_22 = [ 0xFF ];
immutable ubyte[] enemyBankD_23 = [ 0x41,0xCE,0x80,0x70, 0xFF ];
immutable ubyte[] enemyBankD_24 = [ 0xFF ];
immutable ubyte[] enemyBankD_25 = [ 0xFF ];
immutable ubyte[] enemyBankD_26 = [ 0xFF ];
immutable ubyte[] enemyBankD_27 = [ 0xFF ];
immutable ubyte[] enemyBankD_28 = [ 0xFF ];
immutable ubyte[] enemyBankD_29 = [ 0xFF ];
immutable ubyte[] enemyBankD_2A = [ 0xFF ];
immutable ubyte[] enemyBankD_2B = [ 0x12,0x1F,0xBC,0x50, 0xFF ];
immutable ubyte[] enemyBankD_2C = [ 0xFF ];
immutable ubyte[] enemyBankD_2D = [ 0xFF ];
immutable ubyte[] enemyBankD_2E = [ 0xFF ];
immutable ubyte[] enemyBankD_2F = [ 0xFF ];
immutable ubyte[] enemyBankD_30 = [ 0xFF ];
immutable ubyte[] enemyBankD_31 = [ 0xFF ];
immutable ubyte[] enemyBankD_32 = [ 0xFF ];
immutable ubyte[] enemyBankD_33 = [ 0x42,0xCE,0x70,0xE0, 0xFF ];
immutable ubyte[] enemyBankD_34 = [ 0xFF ];
immutable ubyte[] enemyBankD_35 = [ 0xFF ];
immutable ubyte[] enemyBankD_36 = [ 0xFF ];
immutable ubyte[] enemyBankD_37 = [ 0xFF ];
immutable ubyte[] enemyBankD_38 = [ 0x10,0x1F,0xFC,0xCC, 0xFF ];
immutable ubyte[] enemyBankD_39 = [ 0xFF ];
immutable ubyte[] enemyBankD_3A = [ 0x62,0x97,0x58,0x78, 0xFF ];
immutable ubyte[] enemyBankD_3B = [ 0x13,0x4A,0x44,0x50, 0xFF ];
immutable ubyte[] enemyBankD_3C = [ 0xFF ];
immutable ubyte[] enemyBankD_3D = [ 0xFF ];
immutable ubyte[] enemyBankD_3E = [ 0xFF ];
immutable ubyte[] enemyBankD_3F = [ 0xFF ];
immutable ubyte[] enemyBankD_40 = [ 0xFF ];
immutable ubyte[] enemyBankD_41 = [ 0xFF ];
immutable ubyte[] enemyBankD_42 = [ 0x43,0xCE,0x70,0xE0, 0xFF ];
immutable ubyte[] enemyBankD_43 = [ 0xFF ];
immutable ubyte[] enemyBankD_44 = [ 0x63,0x88,0x5C,0x60, 0x7A,0x99,0xA8,0xC8, 0x64,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankD_45 = [ 0xFF ];
immutable ubyte[] enemyBankD_46 = [ 0xFF ];
immutable ubyte[] enemyBankD_47 = [ 0xFF ];
immutable ubyte[] enemyBankD_48 = [ 0xFF ];
immutable ubyte[] enemyBankD_49 = [ 0xFF ];
immutable ubyte[] enemyBankD_4A = [ 0xFF ];
immutable ubyte[] enemyBankD_4B = [ 0x14,0x1F,0xBC,0x50, 0xFF ];
immutable ubyte[] enemyBankD_4C = [ 0x18,0x4A,0x44,0xB0, 0x65,0x99,0xB8,0xE8, 0x19,0x4A,0xE4,0xBD, 0xFF ];
immutable ubyte[] enemyBankD_4D = [ 0x1A,0x1F,0x3C,0xE0, 0x66,0x99,0x68,0x58, 0x67,0x99,0x78,0xE8, 0xFF ];
immutable ubyte[] enemyBankD_4E = [ 0xFF ];
immutable ubyte[] enemyBankD_4F = [ 0xFF ];
immutable ubyte[] enemyBankD_50 = [ 0xFF ];
immutable ubyte[] enemyBankD_51 = [ 0xFF ];
immutable ubyte[] enemyBankD_52 = [ 0xFF ];
immutable ubyte[] enemyBankD_53 = [ 0x10,0x1E,0x60,0xE8, 0xFF ];
immutable ubyte[] enemyBankD_54 = [ 0xFF ];
immutable ubyte[] enemyBankD_55 = [ 0xFF ];
immutable ubyte[] enemyBankD_56 = [ 0xFF ];
immutable ubyte[] enemyBankD_57 = [ 0xFF ];
immutable ubyte[] enemyBankD_58 = [ 0x0F,0x82,0x5C,0x60, 0x68,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankD_59 = [ 0x17,0x4A,0x24,0xD0, 0xFF ];
immutable ubyte[] enemyBankD_5A = [ 0x16,0x1F,0xDC,0xD4, 0xFF ];
immutable ubyte[] enemyBankD_5B = [ 0x15,0x4A,0x44,0x50, 0xFF ];
immutable ubyte[] enemyBankD_5C = [ 0xFF ];
immutable ubyte[] enemyBankD_5D = [ 0xFF ];
immutable ubyte[] enemyBankD_5E = [ 0xFF ];
immutable ubyte[] enemyBankD_5F = [ 0xFF ];
immutable ubyte[] enemyBankD_60 = [ 0x69,0x8C,0x48,0xE8, 0xFF ];
immutable ubyte[] enemyBankD_61 = [ 0x6A,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankD_62 = [ 0xFF ];
immutable ubyte[] enemyBankD_63 = [ 0xFF ];
immutable ubyte[] enemyBankD_64 = [ 0xFF ];
immutable ubyte[] enemyBankD_65 = [ 0xFF ];
immutable ubyte[] enemyBankD_66 = [ 0xFF ];
immutable ubyte[] enemyBankD_67 = [ 0xFF ];
immutable ubyte[] enemyBankD_68 = [ 0xFF ];
immutable ubyte[] enemyBankD_69 = [ 0xFF ];
immutable ubyte[] enemyBankD_6A = [ 0xFF ];
immutable ubyte[] enemyBankD_6B = [ 0xFF ];
immutable ubyte[] enemyBankD_6C = [ 0xFF ];
immutable ubyte[] enemyBankD_6D = [ 0xFF ];
immutable ubyte[] enemyBankD_6E = [ 0xFF ];
immutable ubyte[] enemyBankD_6F = [ 0xFF ];
immutable ubyte[] enemyBankD_70 = [ 0xFF ];
immutable ubyte[] enemyBankD_71 = [ 0xFF ];
immutable ubyte[] enemyBankD_72 = [ 0xFF ];
immutable ubyte[] enemyBankD_73 = [ 0xFF ];
immutable ubyte[] enemyBankD_74 = [ 0xFF ];
immutable ubyte[] enemyBankD_75 = [ 0xFF ];
immutable ubyte[] enemyBankD_76 = [ 0x44,0xA0,0xC0,0x76, 0xFF ];
immutable ubyte[] enemyBankD_77 = [ 0x6C,0x99,0xA8,0xB8, 0xFF ];
immutable ubyte[] enemyBankD_78 = [ 0xFF ];
immutable ubyte[] enemyBankD_79 = [ 0x6C,0x99,0xA8,0xB8, 0xFF ];
immutable ubyte[] enemyBankD_7A = [ 0xFF ];
immutable ubyte[] enemyBankD_7B = [ 0xFF ];
immutable ubyte[] enemyBankD_7C = [ 0xFF ];
immutable ubyte[] enemyBankD_7D = [ 0xFF ];
immutable ubyte[] enemyBankD_7E = [ 0xFF ];
immutable ubyte[] enemyBankD_7F = [ 0xFF ];
immutable ubyte[] enemyBankD_80 = [ 0x78,0x99,0x98,0x48, 0xFF ];
immutable ubyte[] enemyBankD_81 = [ 0xFF ];
immutable ubyte[] enemyBankD_82 = [ 0xFF ];
immutable ubyte[] enemyBankD_83 = [ 0xFF ];
immutable ubyte[] enemyBankD_84 = [ 0xFF ];
immutable ubyte[] enemyBankD_85 = [ 0xFF ];
immutable ubyte[] enemyBankD_86 = [ 0xFF ];
immutable ubyte[] enemyBankD_87 = [ 0xFF ];
immutable ubyte[] enemyBankD_88 = [ 0xFF ];
immutable ubyte[] enemyBankD_89 = [ 0xFF ];
immutable ubyte[] enemyBankD_8A = [ 0xFF ];
immutable ubyte[] enemyBankD_8B = [ 0xFF ];
immutable ubyte[] enemyBankD_8C = [ 0xFF ];
immutable ubyte[] enemyBankD_8D = [ 0xFF ];
immutable ubyte[] enemyBankD_8E = [ 0xFF ];
immutable ubyte[] enemyBankD_8F = [ 0xFF ];
immutable ubyte[] enemyBankD_90 = [ 0xFF ];
immutable ubyte[] enemyBankD_91 = [ 0x6D,0x99,0x38,0x28, 0xFF ];
immutable ubyte[] enemyBankD_92 = [ 0xFF ];
immutable ubyte[] enemyBankD_93 = [ 0x45,0xA4,0x78,0xCC, 0xFF ];
immutable ubyte[] enemyBankD_94 = [ 0xFF ];
immutable ubyte[] enemyBankD_95 = [ 0xFF ];
immutable ubyte[] enemyBankD_96 = [ 0xFF ];
immutable ubyte[] enemyBankD_97 = [ 0xFF ];
immutable ubyte[] enemyBankD_98 = [ 0xFF ];
immutable ubyte[] enemyBankD_99 = [ 0xFF ];
immutable ubyte[] enemyBankD_9A = [ 0xFF ];
immutable ubyte[] enemyBankD_9B = [ 0xFF ];
immutable ubyte[] enemyBankD_9C = [ 0xFF ];
immutable ubyte[] enemyBankD_9D = [ 0xFF ];
immutable ubyte[] enemyBankD_9E = [ 0xFF ];
immutable ubyte[] enemyBankD_9F = [ 0xFF ];
immutable ubyte[] enemyBankD_A0 = [ 0xFF ];
immutable ubyte[] enemyBankD_A1 = [ 0xFF ];
immutable ubyte[] enemyBankD_A2 = [ 0xFF ];
immutable ubyte[] enemyBankD_A3 = [ 0xFF ];
immutable ubyte[] enemyBankD_A4 = [ 0x0F,0x84,0x5C,0x60, 0x6F,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankD_A5 = [ 0x13,0x46,0x98,0xB0, 0xFF ];
immutable ubyte[] enemyBankD_A6 = [ 0xFF ];
immutable ubyte[] enemyBankD_A7 = [ 0xFF ];
immutable ubyte[] enemyBankD_A8 = [ 0xFF ];
immutable ubyte[] enemyBankD_A9 = [ 0xFF ];
immutable ubyte[] enemyBankD_AA = [ 0xFF ];
immutable ubyte[] enemyBankD_AB = [ 0xFF ];
immutable ubyte[] enemyBankD_AC = [ 0xFF ];
immutable ubyte[] enemyBankD_AD = [ 0xFF ];
immutable ubyte[] enemyBankD_AE = [ 0xFF ];
immutable ubyte[] enemyBankD_AF = [ 0xFF ];
immutable ubyte[] enemyBankD_B0 = [ 0xFF ];
immutable ubyte[] enemyBankD_B1 = [ 0xFF ];
immutable ubyte[] enemyBankD_B2 = [ 0xFF ];
immutable ubyte[] enemyBankD_B3 = [ 0xFF ];
immutable ubyte[] enemyBankD_B4 = [ 0xFF ];
immutable ubyte[] enemyBankD_B5 = [ 0xFF ];
immutable ubyte[] enemyBankD_B6 = [ 0xFF ];
immutable ubyte[] enemyBankD_B7 = [ 0xFF ];
immutable ubyte[] enemyBankD_B8 = [ 0xFF ];
immutable ubyte[] enemyBankD_B9 = [ 0xFF ];
immutable ubyte[] enemyBankD_BA = [ 0x1D,0x1F,0xBC,0xE0, 0xFF ];
immutable ubyte[] enemyBankD_BB = [ 0xFF ];
immutable ubyte[] enemyBankD_BC = [ 0xFF ];
immutable ubyte[] enemyBankD_BD = [ 0xFF ];
immutable ubyte[] enemyBankD_BE = [ 0xFF ];
immutable ubyte[] enemyBankD_BF = [ 0xFF ];
immutable ubyte[] enemyBankD_C0 = [ 0x70,0x9C,0x4C,0xB0, 0x71,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankD_C1 = [ 0xFF ];
immutable ubyte[] enemyBankD_C2 = [ 0xFF ];
immutable ubyte[] enemyBankD_C3 = [ 0xFF ];
immutable ubyte[] enemyBankD_C4 = [ 0xFF ];
immutable ubyte[] enemyBankD_C5 = [ 0x19,0x4A,0x34,0xE0, 0xFF ];
immutable ubyte[] enemyBankD_C6 = [ 0x18,0x4A,0x44,0xB0, 0xFF ];
immutable ubyte[] enemyBankD_C7 = [ 0x15,0x1F,0x3C,0xC0, 0x72,0x99,0x68,0x58, 0x73,0x99,0x78,0xE8, 0x16,0x4A,0xB4,0xC0, 0xFF ];
immutable ubyte[] enemyBankD_C8 = [ 0x17,0x1F,0x1C,0xE0, 0xFF ];
immutable ubyte[] enemyBankD_C9 = [ 0xFF ];
immutable ubyte[] enemyBankD_CA = [ 0x1E,0x1F,0xBC,0x40, 0x1F,0x1F,0xBC,0xA0, 0xFF ];
immutable ubyte[] enemyBankD_CB = [ 0xFF ];
immutable ubyte[] enemyBankD_CC = [ 0xFF ];
immutable ubyte[] enemyBankD_CD = [ 0xFF ];
immutable ubyte[] enemyBankD_CE = [ 0xFF ];
immutable ubyte[] enemyBankD_CF = [ 0xFF ];
immutable ubyte[] enemyBankD_D0 = [ 0xFF ];
immutable ubyte[] enemyBankD_D1 = [ 0xFF ];
immutable ubyte[] enemyBankD_D2 = [ 0xFF ];
immutable ubyte[] enemyBankD_D3 = [ 0xFF ];
immutable ubyte[] enemyBankD_D4 = [ 0xFF ];
immutable ubyte[] enemyBankD_D5 = [ 0x1A,0x4A,0x34,0x10, 0xFF ];
immutable ubyte[] enemyBankD_D6 = [ 0x1B,0x1F,0x8C,0xC0, 0x7B,0x99,0xB8,0xE8, 0x1C,0x1F,0xFC,0xA0, 0xFF ];
immutable ubyte[] enemyBankD_D7 = [ 0x74,0x99,0x18,0xE8, 0x77,0x97,0x18,0x58, 0xFF ];
immutable ubyte[] enemyBankD_D8 = [ 0xFF ];
immutable ubyte[] enemyBankD_D9 = [ 0x75,0x8E,0x5C,0x60, 0x76,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankD_DA = [ 0x20,0x1F,0xBC,0x00, 0x21,0x1F,0xBC,0x60, 0x22,0x1F,0xBC,0xC0, 0xFF ];
immutable ubyte[] enemyBankD_DB = [ 0xFF ];
immutable ubyte[] enemyBankD_DC = [ 0xFF ];
immutable ubyte[] enemyBankD_DD = [ 0xFF ];
immutable ubyte[] enemyBankD_DE = [ 0xFF ];
immutable ubyte[] enemyBankD_DF = [ 0xFF ];
immutable ubyte[] enemyBankD_E0 = [ 0xFF ];
immutable ubyte[] enemyBankD_E1 = [ 0xFF ];
immutable ubyte[] enemyBankD_E2 = [ 0xFF ];
immutable ubyte[] enemyBankD_E3 = [ 0xFF ];
immutable ubyte[] enemyBankD_E4 = [ 0xFF ];
immutable ubyte[] enemyBankD_E5 = [ 0xFF ];
immutable ubyte[] enemyBankD_E6 = [ 0xFF ];
immutable ubyte[] enemyBankD_E7 = [ 0xFF ];
immutable ubyte[] enemyBankD_E8 = [ 0xFF ];
immutable ubyte[] enemyBankD_E9 = [ 0xFF ];
immutable ubyte[] enemyBankD_EA = [ 0xFF ];
immutable ubyte[] enemyBankD_EB = [ 0xFF ];
immutable ubyte[] enemyBankD_EC = [ 0xFF ];
immutable ubyte[] enemyBankD_ED = [ 0xFF ];
immutable ubyte[] enemyBankD_EE = [ 0xFF ];
immutable ubyte[] enemyBankD_EF = [ 0xFF ];
immutable ubyte[] enemyBankD_F0 = [ 0xFF ];
immutable ubyte[] enemyBankD_F1 = [ 0xFF ];
immutable ubyte[] enemyBankD_F2 = [ 0xFF ];
immutable ubyte[] enemyBankD_F3 = [ 0xFF ];
immutable ubyte[] enemyBankD_F4 = [ 0xFF ];
immutable ubyte[] enemyBankD_F5 = [ 0xFF ];
immutable ubyte[] enemyBankD_F6 = [ 0xFF ];
immutable ubyte[] enemyBankD_F7 = [ 0xFF ];
immutable ubyte[] enemyBankD_F8 = [ 0xFF ];
immutable ubyte[] enemyBankD_F9 = [ 0xFF ];
immutable ubyte[] enemyBankD_FA = [ 0xFF ];
immutable ubyte[] enemyBankD_FB = [ 0xFF ];
immutable ubyte[] enemyBankD_FC = [ 0xFF ];
immutable ubyte[] enemyBankD_FD = [ 0xFF ];
immutable ubyte[] enemyBankD_FE = [ 0xFF ];
immutable ubyte[] enemyBankD_FF = [ 0xFF ];
immutable ubyte[] enemyBankE_00 = [ 0xFF ];
immutable ubyte[] enemyBankE_01 = [ 0xFF ];
immutable ubyte[] enemyBankE_02 = [ 0xFF ];
immutable ubyte[] enemyBankE_03 = [ 0x41,0xCE,0xA0,0x90, 0xFF ];
immutable ubyte[] enemyBankE_04 = [ 0xFF ];
immutable ubyte[] enemyBankE_05 = [ 0x42,0xCE,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankE_06 = [ 0xFF ];
immutable ubyte[] enemyBankE_07 = [ 0x49,0xA4,0xB0,0x80, 0xFF ];
immutable ubyte[] enemyBankE_08 = [ 0x0F,0x9B,0x18,0xD8, 0x4A,0xA3,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankE_09 = [ 0xFF ];
immutable ubyte[] enemyBankE_0A = [ 0xFF ];
immutable ubyte[] enemyBankE_0B = [ 0xFF ];
immutable ubyte[] enemyBankE_0C = [ 0xFF ];
immutable ubyte[] enemyBankE_0D = [ 0xFF ];
immutable ubyte[] enemyBankE_0E = [ 0xFF ];
immutable ubyte[] enemyBankE_0F = [ 0xFF ];
immutable ubyte[] enemyBankE_10 = [ 0xFF ];
immutable ubyte[] enemyBankE_11 = [ 0xFF ];
immutable ubyte[] enemyBankE_12 = [ 0xFF ];
immutable ubyte[] enemyBankE_13 = [ 0xFF ];
immutable ubyte[] enemyBankE_14 = [ 0xFF ];
immutable ubyte[] enemyBankE_15 = [ 0xFF ];
immutable ubyte[] enemyBankE_16 = [ 0xFF ];
immutable ubyte[] enemyBankE_17 = [ 0xFF ];
immutable ubyte[] enemyBankE_18 = [ 0xFF ];
immutable ubyte[] enemyBankE_19 = [ 0xFF ];
immutable ubyte[] enemyBankE_1A = [ 0xFF ];
immutable ubyte[] enemyBankE_1B = [ 0x60,0x99,0x88,0xC8, 0xFF ];
immutable ubyte[] enemyBankE_1C = [ 0xFF ];
immutable ubyte[] enemyBankE_1D = [ 0xFF ];
immutable ubyte[] enemyBankE_1E = [ 0xFF ];
immutable ubyte[] enemyBankE_1F = [ 0xFF ];
immutable ubyte[] enemyBankE_20 = [ 0xFF ];
immutable ubyte[] enemyBankE_21 = [ 0x0F,0xDB,0xAC,0xA7, 0xFF ];
immutable ubyte[] enemyBankE_22 = [ 0x43,0x6D,0x40,0xD8, 0xFF ];
immutable ubyte[] enemyBankE_23 = [ 0xFF ];
immutable ubyte[] enemyBankE_24 = [ 0xFF ];
immutable ubyte[] enemyBankE_25 = [ 0xFF ];
immutable ubyte[] enemyBankE_26 = [ 0xFF ];
immutable ubyte[] enemyBankE_27 = [ 0xFF ];
immutable ubyte[] enemyBankE_28 = [ 0xFF ];
immutable ubyte[] enemyBankE_29 = [ 0xFF ];
immutable ubyte[] enemyBankE_2A = [ 0xFF ];
immutable ubyte[] enemyBankE_2B = [ 0x61,0x8A,0x5C,0x60, 0xFF ];
immutable ubyte[] enemyBankE_2C = [ 0xFF ];
immutable ubyte[] enemyBankE_2D = [ 0xFF ];
immutable ubyte[] enemyBankE_2E = [ 0xFF ];
immutable ubyte[] enemyBankE_2F = [ 0xFF ];
immutable ubyte[] enemyBankE_30 = [ 0xFF ];
immutable ubyte[] enemyBankE_31 = [ 0xFF ];
immutable ubyte[] enemyBankE_32 = [ 0xFF ];
immutable ubyte[] enemyBankE_33 = [ 0x44,0xCE,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankE_34 = [ 0xFF ];
immutable ubyte[] enemyBankE_35 = [ 0xFF ];
immutable ubyte[] enemyBankE_36 = [ 0xFF ];
immutable ubyte[] enemyBankE_37 = [ 0xFF ];
immutable ubyte[] enemyBankE_38 = [ 0xFF ];
immutable ubyte[] enemyBankE_39 = [ 0xFF ];
immutable ubyte[] enemyBankE_3A = [ 0x45,0xAD,0x40,0x88, 0xFF ];
immutable ubyte[] enemyBankE_3B = [ 0xFF ];
immutable ubyte[] enemyBankE_3C = [ 0xFF ];
immutable ubyte[] enemyBankE_3D = [ 0xFF ];
immutable ubyte[] enemyBankE_3E = [ 0xFF ];
immutable ubyte[] enemyBankE_3F = [ 0xFF ];
immutable ubyte[] enemyBankE_40 = [ 0xFF ];
immutable ubyte[] enemyBankE_41 = [ 0xFF ];
immutable ubyte[] enemyBankE_42 = [ 0xFF ];
immutable ubyte[] enemyBankE_43 = [ 0xFF ];
immutable ubyte[] enemyBankE_44 = [ 0xFF ];
immutable ubyte[] enemyBankE_45 = [ 0xFF ];
immutable ubyte[] enemyBankE_46 = [ 0xFF ];
immutable ubyte[] enemyBankE_47 = [ 0xFF ];
immutable ubyte[] enemyBankE_48 = [ 0xFF ];
immutable ubyte[] enemyBankE_49 = [ 0xFF ];
immutable ubyte[] enemyBankE_4A = [ 0xFF ];
immutable ubyte[] enemyBankE_4B = [ 0xFF ];
immutable ubyte[] enemyBankE_4C = [ 0xFF ];
immutable ubyte[] enemyBankE_4D = [ 0xFF ];
immutable ubyte[] enemyBankE_4E = [ 0xFF ];
immutable ubyte[] enemyBankE_4F = [ 0xFF ];
immutable ubyte[] enemyBankE_50 = [ 0xFF ];
immutable ubyte[] enemyBankE_51 = [ 0xFF ];
immutable ubyte[] enemyBankE_52 = [ 0xFF ];
immutable ubyte[] enemyBankE_53 = [ 0xFF ];
immutable ubyte[] enemyBankE_54 = [ 0xFF ];
immutable ubyte[] enemyBankE_55 = [ 0x6D,0x99,0x78,0xB8, 0xFF ];
immutable ubyte[] enemyBankE_56 = [ 0xFF ];
immutable ubyte[] enemyBankE_57 = [ 0xFF ];
immutable ubyte[] enemyBankE_58 = [ 0xFF ];
immutable ubyte[] enemyBankE_59 = [ 0xFF ];
immutable ubyte[] enemyBankE_5A = [ 0x0F,0x80,0x5C,0x60, 0x62,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankE_5B = [ 0xFF ];
immutable ubyte[] enemyBankE_5C = [ 0xFF ];
immutable ubyte[] enemyBankE_5D = [ 0xFF ];
immutable ubyte[] enemyBankE_5E = [ 0xFF ];
immutable ubyte[] enemyBankE_5F = [ 0xFF ];
immutable ubyte[] enemyBankE_60 = [ 0xFF ];
immutable ubyte[] enemyBankE_61 = [ 0x63,0x90,0x5C,0x60, 0xFF ];
immutable ubyte[] enemyBankE_62 = [ 0xFF ];
immutable ubyte[] enemyBankE_63 = [ 0xFF ];
immutable ubyte[] enemyBankE_64 = [ 0x14,0x1E,0x46,0x88, 0x15,0x41,0xB9,0xD8, 0xFF ];
immutable ubyte[] enemyBankE_65 = [ 0x64,0x97,0x38,0x68, 0xFF ];
immutable ubyte[] enemyBankE_66 = [ 0xFF ];
immutable ubyte[] enemyBankE_67 = [ 0xFF ];
immutable ubyte[] enemyBankE_68 = [ 0xFF ];
immutable ubyte[] enemyBankE_69 = [ 0xFF ];
immutable ubyte[] enemyBankE_6A = [ 0x0F,0x86,0x5C,0x60, 0x65,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankE_6B = [ 0x10,0x51,0x70,0x60, 0xFF ];
immutable ubyte[] enemyBankE_6C = [ 0xFF ];
immutable ubyte[] enemyBankE_6D = [ 0xFF ];
immutable ubyte[] enemyBankE_6E = [ 0xFF ];
immutable ubyte[] enemyBankE_6F = [ 0xFF ];
immutable ubyte[] enemyBankE_70 = [ 0xFF ];
immutable ubyte[] enemyBankE_71 = [ 0xFF ];
immutable ubyte[] enemyBankE_72 = [ 0xFF ];
immutable ubyte[] enemyBankE_73 = [ 0xFF ];
immutable ubyte[] enemyBankE_74 = [ 0x16,0x1E,0x46,0x38, 0x17,0x41,0xB9,0xE8, 0xFF ];
immutable ubyte[] enemyBankE_75 = [ 0x6E,0x99,0x20,0x28, 0xFF ];
immutable ubyte[] enemyBankE_76 = [ 0xFF ];
immutable ubyte[] enemyBankE_77 = [ 0xFF ];
immutable ubyte[] enemyBankE_78 = [ 0xFF ];
immutable ubyte[] enemyBankE_79 = [ 0xFF ];
immutable ubyte[] enemyBankE_7A = [ 0x0F,0x84,0x5C,0x60, 0x66,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankE_7B = [ 0x11,0x51,0x70,0xA0, 0xFF ];
immutable ubyte[] enemyBankE_7C = [ 0xFF ];
immutable ubyte[] enemyBankE_7D = [ 0xFF ];
immutable ubyte[] enemyBankE_7E = [ 0xFF ];
immutable ubyte[] enemyBankE_7F = [ 0xFF ];
immutable ubyte[] enemyBankE_80 = [ 0xFF ];
immutable ubyte[] enemyBankE_81 = [ 0x0F,0x86,0x5C,0x60, 0x67,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankE_82 = [ 0x12,0x46,0xB0,0x80, 0x13,0x41,0xC8,0xD8, 0xFF ];
immutable ubyte[] enemyBankE_83 = [ 0x10,0x46,0x40,0x80, 0x11,0x46,0x68,0xC0, 0xFF ];
immutable ubyte[] enemyBankE_84 = [ 0x18,0x41,0xB9,0xC8, 0xFF ];
immutable ubyte[] enemyBankE_85 = [ 0x46,0xA3,0x68,0x68, 0xFF ];
immutable ubyte[] enemyBankE_86 = [ 0xFF ];
immutable ubyte[] enemyBankE_87 = [ 0xFF ];
immutable ubyte[] enemyBankE_88 = [ 0xFF ];
immutable ubyte[] enemyBankE_89 = [ 0xFF ];
immutable ubyte[] enemyBankE_8A = [ 0x0F,0x82,0x5C,0x60, 0x68,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankE_8B = [ 0xFF ];
immutable ubyte[] enemyBankE_8C = [ 0xFF ];
immutable ubyte[] enemyBankE_8D = [ 0xFF ];
immutable ubyte[] enemyBankE_8E = [ 0xFF ];
immutable ubyte[] enemyBankE_8F = [ 0xFF ];
immutable ubyte[] enemyBankE_90 = [ 0xFF ];
immutable ubyte[] enemyBankE_91 = [ 0xFF ];
immutable ubyte[] enemyBankE_92 = [ 0xFF ];
immutable ubyte[] enemyBankE_93 = [ 0xFF ];
immutable ubyte[] enemyBankE_94 = [ 0xFF ];
immutable ubyte[] enemyBankE_95 = [ 0xFF ];
immutable ubyte[] enemyBankE_96 = [ 0xFF ];
immutable ubyte[] enemyBankE_97 = [ 0xFF ];
immutable ubyte[] enemyBankE_98 = [ 0xFF ];
immutable ubyte[] enemyBankE_99 = [ 0xFF ];
immutable ubyte[] enemyBankE_9A = [ 0xFF ];
immutable ubyte[] enemyBankE_9B = [ 0xFF ];
immutable ubyte[] enemyBankE_9C = [ 0xFF ];
immutable ubyte[] enemyBankE_9D = [ 0xFF ];
immutable ubyte[] enemyBankE_9E = [ 0xFF ];
immutable ubyte[] enemyBankE_9F = [ 0xFF ];
immutable ubyte[] enemyBankE_A0 = [ 0x0F,0x80,0x5C,0x60, 0x69,0xF8,0xFF,0x88, 0xFF ];
immutable ubyte[] enemyBankE_A1 = [ 0x1E,0x46,0xC0,0xA0, 0xFF ];
immutable ubyte[] enemyBankE_A2 = [ 0x1C,0x46,0x2C,0xD0, 0xFF ];
immutable ubyte[] enemyBankE_A3 = [ 0xFF ];
immutable ubyte[] enemyBankE_A4 = [ 0x47,0xA3,0x28,0x68, 0xFF ];
immutable ubyte[] enemyBankE_A5 = [ 0x1B,0x46,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankE_A6 = [ 0x1A,0x46,0x70,0xC0, 0x70,0x99,0x80,0xA8, 0xFF ];
immutable ubyte[] enemyBankE_A7 = [ 0x19,0x46,0x30,0xA0, 0xFF ];
immutable ubyte[] enemyBankE_A8 = [ 0xFF ];
immutable ubyte[] enemyBankE_A9 = [ 0xFF ];
immutable ubyte[] enemyBankE_AA = [ 0xFF ];
immutable ubyte[] enemyBankE_AB = [ 0xFF ];
immutable ubyte[] enemyBankE_AC = [ 0xFF ];
immutable ubyte[] enemyBankE_AD = [ 0xFF ];
immutable ubyte[] enemyBankE_AE = [ 0xFF ];
immutable ubyte[] enemyBankE_AF = [ 0xFF ];
immutable ubyte[] enemyBankE_B0 = [ 0x6A,0x97,0xA8,0x58, 0xFF ];
immutable ubyte[] enemyBankE_B1 = [ 0xFF ];
immutable ubyte[] enemyBankE_B2 = [ 0x48,0xA4,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankE_B3 = [ 0xFF ];
immutable ubyte[] enemyBankE_B4 = [ 0xFF ];
immutable ubyte[] enemyBankE_B5 = [ 0x20,0x5C,0xE0,0xBC, 0xFF ];
immutable ubyte[] enemyBankE_B6 = [ 0x21,0x63,0xC0,0xA0, 0xFF ];
immutable ubyte[] enemyBankE_B7 = [ 0x1F,0x5C,0x00,0xBC, 0xFF ];
immutable ubyte[] enemyBankE_B8 = [ 0xFF ];
immutable ubyte[] enemyBankE_B9 = [ 0xFF ];
immutable ubyte[] enemyBankE_BA = [ 0xFF ];
immutable ubyte[] enemyBankE_BB = [ 0xFF ];
immutable ubyte[] enemyBankE_BC = [ 0xFF ];
immutable ubyte[] enemyBankE_BD = [ 0xFF ];
immutable ubyte[] enemyBankE_BE = [ 0xFF ];
immutable ubyte[] enemyBankE_BF = [ 0xFF ];
immutable ubyte[] enemyBankE_C0 = [ 0xFF ];
immutable ubyte[] enemyBankE_C1 = [ 0xFF ];
immutable ubyte[] enemyBankE_C2 = [ 0xFF ];
immutable ubyte[] enemyBankE_C3 = [ 0xFF ];
immutable ubyte[] enemyBankE_C4 = [ 0xFF ];
immutable ubyte[] enemyBankE_C5 = [ 0xFF ];
immutable ubyte[] enemyBankE_C6 = [ 0xFF ];
immutable ubyte[] enemyBankE_C7 = [ 0xFF ];
immutable ubyte[] enemyBankE_C8 = [ 0xFF ];
immutable ubyte[] enemyBankE_C9 = [ 0xFF ];
immutable ubyte[] enemyBankE_CA = [ 0xFF ];
immutable ubyte[] enemyBankE_CB = [ 0xFF ];
immutable ubyte[] enemyBankE_CC = [ 0xFF ];
immutable ubyte[] enemyBankE_CD = [ 0xFF ];
immutable ubyte[] enemyBankE_CE = [ 0xFF ];
immutable ubyte[] enemyBankE_CF = [ 0xFF ];
immutable ubyte[] enemyBankE_D0 = [ 0xFF ];
immutable ubyte[] enemyBankE_D1 = [ 0x0F,0x82,0x2C,0x60, 0xFF ];
immutable ubyte[] enemyBankE_D2 = [ 0xFF ];
immutable ubyte[] enemyBankE_D3 = [ 0x0E,0x9B,0x48,0x88, 0x0F,0x9D,0xB8,0x88, 0xFF ];
immutable ubyte[] enemyBankE_D4 = [ 0xFF ];
immutable ubyte[] enemyBankE_D5 = [ 0xFF ];
immutable ubyte[] enemyBankE_D6 = [ 0xFF ];
immutable ubyte[] enemyBankE_D7 = [ 0xFF ];
immutable ubyte[] enemyBankE_D8 = [ 0xFF ];
immutable ubyte[] enemyBankE_D9 = [ 0xFF ];
immutable ubyte[] enemyBankE_DA = [ 0xFF ];
immutable ubyte[] enemyBankE_DB = [ 0xFF ];
immutable ubyte[] enemyBankE_DC = [ 0xFF ];
immutable ubyte[] enemyBankE_DD = [ 0xFF ];
immutable ubyte[] enemyBankE_DE = [ 0xFF ];
immutable ubyte[] enemyBankE_DF = [ 0xFF ];
immutable ubyte[] enemyBankE_E0 = [ 0xFF ];
immutable ubyte[] enemyBankE_E1 = [ 0xFF ];
immutable ubyte[] enemyBankE_E2 = [ 0xFF ];
immutable ubyte[] enemyBankE_E3 = [ 0xFF ];
immutable ubyte[] enemyBankE_E4 = [ 0xFF ];
immutable ubyte[] enemyBankE_E5 = [ 0xFF ];
immutable ubyte[] enemyBankE_E6 = [ 0xFF ];
immutable ubyte[] enemyBankE_E7 = [ 0xFF ];
immutable ubyte[] enemyBankE_E8 = [ 0xFF ];
immutable ubyte[] enemyBankE_E9 = [ 0xFF ];
immutable ubyte[] enemyBankE_EA = [ 0xFF ];
immutable ubyte[] enemyBankE_EB = [ 0xFF ];
immutable ubyte[] enemyBankE_EC = [ 0xFF ];
immutable ubyte[] enemyBankE_ED = [ 0xFF ];
immutable ubyte[] enemyBankE_EE = [ 0xFF ];
immutable ubyte[] enemyBankE_EF = [ 0xFF ];
immutable ubyte[] enemyBankE_F0 = [ 0xFF ];
immutable ubyte[] enemyBankE_F1 = [ 0xFF ];
immutable ubyte[] enemyBankE_F2 = [ 0xFF ];
immutable ubyte[] enemyBankE_F3 = [ 0xFF ];
immutable ubyte[] enemyBankE_F4 = [ 0xFF ];
immutable ubyte[] enemyBankE_F5 = [ 0xFF ];
immutable ubyte[] enemyBankE_F6 = [ 0xFF ];
immutable ubyte[] enemyBankE_F7 = [ 0xFF ];
immutable ubyte[] enemyBankE_F8 = [ 0xFF ];
immutable ubyte[] enemyBankE_F9 = [ 0xFF ];
immutable ubyte[] enemyBankE_FA = [ 0xFF ];
immutable ubyte[] enemyBankE_FB = [ 0xFF ];
immutable ubyte[] enemyBankE_FC = [ 0xFF ];
immutable ubyte[] enemyBankE_FD = [ 0xFF ];
immutable ubyte[] enemyBankE_FE = [ 0xFF ];
immutable ubyte[] enemyBankE_FF = [ 0xFF ];
immutable ubyte[] enemyBankF_00 = [ 0xFF ];
immutable ubyte[] enemyBankF_01 = [ 0xFF ];
immutable ubyte[] enemyBankF_02 = [ 0xFF ];
immutable ubyte[] enemyBankF_03 = [ 0xFF ];
immutable ubyte[] enemyBankF_04 = [ 0xFF ];
immutable ubyte[] enemyBankF_05 = [ 0xFF ];
immutable ubyte[] enemyBankF_06 = [ 0xFF ];
immutable ubyte[] enemyBankF_07 = [ 0xFF ];
immutable ubyte[] enemyBankF_08 = [ 0xFF ];
immutable ubyte[] enemyBankF_09 = [ 0xFF ];
immutable ubyte[] enemyBankF_0A = [ 0xFF ];
immutable ubyte[] enemyBankF_0B = [ 0xFF ];
immutable ubyte[] enemyBankF_0C = [ 0xFF ];
immutable ubyte[] enemyBankF_0D = [ 0xFF ];
immutable ubyte[] enemyBankF_0E = [ 0xFF ];
immutable ubyte[] enemyBankF_0F = [ 0xFF ];
immutable ubyte[] enemyBankF_10 = [ 0x41,0xA0,0x90,0xE6, 0x0E,0x9B,0xC8,0x48, 0x0F,0x9D,0xE8,0x48, 0xFF ];
immutable ubyte[] enemyBankF_11 = [ 0xFF ];
immutable ubyte[] enemyBankF_12 = [ 0x31,0x14,0x90,0xC8, 0xFF ];
immutable ubyte[] enemyBankF_13 = [ 0x2F,0x12,0x60,0xA8, 0x30,0x14,0x80,0xB0, 0xFF ];
immutable ubyte[] enemyBankF_14 = [ 0x2D,0x12,0x50,0xA0, 0x2E,0x12,0x80,0xA8, 0xFF ];
immutable ubyte[] enemyBankF_15 = [ 0x2C,0x14,0x60,0xD0, 0xFF ];
immutable ubyte[] enemyBankF_16 = [ 0xFF ];
immutable ubyte[] enemyBankF_17 = [ 0xFF ];
immutable ubyte[] enemyBankF_18 = [ 0xFF ];
immutable ubyte[] enemyBankF_19 = [ 0xFF ];
immutable ubyte[] enemyBankF_1A = [ 0xFF ];
immutable ubyte[] enemyBankF_1B = [ 0xFF ];
immutable ubyte[] enemyBankF_1C = [ 0xFF ];
immutable ubyte[] enemyBankF_1D = [ 0xFF ];
immutable ubyte[] enemyBankF_1E = [ 0xFF ];
immutable ubyte[] enemyBankF_1F = [ 0xFF ];
immutable ubyte[] enemyBankF_20 = [ 0xFF ];
immutable ubyte[] enemyBankF_21 = [ 0xFF ];
immutable ubyte[] enemyBankF_22 = [ 0xFF ];
immutable ubyte[] enemyBankF_23 = [ 0xFF ];
immutable ubyte[] enemyBankF_24 = [ 0xFF ];
immutable ubyte[] enemyBankF_25 = [ 0xFF ];
immutable ubyte[] enemyBankF_26 = [ 0xFF ];
immutable ubyte[] enemyBankF_27 = [ 0xFF ];
immutable ubyte[] enemyBankF_28 = [ 0xFF ];
immutable ubyte[] enemyBankF_29 = [ 0xFF ];
immutable ubyte[] enemyBankF_2A = [ 0xFF ];
immutable ubyte[] enemyBankF_2B = [ 0xFF ];
immutable ubyte[] enemyBankF_2C = [ 0xFF ];
immutable ubyte[] enemyBankF_2D = [ 0xFF ];
immutable ubyte[] enemyBankF_2E = [ 0xFF ];
immutable ubyte[] enemyBankF_2F = [ 0xFF ];
immutable ubyte[] enemyBankF_30 = [ 0xFF ];
immutable ubyte[] enemyBankF_31 = [ 0xFF ];
immutable ubyte[] enemyBankF_32 = [ 0xFF ];
immutable ubyte[] enemyBankF_33 = [ 0xFF ];
immutable ubyte[] enemyBankF_34 = [ 0xFF ];
immutable ubyte[] enemyBankF_35 = [ 0xFF ];
immutable ubyte[] enemyBankF_36 = [ 0xFF ];
immutable ubyte[] enemyBankF_37 = [ 0xFF ];
immutable ubyte[] enemyBankF_38 = [ 0xFF ];
immutable ubyte[] enemyBankF_39 = [ 0xFF ];
immutable ubyte[] enemyBankF_3A = [ 0xFF ];
immutable ubyte[] enemyBankF_3B = [ 0xFF ];
immutable ubyte[] enemyBankF_3C = [ 0xFF ];
immutable ubyte[] enemyBankF_3D = [ 0xFF ];
immutable ubyte[] enemyBankF_3E = [ 0xFF ];
immutable ubyte[] enemyBankF_3F = [ 0xFF ];
immutable ubyte[] enemyBankF_40 = [ 0xFF ];
immutable ubyte[] enemyBankF_41 = [ 0xFF ];
immutable ubyte[] enemyBankF_42 = [ 0xFF ];
immutable ubyte[] enemyBankF_43 = [ 0xFF ];
immutable ubyte[] enemyBankF_44 = [ 0xFF ];
immutable ubyte[] enemyBankF_45 = [ 0xFF ];
immutable ubyte[] enemyBankF_46 = [ 0xFF ];
immutable ubyte[] enemyBankF_47 = [ 0xFF ];
immutable ubyte[] enemyBankF_48 = [ 0xFF ];
immutable ubyte[] enemyBankF_49 = [ 0xFF ];
immutable ubyte[] enemyBankF_4A = [ 0xFF ];
immutable ubyte[] enemyBankF_4B = [ 0xFF ];
immutable ubyte[] enemyBankF_4C = [ 0xFF ];
immutable ubyte[] enemyBankF_4D = [ 0xFF ];
immutable ubyte[] enemyBankF_4E = [ 0xFF ];
immutable ubyte[] enemyBankF_4F = [ 0xFF ];
immutable ubyte[] enemyBankF_50 = [ 0xFF ];
immutable ubyte[] enemyBankF_51 = [ 0xFF ];
immutable ubyte[] enemyBankF_52 = [ 0xFF ];
immutable ubyte[] enemyBankF_53 = [ 0xFF ];
immutable ubyte[] enemyBankF_54 = [ 0xFF ];
immutable ubyte[] enemyBankF_55 = [ 0xFF ];
immutable ubyte[] enemyBankF_56 = [ 0xFF ];
immutable ubyte[] enemyBankF_57 = [ 0xFF ];
immutable ubyte[] enemyBankF_58 = [ 0xFF ];
immutable ubyte[] enemyBankF_59 = [ 0xFF ];
immutable ubyte[] enemyBankF_5A = [ 0xFF ];
immutable ubyte[] enemyBankF_5B = [ 0xFF ];
immutable ubyte[] enemyBankF_5C = [ 0xFF ];
immutable ubyte[] enemyBankF_5D = [ 0xFF ];
immutable ubyte[] enemyBankF_5E = [ 0x0F,0x9D,0x08,0xC0, 0xFF ];
immutable ubyte[] enemyBankF_5F = [ 0xFF ];
immutable ubyte[] enemyBankF_60 = [ 0xFF ];
immutable ubyte[] enemyBankF_61 = [ 0xFF ];
immutable ubyte[] enemyBankF_62 = [ 0xFF ];
immutable ubyte[] enemyBankF_63 = [ 0xFF ];
immutable ubyte[] enemyBankF_64 = [ 0xFF ];
immutable ubyte[] enemyBankF_65 = [ 0xFF ];
immutable ubyte[] enemyBankF_66 = [ 0xFF ];
immutable ubyte[] enemyBankF_67 = [ 0xFF ];
immutable ubyte[] enemyBankF_68 = [ 0xFF ];
immutable ubyte[] enemyBankF_69 = [ 0xFF ];
immutable ubyte[] enemyBankF_6A = [ 0x17,0x00,0x80,0xA8, 0xFF ];
immutable ubyte[] enemyBankF_6B = [ 0x18,0x01,0x80,0xA8, 0xFF ];
immutable ubyte[] enemyBankF_6C = [ 0x19,0x14,0x20,0x80, 0xFF ];
immutable ubyte[] enemyBankF_6D = [ 0xFF ];
immutable ubyte[] enemyBankF_6E = [ 0xFF ];
immutable ubyte[] enemyBankF_6F = [ 0xFF ];
immutable ubyte[] enemyBankF_70 = [ 0xFF ];
immutable ubyte[] enemyBankF_71 = [ 0xFF ];
immutable ubyte[] enemyBankF_72 = [ 0xFF ];
immutable ubyte[] enemyBankF_73 = [ 0xFF ];
immutable ubyte[] enemyBankF_74 = [ 0xFF ];
immutable ubyte[] enemyBankF_75 = [ 0x0E,0x9B,0xD0,0xB8, 0xFF ];
immutable ubyte[] enemyBankF_76 = [ 0x0F,0x9D,0x38,0xB8, 0xFF ];
immutable ubyte[] enemyBankF_77 = [ 0xFF ];
immutable ubyte[] enemyBankF_78 = [ 0xFF ];
immutable ubyte[] enemyBankF_79 = [ 0xFF ];
immutable ubyte[] enemyBankF_7A = [ 0xFF ];
immutable ubyte[] enemyBankF_7B = [ 0xFF ];
immutable ubyte[] enemyBankF_7C = [ 0xFF ];
immutable ubyte[] enemyBankF_7D = [ 0xFF ];
immutable ubyte[] enemyBankF_7E = [ 0xFF ];
immutable ubyte[] enemyBankF_7F = [ 0xFF ];
immutable ubyte[] enemyBankF_80 = [ 0xFF ];
immutable ubyte[] enemyBankF_81 = [ 0xFF ];
immutable ubyte[] enemyBankF_82 = [ 0xFF ];
immutable ubyte[] enemyBankF_83 = [ 0xFF ];
immutable ubyte[] enemyBankF_84 = [ 0xFF ];
immutable ubyte[] enemyBankF_85 = [ 0xFF ];
immutable ubyte[] enemyBankF_86 = [ 0xFF ];
immutable ubyte[] enemyBankF_87 = [ 0xFF ];
immutable ubyte[] enemyBankF_88 = [ 0xFF ];
immutable ubyte[] enemyBankF_89 = [ 0xFF ];
immutable ubyte[] enemyBankF_8A = [ 0xFF ];
immutable ubyte[] enemyBankF_8B = [ 0xFF ];
immutable ubyte[] enemyBankF_8C = [ 0xFF ];
immutable ubyte[] enemyBankF_8D = [ 0xFF ];
immutable ubyte[] enemyBankF_8E = [ 0xFF ];
immutable ubyte[] enemyBankF_8F = [ 0xFF ];
immutable ubyte[] enemyBankF_90 = [ 0xFF ];
immutable ubyte[] enemyBankF_91 = [ 0xFF ];
immutable ubyte[] enemyBankF_92 = [ 0xFF ];
immutable ubyte[] enemyBankF_93 = [ 0xFF ];
immutable ubyte[] enemyBankF_94 = [ 0xFF ];
immutable ubyte[] enemyBankF_95 = [ 0xFF ];
immutable ubyte[] enemyBankF_96 = [ 0xFF ];
immutable ubyte[] enemyBankF_97 = [ 0xFF ];
immutable ubyte[] enemyBankF_98 = [ 0xFF ];
immutable ubyte[] enemyBankF_99 = [ 0xFF ];
immutable ubyte[] enemyBankF_9A = [ 0xFF ];
immutable ubyte[] enemyBankF_9B = [ 0xFF ];
immutable ubyte[] enemyBankF_9C = [ 0xFF ];
immutable ubyte[] enemyBankF_9D = [ 0xFF ];
immutable ubyte[] enemyBankF_9E = [ 0xFF ];
immutable ubyte[] enemyBankF_9F = [ 0xFF ];
immutable ubyte[] enemyBankF_A0 = [ 0xFF ];
immutable ubyte[] enemyBankF_A1 = [ 0xFF ];
immutable ubyte[] enemyBankF_A2 = [ 0xFF ];
immutable ubyte[] enemyBankF_A3 = [ 0xFF ];
immutable ubyte[] enemyBankF_A4 = [ 0xFF ];
immutable ubyte[] enemyBankF_A5 = [ 0xFF ];
immutable ubyte[] enemyBankF_A6 = [ 0xFF ];
immutable ubyte[] enemyBankF_A7 = [ 0x42,0xA6,0xAC,0xA7, 0xFF ];
immutable ubyte[] enemyBankF_A8 = [ 0xFF ];
immutable ubyte[] enemyBankF_A9 = [ 0xFF ];
immutable ubyte[] enemyBankF_AA = [ 0xFF ];
immutable ubyte[] enemyBankF_AB = [ 0xFF ];
immutable ubyte[] enemyBankF_AC = [ 0xFF ];
immutable ubyte[] enemyBankF_AD = [ 0xFF ];
immutable ubyte[] enemyBankF_AE = [ 0xFF ];
immutable ubyte[] enemyBankF_AF = [ 0xFF ];
immutable ubyte[] enemyBankF_B0 = [ 0x43,0xB3,0x40,0x80, 0xFF ];
immutable ubyte[] enemyBankF_B1 = [ 0xFF ];
immutable ubyte[] enemyBankF_B2 = [ 0xFF ];
immutable ubyte[] enemyBankF_B3 = [ 0xFF ];
immutable ubyte[] enemyBankF_B4 = [ 0xFF ];
immutable ubyte[] enemyBankF_B5 = [ 0xFF ];
immutable ubyte[] enemyBankF_B6 = [ 0xFF ];
immutable ubyte[] enemyBankF_B7 = [ 0xFF ];
immutable ubyte[] enemyBankF_B8 = [ 0xFF ];
immutable ubyte[] enemyBankF_B9 = [ 0xFF ];
immutable ubyte[] enemyBankF_BA = [ 0xFF ];
immutable ubyte[] enemyBankF_BB = [ 0x10,0x65,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankF_BC = [ 0x11,0x65,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankF_BD = [ 0x12,0x65,0x80,0xC0, 0xFF ];
immutable ubyte[] enemyBankF_BE = [ 0xFF ];
immutable ubyte[] enemyBankF_BF = [ 0xFF ];
immutable ubyte[] enemyBankF_C0 = [ 0xFF ];
immutable ubyte[] enemyBankF_C1 = [ 0xFF ];
immutable ubyte[] enemyBankF_C2 = [ 0xFF ];
immutable ubyte[] enemyBankF_C3 = [ 0xFF ];
immutable ubyte[] enemyBankF_C4 = [ 0xFF ];
immutable ubyte[] enemyBankF_C5 = [ 0xFF ];
immutable ubyte[] enemyBankF_C6 = [ 0xFF ];
immutable ubyte[] enemyBankF_C7 = [ 0xFF ];
immutable ubyte[] enemyBankF_C8 = [ 0xFF ];
immutable ubyte[] enemyBankF_C9 = [ 0xFF ];
immutable ubyte[] enemyBankF_CA = [ 0x13,0x65,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankF_CB = [ 0xFF ];
immutable ubyte[] enemyBankF_CC = [ 0xFF ];
immutable ubyte[] enemyBankF_CD = [ 0xFF ];
immutable ubyte[] enemyBankF_CE = [ 0x14,0x65,0x80,0x80, 0xFF ];
immutable ubyte[] enemyBankF_CF = [ 0xFF ];
immutable ubyte[] enemyBankF_D0 = [ 0xFF ];
immutable ubyte[] enemyBankF_D1 = [ 0xFF ];
immutable ubyte[] enemyBankF_D2 = [ 0xFF ];
immutable ubyte[] enemyBankF_D3 = [ 0xFF ];
immutable ubyte[] enemyBankF_D4 = [ 0xFF ];
immutable ubyte[] enemyBankF_D5 = [ 0xFF ];
immutable ubyte[] enemyBankF_D6 = [ 0xFF ];
immutable ubyte[] enemyBankF_D7 = [ 0xFF ];
immutable ubyte[] enemyBankF_D8 = [ 0xFF ];
immutable ubyte[] enemyBankF_D9 = [ 0xFF ];
immutable ubyte[] enemyBankF_DA = [ 0xFF ];
immutable ubyte[] enemyBankF_DB = [ 0xFF ];
immutable ubyte[] enemyBankF_DC = [ 0xFF ];
immutable ubyte[] enemyBankF_DD = [ 0xFF ];
immutable ubyte[] enemyBankF_DE = [ 0xFF ];
immutable ubyte[] enemyBankF_DF = [ 0xFF ];
immutable ubyte[] enemyBankF_E0 = [ 0x40,0xB3,0x40,0x80, 0xFF ];
immutable ubyte[] enemyBankF_E1 = [ 0xFF ];
immutable ubyte[] enemyBankF_E2 = [ 0xFF ];
immutable ubyte[] enemyBankF_E3 = [ 0xFF ];
immutable ubyte[] enemyBankF_E4 = [ 0xFF ];
immutable ubyte[] enemyBankF_E5 = [ 0xFF ];
immutable ubyte[] enemyBankF_E6 = [ 0xFF ];
immutable ubyte[] enemyBankF_E7 = [ 0xFF ];
immutable ubyte[] enemyBankF_E8 = [ 0xFF ];
immutable ubyte[] enemyBankF_E9 = [ 0xFF ];
immutable ubyte[] enemyBankF_EA = [ 0xFF ];
immutable ubyte[] enemyBankF_EB = [ 0xFF ];
immutable ubyte[] enemyBankF_EC = [ 0x15,0x65,0x80,0x50, 0xFF ];
immutable ubyte[] enemyBankF_ED = [ 0xFF ];
immutable ubyte[] enemyBankF_EE = [ 0xFF ];
immutable ubyte[] enemyBankF_EF = [ 0xFF ];
immutable ubyte[] enemyBankF_F0 = [ 0xFF ];
immutable ubyte[] enemyBankF_F1 = [ 0xFF ];
immutable ubyte[] enemyBankF_F2 = [ 0xFF ];
immutable ubyte[] enemyBankF_F3 = [ 0xFF ];
immutable ubyte[] enemyBankF_F4 = [ 0xFF ];
immutable ubyte[] enemyBankF_F5 = [ 0xFF ];
immutable ubyte[] enemyBankF_F6 = [ 0xFF ];
immutable ubyte[] enemyBankF_F7 = [ 0xFF ];
immutable ubyte[] enemyBankF_F8 = [ 0xFF ];
immutable ubyte[] enemyBankF_F9 = [ 0xFF ];
immutable ubyte[] enemyBankF_FA = [ 0xFF ];
immutable ubyte[] enemyBankF_FB = [ 0xFF ];
immutable ubyte[] enemyBankF_FC = [ 0xFF ];
immutable ubyte[] enemyBankF_FD = [ 0xFF ];
immutable ubyte[] enemyBankF_FE = [ 0xFF ];
immutable ubyte[] enemyBankF_FF = [ 0xFF ];

immutable EnemyData[] enemyHeaderPointers = [
	enHeadCrawlerRight, // Tsumari
	enHeadCrawlerLeft, // Tsumari
	enHeadNULL, // Tsumari
	enHeadNULL, // Tsumari
	enHeadSkreek, // Skreek
	enHeadNULL, // Skreek
	enHeadNULL, // Skreek
	enHeadNULL, // Skreek
	enHeadNULL, // Skreek projectile
	enHeadDrivel, // Drivel
	enHeadNULL, // Drivel
	enHeadNULL, // Drivel
	enHeadNULL, // Drivel projectile
	enHeadNULL, // Drivel projectile
	enHeadNULL, // Drivel projectile
	enHeadNULL, // Drivel projectile
	enHeadNULL, // Drivel projectile
	enHeadNULL, // Drivel projectile
	enHeadSmallBug, // Small bugs
	enHeadNULL, // Small bugs
	enHeadHornoad, // Hornoad
	enHeadNULL, // Hornoad
	enHeadSenjoo, // Senjoo
	enHeadNULL, // Gawron
	enHeadNULL, // Gawron
	enHeadPipeBug, // Gawron spawner?
	enHeadPipeBug, // Gawron spawner?
	enHeadChuteLeech, // Chute leech
	enHeadNULL, // Chute leech
	enHeadNULL, // Chute leech
	enHeadAutrackFlipped, // (uses same spritemap as 41h autrack)
	enHeadWallfireFlipped, // (uses same spritemap as 4Ah wallfire)
	enHeadCrawlerRight, // Needler
	enHeadCrawlerLeft, // Needler
	enHeadNULL, // Needler
	enHeadNULL, // Needler
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadSkorpUp, // Skorp
	enHeadSkorpDown, // Skorp
	enHeadSkorpRight, // Skorp
	enHeadSkorpLeft, // Skorp
	enHeadGlowFly, // Glow fly
	enHeadNULL, // Glow fly
	enHeadNULL, // Glow fly
	enHeadNULL, // Glow fly
	enHeadMoheekRight, // Moheek
	enHeadMoheekLeft, // Moheek
	enHeadNULL, // Moheek
	enHeadNULL, // Moheek
	enHeadRockIcicle, // Rock icicle
	enHeadNULL, // Rock icicle
	enHeadNULL, // Rock icicle
	enHeadNULL, // Rock icicle
	enHeadNULL, // Yumee
	enHeadNULL, // Yumee
	enHeadNULL, // Yumee
	enHeadNULL, // Yumee
	enHeadPipeBug, // Yumee spawner?
	enHeadPipeBug, // Yumee spawner?
	enHeadNULL, // Octroll
	enHeadNULL, // Octroll
	enHeadOctroll, // Octroll
	enHeadAutrack, // Autrack
	enHeadNULL, // Autrack
	enHeadNULL, // Autrack
	enHeadNULL, // Autrack
	enHeadNULL, // Autrack projectile
	enHeadAutoad, // Autoad
	enHeadNULL, // Autoad
	enHeadNULL, // Sideways Autoad (unused)
	enHeadNULL, // Sideways Autoad (unused)
	enHeadWallfire, // Wallfire
	enHeadNULL, // Wallfire
	enHeadNULL, // Wallfire
	enHeadNULL, // Wallfire projectile
	enHeadNULL, // Wallfire projectile
	enHeadNULL, // Wallfire projectile
	enHeadNULL, // Wallfire projectile
	enHeadGunzoo, // Gunzoo
	enHeadNULL, // Gunzoo
	enHeadNULL, // Gunzoo
	enHeadNULL, // Gunzoo diagonal projectile
	enHeadNULL, // Gunzoo diagonal projectile
	enHeadNULL, // Gunzoo diagonal projectile
	enHeadNULL, // Gunzoo horizontal projectile
	enHeadNULL, // Gunzoo horizontal projectile (unused frame)
	enHeadNULL, // Gunzoo horizontal projectile
	enHeadNULL, // Gunzoo horizontal projectile
	enHeadNULL, // Gunzoo horizontal projectile
	enHeadAutom, // Autom
	enHeadNULL, // Autom
	enHeadNULL, // Autom projectile
	enHeadNULL, // Autom projectile
	enHeadNULL, // Autom projectile
	enHeadNULL, // Autom projectile
	enHeadNULL, // Autom projectile
	enHeadShirk, // Shirk
	enHeadNULL, // Shirk
	enHeadSeptogg, // Septogg
	enHeadNULL, // Septogg
	enHeadNULL, // Moto
	enHeadMoto, // Moto
	enHeadNULL, // Moto
	enHeadHalzyn, // Halzyn
	enHeadRamulken, // Ramulken
	enHeadNULL, // Ramulken
	enHeadMetroidStinger, // Musical stinger event trigger
	enHeadProboscumFlipped, // (uses same spritemap as 72h proboscum)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadProboscum, // Proboscum
	enHeadNULL, // Proboscum
	enHeadNULL, // Proboscum
	enHeadMissileBlock, // Missile block
	enHeadArachnus, // Arachnus
	enHeadArachnus, // Arachnus
	enHeadArachnus, // Arachnus
	enHeadArachnus, // Arachnus
	enHeadArachnus, // Arachnus
	enHeadNULL, // Arachnus projectile
	enHeadNULL, // Arachnus projectile
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadItem, // Plasma beam orb
	enHeadItem, // Plasma beam
	enHeadItem, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	enHeadItem, // Ice beam
	enHeadItem, // Wave beam orb
	enHeadItem, // Wave beam
	enHeadItem, // Spazer beam orb
	enHeadItem, // Spazer beam
	enHeadItem, // Bombs orb
	enHeadItem, // Bombs
	enHeadItem, // Screw attack orb
	enHeadItem, // Screw attack
	enHeadItem, // Varia suit orb
	enHeadItem, // Varia suit
	enHeadItem, // Hi-jump boots orb
	enHeadItem, // Hi-jump boots
	enHeadItem, // Space jump orb
	enHeadItem, // Space jump
	enHeadItem, // (spider ball orb?)
	enHeadItem, // Spider ball
	enHeadItem, // (spring ball orb?)
	enHeadItem, // Spring ball
	enHeadItem, // (energy tank orb?)
	enHeadItem, // Energy tank
	enHeadItem, // (missile tank orb?)
	enHeadItem, // Missile tank
	enHeadBlobThrower, // Blob thrower (sprite is written to WRAM)
	enHeadItem, // Energy refill
	enHeadArachnusOrb, // Arachnus orb
	enHeadItem, // Missile refill
	enHeadNULL, // Blob thrower projectile
	enHeadNULL, // Blob thrower projectile
	enHeadAlphaHatching, // Metroid
	enHeadNULL, // Metroid hatching
	enHeadNULL, // (no graphics)
	enHeadGammaMetroid, // Alpha metroid
	enHeadAlphaMetroid, // Alpha metroid
	enHeadNULL, // Baby metroid egg
	enHeadBabyMetroid, // Baby metroid egg
	enHeadNULL, // Baby metroid egg
	enHeadNULL, // Baby metroid
	enHeadNULL, // Baby metroid
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadZetaMetroid, // Gamma metroid
	enHeadNULL, // Gamma metroid projectile
	enHeadNULL, // Gamma metroid projectile
	enHeadNULL, // Gamma metroid
	enHeadNULL, // (no graphics)
	enHeadNULL, // Gamma metroid shell
	enHeadOmegaMetroid, // Zeta metroid hatching
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid
	enHeadNULL, // Zeta metroid projectile
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // Omega metroid projectile
	enHeadNULL, // (omega metroid projectile?)
	enHeadMetroid, // Metroid
	enHeadNULL, // Metroid (hurt)
	enHeadFlittVanishing, // Flitt
	enHeadFlittMoving, // Flitt
	enHeadNULL, // Stalagtite (unused)
	enHeadGravitt, // Gravitt
	enHeadNULL, // Gravitt
	enHeadNULL, // Gravitt
	enHeadNULL, // Gravitt
	enHeadNULL, // Gravitt
	enHeadGullugg, // Gullugg
	enHeadNULL, // Gullugg
	enHeadNULL, // Gullugg
	enHeadNULL, // Baby metroid egg preview
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // Small health drop
	enHeadNULL, // Small health drop
	enHeadNULL, // Metroid death / missile door / screw attack explosion
	enHeadNULL, // Metroid death / missile door / screw attack explosion
	enHeadNULL, // Metroid death / missile door / screw attack explosion
	enHeadNULL, // Metroid death / missile door / screw attack explosion
	enHeadNULL, // Metroid death / missile door / screw attack explosion
	enHeadNULL, // Metroid death / missile door / screw attack explosion
	enHeadNULL, // Enemy death explosion
	enHeadNULL, // Enemy death explosion
	enHeadNULL, // Enemy death explosion
	enHeadNULL, // Enemy death explosion (extra frame for enemies not dropping small health)
	enHeadNULL, // Big energy drop
	enHeadNULL, // Big energy drop
	enHeadNULL, // Missile drop
	enHeadNULL, // Missile drop
	enHeadNULL, // Metroid Queen neck (no graphics)
	enHeadNULL, // Metroid Queen head left half (no graphics)
	enHeadNULL, // Metroid Queen projectile/head right half (no graphics)
	enHeadNULL, // Metroid Queen body (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // Metroid Queen mouth closed (no graphics)
	enHeadNULL, // Metroid Queen mouth open (no graphics)
	enHeadNULL, // Metroid Queen mouth stunned (no graphics)
	enHeadMissileDoor, // Missile door
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // (no graphics)
	enHeadNULL, // Nothing - flitt (no graphics)
	enHeadNULL, // ?
];

immutable enHeadNULL = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 , &enAINULL);
immutable enHeadCrawlerRight = EnemyData(0x00,0x20,0x00,0x00,0x00,0xFF,0x00,0x00,0x01, &enAICrawlerA);
immutable enHeadCrawlerLeft = EnemyData(0x00,0x00,0x00,0x00,0x02,0xFF,0x00,0x00,0x01, &enAICrawlerB);
immutable enHeadSkreek = EnemyData(0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0B, &enAISkreek);
immutable enHeadDrivel = EnemyData(0x00,0x00,0x00,0x00,0x00,0x10,0x00,0x00,0x0A, &enAIDrivel);
immutable enHeadSmallBug = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01, &enAISmallBug);
immutable enHeadHornoad = EnemyData(0x00,0x20,0x00,0x00,0x00,0x00,0x02,0x00,0x02, &enAIHopper);
immutable enHeadSenjoo = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x06, &enAISenjooShirk);
immutable enHeadPipeBug = EnemyData(0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIPipeBug);
immutable enHeadChuteLeech = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03, &enAIChuteLeech);
immutable enHeadAutrackFlipped = EnemyData(0x00,0x20,0x00,0x00,0x08,0x00,0x00,0x00,0x0F, &enAIAutrack);
immutable enHeadWallfireFlipped = EnemyData(0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIWallfire);
immutable enHeadSkorpUp = EnemyData(0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x04, &enAISkorpVert);
immutable enHeadSkorpDown = EnemyData(0x80,0x40,0x00,0x00,0x00,0x00,0x00,0x00,0x04, &enAISkorpVert);
immutable enHeadSkorpRight = EnemyData(0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x04, &enAISkorpHori);
immutable enHeadSkorpLeft = EnemyData(0x80,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0x04, &enAISkorpHori);
immutable enHeadMoheekRight = EnemyData(0x00,0x20,0x00,0x00,0x00,0xFF,0x00,0x00,0x05, &enAICrawlerA);
immutable enHeadMoheekLeft = EnemyData(0x00,0x00,0x00,0x00,0x02,0xFF,0x00,0x00,0x05, &enAICrawlerB);
immutable enHeadOctroll = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0F, &enAIChuteLeech);
immutable enHeadAutrack = EnemyData(0x00,0x00,0x00,0x00,0x08,0x00,0x00,0x00,0x0F, &enAIAutrack);
immutable enHeadAutoad = EnemyData(0x00,0x20,0x00,0x00,0x00,0x00,0x02,0x00,0x0E, &enAIHopper);
immutable enHeadWallfire = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIWallfire);
immutable enHeadGunzoo = EnemyData(0x00,0x00,0x00,0x00,0x01,0x00,0x00,0x00,0x15, &enAIGunzoo);
immutable enHeadAutom = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIAutom);
immutable enHeadShirk = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x0A, &enAISenjooShirk);
immutable enHeadSeptogg = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAISeptogg);
immutable enHeadMoto = EnemyData(0x00,0x20,0x00,0x00,0x20,0x00,0x00,0x00,0x11, &enAIMoto);
immutable enHeadHalzyn = EnemyData(0x00,0x00,0x00,0x00,0x30,0x00,0x00,0x00,0x03, &enAIHalzyn);
immutable enHeadRamulken = EnemyData(0x00,0x20,0x00,0x00,0xB0,0x00,0x02,0x00,0x0C, &enAIHopper);
immutable enHeadMetroidStinger = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIMetroidStinger);
immutable enHeadProboscumFlipped = EnemyData(0x00,0x20,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIProboscum);
immutable enHeadProboscum = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIProboscum);
immutable enHeadMissileBlock = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIMissileBlock);
immutable enHeadFlittVanishing = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIFlittVanishing);
immutable enHeadFlittMoving = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIFlittMoving);
immutable enHeadGravitt = EnemyData(0x80,0x00,0x00,0x00,0x80,0x00,0x00,0x00,0x05, &enAIGravitt);
immutable enHeadGullugg = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x04, &enAIGullugg);
immutable enHeadMissileDoor = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIMissileDoor);
immutable enHeadAlphaHatching = EnemyData(0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0x05, &enAIHatchingAlpha);
immutable enHeadAlphaMetroid = EnemyData(0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0x05, &enAIAlphaMetroid);
immutable enHeadGammaMetroid = EnemyData(0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0x0A, &enAIGammaMetroid);
immutable enHeadZetaMetroid = EnemyData(0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0x14, &enAIZetaMetroid);
immutable enHeadOmegaMetroid = EnemyData(0x00,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0x28, &enAIOmegaMetroid);
immutable enHeadMetroid = EnemyData(0x00,0x00,0x00,0x00,0xFF,0x10,0x10,0x00,0x05, &enAINormalMetroid);
immutable enHeadBabyMetroid = EnemyData(0x80,0x00,0x00,0x00,0xFF,0x00,0x00,0x00,0xFF, &enAIBabyMetroid);
immutable enHeadItem = EnemyData(0x80,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIItemOrb);
immutable enHeadItemFlipped = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF, &enAIItemOrb);
immutable enHeadBlobThrower = EnemyData(0x00,0x00,0x00,0x00,0x70,0x00,0x00,0x00,0x15, &enAIBlobThrower);
immutable enHeadGlowFly = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03, &enAIGlowFly);
immutable enHeadRockIcicle = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x01, &enAIRockIcicle);
immutable enHeadArachnus = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFD, &enAIArachnus);
immutable enHeadArachnusOrb = EnemyData(0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFD, &enAIArachnus);

immutable ubyte[] enemyDamageTable = [
	0x08, // Tsumari
	0x08, // Tsumari
	0x08, // Tsumari
	0x08, // Tsumari
	0x10, // Skreek
	0x10, // Skreek
	0x10, // Skreek
	0x10, // Skreek
	0x03, // Skreek projectile
	0x10, // Drivel
	0x10, // Drivel
	0x10, // Drivel
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x03, // Drivel projectile
	0x05, // Small bugs
	0x05, // Small bugs
	0x10, // Hornoad
	0x10, // Hornoad
	0x15, // Senjoo
	0x08, // Gawron
	0x08, // Gawron
	0x00, // Gawron spawner?
	0x00, // Gawron spawner?
	0x12, // Chute leech
	0x12, // Chute leech
	0x12, // Chute leech
	0x15, // (uses same spritemap as 41h autrack)
	0x15, // (uses same spritemap as 4Ah wallfire)
	0x10, // Needler
	0x10, // Needler
	0x10, // Needler
	0x10, // Needler
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x11, // Skorp
	0x11, // Skorp
	0x11, // Skorp
	0x11, // Skorp
	0x10, // Glow fly
	0x10, // Glow fly
	0x10, // Glow fly
	0x10, // Glow fly
	0x13, // Moheek
	0x13, // Moheek
	0x13, // Moheek
	0x13, // Moheek
	0x00, // Rock icicle
	0x08, // Rock icicle
	0x08, // Rock icicle
	0x08, // Rock icicle
	0x12, // Yumee
	0x12, // Yumee
	0x12, // Yumee
	0x12, // Yumee
	0x00, // Yumee spawner?
	0x00, // Yumee spawner?
	0x20, // Octroll
	0x20, // Octroll
	0x20, // Octroll
	0x15, // Autrack
	0x15, // Autrack
	0x15, // Autrack
	0x15, // Autrack
	0x10, // Autrack projectile
	0x15, // Autoad
	0x15, // Autoad
	0x00, // Sideways Autoad (unused)
	0x00, // Sideways Autoad (unused)
	0x15, // Wallfire
	0x15, // Wallfire
	0xFF, // Wallfire
	0x10, // Wallfire projectile
	0x10, // Wallfire projectile
	0x10, // Wallfire projectile
	0x10, // Wallfire projectile
	0x15, // Gunzoo
	0x15, // Gunzoo
	0x15, // Gunzoo
	0x08, // Gunzoo diagonal projectile
	0x08, // Gunzoo diagonal projectile
	0x08, // Gunzoo diagonal projectile
	0x08, // Gunzoo horizontal projectile
	0x08, // Gunzoo horizontal projectile (unused frame)
	0x08, // Gunzoo horizontal projectile
	0x08, // Gunzoo horizontal projectile
	0x08, // Gunzoo horizontal projectile
	0x15, // Autom
	0x15, // Autom
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x10, // Autom projectile
	0x15, // Shirk
	0x15, // Shirk
	0xFF, // Septogg
	0xFF, // Septogg
	0x20, // Moto
	0x20, // Moto
	0x20, // Moto
	0x10, // Halzyn
	0x20, // Ramulken
	0x20, // Ramulken
	0x00, // Musical stinger event trigger
	0xFF, // (uses same spritemap as 72h proboscum)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0xFF, // Proboscum
	0x00, // Proboscum
	0x00, // Proboscum
	0xFF, // Missile block
	0x20, // Arachnus
	0x20, // Arachnus
	0x20, // Arachnus
	0x20, // Arachnus
	0x20, // Arachnus
	0x02, // Arachnus projectile
	0x02, // Arachnus projectile
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0xFF, // Plasma beam orb
	0x00, // Plasma beam
	0xFF, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	0x00, // Ice beam
	0xFF, // Wave beam orb
	0x00, // Wave beam
	0xFF, // Spazer beam orb
	0x00, // Spazer beam
	0xFF, // Bombs orb
	0x00, // Bombs
	0xFF, // Screw attack orb
	0x00, // Screw attack
	0xFF, // Varia suit orb
	0x00, // Varia suit
	0xFF, // Hi-jump boots orb
	0x00, // Hi-jump boots
	0xFF, // Space jump orb
	0x00, // Space jump
	0xFF, // (spider ball orb?)
	0x00, // Spider ball
	0xFF, // (spring ball orb?)
	0x00, // Spring ball
	0xFF, // (energy tank orb?)
	0x00, // Energy tank
	0xFF, // (missile tank orb?)
	0x00, // Missile tank
	0x30, // Blob thrower (sprite is written to WRAM)
	0x00, // Energy refill
	0xFF, // Arachnus orb
	0x00, // Missile refill
	0x10, // Blob thrower projectile
	0x10, // Blob thrower projectile
	0xFE, // Metroid
	0x00, // Metroid hatching
	0x00, // (no graphics)
	0x10, // Alpha metroid
	0x10, // Alpha metroid
	0xFF, // Baby metroid egg
	0xFF, // Baby metroid egg
	0xFF, // Baby metroid egg
	0x00, // Baby metroid
	0x00, // Baby metroid
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x15, // Gamma metroid
	0x15, // Gamma metroid projectile
	0x15, // Gamma metroid projectile
	0x15, // Gamma metroid
	0x00, // (no graphics)
	0x00, // Gamma metroid shell
	0x20, // Zeta metroid hatching
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x20, // Zeta metroid
	0x00, // Zeta metroid
	0x00, // Zeta metroid
	0x00, // Zeta metroid
	0x00, // Zeta metroid
	0x10, // Zeta metroid projectile
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x25, // Omega metroid
	0x00, // Omega metroid
	0x00, // Omega metroid
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // Omega metroid projectile
	0x12, // (omega metroid projectile?)
	0xFE, // Metroid
	0xFE, // Metroid (hurt)
	0xFF, // Flitt
	0xFF, // Flitt
	0x00, // Stalagtite (unused)
	0x10, // Gravitt
	0x10, // Gravitt
	0x10, // Gravitt
	0x10, // Gravitt
	0x10, // Gravitt
	0x12, // Gullugg
	0x12, // Gullugg
	0x12, // Gullugg
	0x00, // Baby metroid egg preview
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // Small health drop
	0x00, // Small health drop
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Metroid death / missile door / screw attack explosion
	0x00, // Enemy death explosion
	0x00, // Enemy death explosion
	0x00, // Enemy death explosion
	0x00, // Enemy death explosion (extra frame for enemies not dropping small health)
	0x00, // Big energy drop
	0x00, // Big energy drop
	0x00, // Missile drop
	0x00, // Missile drop
	0x40, // Metroid Queen neck (no graphics)
	0x40, // Metroid Queen head left half (no graphics)
	0x20, // Metroid Queen projectile/head right half (no graphics)
	0x40, // Metroid Queen body (no graphics)
	0x00, // (no graphics)
	0x40, // Metroid Queen mouth closed (no graphics)
	0x40, // Metroid Queen mouth open (no graphics)
	0xFF, // Metroid Queen mouth stunned (no graphics)
	0xFF, // Missile door
	0xFF, // (no graphics)
	0xFF, // (no graphics)
	0x00, // (no graphics)
	0x00, // (no graphics)
	0x00, // Nothing - flitt (no graphics)
	0x00, // ?
];
const Rectangle*[] enemyHitboxes = [
	&hitboxBlock, // Tsumari
	&hitboxBlock, // Tsumari
	&hitboxBlock, // Tsumari
	&hitboxBlock, // Tsumari
	&hitbox6A6F, // Skreek
	&hitbox6A6F, // Skreek
	&hitbox6A6F, // Skreek
	&hitbox6A6F, // Skreek
	&hitboxTile, // Skreek projectile
	&hitbox6A4B, // Drivel
	&hitbox6A7F, // Drivel
	&hitbox6A77, // Drivel
	&hitboxTile, // Drivel projectile
	&hitboxTile, // Drivel projectile
	&hitboxTile, // Drivel projectile
	&hitbox6A43, // Drivel projectile
	&hitbox6A7B, // Drivel projectile
	&hitbox6AA7, // Drivel projectile
	&hitbox6A43, // Small bugs
	&hitbox6A43, // Small bugs
	&hitbox6A6F, // Hornoad
	&hitbox6A6F, // Hornoad
	&hitbox6A6F, // Senjoo
	&hitboxBlock, // Gawron
	&hitboxBlock, // Gawron
	&hitboxPoint, // Gawron spawner?
	&hitboxPoint, // Gawron spawner?
	&hitbox6A47, // Chute leech
	&hitboxBlock, // Chute leech
	&hitbox6A6F, // Chute leech
	&hitboxBlock, // (uses same spritemap as 41h autrack)
	&hitbox6A8F, // (uses same spritemap as 4Ah wallfire)
	&hitboxBlock, // Needler
	&hitboxBlock, // Needler
	&hitboxBlock, // Needler
	&hitboxBlock, // Needler
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitbox6A93, // Skorp
	&hitbox6A93, // Skorp
	&hitbox6A6F, // Skorp
	&hitbox6A6F, // Skorp
	&hitbox6A8F, // Glow fly
	&hitbox6A8F, // Glow fly
	&hitboxBlock, // Glow fly
	&hitboxBlock, // Glow fly
	&hitboxBlock, // Moheek
	&hitboxBlock, // Moheek
	&hitboxBlock, // Moheek
	&hitboxBlock, // Moheek
	&hitboxTile, // Rock icicle
	&hitboxTile, // Rock icicle
	&hitbox6A67, // Rock icicle
	&hitbox6A67, // Rock icicle
	&hitboxBlock, // Yumee
	&hitboxBlock, // Yumee
	&hitbox6A5B, // Yumee
	&hitbox6A5B, // Yumee
	&hitboxPoint, // Yumee spawner?
	&hitboxPoint, // Yumee spawner?
	&hitboxOctroll, // Octroll
	&hitboxOctroll, // Octroll
	&hitboxOctroll, // Octroll
	&hitboxBlock, // Autrack
	&hitboxAutrackMid, // Autrack
	&hitboxAutrackTall, // Autrack
	&hitboxAutrackTall, // Autrack
	&hitbox6A43, // Autrack projectile
	&hitbox6A6F, // Autoad
	&hitbox6A6F, // Autoad
	&hitbox6A93, // Sideways Autoad (unused)
	&hitbox6A93, // Sideways Autoad (unused)
	&hitbox6A8F, // Wallfire
	&hitbox6A8F, // Wallfire
	&hitbox6A8F, // Wallfire
	&hitboxTile, // Wallfire projectile
	&hitboxTile, // Wallfire projectile
	&hitbox6A67, // Wallfire projectile
	&hitbox6AB7, // Wallfire projectile
	&hitbox6A97, // Gunzoo
	&hitbox6A97, // Gunzoo
	&hitbox6A97, // Gunzoo
	&hitboxTile, // Gunzoo diagonal projectile
	&hitbox6A67, // Gunzoo diagonal projectile
	&hitbox6AB7, // Gunzoo diagonal projectile
	&hitboxTile, // Gunzoo horizontal projectile
	&hitboxTile, // Gunzoo horizontal projectile (unused frame)
	&hitbox6A67, // Gunzoo horizontal projectile
	&hitbox6ACF, // Gunzoo horizontal projectile
	&hitbox6ADB, // Gunzoo horizontal projectile
	&hitbox6A97, // Autom
	&hitbox6A97, // Autom
	&hitboxTile, // Autom projectile
	&hitbox6A8F, // Autom projectile
	&hitbox6ACF, // Autom projectile
	&hitbox6ACF, // Autom projectile
	&hitbox6ACF, // Autom projectile
	&hitbox6A97, // Shirk
	&hitbox6A97, // Shirk
	&hitbox6A93, // Septogg
	&hitbox6A93, // Septogg
	&hitbox6A93, // Moto
	&hitbox6A93, // Moto
	&hitbox6A93, // Moto
	&hitbox6A67, // Halzyn
	&hitbox6A6F, // Ramulken
	&hitbox6A6F, // Ramulken
	&hitboxBlock, // Musical stinger event trigger
	&hitbox6A43, // (uses same spritemap as 72h proboscum)
	&hitbox6A43, // (no graphics)
	&hitbox6A43, // (no graphics)
	&hitbox6A43, // (no graphics)
	&hitbox6A47, // Proboscum
	&hitboxPoint, // Proboscum
	&hitboxPoint, // Proboscum
	&hitboxBlock, // Missile block
	&hitboxBlock, // Arachnus
	&hitboxBlock, // Arachnus
	&hitbox6ABB, // Arachnus
	&hitbox6ABB, // Arachnus
	&hitbox6ABB, // Arachnus
	&hitbox6A77, // Arachnus projectile
	&hitbox6A77, // Arachnus projectile
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxBlock, // Plasma beam orb
	&hitboxTile, // Plasma beam
	&hitboxBlock, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	&hitboxTile, // Ice beam
	&hitboxBlock, // Wave beam orb
	&hitboxTile, // Wave beam
	&hitboxBlock, // Spazer beam orb
	&hitboxTile, // Spazer beam
	&hitboxBlock, // Bombs orb
	&hitboxTile, // Bombs
	&hitboxBlock, // Screw attack orb
	&hitboxTile, // Screw attack
	&hitboxBlock, // Varia suit orb
	&hitboxTile, // Varia suit
	&hitboxBlock, // Hi-jump boots orb
	&hitboxTile, // Hi-jump boots
	&hitboxBlock, // Space jump orb
	&hitboxTile, // Space jump
	&hitboxBlock, // (spider ball orb?)
	&hitboxTile, // Spider ball
	&hitboxBlock, // (spring ball orb?)
	&hitboxTile, // Spring ball
	&hitboxBlock, // (energy tank orb?)
	&hitboxTile, // Energy tank
	&hitboxBlock, // (missile tank orb?)
	&hitboxTile, // Missile tank
	&hitboxC360, // Blob thrower (sprite is written to WRAM)
	&hitboxRefill, // Energy refill
	&hitboxBlock, // Arachnus orb
	&hitboxRefill, // Missile refill
	&hitboxTile, // Blob thrower projectile
	&hitboxTile, // Blob thrower projectile
	&hitboxMetroid, // Metroid
	&hitboxAlphaMetroid, // Metroid hatching
	&hitboxAlphaMetroid, // (no graphics)
	&hitboxAlphaMetroid, // Alpha metroid
	&hitboxAlphaMetroid, // Alpha metroid
	&hitbox6A97, // Baby metroid egg
	&hitbox6A97, // Baby metroid egg
	&hitbox6A97, // Baby metroid egg
	&hitboxBlock, // Baby metroid
	&hitboxBlock, // Baby metroid
	&hitboxTile, // (no graphics)
	&hitbox6A5F, // (no graphics)
	&hitbox6A63, // (no graphics)
	&hitbox6A9F, // Gamma metroid
	&hitbox6A9F, // Gamma metroid projectile
	&hitbox6A9F, // Gamma metroid projectile
	&hitbox6AC3, // Gamma metroid
	&hitboxTile, // (no graphics)
	&hitboxPoint, // Gamma metroid shell
	&hitbox6ABB, // Zeta metroid hatching
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitbox6ABB, // Zeta metroid
	&hitboxTile, // Zeta metroid projectile
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxOmegaMetroid, // Omega metroid
	&hitboxPoint, // Omega metroid
	&hitboxPoint, // Omega metroid
	&hitboxTile, // Omega metroid projectile
	&hitboxTile, // Omega metroid projectile
	&hitbox6A43, // Omega metroid projectile
	&hitbox6A4F, // Omega metroid projectile
	&hitbox6A53, // Omega metroid projectile
	&hitbox6A57, // Omega metroid projectile
	&hitboxTile, // Omega metroid projectile
	&hitboxTile, // (omega metroid projectile?)
	&hitboxMetroid, // Metroid
	&hitboxMetroid, // Metroid (hurt)
	&hitboxBlock, // Flitt
	&hitboxBlock, // Flitt
	&hitboxPoint, // Stalagtite (unused)
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitboxBlock, // Gravitt
	&hitbox6A93, // Gullugg
	&hitbox6A93, // Gullugg
	&hitbox6A93, // Gullugg
	&hitboxPoint, // Baby metroid egg preview
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxPoint, // (no graphics)
	&hitboxTile, // Small health drop
	&hitboxTile, // Small health drop
	&hitboxBlock, // Metroid death / missile door / screw attack explosion
	&hitboxBlock, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitbox6A97, // Metroid death / missile door / screw attack explosion
	&hitboxBlock, // Enemy death explosion
	&hitboxTile, // Enemy death explosion
	&hitbox6A97, // Enemy death explosion
	&hitbox6ABF, // Enemy death explosion (extra frame for enemies not dropping small health)
	&hitboxBlock, // Big energy drop
	&hitboxBlock, // Big energy drop
	&hitboxTile, // Missile drop
	&hitboxTile, // Missile drop
	&hitbox6A8B, // Metroid Queen neck (no graphics)
	&hitbox6AD7, // Metroid Queen head left half (no graphics)
	&hitbox6AAB, // Metroid Queen projectile/head right half (no graphics)
	&hitbox6AE3, // Metroid Queen body (no graphics)
	&hitboxPoint, // (no graphics)
	&hitbox6AD7, // Metroid Queen mouth closed (no graphics)
	&hitbox6ACB, // Metroid Queen mouth open (no graphics)
	&hitbox6ACB, // Metroid Queen mouth stunned (no graphics)
	&hitboxMissileDoor, // Missile door
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // (no graphics)
	&hitboxMissileDoor, // Nothing - flitt (no graphics)
	&hitboxTile, // ?
];

immutable hitboxPoint = Rectangle(0, 0, 0, 0);
immutable hitboxRefill = Rectangle(1, 1, 1, 1);
immutable hitboxTile = Rectangle(-4, 3, -4, 3);
immutable hitbox6A43 = Rectangle(-4, 3, -8, 7);
immutable hitbox6A47 = Rectangle(-4, 3, -12, 11);
immutable hitbox6A4B = Rectangle(-4, 3, -16, 15);
immutable hitbox6A4F = Rectangle(-4, 3, -20, 19);
immutable hitbox6A53 = Rectangle(-4, 3, -24, 23);
immutable hitbox6A57 = Rectangle(-4, 3, -28, 27);
immutable hitbox6A5B = Rectangle(-8, 0, -8, 16);
immutable hitbox6A5F = Rectangle(-4, 3, -12, 3);
immutable hitbox6A63 = Rectangle(-4, 3, -20, 3);
immutable hitbox6A67 = Rectangle(-8, 7, -4, 3);
immutable hitboxBlock = Rectangle(-8, 7, -8, 7);
immutable hitbox6A6F = Rectangle(-8, 7, -12, 11);
immutable hitboxOctroll = Rectangle(-8, 7, -16, 15);
immutable hitbox6A77 = Rectangle(-4, 11, -8, 7);
immutable hitbox6A7B = Rectangle(-12, 3, -12, 11);
immutable hitbox6A7F = Rectangle(-4, 11, -12, 11);
immutable hitbox6A83 = Rectangle(-4, 11, -12, 3);
immutable hitboxMetroid = Rectangle(-11, 9, -12, 11);
immutable hitbox6A8B = Rectangle(0, 15, 0, 7);
immutable hitbox6A8F = Rectangle(-12, 11, -4, 3);
immutable hitbox6A93 = Rectangle(-12, 11, -8, 7);
immutable hitbox6A97 = Rectangle(-12, 11, -12, 11);
immutable hitboxAlphaMetroid = Rectangle(-12, 11, -16, 15);
immutable hitbox6A9F = Rectangle(-12, 11, -20, 19);
immutable hitboxAutrackMid = Rectangle(-16, 7, -8, 7);
immutable hitbox6AA7 = Rectangle(-20, 3, -4, 19);
immutable hitbox6AAB = Rectangle(0, 19, 0, 8);
immutable hitbox6AAF = Rectangle(-4, 19, -12, 3);
immutable hitboxOmegaMetroid = Rectangle(-12, 19, -8, 7);
immutable hitbox6AB7 = Rectangle(-16, 15, -4, 3);
immutable hitbox6ABB = Rectangle(-16, 15, -12, 11);
immutable hitbox6ABF = Rectangle(-16, 15, -16, 15);
immutable hitbox6AC3 = Rectangle(-16, 15, -20, 19);
immutable hitboxAutrackTall = Rectangle(-24, 7, -8, 7);
immutable hitbox6ACB = Rectangle(0, 33, 0, 18);
immutable hitbox6ACF = Rectangle(-20, 19, -4, 3);
immutable hitbox6AD3 = Rectangle(-20, 19, -20, 19);
immutable hitbox6AD7 = Rectangle(0, 39, 0, 31);
immutable hitbox6ADB = Rectangle(-24, 23, -4, 3);
immutable hitboxMissileDoor = Rectangle(-24, 23, -24, 23);
immutable hitbox6AE3 = Rectangle(0, 55, 0, 47);
