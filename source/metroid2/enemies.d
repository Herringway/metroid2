module metroid2.enemies;

import metroid2.bank02;
import metroid2.defs;
import metroid2.globals;

import libgb;

immutable EnemySpawn[][][] enemyDataPointers = [
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


immutable EnemySpawn[] enemyBank9_00 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_01 = [
	EnemySpawn(0x65, Actor.missileTank, 0x88, 0x18),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_02 = [
	EnemySpawn(0x67, Actor.energyTank, 0x48, 0x18),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_03 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_04 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_05 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_06 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_07 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_08 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_09 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_0A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_0B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_0D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_0E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_10 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_11 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_12 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_13 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_14 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_15 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_16 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_17 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_18 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_19 = [
	EnemySpawn(0x1F, Actor.blobThrower, 0x00, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_1A = [
	EnemySpawn(0x1D, Actor.chuteLeech, 0x60, 0x9C),
	EnemySpawn(0x1E, Actor.chuteLeech, 0xA0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_1B = [
	EnemySpawn(0x1C, Actor.blobThrower, 0xA0, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_1C = [
	EnemySpawn(0x16, Actor.senjoo, 0x70, 0x60),
	EnemySpawn(0x17, Actor.senjoo, 0x98, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_1D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_1E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_20 = [
	EnemySpawn(0x1D, Actor.moto, 0xC0, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_21 = [
	EnemySpawn(0x1E, Actor.ramulken, 0xF8, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_22 = [
	EnemySpawn(0x60, Actor.energyTank, 0x78, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_23 = [
	EnemySpawn(0x1F, Actor.moto, 0x30, 0x96),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_24 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_25 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_26 = [
	EnemySpawn(0x66, Actor.missileTank, 0xC8, 0x18),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_27 = [
	EnemySpawn(0x23, Actor.smallBug, 0xA0, 0xC0),
	EnemySpawn(0x24, Actor.smallBug, 0xC0, 0x70),
	EnemySpawn(0x25, Actor.smallBug, 0xE0, 0x20),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_28 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_29 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_2A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_2B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_2C = [
	EnemySpawn(0x18, Actor.senjoo, 0x98, 0x40),
	EnemySpawn(0x19, Actor.senjoo, 0x98, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_2E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_30 = [
	EnemySpawn(0x25, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_31 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_32 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_33 = [
	EnemySpawn(0x20, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_35 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_36 = [
	EnemySpawn(0x26, Actor.senjoo, 0x50, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_37 = [
	EnemySpawn(0x21, Actor.smallBug, 0x60, 0x60),
	EnemySpawn(0x22, Actor.smallBug, 0x80, 0x10),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_38 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_39 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_3A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_3B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_3C = [
	EnemySpawn(0x1A, Actor.senjoo, 0x98, 0x40),
	EnemySpawn(0x1B, Actor.senjoo, 0x98, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_40 = [
	EnemySpawn(0x26, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_41 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_42 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_43 = [
	EnemySpawn(0x21, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_44 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_45 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_46 = [
	EnemySpawn(0x28, Actor.senjoo, 0x50, 0x80),
	EnemySpawn(0x27, Actor.senjoo, 0x60, 0x00),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_47 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_4B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_4C = [
	EnemySpawn(0x14, Actor.chuteLeech, 0xA8, 0x9C),
	EnemySpawn(0x15, Actor.senjoo, 0xF8, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_4D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_4E = [
	EnemySpawn(0x12, Actor.chuteLeech, 0x30, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_50 = [
	EnemySpawn(0x27, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_51 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_52 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_53 = [
	EnemySpawn(0x22, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_54 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_55 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_56 = [
	EnemySpawn(0x29, Actor.senjoo, 0x60, 0x00),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_57 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_58 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_59 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_5A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_5B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_5C = [
	EnemySpawn(0x0F, Actor.energyRefill, 0x90, 0x74),
	EnemySpawn(0x26, Actor.smallBug, 0xB8, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_5D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_5E = [
	EnemySpawn(0x11, Actor.senjoo, 0xB0, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_5F = [
	EnemySpawn(0x10, Actor.senjoo, 0x50, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_60 = [
	EnemySpawn(0x28, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_61 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_62 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_63 = [
	EnemySpawn(0x23, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_64 = [
	EnemySpawn(0x2E, Actor.chuteLeech, 0xD8, 0xCC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_65 = [
	EnemySpawn(0x2C, Actor.chuteLeech, 0x30, 0xCC),
	EnemySpawn(0x2D, Actor.chuteLeech, 0xB0, 0xCC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_66 = [
	EnemySpawn(0x2A, Actor.needlerLeft, 0x10, 0xA8),
	EnemySpawn(0x2B, Actor.needlerRight, 0x30, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_67 = [
	EnemySpawn(0x24, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_69 = [
	EnemySpawn(0x25, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_6A = [
	EnemySpawn(0x28, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_6B = [
	EnemySpawn(0x18, Actor.smallBug, 0x40, 0x40),
	EnemySpawn(0x19, Actor.smallBug, 0x80, 0x58),
	EnemySpawn(0x1A, Actor.smallBug, 0xC0, 0x94),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_6C = [
	EnemySpawn(0x1B, Actor.smallBug, 0x40, 0x94),
	EnemySpawn(0x1C, Actor.smallBug, 0x80, 0x58),
	EnemySpawn(0x1D, Actor.smallBug, 0xC0, 0x44),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_6D = [
	EnemySpawn(0x27, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_6E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_70 = [
	EnemySpawn(0x29, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_71 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_73 = [
	EnemySpawn(0x0F, Actor.missileRefill, 0x18, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_74 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_75 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_76 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_77 = [
	EnemySpawn(0x33, Actor.gravitt, 0xF0, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_78 = [
	EnemySpawn(0x34, Actor.gravitt, 0xC0, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_79 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_7A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_7B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_7D = [
	EnemySpawn(0x1E, Actor.proboscumFlipped, 0xB8, 0x40),
	EnemySpawn(0x1F, Actor.proboscumFlipped, 0xC0, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_80 = [
	EnemySpawn(0x2A, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_81 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_82 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_83 = [
	EnemySpawn(0x16, Actor.halzyn, 0xB8, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_84 = [
	EnemySpawn(0x1C, Actor.smallBug, 0x80, 0x80),
	EnemySpawn(0x61, Actor.missileTank, 0xE8, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_85 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_87 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_88 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_89 = [
	EnemySpawn(0x29, Actor.smallBug, 0xB8, 0x40),
	EnemySpawn(0x2A, Actor.smallBug, 0xB8, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_8A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_8B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_8D = [
	EnemySpawn(0x62, Actor.missileTank, 0x48, 0xA8),
	EnemySpawn(0x20, Actor.proboscumFlipped, 0xB8, 0x3C),
	EnemySpawn(0x21, Actor.proboscumFlipped, 0xB8, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_90 = [
	EnemySpawn(0x2B, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_91 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_93 = [
	EnemySpawn(0x15, Actor.halzyn, 0xB8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_94 = [
	EnemySpawn(0x1B, Actor.smallBug, 0xA8, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_96 = [
	EnemySpawn(0x31, Actor.gravitt, 0xF0, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_97 = [
	EnemySpawn(0x32, Actor.gravitt, 0x40, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_98 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_99 = [
	EnemySpawn(0x35, Actor.gravitt, 0xC0, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_9A = [
	EnemySpawn(0x36, Actor.gravitt, 0x88, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_9B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_9C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_9D = [
	EnemySpawn(0x22, Actor.proboscumFlipped, 0xB8, 0x48),
	EnemySpawn(0x23, Actor.proboscumFlipped, 0xC0, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_9E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_9F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A0 = [
	EnemySpawn(0x2C, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A3 = [
	EnemySpawn(0x14, Actor.halzyn, 0xB8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A4 = [
	EnemySpawn(0x1A, Actor.smallBug, 0xB0, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A6 = [
	EnemySpawn(0x0F, Actor.missileRefill, 0x28, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_A9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_AA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_AB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B0 = [
	EnemySpawn(0x2D, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B3 = [
	EnemySpawn(0x13, Actor.halzyn, 0xB8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B4 = [
	EnemySpawn(0x19, Actor.smallBug, 0xA8, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B8 = [
	EnemySpawn(0x27, Actor.gullugg, 0x48, 0x80),
	EnemySpawn(0x0E, Actor.missileRefill, 0x48, 0x97),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_B9 = [
	EnemySpawn(0x28, Actor.gullugg, 0x48, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_BA = [
	EnemySpawn(0x29, Actor.gullugg, 0x48, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_BB = [
	EnemySpawn(0x2A, Actor.gullugg, 0x48, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_BC = [
	EnemySpawn(0x2B, Actor.gullugg, 0x48, 0x80),
	EnemySpawn(0x0F, Actor.energyRefill, 0x48, 0x94),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_BD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_BE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C0 = [
	EnemySpawn(0x2E, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C3 = [
	EnemySpawn(0x12, Actor.halzyn, 0xB8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C4 = [
	EnemySpawn(0x18, Actor.smallBug, 0xA8, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C8 = [
	EnemySpawn(0x19, Actor.chuteLeech, 0xE0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_C9 = [
	EnemySpawn(0x1A, Actor.chuteLeech, 0x40, 0x9C),
	EnemySpawn(0x1B, Actor.chuteLeech, 0xC0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_CA = [
	EnemySpawn(0x1C, Actor.chuteLeech, 0x40, 0x9C),
	EnemySpawn(0x1D, Actor.chuteLeech, 0xC0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_CB = [
	EnemySpawn(0x1E, Actor.chuteLeech, 0x40, 0x9C),
	EnemySpawn(0x1F, Actor.chuteLeech, 0xC0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_CC = [
	EnemySpawn(0x20, Actor.chuteLeech, 0x80, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_CD = [
	EnemySpawn(0x21, Actor.chuteLeech, 0x20, 0x9C),
	EnemySpawn(0x22, Actor.gullugg, 0x60, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_CE = [
	EnemySpawn(0x23, Actor.gullugg, 0x00, 0x80),
	EnemySpawn(0x24, Actor.gullugg, 0x60, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D0 = [
	EnemySpawn(0x2F, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D3 = [
	EnemySpawn(0x1F, Actor.halzyn, 0xB8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D4 = [
	EnemySpawn(0x17, Actor.smallBug, 0x88, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D6 = [
	EnemySpawn(0x13, Actor.gullugg, 0x98, 0x80),
	EnemySpawn(0x14, Actor.chuteLeech, 0xF0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D7 = [
	EnemySpawn(0x15, Actor.chuteLeech, 0x40, 0x9C),
	EnemySpawn(0x16, Actor.chuteLeech, 0xC0, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D8 = [
	EnemySpawn(0x17, Actor.chuteLeech, 0x00, 0x9C),
	EnemySpawn(0x18, Actor.chuteLeech, 0x50, 0x9C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_D9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_DA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_DB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_DF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E0 = [
	EnemySpawn(0x30, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E3 = [
	EnemySpawn(0x10, Actor.halzyn, 0xF0, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E5 = [
	EnemySpawn(0x10, Actor.chuteLeech, 0xB8, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E6 = [
	EnemySpawn(0x11, Actor.chuteLeech, 0x00, 0xBC),
	EnemySpawn(0x12, Actor.gullugg, 0x40, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_EC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_ED = [
	EnemySpawn(0x26, Actor.chuteLeech, 0xB8, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_EE = [
	EnemySpawn(0x25, Actor.chuteLeech, 0x58, 0xAC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F3 = [
	EnemySpawn(0x63, Actor.missileTank, 0x20, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_F9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_FA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_FB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_FC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_FD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_FE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBank9_FF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_00 = [
	EnemySpawn(0x14, Actor.smallBug, 0xD8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_01 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_02 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_03 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_04 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_05 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_06 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_07 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_08 = [
	EnemySpawn(0x1B, Actor.rockIcicleIdle1, 0x80, 0x30),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_09 = [
	EnemySpawn(0x1C, Actor.moheekLeft, 0x90, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_0A = [
	EnemySpawn(0x1D, Actor.moheekRight, 0x90, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_0B = [
	EnemySpawn(0x1F, Actor.rockIcicleIdle1, 0x78, 0x30),
	EnemySpawn(0x1E, Actor.moheekLeft, 0x80, 0x80),
	EnemySpawn(0x20, Actor.rockIcicleIdle1, 0xA8, 0x30),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_0D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_0E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_10 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_11 = [
	EnemySpawn(0x16, Actor.moheekLeft, 0x80, 0x68),
	EnemySpawn(0x17, Actor.moheekRight, 0x90, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_12 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_13 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_14 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_15 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_16 = [
	EnemySpawn(0x0F, Actor.energyRefill, 0x18, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_17 = [
	EnemySpawn(0x40, Actor.alphaMetroid, 0x98, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_18 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_19 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_1A = [
	EnemySpawn(0x21, Actor.moheekLeft, 0x80, 0x80),
	EnemySpawn(0x22, Actor.smallBug, 0xC0, 0x64),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_1B = [
	EnemySpawn(0x23, Actor.moheekRight, 0x60, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_1C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_1D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_1E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_20 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_21 = [
	EnemySpawn(0x18, Actor.rockIcicleIdle1, 0x48, 0x10),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_22 = [
	EnemySpawn(0x10, Actor.rockIcicleIdle1, 0x90, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_23 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_24 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_25 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_26 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_27 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_28 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_29 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_2A = [
	EnemySpawn(0x24, Actor.moheekLeft, 0x88, 0x28),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_2B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_2C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_2E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_30 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_31 = [
	EnemySpawn(0x35, Actor.skreek, 0x00, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_32 = [
	EnemySpawn(0x13, Actor.moheekRight, 0x40, 0x40),
	EnemySpawn(0x14, Actor.moheekLeft, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_33 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_35 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_36 = [
	EnemySpawn(0x41, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_37 = [
	EnemySpawn(0x0F, Actor.missileRefill, 0xE8, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_38 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_39 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_3A = [
	EnemySpawn(0x25, Actor.moheekRight, 0x88, 0xC7),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_3B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_3C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_40 = [
	EnemySpawn(0x10, Actor.halzyn, 0xB0, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_41 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_42 = [
	EnemySpawn(0x16, Actor.rockIcicleIdle1, 0x80, 0x70),
	EnemySpawn(0x17, Actor.smallBug, 0xA0, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_43 = [
	EnemySpawn(0x15, Actor.moheekLeft, 0x80, 0x58),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_44 = [
	EnemySpawn(0x0B, Actor.smallBug, 0xF0, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_45 = [
	EnemySpawn(0x0C, Actor.hornoad, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_46 = [
	EnemySpawn(0x0D, Actor.smallBug, 0x80, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_47 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_4B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_4C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_4D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_4E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_50 = [
	EnemySpawn(0x12, Actor.smallBug, 0x78, 0x64),
	EnemySpawn(0x13, Actor.smallBug, 0x98, 0x94),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_51 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_52 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_53 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_54 = [
	EnemySpawn(0x10, Actor.rockIcicleIdle1, 0x68, 0x20),
	EnemySpawn(0x11, Actor.rockIcicleIdle1, 0x88, 0x20),
	EnemySpawn(0x12, Actor.rockIcicleIdle1, 0xF8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_55 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_56 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_57 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_58 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_59 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_5A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_5B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_5C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_5D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_5E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_5F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_60 = [
	EnemySpawn(0x15, Actor.smallBug, 0x98, 0x74),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_61 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_62 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_63 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_64 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_65 = [
	EnemySpawn(0x13, Actor.rockIcicleIdle1, 0x30, 0xA0),
	EnemySpawn(0x14, Actor.rockIcicleIdle1, 0x58, 0x90),
	EnemySpawn(0x15, Actor.smallBug, 0xB8, 0x54),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_66 = [
	EnemySpawn(0x18, Actor.glowflyIdle1, 0x64, 0xFF),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_67 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_69 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_6A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_6B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_6C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_6D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_6E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_70 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_71 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_73 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_74 = [
	EnemySpawn(0x16, Actor.smallBug, 0x80, 0x5C),
	EnemySpawn(0x17, Actor.rockIcicleIdle1, 0x90, 0x80),
	EnemySpawn(0x18, Actor.rockIcicleIdle1, 0xC8, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_75 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_76 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_77 = [
	EnemySpawn(0x60, Actor.missileBlock, 0x88, 0x98),
	EnemySpawn(0x61, Actor.missileBlock, 0x88, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_78 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_79 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_7A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_7B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_7D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_80 = [
	EnemySpawn(0x12, Actor.moheekRight, 0xF0, 0xC8),
	EnemySpawn(0x13, Actor.rockIcicleIdle1, 0xF8, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_81 = [
	EnemySpawn(0x10, Actor.rockIcicleIdle1, 0x78, 0x30),
	EnemySpawn(0x11, Actor.rockIcicleIdle1, 0x88, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_82 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_83 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_84 = [
	EnemySpawn(0x19, Actor.rockIcicleIdle1, 0x88, 0x20),
	EnemySpawn(0x1A, Actor.rockIcicleIdle1, 0x90, 0x80),
	EnemySpawn(0x1B, Actor.rockIcicleIdle1, 0xA8, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_85 = [
	EnemySpawn(0x1C, Actor.smallBug, 0x30, 0xDC),
	EnemySpawn(0x1D, Actor.rockIcicleIdle1, 0x48, 0x80),
	EnemySpawn(0x1E, Actor.rockIcicleIdle1, 0x90, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_87 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_88 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_89 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_8A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_8B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_8D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_90 = [
	EnemySpawn(0x14, Actor.skorpRight, 0x18, 0x60),
	EnemySpawn(0x15, Actor.rockIcicleIdle1, 0x88, 0x20),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_91 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_93 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_94 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_96 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_97 = [
	EnemySpawn(0x1C, Actor.smallBug, 0x88, 0xC8),
	EnemySpawn(0x1D, Actor.smallBug, 0xA8, 0xA8),
	EnemySpawn(0x1E, Actor.smallBug, 0xB0, 0x40),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_98 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_99 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_9A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_9B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_9C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_9D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_9E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_9F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A0 = [
	EnemySpawn(0x1A, Actor.rockIcicleIdle1, 0xC0, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A1 = [
	EnemySpawn(0x19, Actor.skorpLeft, 0xF8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A7 = [
	EnemySpawn(0x1F, Actor.smallBug, 0x40, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_A9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_AA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_AB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B0 = [
	EnemySpawn(0x1B, Actor.glowflyIdle1, 0x30, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_B9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_BA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_BB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_BC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_BD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_BE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C0 = [
	EnemySpawn(0x1F, Actor.skorpDown, 0xA8, 0xF8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C1 = [
	EnemySpawn(0x1C, Actor.moheekLeft, 0x50, 0x48),
	EnemySpawn(0x1D, Actor.moheekLeft, 0x70, 0x58),
	EnemySpawn(0x1E, Actor.rockIcicleIdle1, 0x78, 0x20),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C6 = [
	EnemySpawn(0x20, Actor.skorpDown, 0x78, 0x18),
	EnemySpawn(0x21, Actor.skorpUp, 0xB0, 0xF8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C7 = [
	EnemySpawn(0x1E, Actor.skorpDown, 0x50, 0x28),
	EnemySpawn(0x1F, Actor.skorpUp, 0x90, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_C9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_CA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_CB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_CC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_CD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_CE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D0 = [
	EnemySpawn(0x20, Actor.rockIcicleIdle1, 0x88, 0x20),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D6 = [
	EnemySpawn(0x22, Actor.skorpRight, 0x18, 0x70),
	EnemySpawn(0x23, Actor.skorpRight, 0x58, 0xD0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D7 = [
	EnemySpawn(0x24, Actor.skorpUp, 0x70, 0xF8),
	EnemySpawn(0x25, Actor.skorpUp, 0xC0, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_D9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_DA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_DB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_DF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E1 = [
	EnemySpawn(0x21, Actor.skorpUp, 0xB0, 0xD8),
	EnemySpawn(0x22, Actor.skorpUp, 0xD0, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_EC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_ED = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_EE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F5 = [
	EnemySpawn(0x44, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F6 = [
	EnemySpawn(0x26, Actor.glowflyIdle1, 0x40, 0x80),
	EnemySpawn(0x27, Actor.glowflyIdle1, 0x40, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F8 = [
	EnemySpawn(0x45, Actor.zetaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_F9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_FA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_FB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_FC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_FD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_FE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankA_FF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_00 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_01 = [
	EnemySpawn(0x42, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_02 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_03 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_04 = [
	EnemySpawn(0x4E, Actor.zetaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_05 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_06 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_07 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_08 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_09 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_0A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_0B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_0D = [
	EnemySpawn(0x11, Actor.smallBug, 0xD0, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_0E = [
	EnemySpawn(0x12, Actor.smallBug, 0x40, 0x90),
	EnemySpawn(0x13, Actor.smallBug, 0x98, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_10 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_11 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_12 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_13 = [
	EnemySpawn(0x15, Actor.chuteLeech, 0x90, 0xEC),
	EnemySpawn(0x16, Actor.smallBug, 0xD0, 0x90),
	EnemySpawn(0x17, Actor.chuteLeech, 0xE8, 0xEC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_14 = [
	EnemySpawn(0x1A, Actor.chuteLeech, 0xE0, 0xEC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_15 = [
	EnemySpawn(0x1C, Actor.chuteLeech, 0x60, 0xEC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_16 = [
	EnemySpawn(0x20, Actor.pipeBug, 0xD0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_17 = [
	EnemySpawn(0x21, Actor.pipeBug2, 0x30, 0xF0),
	EnemySpawn(0x22, Actor.pipeBug, 0xB0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_18 = [
	EnemySpawn(0x23, Actor.pipeBug2, 0x70, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_19 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_1A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_1B = [
	EnemySpawn(0x27, Actor.smallBug, 0x90, 0xDC),
	EnemySpawn(0x28, Actor.smallBug, 0xB0, 0x8C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_1C = [
	EnemySpawn(0x0F, Actor.energyRefill, 0x28, 0x48),
	EnemySpawn(0x29, Actor.gullugg, 0x38, 0x8C),
	EnemySpawn(0x2A, Actor.gullugg, 0x78, 0xAC),
	EnemySpawn(0x2B, Actor.gullugg, 0xB8, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_1D = [
	EnemySpawn(0x2C, Actor.gullugg, 0x38, 0xBC),
	EnemySpawn(0x2D, Actor.gullugg, 0x78, 0x98),
	EnemySpawn(0x2E, Actor.smallBug, 0xF0, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_1E = [
	EnemySpawn(0x2F, Actor.gullugg, 0x13, 0x70),
	EnemySpawn(0x31, Actor.gullugg, 0x70, 0x90),
	EnemySpawn(0x32, Actor.gullugg, 0xA0, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_20 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_21 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_22 = [
	EnemySpawn(0x40, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_23 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_24 = [
	EnemySpawn(0x30, Actor.septogg, 0x48, 0x98),
	EnemySpawn(0x31, Actor.septogg, 0x78, 0xA0),
	EnemySpawn(0x32, Actor.septogg, 0xA8, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_25 = [
	EnemySpawn(0x33, Actor.septogg, 0x38, 0xA0),
	EnemySpawn(0x34, Actor.septogg, 0x68, 0x90),
	EnemySpawn(0x35, Actor.septogg, 0x98, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_26 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_27 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_28 = [
	EnemySpawn(0x2E, Actor.yumeeSpawner, 0xD0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_29 = [
	EnemySpawn(0x2F, Actor.yumeeSpawner2, 0x30, 0xF0),
	EnemySpawn(0x30, Actor.yumeeSpawner, 0xB0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_2A = [
	EnemySpawn(0x31, Actor.yumeeSpawner2, 0x30, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_2B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_2C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_2E = [
	EnemySpawn(0x41, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_30 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_31 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_32 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_33 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_35 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_36 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_37 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_38 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_39 = [
	EnemySpawn(0x43, Actor.alphaMetroid, 0x80, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_3A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_3B = [
	EnemySpawn(0x44, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_3C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_40 = [
	EnemySpawn(0x1E, Actor.octroll, 0xA0, 0xC0),
	EnemySpawn(0x1F, Actor.octroll, 0xE0, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_41 = [
	EnemySpawn(0x20, Actor.octroll, 0x40, 0x80),
	EnemySpawn(0x21, Actor.octroll, 0xC8, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_42 = [
	EnemySpawn(0x22, Actor.octroll, 0x70, 0xD0),
	EnemySpawn(0x23, Actor.octroll, 0xF0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_43 = [
	EnemySpawn(0x24, Actor.octroll, 0x60, 0xC0),
	EnemySpawn(0x25, Actor.octroll, 0x80, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_44 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_45 = [
	EnemySpawn(0x45, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_46 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_47 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_4B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_4C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_4D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_4E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_50 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_51 = [
	EnemySpawn(0x16, Actor.drivel, 0xA0, 0x98),
	EnemySpawn(0x17, Actor.skreek, 0xD0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_52 = [
	EnemySpawn(0x0C, Actor.skreek, 0x08, 0xE8),
	EnemySpawn(0x14, Actor.drivel, 0x90, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_53 = [
	EnemySpawn(0x15, Actor.skreek, 0x08, 0xE8),
	EnemySpawn(0x12, Actor.drivel, 0x80, 0x98),
	EnemySpawn(0x13, Actor.skreek, 0xFF, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_54 = [
	EnemySpawn(0x10, Actor.skreek, 0x68, 0xE8),
	EnemySpawn(0x11, Actor.drivel, 0x70, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_55 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_56 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_57 = [
	EnemySpawn(0x47, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_58 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_59 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_5A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_5B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_5C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_5D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_5E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_5F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_60 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_61 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_62 = [
	EnemySpawn(0x18, Actor.moto, 0x40, 0xC8),
	EnemySpawn(0x19, Actor.moto, 0xC0, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_63 = [
	EnemySpawn(0x1A, Actor.moto, 0x40, 0xA8),
	EnemySpawn(0x1B, Actor.moto, 0x80, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_64 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_65 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_66 = [
	EnemySpawn(0x49, Actor.metroid1, 0x80, 0xB6),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_67 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_69 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_6A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_6B = [
	EnemySpawn(0x2D, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0x2E, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_6C = [
	EnemySpawn(0x2F, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0x30, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_6D = [
	EnemySpawn(0x31, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0x32, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_6E = [
	EnemySpawn(0x33, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0x34, Actor.halzyn, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_70 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_71 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_73 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_74 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_75 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_76 = [
	EnemySpawn(0x4A, Actor.zeta1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_77 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_78 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_79 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_7A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_7B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_7D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_80 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_81 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_82 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_83 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_84 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_85 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_87 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_88 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_89 = [
	EnemySpawn(0x32, Actor.yumeeSpawner, 0xA0, 0xE0),
	EnemySpawn(0x33, Actor.yumeeSpawner2, 0xFF, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_8A = [
	EnemySpawn(0x34, Actor.yumeeSpawner, 0x68, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_8B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_8D = [
	EnemySpawn(0x4C, Actor.zeta1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_90 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_91 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_93 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_94 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_96 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_97 = [
	EnemySpawn(0x30, Actor.moheekRight, 0x68, 0xA8),
	EnemySpawn(0x31, Actor.moheekLeft, 0xC0, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_98 = [
	EnemySpawn(0x2E, Actor.moheekLeft, 0x40, 0x80),
	EnemySpawn(0x2F, Actor.moheekRight, 0xB0, 0x58),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_99 = [
	EnemySpawn(0x2C, Actor.moheekLeft, 0x40, 0x80),
	EnemySpawn(0x2D, Actor.moheekRight, 0xB0, 0x58),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_9A = [
	EnemySpawn(0x2A, Actor.moheekLeft, 0x40, 0x98),
	EnemySpawn(0x2B, Actor.moheekRight, 0x88, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_9B = [
	EnemySpawn(0x12, Actor.skorpUp, 0xA0, 0xD8),
	EnemySpawn(0x13, Actor.skorpUp, 0xD8, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_9C = [
	EnemySpawn(0x10, Actor.skorpUp, 0x20, 0xA8),
	EnemySpawn(0x11, Actor.skorpUp, 0x68, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_9D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_9E = [
	EnemySpawn(0x18, Actor.moto, 0x40, 0xC8),
	EnemySpawn(0x19, Actor.moto, 0xC0, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_9F = [
	EnemySpawn(0x1A, Actor.moto, 0x40, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A7 = [
	EnemySpawn(0x46, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_A9 = [
	EnemySpawn(0x35, Actor.smallBug, 0xA0, 0xB4),
	EnemySpawn(0x36, Actor.smallBug, 0xA8, 0xD4),
	EnemySpawn(0x37, Actor.smallBug, 0xAC, 0xFC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_AA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_AB = [
	EnemySpawn(0x4F, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B8 = [
	EnemySpawn(0x18, Actor.smallBug, 0xA0, 0xAC),
	EnemySpawn(0x19, Actor.smallBug, 0xA8, 0xD4),
	EnemySpawn(0x1A, Actor.smallBug, 0xC0, 0xFC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_B9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_BA = [
	EnemySpawn(0x10, Actor.chuteLeech, 0x90, 0xBE),
	EnemySpawn(0x11, Actor.chuteLeech, 0xD0, 0xDE),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_BB = [
	EnemySpawn(0x12, Actor.chuteLeech, 0x10, 0xAE),
	EnemySpawn(0x13, Actor.chuteLeech, 0x70, 0xBE),
	EnemySpawn(0x14, Actor.chuteLeech, 0xC0, 0xDE),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_BC = [
	EnemySpawn(0x15, Actor.chuteLeech, 0x40, 0xDE),
	EnemySpawn(0x16, Actor.chuteLeech, 0x80, 0xBE),
	EnemySpawn(0x17, Actor.chuteLeech, 0xB0, 0xDE),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_BD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_BE = [
	EnemySpawn(0x50, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C0 = [
	EnemySpawn(0x1C, Actor.smallBug, 0x80, 0x80),
	EnemySpawn(0x1D, Actor.yumeeSpawner2, 0xA0, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C1 = [
	EnemySpawn(0x1A, Actor.yumeeSpawner, 0x08, 0xF0),
	EnemySpawn(0x1B, Actor.glowflyIdle1, 0xF0, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C2 = [
	EnemySpawn(0x18, Actor.skorpUp, 0x80, 0xE8),
	EnemySpawn(0x19, Actor.skorpUp, 0xB0, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C3 = [
	EnemySpawn(0x16, Actor.moheekLeft, 0x58, 0xA8),
	EnemySpawn(0x17, Actor.moheekRight, 0x78, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C4 = [
	EnemySpawn(0x51, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C8 = [
	EnemySpawn(0x1B, Actor.gullugg, 0x80, 0x90),
	EnemySpawn(0x1C, Actor.smallBug, 0xA0, 0x2C),
	EnemySpawn(0x1D, Actor.smallBug, 0xB0, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_C9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_CA = [
	EnemySpawn(0x52, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_CB = [
	EnemySpawn(0x2B, Actor.smallBug, 0xC0, 0xF8),
	EnemySpawn(0x2C, Actor.smallBug, 0xC8, 0xAC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_CC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_CD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_CE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_D9 = [
	EnemySpawn(0x53, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_DA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_DB = [
	EnemySpawn(0x2D, Actor.smallBug, 0x78, 0x3C),
	EnemySpawn(0x2E, Actor.smallBug, 0xB0, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_DF = [
	EnemySpawn(0x54, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E3 = [
	EnemySpawn(0x0F, Actor.energyRefill, 0x48, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E4 = [
	EnemySpawn(0x55, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_EC = [
	EnemySpawn(0x56, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_ED = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_EE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F1 = [
	EnemySpawn(0x30, Actor.flittMoving, 0x50, 0xA0),
	EnemySpawn(0x31, Actor.flittMoving, 0xB0, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F2 = [
	EnemySpawn(0x2D, Actor.flittMoving, 0x00, 0x78),
	EnemySpawn(0x2E, Actor.flittMoving, 0x50, 0x80),
	EnemySpawn(0x2F, Actor.flittMoving, 0xA0, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F3 = [
	EnemySpawn(0x2A, Actor.flittMoving, 0x00, 0xD0),
	EnemySpawn(0x2B, Actor.flittMoving, 0x50, 0x90),
	EnemySpawn(0x2C, Actor.flittMoving, 0xA0, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F4 = [
	EnemySpawn(0x27, Actor.flittMoving, 0x00, 0xD0),
	EnemySpawn(0x28, Actor.flittMoving, 0x30, 0x90),
	EnemySpawn(0x29, Actor.flittMoving, 0x70, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F5 = [
	EnemySpawn(0x20, Actor.flittVanishing, 0x60, 0xA0),
	EnemySpawn(0x21, Actor.flittVanishing, 0x90, 0xA0),
	EnemySpawn(0x22, Actor.flittVanishing, 0xC0, 0x90),
	EnemySpawn(0x23, Actor.flittVanishing, 0xE0, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F6 = [
	EnemySpawn(0x24, Actor.flittVanishing, 0x10, 0x88),
	EnemySpawn(0x25, Actor.flittVanishing, 0x50, 0x98),
	EnemySpawn(0x26, Actor.flittVanishing, 0x90, 0xA0),
	EnemySpawn(0x27, Actor.flittVanishing, 0xD0, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F7 = [
	EnemySpawn(0x28, Actor.flittVanishing, 0x00, 0xA0),
	EnemySpawn(0x29, Actor.flittVanishing, 0x30, 0x90),
	EnemySpawn(0x2A, Actor.flittVanishing, 0x80, 0xA8),
	EnemySpawn(0x2B, Actor.flittVanishing, 0xC0, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F8 = [
	EnemySpawn(0x2C, Actor.flittVanishing, 0x00, 0x90),
	EnemySpawn(0x2D, Actor.flittVanishing, 0x40, 0x90),
	EnemySpawn(0x2E, Actor.flittVanishing, 0x80, 0xA0),
	EnemySpawn(0x2F, Actor.flittVanishing, 0xB0, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_F9 = [
	EnemySpawn(0x10, Actor.octroll, 0xC0, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_FA = [
	EnemySpawn(0x11, Actor.octroll, 0x08, 0xD8),
	EnemySpawn(0x12, Actor.octroll, 0xA0, 0xD8),
	EnemySpawn(0x13, Actor.octroll, 0xFF, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_FB = [
	EnemySpawn(0x14, Actor.octroll, 0x90, 0xD8),
	EnemySpawn(0x15, Actor.octroll, 0xF8, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_FC = [
	EnemySpawn(0x16, Actor.octroll, 0x70, 0xD8),
	EnemySpawn(0x17, Actor.octroll, 0xFF, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_FD = [
	EnemySpawn(0x18, Actor.octroll, 0x90, 0xD8),
	EnemySpawn(0x19, Actor.octroll, 0xF8, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_FE = [
	EnemySpawn(0x1A, Actor.octroll, 0x90, 0xD8),
	EnemySpawn(0x1B, Actor.octroll, 0xF0, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankB_FF = [
	EnemySpawn(0x1C, Actor.octroll, 0x40, 0xD8),
	EnemySpawn(0x1D, Actor.octroll, 0x80, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_00 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_01 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_02 = [
	EnemySpawn(0x20, Actor.needlerRight, 0x80, 0x58),
	EnemySpawn(0x21, Actor.needlerLeft, 0xA0, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_03 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_04 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_05 = [
	EnemySpawn(0x24, Actor.smallBug, 0x88, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_06 = [
	EnemySpawn(0x36, Actor.smallBug, 0x78, 0xD4),
	EnemySpawn(0x37, Actor.smallBug, 0xC8, 0xCC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_07 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_08 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_09 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_0A = [
	EnemySpawn(0x10, Actor.smallBug, 0xB0, 0x84),
	EnemySpawn(0x11, Actor.smallBug, 0xB8, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_0B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_0D = [
	EnemySpawn(0x16, Actor.smallBug, 0x88, 0xBC),
	EnemySpawn(0x17, Actor.smallBug, 0xA8, 0xC4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_0E = [
	EnemySpawn(0x16, Actor.smallBug, 0x88, 0xBC),
	EnemySpawn(0x17, Actor.smallBug, 0xA8, 0xC4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_10 = [
	EnemySpawn(0x14, Actor.smallBug, 0x40, 0x40),
	EnemySpawn(0x15, Actor.smallBug, 0xC0, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_11 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_12 = [
	EnemySpawn(0x22, Actor.needlerRight, 0x60, 0x60),
	EnemySpawn(0x23, Actor.needlerLeft, 0xA0, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_13 = [
	EnemySpawn(0x60, Actor.spiderBall, 0x48, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_14 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_15 = [
	EnemySpawn(0x25, Actor.smallBug, 0x88, 0x4C),
	EnemySpawn(0x26, Actor.smallBug, 0xA0, 0x54),
	EnemySpawn(0x27, Actor.smallBug, 0xA8, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_16 = [
	EnemySpawn(0x38, Actor.smallBug, 0xA0, 0x40),
	EnemySpawn(0x39, Actor.smallBug, 0xB0, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_17 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_18 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_19 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_1A = [
	EnemySpawn(0x12, Actor.smallBug, 0x88, 0x3C),
	EnemySpawn(0x13, Actor.smallBug, 0xB8, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_1B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_1C = [
	EnemySpawn(0x18, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_1D = [
	EnemySpawn(0x14, Actor.smallBug, 0x88, 0x4C),
	EnemySpawn(0x15, Actor.smallBug, 0xA8, 0x54),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_1E = [
	EnemySpawn(0x14, Actor.smallBug, 0x88, 0x4C),
	EnemySpawn(0x15, Actor.smallBug, 0xA8, 0x54),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_20 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_21 = [
	EnemySpawn(0x1A, Actor.tsumuriRight, 0x80, 0x80),
	EnemySpawn(0x1B, Actor.smallBug, 0xB0, 0xAC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_22 = [
	EnemySpawn(0x24, Actor.needlerRight, 0x40, 0x28),
	EnemySpawn(0x25, Actor.needlerLeft, 0x50, 0x88),
	EnemySpawn(0x26, Actor.smallBug, 0xB8, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_23 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_24 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_25 = [
	EnemySpawn(0x28, Actor.smallBug, 0x88, 0x40),
	EnemySpawn(0x29, Actor.smallBug, 0xB8, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_26 = [
	EnemySpawn(0x3A, Actor.smallBug, 0x80, 0x40),
	EnemySpawn(0x3B, Actor.smallBug, 0x90, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_27 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_28 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_29 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_2A = [
	EnemySpawn(0x14, Actor.smallBug, 0x80, 0x3C),
	EnemySpawn(0x15, Actor.smallBug, 0x80, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_2B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_2C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_2E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_30 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_31 = [
	EnemySpawn(0x1C, Actor.tsumuriLeft, 0x70, 0x40),
	EnemySpawn(0x1D, Actor.tsumuriRight, 0x80, 0x80),
	EnemySpawn(0x1E, Actor.tsumuriLeft, 0x90, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_32 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_33 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_35 = [
	EnemySpawn(0x2A, Actor.smallBug, 0x88, 0x40),
	EnemySpawn(0x2B, Actor.smallBug, 0xB8, 0xB4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_36 = [
	EnemySpawn(0x3C, Actor.smallBug, 0xA0, 0x4C),
	EnemySpawn(0x3D, Actor.smallBug, 0xA8, 0x84),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_37 = [
	EnemySpawn(0x14, Actor.smallBug, 0xA0, 0x7C),
	EnemySpawn(0x15, Actor.smallBug, 0xB0, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_38 = [
	EnemySpawn(0x41, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_39 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_3A = [
	EnemySpawn(0x16, Actor.smallBug, 0xA0, 0x3C),
	EnemySpawn(0x17, Actor.smallBug, 0xA0, 0x8C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_3B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_3C = [
	EnemySpawn(0x19, Actor.halzyn, 0x80, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_40 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_41 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_42 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_43 = [
	EnemySpawn(0x35, Actor.glowflyIdle1, 0x40, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_44 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_45 = [
	EnemySpawn(0x2C, Actor.smallBug, 0x90, 0x3C),
	EnemySpawn(0x2D, Actor.smallBug, 0xB0, 0x8C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_46 = [
	EnemySpawn(0x13, Actor.smallBug, 0x88, 0xA4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_47 = [
	EnemySpawn(0x16, Actor.smallBug, 0xA0, 0x3C),
	EnemySpawn(0x17, Actor.smallBug, 0xB0, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_4B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_4C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_4D = [
	EnemySpawn(0x35, Actor.moto, 0x58, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_4E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_50 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_51 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_52 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_53 = [
	EnemySpawn(0x36, Actor.glowflyIdle1, 0x40, 0x48),
	EnemySpawn(0x37, Actor.glowflyIdle1, 0x40, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_54 = [
	EnemySpawn(0x26, Actor.smallBug, 0xB0, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_55 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_56 = [
	EnemySpawn(0x11, Actor.moto, 0x80, 0x18),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_57 = [
	EnemySpawn(0x18, Actor.smallBug, 0xA0, 0x3C),
	EnemySpawn(0x19, Actor.smallBug, 0xB0, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_58 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_59 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_5A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_5B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_5C = [
	EnemySpawn(0x1A, Actor.halzyn, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_5D = [
	EnemySpawn(0x36, Actor.moto, 0xA0, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_5E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_5F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_60 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_61 = [
	EnemySpawn(0x27, Actor.smallBug, 0xB0, 0x94),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_62 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_63 = [
	EnemySpawn(0x38, Actor.glowflyIdle1, 0x40, 0xC8),
	EnemySpawn(0x39, Actor.moheekLeft, 0x80, 0x58),
	EnemySpawn(0x3A, Actor.moheekLeft, 0x80, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_64 = [
	EnemySpawn(0x23, Actor.smallBug, 0xB8, 0xAC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_65 = [
	EnemySpawn(0x1B, Actor.smallBug, 0xB0, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_66 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_67 = [
	EnemySpawn(0x1A, Actor.smallBug, 0xA0, 0x34),
	EnemySpawn(0x1B, Actor.smallBug, 0xA8, 0x84),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_69 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_6A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_6B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_6C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_6D = [
	EnemySpawn(0x37, Actor.moto, 0xB8, 0x88),
	EnemySpawn(0x38, Actor.ramulken, 0xC0, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_6E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_70 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_71 = [
	EnemySpawn(0x28, Actor.smallBug, 0xB8, 0x94),
	EnemySpawn(0x29, Actor.tsumuriLeft, 0xC1, 0x30),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_73 = [
	EnemySpawn(0x3B, Actor.glowflyIdle1, 0x40, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_74 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_75 = [
	EnemySpawn(0x1A, Actor.smallBug, 0x90, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_76 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_77 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_78 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_79 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_7A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_7B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_7D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_80 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_81 = [
	EnemySpawn(0x2A, Actor.tsumuriLeft, 0xB8, 0x50),
	EnemySpawn(0x2B, Actor.smallBug, 0xC0, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_82 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_83 = [
	EnemySpawn(0x3C, Actor.skorpUp, 0x80, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_84 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_85 = [
	EnemySpawn(0x18, Actor.smallBug, 0xA0, 0x54),
	EnemySpawn(0x19, Actor.smallBug, 0xA0, 0x94),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_87 = [
	EnemySpawn(0x1D, Actor.halzyn, 0x80, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_88 = [
	EnemySpawn(0x40, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_89 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_8A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_8B = [
	EnemySpawn(0x1D, Actor.halzyn, 0x80, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_8D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_90 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_91 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_93 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_94 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_96 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_97 = [
	EnemySpawn(0x1C, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_98 = [
	EnemySpawn(0x0F, Actor.energyRefill, 0xE8, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_99 = [
	EnemySpawn(0x22, Actor.halzyn, 0x80, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_9A = [
	EnemySpawn(0x32, Actor.glowflyIdle1, 0x20, 0x68),
	EnemySpawn(0x33, Actor.glowflyIdle1, 0x60, 0xF0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_9B = [
	EnemySpawn(0x1C, Actor.halzyn, 0x80, 0x40),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_9C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_9D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_9E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_9F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A1 = [
	EnemySpawn(0x10, Actor.moheekLeft, 0x70, 0x57),
	EnemySpawn(0x11, Actor.moheekRight, 0xB9, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A2 = [
	EnemySpawn(0x21, Actor.tsumuriLeft, 0x60, 0xB8),
	EnemySpawn(0x22, Actor.tsumuriRight, 0x80, 0x58),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A3 = [
	EnemySpawn(0x1C, Actor.smallBug, 0xA0, 0x84),
	EnemySpawn(0x1D, Actor.smallBug, 0x90, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_A9 = [
	EnemySpawn(0x20, Actor.halzyn, 0xA8, 0x30),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_AA = [
	EnemySpawn(0x34, Actor.glowflyIdle1, 0x20, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_AB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B1 = [
	EnemySpawn(0x19, Actor.moheekRight, 0x90, 0x87),
	EnemySpawn(0x1A, Actor.smallBug, 0xB0, 0xAC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B2 = [
	EnemySpawn(0x23, Actor.tsumuriRight, 0x60, 0xD7),
	EnemySpawn(0x24, Actor.tsumuriLeft, 0x80, 0x77),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B3 = [
	EnemySpawn(0x1E, Actor.smallBug, 0x90, 0x3C),
	EnemySpawn(0x1F, Actor.smallBug, 0x90, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_B9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_BA = [
	EnemySpawn(0x35, Actor.glowflyIdle1, 0xA0, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_BB = [
	EnemySpawn(0x34, Actor.glowflyIdle1, 0x90, 0x28),
	EnemySpawn(0x35, Actor.glowflyIdle1, 0xB0, 0x70),
	EnemySpawn(0x36, Actor.glowflyIdle1, 0x90, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_BC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_BD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_BE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C2 = [
	EnemySpawn(0x25, Actor.tsumuriLeft, 0x90, 0x37),
	EnemySpawn(0x26, Actor.tsumuriRight, 0xA7, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C3 = [
	EnemySpawn(0x30, Actor.smallBug, 0x90, 0x3C),
	EnemySpawn(0x31, Actor.smallBug, 0x90, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C6 = [
	EnemySpawn(0x14, Actor.skorpRight, 0x48, 0xF0),
	EnemySpawn(0x15, Actor.skorpLeft, 0x68, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_C9 = [
	EnemySpawn(0x1C, Actor.halzyn, 0x50, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_CA = [
	EnemySpawn(0x36, Actor.glowflyIdle1, 0x20, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_CB = [
	EnemySpawn(0x37, Actor.glowflyIdle1, 0x20, 0x50),
	EnemySpawn(0x38, Actor.glowflyIdle1, 0x20, 0x70),
	EnemySpawn(0x39, Actor.glowflyIdle1, 0x40, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_CC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_CD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_CE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D1 = [
	EnemySpawn(0x1E, Actor.needlerRight, 0x70, 0x58),
	EnemySpawn(0x1F, Actor.needlerLeft, 0x80, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D2 = [
	EnemySpawn(0x27, Actor.tsumuriLeft, 0x88, 0x77),
	EnemySpawn(0x28, Actor.tsumuriRight, 0xB0, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D3 = [
	EnemySpawn(0x32, Actor.smallBug, 0x90, 0x3C),
	EnemySpawn(0x33, Actor.smallBug, 0x90, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_D9 = [
	EnemySpawn(0x1A, Actor.halzyn, 0xB0, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_DA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_DB = [
	EnemySpawn(0x3A, Actor.glowflyIdle1, 0xB0, 0x70),
	EnemySpawn(0x3B, Actor.glowflyIdle1, 0x90, 0x98),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_DF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E1 = [
	EnemySpawn(0x1D, Actor.smallBug, 0xB0, 0x4C),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E2 = [
	EnemySpawn(0x29, Actor.tsumuriLeft, 0x88, 0x77),
	EnemySpawn(0x2A, Actor.tsumuriRight, 0x98, 0x37),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E3 = [
	EnemySpawn(0x34, Actor.smallBug, 0x90, 0x3C),
	EnemySpawn(0x35, Actor.smallBug, 0x90, 0x84),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_EC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_ED = [
	EnemySpawn(0x28, Actor.skorpRight, 0x98, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_EE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_F9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_FA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_FB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_FC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_FD = [
	EnemySpawn(0x0C, Actor.skorpRight, 0x88, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_FE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankC_FF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_00 = [
	EnemySpawn(0x47, Actor.metroid, 0xA0, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_01 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_02 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_03 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_04 = [
	EnemySpawn(0x0F, Actor.energyRefill, 0x18, 0xE8),
	EnemySpawn(0x46, Actor.alphaMetroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_05 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_06 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_07 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_08 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_09 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_0A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_0B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_0D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_0E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_10 = [
	EnemySpawn(0x40, Actor.metroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_11 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_12 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_13 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_14 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_15 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_16 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_17 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_18 = [
	EnemySpawn(0x60, Actor.missileTank, 0xB8, 0xE8),
	EnemySpawn(0x1D, Actor.wallfire, 0xE4, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_19 = [
	EnemySpawn(0x1C, Actor.wallfire, 0xB4, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_1A = [
	EnemySpawn(0x61, Actor.missileTank, 0x48, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_1B = [
	EnemySpawn(0x11, Actor.wallfireFlipped, 0xBC, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_1C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_1D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_1E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_20 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_21 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_22 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_23 = [
	EnemySpawn(0x41, Actor.metroid, 0x80, 0x70),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_24 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_25 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_26 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_27 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_28 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_29 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_2A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_2B = [
	EnemySpawn(0x12, Actor.wallfireFlipped, 0xBC, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_2C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_2E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_30 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_31 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_32 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_33 = [
	EnemySpawn(0x42, Actor.metroid, 0x70, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_35 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_36 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_37 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_38 = [
	EnemySpawn(0x10, Actor.wallfireFlipped, 0xFC, 0xCC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_39 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_3A = [
	EnemySpawn(0x62, Actor.energyTank, 0x58, 0x78),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_3B = [
	EnemySpawn(0x13, Actor.wallfire, 0x44, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_3C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_40 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_41 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_42 = [
	EnemySpawn(0x43, Actor.metroid, 0x70, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_43 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_44 = [
	EnemySpawn(0x63, Actor.bombsOrb, 0x5C, 0x60),
	EnemySpawn(0x7A, Actor.missileTank, 0xA8, 0xC8),
	EnemySpawn(0x64, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_45 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_46 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_47 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_4B = [
	EnemySpawn(0x14, Actor.wallfireFlipped, 0xBC, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_4C = [
	EnemySpawn(0x18, Actor.wallfire, 0x44, 0xB0),
	EnemySpawn(0x65, Actor.missileTank, 0xB8, 0xE8),
	EnemySpawn(0x19, Actor.wallfire, 0xE4, 0xBD),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_4D = [
	EnemySpawn(0x1A, Actor.wallfireFlipped, 0x3C, 0xE0),
	EnemySpawn(0x66, Actor.missileTank, 0x68, 0x58),
	EnemySpawn(0x67, Actor.missileTank, 0x78, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_4E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_50 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_51 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_52 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_53 = [
	EnemySpawn(0x10, Actor.autrackFlipped, 0x60, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_54 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_55 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_56 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_57 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_58 = [
	EnemySpawn(0x0F, Actor.iceBeamOrb, 0x5C, 0x60),
	EnemySpawn(0x68, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_59 = [
	EnemySpawn(0x17, Actor.wallfire, 0x24, 0xD0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_5A = [
	EnemySpawn(0x16, Actor.wallfireFlipped, 0xDC, 0xD4),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_5B = [
	EnemySpawn(0x15, Actor.wallfire, 0x44, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_5C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_5D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_5E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_5F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_60 = [
	EnemySpawn(0x69, Actor.variaSuitOrb, 0x48, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_61 = [
	EnemySpawn(0x6A, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_62 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_63 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_64 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_65 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_66 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_67 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_69 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_6A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_6B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_6C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_6D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_6E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_70 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_71 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_73 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_74 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_75 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_76 = [
	EnemySpawn(0x44, Actor.metroid1, 0xC0, 0x76),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_77 = [
	EnemySpawn(0x6C, Actor.missileTank, 0xA8, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_78 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_79 = [
	EnemySpawn(0x6C, Actor.missileTank, 0xA8, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_7A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_7B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_7D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_80 = [
	EnemySpawn(0x78, Actor.missileTank, 0x98, 0x48),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_81 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_82 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_83 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_84 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_85 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_87 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_88 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_89 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_8A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_8B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_8D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_90 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_91 = [
	EnemySpawn(0x6D, Actor.missileTank, 0x38, 0x28),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_93 = [
	EnemySpawn(0x45, Actor.alphaMetroid, 0x78, 0xCC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_94 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_96 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_97 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_98 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_99 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_9A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_9B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_9C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_9D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_9E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_9F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A4 = [
	EnemySpawn(0x0F, Actor.waveBeamOrb, 0x5C, 0x60),
	EnemySpawn(0x6F, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A5 = [
	EnemySpawn(0x13, Actor.autoad, 0x98, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_A9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_AA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_AB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_B9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_BA = [
	EnemySpawn(0x1D, Actor.wallfireFlipped, 0xBC, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_BB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_BC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_BD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_BE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C0 = [
	EnemySpawn(0x70, Actor.arachnusOrb, 0x4C, 0xB0),
	EnemySpawn(0x71, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C5 = [
	EnemySpawn(0x19, Actor.wallfire, 0x34, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C6 = [
	EnemySpawn(0x18, Actor.wallfire, 0x44, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C7 = [
	EnemySpawn(0x15, Actor.wallfireFlipped, 0x3C, 0xC0),
	EnemySpawn(0x72, Actor.missileTank, 0x68, 0x58),
	EnemySpawn(0x73, Actor.missileTank, 0x78, 0xE8),
	EnemySpawn(0x16, Actor.wallfire, 0xB4, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C8 = [
	EnemySpawn(0x17, Actor.wallfireFlipped, 0x1C, 0xE0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_C9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_CA = [
	EnemySpawn(0x1E, Actor.wallfireFlipped, 0xBC, 0x40),
	EnemySpawn(0x1F, Actor.wallfireFlipped, 0xBC, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_CB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_CC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_CD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_CE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D5 = [
	EnemySpawn(0x1A, Actor.wallfire, 0x34, 0x10),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D6 = [
	EnemySpawn(0x1B, Actor.wallfireFlipped, 0x8C, 0xC0),
	EnemySpawn(0x7B, Actor.missileTank, 0xB8, 0xE8),
	EnemySpawn(0x1C, Actor.wallfireFlipped, 0xFC, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D7 = [
	EnemySpawn(0x74, Actor.missileTank, 0x18, 0xE8),
	EnemySpawn(0x77, Actor.energyTank, 0x18, 0x58),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_D9 = [
	EnemySpawn(0x75, Actor.hiJumpBootsOrb, 0x5C, 0x60),
	EnemySpawn(0x76, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_DA = [
	EnemySpawn(0x20, Actor.wallfireFlipped, 0xBC, 0x00),
	EnemySpawn(0x21, Actor.wallfireFlipped, 0xBC, 0x60),
	EnemySpawn(0x22, Actor.wallfireFlipped, 0xBC, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_DB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_DF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_EC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_ED = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_EE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_F9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_FA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_FB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_FC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_FD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_FE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankD_FF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_00 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_01 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_02 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_03 = [
	EnemySpawn(0x41, Actor.metroid, 0xA0, 0x90),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_04 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_05 = [
	EnemySpawn(0x42, Actor.metroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_06 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_07 = [
	EnemySpawn(0x49, Actor.alphaMetroid, 0xB0, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_08 = [
	EnemySpawn(0x0F, Actor.energyRefill, 0x18, 0xD8),
	EnemySpawn(0x4A, Actor.alpha1, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_09 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_0A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_0B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_0D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_0E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_10 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_11 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_12 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_13 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_14 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_15 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_16 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_17 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_18 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_19 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_1A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_1B = [
	EnemySpawn(0x60, Actor.missileTank, 0x88, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_1C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_1D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_1E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_20 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_21 = [
	EnemySpawn(0x0F, Actor.babyMetroidEggPreview, 0xAC, 0xA7),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_22 = [
	EnemySpawn(0x43, Actor.metroidStinger, 0x40, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_23 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_24 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_25 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_26 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_27 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_28 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_29 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_2A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_2B = [
	EnemySpawn(0x61, Actor.screwAttackOrb, 0x5C, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_2C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_2E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_30 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_31 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_32 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_33 = [
	EnemySpawn(0x44, Actor.metroid, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_35 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_36 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_37 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_38 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_39 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_3A = [
	EnemySpawn(0x45, Actor.zetaMetroid, 0x40, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_3B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_3C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_40 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_41 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_42 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_43 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_44 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_45 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_46 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_47 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_4B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_4C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_4D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_4E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_50 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_51 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_52 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_53 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_54 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_55 = [
	EnemySpawn(0x6D, Actor.missileTank, 0x78, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_56 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_57 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_58 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_59 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_5A = [
	EnemySpawn(0x0F, Actor.plasmaBeamOrb, 0x5C, 0x60),
	EnemySpawn(0x62, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_5B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_5C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_5D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_5E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_5F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_60 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_61 = [
	EnemySpawn(0x63, Actor.spaceJumpOrb, 0x5C, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_62 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_63 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_64 = [
	EnemySpawn(0x14, Actor.autrackFlipped, 0x46, 0x88),
	EnemySpawn(0x15, Actor.autrack, 0xB9, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_65 = [
	EnemySpawn(0x64, Actor.energyTank, 0x38, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_66 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_67 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_69 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_6A = [
	EnemySpawn(0x0F, Actor.spazerOrb, 0x5C, 0x60),
	EnemySpawn(0x65, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_6B = [
	EnemySpawn(0x10, Actor.gunzoo, 0x70, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_6C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_6D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_6E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_70 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_71 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_73 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_74 = [
	EnemySpawn(0x16, Actor.autrackFlipped, 0x46, 0x38),
	EnemySpawn(0x17, Actor.autrack, 0xB9, 0xE8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_75 = [
	EnemySpawn(0x6E, Actor.missileTank, 0x20, 0x28),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_76 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_77 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_78 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_79 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_7A = [
	EnemySpawn(0x0F, Actor.waveBeamOrb, 0x5C, 0x60),
	EnemySpawn(0x66, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_7B = [
	EnemySpawn(0x11, Actor.gunzoo, 0x70, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_7D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_80 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_81 = [
	EnemySpawn(0x0F, Actor.spazerOrb, 0x5C, 0x60),
	EnemySpawn(0x67, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_82 = [
	EnemySpawn(0x12, Actor.autoad, 0xB0, 0x80),
	EnemySpawn(0x13, Actor.autrack, 0xC8, 0xD8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_83 = [
	EnemySpawn(0x10, Actor.autoad, 0x40, 0x80),
	EnemySpawn(0x11, Actor.autoad, 0x68, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_84 = [
	EnemySpawn(0x18, Actor.autrack, 0xB9, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_85 = [
	EnemySpawn(0x46, Actor.alpha1, 0x68, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_87 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_88 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_89 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_8A = [
	EnemySpawn(0x0F, Actor.iceBeam, 0x5C, 0x60),
	EnemySpawn(0x68, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_8B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_8D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_90 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_91 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_93 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_94 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_96 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_97 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_98 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_99 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_9A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_9B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_9C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_9D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_9E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_9F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A0 = [
	EnemySpawn(0x0F, Actor.plasmaBeamOrb, 0x5C, 0x60),
	EnemySpawn(0x69, Actor.missileDoor, 0xFF, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A1 = [
	EnemySpawn(0x1E, Actor.autoad, 0xC0, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A2 = [
	EnemySpawn(0x1C, Actor.autoad, 0x2C, 0xD0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A4 = [
	EnemySpawn(0x47, Actor.alpha1, 0x28, 0x68),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A5 = [
	EnemySpawn(0x1B, Actor.autoad, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A6 = [
	EnemySpawn(0x1A, Actor.autoad, 0x70, 0xC0),
	EnemySpawn(0x70, Actor.missileTank, 0x80, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A7 = [
	EnemySpawn(0x19, Actor.autoad, 0x30, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_A9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_AA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_AB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B0 = [
	EnemySpawn(0x6A, Actor.energyTank, 0xA8, 0x58),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B2 = [
	EnemySpawn(0x48, Actor.alphaMetroid, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B5 = [
	EnemySpawn(0x20, Actor.autom, 0xE0, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B6 = [
	EnemySpawn(0x21, Actor.shirk, 0xC0, 0xA0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B7 = [
	EnemySpawn(0x1F, Actor.autom, 0x00, 0xBC),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_B9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_BA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_BB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_BC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_BD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_BE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_C9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_CA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_CB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_CC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_CD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_CE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D1 = [
	EnemySpawn(0x0F, Actor.iceBeamOrb, 0x2C, 0x60),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D3 = [
	EnemySpawn(0x0E, Actor.energyRefill, 0x48, 0x88),
	EnemySpawn(0x0F, Actor.missileRefill, 0xB8, 0x88),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_D9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_DA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_DB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_DF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_EC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_ED = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_EE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_F9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_FA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_FB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_FC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_FD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_FE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankE_FF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_00 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_01 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_02 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_03 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_04 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_05 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_06 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_07 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_08 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_09 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_0A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_0B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_0C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_0D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_0E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_0F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_10 = [
	EnemySpawn(0x41, Actor.metroid1, 0x90, 0xE6),
	EnemySpawn(0x0E, Actor.energyRefill, 0xC8, 0x48),
	EnemySpawn(0x0F, Actor.missileRefill, 0xE8, 0x48),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_11 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_12 = [
	EnemySpawn(0x31, Actor.hornoad, 0x90, 0xC8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_13 = [
	EnemySpawn(0x2F, Actor.smallBug, 0x60, 0xA8),
	EnemySpawn(0x30, Actor.hornoad, 0x80, 0xB0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_14 = [
	EnemySpawn(0x2D, Actor.smallBug, 0x50, 0xA0),
	EnemySpawn(0x2E, Actor.smallBug, 0x80, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_15 = [
	EnemySpawn(0x2C, Actor.hornoad, 0x60, 0xD0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_16 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_17 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_18 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_19 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_1A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_1B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_1C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_1D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_1E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_1F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_20 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_21 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_22 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_23 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_24 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_25 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_26 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_27 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_28 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_29 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_2A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_2B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_2C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_2D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_2E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_2F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_30 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_31 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_32 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_33 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_34 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_35 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_36 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_37 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_38 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_39 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_3A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_3B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_3C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_3D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_3E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_3F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_40 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_41 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_42 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_43 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_44 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_45 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_46 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_47 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_48 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_49 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_4A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_4B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_4C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_4D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_4E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_4F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_50 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_51 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_52 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_53 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_54 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_55 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_56 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_57 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_58 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_59 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_5A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_5B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_5C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_5D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_5E = [
	EnemySpawn(0x0F, Actor.missileRefill, 0x08, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_5F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_60 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_61 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_62 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_63 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_64 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_65 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_66 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_67 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_68 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_69 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_6A = [
	EnemySpawn(0x17, Actor.tsumuriRight, 0x80, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_6B = [
	EnemySpawn(0x18, Actor.tsumuriLeft, 0x80, 0xA8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_6C = [
	EnemySpawn(0x19, Actor.hornoad, 0x20, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_6D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_6E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_6F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_70 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_71 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_72 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_73 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_74 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_75 = [
	EnemySpawn(0x0E, Actor.energyRefill, 0xD0, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_76 = [
	EnemySpawn(0x0F, Actor.missileRefill, 0x38, 0xB8),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_77 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_78 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_79 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_7A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_7B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_7C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_7D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_7E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_7F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_80 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_81 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_82 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_83 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_84 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_85 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_86 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_87 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_88 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_89 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_8A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_8B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_8C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_8D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_8E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_8F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_90 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_91 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_92 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_93 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_94 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_95 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_96 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_97 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_98 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_99 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_9A = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_9B = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_9C = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_9D = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_9E = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_9F = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A7 = [
	EnemySpawn(0x42, Actor.egg2, 0xAC, 0xA7),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_A9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_AA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_AB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_AC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_AD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_AE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_AF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B0 = [
	EnemySpawn(0x43, Actor.zeta1, 0x40, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_B9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_BA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_BB = [
	EnemySpawn(0x10, Actor.septogg, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_BC = [
	EnemySpawn(0x11, Actor.septogg, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_BD = [
	EnemySpawn(0x12, Actor.septogg, 0x80, 0xC0),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_BE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_BF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_C9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_CA = [
	EnemySpawn(0x13, Actor.septogg, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_CB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_CC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_CD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_CE = [
	EnemySpawn(0x14, Actor.septogg, 0x80, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_CF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_D9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_DA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_DB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_DC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_DD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_DE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_DF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E0 = [
	EnemySpawn(0x40, Actor.zeta1, 0x40, 0x80),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_E9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_EA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_EB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_EC = [
	EnemySpawn(0x15, Actor.septogg, 0x80, 0x50),
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_ED = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_EE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_EF = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F0 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F1 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F2 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F3 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F4 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F5 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F6 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F7 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F8 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_F9 = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_FA = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_FB = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_FC = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_FD = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_FE = [
	EnemySpawn(0xFF)
];
immutable EnemySpawn[] enemyBankF_FF = [
	EnemySpawn(0xFF)
];

immutable EnemyData[] enemyHeaderPointers = [
	Actor.tsumuriRight: enHeadCrawlerRight, // Tsumari
	Actor.tsumuriLeft: enHeadCrawlerLeft, // Tsumari
	Actor.tsumuri2: enHeadNULL, // Tsumari
	Actor.tsumuri3: enHeadNULL, // Tsumari
	Actor.skreek: enHeadSkreek, // Skreek
	Actor.skreek2: enHeadNULL, // Skreek
	Actor.skreek3: enHeadNULL, // Skreek
	Actor.skreek4: enHeadNULL, // Skreek
	Actor.skreekSpit: enHeadNULL, // Skreek projectile
	Actor.drivel: enHeadDrivel, // Drivel
	Actor.drivel2: enHeadNULL, // Drivel
	Actor.drivel3: enHeadNULL, // Drivel
	Actor.drivelSpit: enHeadNULL, // Drivel projectile
	Actor.drivelSpit2: enHeadNULL, // Drivel projectile
	Actor.drivelSpit3: enHeadNULL, // Drivel projectile
	Actor.drivelSpit4: enHeadNULL, // Drivel projectile
	Actor.drivelSpit5: enHeadNULL, // Drivel projectile
	Actor.drivelSpit6: enHeadNULL, // Drivel projectile
	Actor.smallBug: enHeadSmallBug, // Small bugs
	Actor.smallBug2: enHeadNULL, // Small bugs
	Actor.hornoad: enHeadHornoad, // Hornoad
	Actor.hornoad2: enHeadNULL, // Hornoad
	Actor.senjoo: enHeadSenjoo, // Senjoo
	Actor.gawron: enHeadNULL, // Gawron
	Actor.gawron2: enHeadNULL, // Gawron
	Actor.pipeBug: enHeadPipeBug, // Gawron spawner?
	Actor.pipeBug2: enHeadPipeBug, // Gawron spawner?
	Actor.chuteLeech: enHeadChuteLeech, // Chute leech
	Actor.chuteLeech2: enHeadNULL, // Chute leech
	Actor.chuteLeech3: enHeadNULL, // Chute leech
	Actor.autrackFlipped: enHeadAutrackFlipped, // (uses same spritemap as 41h autrack)
	Actor.wallfireFlipped: enHeadWallfireFlipped, // (uses same spritemap as 4Ah wallfire)
	Actor.needlerRight: enHeadCrawlerRight, // Needler
	Actor.needlerLeft: enHeadCrawlerLeft, // Needler
	Actor.needler3: enHeadNULL, // Needler
	Actor.needler4: enHeadNULL, // Needler
	Actor.actor24: enHeadNULL, // (no graphics)
	Actor.actor25: enHeadNULL, // (no graphics)
	Actor.actor26: enHeadNULL, // (no graphics)
	Actor.actor27: enHeadNULL, // (no graphics)
	Actor.skorpUp: enHeadSkorpUp, // Skorp
	Actor.skorpDown: enHeadSkorpDown, // Skorp
	Actor.skorpRight: enHeadSkorpRight, // Skorp
	Actor.skorpLeft: enHeadSkorpLeft, // Skorp
	Actor.glowflyIdle1: enHeadGlowFly, // Glow fly
	Actor.glowflyIdle2: enHeadNULL, // Glow fly
	Actor.glowflyWindup: enHeadNULL, // Glow fly
	Actor.glowflyMoving: enHeadNULL, // Glow fly
	Actor.moheekRight: enHeadMoheekRight, // Moheek
	Actor.moheekLeft: enHeadMoheekLeft, // Moheek
	0x32: enHeadNULL, // Moheek
	0x33: enHeadNULL, // Moheek
	0x34: enHeadRockIcicle, // Rock icicle
	0x35: enHeadNULL, // Rock icicle
	0x36: enHeadNULL, // Rock icicle
	0x37: enHeadNULL, // Rock icicle
	0x38: enHeadNULL, // Yumee
	0x39: enHeadNULL, // Yumee
	0x3A: enHeadNULL, // Yumee
	0x3B: enHeadNULL, // Yumee
	Actor.yumeeSpawner: enHeadPipeBug, // Yumee spawner?
	Actor.yumeeSpawner2: enHeadPipeBug, // Yumee spawner?
	0x3E: enHeadNULL, // Octroll
	0x3F: enHeadNULL, // Octroll
	Actor.octroll: enHeadOctroll, // Octroll
	Actor.autrack: enHeadAutrack, // Autrack
	0x42: enHeadNULL, // Autrack
	0x43: enHeadNULL, // Autrack
	0x44: enHeadNULL, // Autrack
	0x45: enHeadNULL, // Autrack projectile
	Actor.autoad: enHeadAutoad, // Autoad
	0x47: enHeadNULL, // Autoad
	0x48: enHeadNULL, // Sideways Autoad (unused)
	0x49: enHeadNULL, // Sideways Autoad (unused)
	Actor.wallfire: enHeadWallfire, // Wallfire
	0x4B: enHeadNULL, // Wallfire
	0x4C: enHeadNULL, // Wallfire
	0x4D: enHeadNULL, // Wallfire projectile
	0x4E: enHeadNULL, // Wallfire projectile
	0x4F: enHeadNULL, // Wallfire projectile
	0x50: enHeadNULL, // Wallfire projectile
	Actor.gunzoo: enHeadGunzoo, // Gunzoo
	0x52: enHeadNULL, // Gunzoo
	0x53: enHeadNULL, // Gunzoo
	0x54: enHeadNULL, // Gunzoo diagonal projectile
	0x55: enHeadNULL, // Gunzoo diagonal projectile
	0x56: enHeadNULL, // Gunzoo diagonal projectile
	0x57: enHeadNULL, // Gunzoo horizontal projectile
	0x58: enHeadNULL, // Gunzoo horizontal projectile (unused frame)
	0x59: enHeadNULL, // Gunzoo horizontal projectile
	0x5A: enHeadNULL, // Gunzoo horizontal projectile
	0x5B: enHeadNULL, // Gunzoo horizontal projectile
	Actor.autom: enHeadAutom, // Autom
	0x5D: enHeadNULL, // Autom
	0x5E: enHeadNULL, // Autom projectile
	0x5F: enHeadNULL, // Autom projectile
	0x60: enHeadNULL, // Autom projectile
	0x61: enHeadNULL, // Autom projectile
	0x62: enHeadNULL, // Autom projectile
	Actor.shirk: enHeadShirk, // Shirk
	0x64: enHeadNULL, // Shirk
	Actor.septogg: enHeadSeptogg, // Septogg
	0x66: enHeadNULL, // Septogg
	0x67: enHeadNULL, // Moto
	Actor.moto: enHeadMoto, // Moto
	0x69: enHeadNULL, // Moto
	Actor.halzyn: enHeadHalzyn, // Halzyn
	Actor.ramulken: enHeadRamulken, // Ramulken
	0x6C: enHeadNULL, // Ramulken
	Actor.metroidStinger: enHeadMetroidStinger, // Musical stinger event trigger
	0x6E: enHeadProboscumFlipped, // (uses same spritemap as 72h proboscum)
	0x6F: enHeadNULL, // (no graphics)
	0x70: enHeadNULL, // (no graphics)
	0x71: enHeadNULL, // (no graphics)
	0x72: enHeadProboscum, // Proboscum
	0x73: enHeadNULL, // Proboscum
	0x74: enHeadNULL, // Proboscum
	Actor.missileBlock: enHeadMissileBlock, // Missile block
	0x76: enHeadArachnus, // Arachnus
	0x77: enHeadArachnus, // Arachnus
	0x78: enHeadArachnus, // Arachnus
	0x79: enHeadArachnus, // Arachnus
	0x7A: enHeadArachnus, // Arachnus
	0x7B: enHeadNULL, // Arachnus projectile
	0x7C: enHeadNULL, // Arachnus projectile
	0x7D: enHeadNULL, // (no graphics)
	0x7E: enHeadNULL, // (no graphics)
	0x7F: enHeadNULL, // (no graphics)
	Actor.plasmaBeamOrb: enHeadItem, // Plasma beam orb
	Actor.plasmaBeam: enHeadItem, // Plasma beam
	Actor.iceBeamOrb: enHeadItem, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	Actor.iceBeam: enHeadItem, // Ice beam
	Actor.waveBeamOrb: enHeadItem, // Wave beam orb
	Actor.waveBeam: enHeadItem, // Wave beam
	Actor.spazerOrb: enHeadItem, // Spazer orb
	Actor.spazer: enHeadItem, // Spazer
	Actor.bombsOrb: enHeadItem, // Bombs orb
	Actor.bombs: enHeadItem, // Bombs
	Actor.screwAttackOrb: enHeadItem, // Screw attack orb
	Actor.screwAttack: enHeadItem, // Screw attack
	Actor.variaSuitOrb: enHeadItem, // Varia suit orb
	Actor.variaSuit: enHeadItem, // Varia suit
	Actor.hiJumpBootsOrb: enHeadItem, // Hi-jump boots orb
	Actor.hiJumpBoots: enHeadItem, // Hi-jump boots
	Actor.spaceJumpOrb: enHeadItem, // Space jump orb
	Actor.spaceJump: enHeadItem, // Space jump
	Actor.spiderBallOrb: enHeadItem, // (spider ball orb?)
	Actor.spiderBall: enHeadItem, // Spider ball
	Actor.springBallOrb: enHeadItem, // (spring ball orb?)
	Actor.springBall: enHeadItem, // Spring ball
	Actor.energyTankOrb: enHeadItem, // (energy tank orb?)
	Actor.energyTank: enHeadItem, // Energy tank
	Actor.missileTankOrb: enHeadItem, // (missile tank orb?)
	Actor.missileTank: enHeadItem, // Missile tank
	Actor.blobThrower: enHeadBlobThrower, // Blob thrower (sprite is written to WRAM)
	Actor.energyRefill: enHeadItem, // Energy refill
	Actor.arachnusOrb: enHeadArachnusOrb, // Arachnus orb
	Actor.missileRefill : enHeadItem, // Missile refill
	0x9E: enHeadNULL, // Blob thrower projectile
	0x9F: enHeadNULL, // Blob thrower projectile
	0xA0: enHeadAlphaHatching, // Metroid
	0xA1: enHeadNULL, // Metroid hatching
	0xA2: enHeadNULL, // (no graphics)
	0xA3: enHeadGammaMetroid, // Alpha metroid
	Actor.alphaMetroid: enHeadAlphaMetroid, // Alpha metroid
	0xA5: enHeadNULL, // Baby metroid egg
	0xA6: enHeadBabyMetroid, // Baby metroid egg
	0xA7: enHeadNULL, // Baby metroid egg
	0xA8: enHeadNULL, // Baby metroid
	0xA9: enHeadNULL, // Baby metroid
	0xAA: enHeadNULL, // (no graphics)
	0xAB: enHeadNULL, // (no graphics)
	0xAC: enHeadNULL, // (no graphics)
	Actor.zetaMetroid: enHeadZetaMetroid, // Zeta metroid
	0xAE: enHeadNULL, // Gamma metroid projectile
	0xAF: enHeadNULL, // Gamma metroid projectile
	0xB0: enHeadNULL, // Gamma metroid
	0xB1: enHeadNULL, // (no graphics)
	0xB2: enHeadNULL, // Gamma metroid shell
	0xB3: enHeadOmegaMetroid, // Zeta metroid hatching
	0xB4: enHeadNULL, // Zeta metroid
	0xB5: enHeadNULL, // Zeta metroid
	0xB6: enHeadNULL, // Zeta metroid
	0xB7: enHeadNULL, // Zeta metroid
	0xB8: enHeadNULL, // Zeta metroid
	0xB9: enHeadNULL, // Zeta metroid
	0xBA: enHeadNULL, // Zeta metroid
	0xBB: enHeadNULL, // Zeta metroid
	0xBC: enHeadNULL, // Zeta metroid
	0xBD: enHeadNULL, // Zeta metroid
	0xBE: enHeadNULL, // Zeta metroid projectile
	0xBF: enHeadNULL, // Omega metroid
	0xC0: enHeadNULL, // Omega metroid
	0xC1: enHeadNULL, // Omega metroid
	0xC2: enHeadNULL, // Omega metroid
	0xC3: enHeadNULL, // Omega metroid
	0xC4: enHeadNULL, // Omega metroid
	0xC5: enHeadNULL, // Omega metroid
	0xC6: enHeadNULL, // Omega metroid projectile
	0xC7: enHeadNULL, // Omega metroid projectile
	0xC8: enHeadNULL, // Omega metroid projectile
	0xC9: enHeadNULL, // Omega metroid projectile
	0xCA: enHeadNULL, // Omega metroid projectile
	0xCB: enHeadNULL, // Omega metroid projectile
	0xCC: enHeadNULL, // Omega metroid projectile
	0xCD: enHeadNULL, // (omega metroid projectile?)
	Actor.metroid: enHeadMetroid, // Metroid
	0xCF: enHeadNULL, // Metroid (hurt)
	Actor.flittVanishing: enHeadFlittVanishing, // Flitt
	Actor.flittMoving: enHeadFlittMoving, // Flitt
	0xD2: enHeadNULL, // Stalagtite (unused)
	Actor.gravitt: enHeadGravitt, // Gravitt
	0xD4: enHeadNULL, // Gravitt
	0xD5: enHeadNULL, // Gravitt
	0xD6: enHeadNULL, // Gravitt
	0xD7: enHeadNULL, // Gravitt
	Actor.gullugg: enHeadGullugg, // Gullugg
	0xD9: enHeadNULL, // Gullugg
	0xDA: enHeadNULL, // Gullugg
	Actor.babyMetroidEggPreview: enHeadNULL, // Baby metroid egg preview
	0xDC: enHeadNULL, // (no graphics)
	0xDD: enHeadNULL, // (no graphics)
	0xDE: enHeadNULL, // (no graphics)
	0xDF: enHeadNULL, // (no graphics)
	0xE0: enHeadNULL, // Small health drop
	0xE1: enHeadNULL, // Small health drop
	0xE2: enHeadNULL, // Metroid death / missile door / screw attack explosion
	0xE3: enHeadNULL, // Metroid death / missile door / screw attack explosion
	0xE4: enHeadNULL, // Metroid death / missile door / screw attack explosion
	0xE5: enHeadNULL, // Metroid death / missile door / screw attack explosion
	0xE6: enHeadNULL, // Metroid death / missile door / screw attack explosion
	0xE7: enHeadNULL, // Metroid death / missile door / screw attack explosion
	0xE8: enHeadNULL, // Enemy death explosion
	0xE9: enHeadNULL, // Enemy death explosion
	0xEA: enHeadNULL, // Enemy death explosion
	0xEB: enHeadNULL, // Enemy death explosion (extra frame for enemies not dropping small health)
	0xEC: enHeadNULL, // Big energy drop
	0xED: enHeadNULL, // Big energy drop
	0xEE: enHeadNULL, // Missile drop
	0xEF: enHeadNULL, // Missile drop
	0xF0: enHeadNULL, // Metroid Queen neck (no graphics)
	0xF1: enHeadNULL, // Metroid Queen head left half (no graphics)
	0xF2: enHeadNULL, // Metroid Queen projectile/head right half (no graphics)
	0xF3: enHeadNULL, // Metroid Queen body (no graphics)
	0xF4: enHeadNULL, // (no graphics)
	0xF5: enHeadNULL, // Metroid Queen mouth closed (no graphics)
	0xF6: enHeadNULL, // Metroid Queen mouth open (no graphics)
	0xF7: enHeadNULL, // Metroid Queen mouth stunned (no graphics)
	Actor.missileDoor: enHeadMissileDoor, // Missile door
	0xF9: enHeadNULL, // (no graphics)
	0xFA: enHeadNULL, // (no graphics)
	0xFB: enHeadNULL, // (no graphics)
	0xFC: enHeadNULL, // (no graphics)
	0xFD: enHeadNULL, // Nothing - flitt (no graphics)
	0xFE: enHeadNULL, // ?
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
	8, // Tsumuri
	8, // Tsumuri
	8, // Tsumuri
	8, // Tsumuri
	16, // Skreek
	16, // Skreek
	16, // Skreek
	16, // Skreek
	3, // Skreek projectile
	16, // Drivel
	16, // Drivel
	16, // Drivel
	3, // Drivel projectile
	3, // Drivel projectile
	3, // Drivel projectile
	3, // Drivel projectile
	3, // Drivel projectile
	3, // Drivel projectile
	5, // Small bugs
	5, // Small bugs
	16, // Hornoad
	16, // Hornoad
	21, // Senjoo
	8, // Gawron
	8, // Gawron
	0, // Gawron spawner?
	0, // Gawron spawner?
	18, // Chute leech
	18, // Chute leech
	18, // Chute leech
	21, // (uses same spritemap as 41h autrack)
	21, // (uses same spritemap as 4Ah wallfire)
	16, // Needler
	16, // Needler
	16, // Needler
	16, // Needler
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	17, // Skorp
	17, // Skorp
	17, // Skorp
	17, // Skorp
	16, // Glow fly
	16, // Glow fly
	16, // Glow fly
	16, // Glow fly
	19, // Moheek
	19, // Moheek
	19, // Moheek
	19, // Moheek
	0, // Rock icicle
	8, // Rock icicle
	8, // Rock icicle
	8, // Rock icicle
	18, // Yumee
	18, // Yumee
	18, // Yumee
	18, // Yumee
	0, // Yumee spawner?
	0, // Yumee spawner?
	32, // Octroll
	32, // Octroll
	32, // Octroll
	21, // Autrack
	21, // Autrack
	21, // Autrack
	21, // Autrack
	16, // Autrack projectile
	21, // Autoad
	21, // Autoad
	0, // Sideways Autoad (unused)
	0, // Sideways Autoad (unused)
	21, // Wallfire
	21, // Wallfire
	solidEnemy, // Wallfire
	16, // Wallfire projectile
	16, // Wallfire projectile
	16, // Wallfire projectile
	16, // Wallfire projectile
	21, // Gunzoo
	21, // Gunzoo
	21, // Gunzoo
	8, // Gunzoo diagonal projectile
	8, // Gunzoo diagonal projectile
	8, // Gunzoo diagonal projectile
	8, // Gunzoo horizontal projectile
	8, // Gunzoo horizontal projectile (unused frame)
	8, // Gunzoo horizontal projectile
	8, // Gunzoo horizontal projectile
	8, // Gunzoo horizontal projectile
	21, // Autom
	21, // Autom
	16, // Autom projectile
	16, // Autom projectile
	16, // Autom projectile
	16, // Autom projectile
	16, // Autom projectile
	21, // Shirk
	21, // Shirk
	solidEnemy, // Septogg
	solidEnemy, // Septogg
	32, // Moto
	32, // Moto
	32, // Moto
	16, // Halzyn
	32, // Ramulken
	32, // Ramulken
	0, // Musical stinger event trigger
	solidEnemy, // (uses same spritemap as 72h proboscum)
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	solidEnemy, // Proboscum
	0, // Proboscum
	0, // Proboscum
	solidEnemy, // Missile block
	32, // Arachnus
	32, // Arachnus
	32, // Arachnus
	32, // Arachnus
	32, // Arachnus
	2, // Arachnus projectile
	2, // Arachnus projectile
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	solidEnemy, // Plasma beam orb
	0, // Plasma beam
	solidEnemy, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
	0, // Ice beam
	solidEnemy, // Wave beam orb
	0, // Wave beam
	solidEnemy, // Spazer beam orb
	0, // Spazer beam
	solidEnemy, // Bombs orb
	0, // Bombs
	solidEnemy, // Screw attack orb
	0, // Screw attack
	solidEnemy, // Varia suit orb
	0, // Varia suit
	solidEnemy, // Hi-jump boots orb
	0, // Hi-jump boots
	solidEnemy, // Space jump orb
	0, // Space jump
	solidEnemy, // (spider ball orb?)
	0, // Spider ball
	solidEnemy, // (spring ball orb?)
	0, // Spring ball
	solidEnemy, // (energy tank orb?)
	0, // Energy tank
	solidEnemy, // (missile tank orb?)
	0, // Missile tank
	48, // Blob thrower (sprite is written to WRAM)
	0, // Energy refill
	solidEnemy, // Arachnus orb
	0, // Missile refill
	16, // Blob thrower projectile
	16, // Blob thrower projectile
	drainsHealth, // Metroid
	0, // Metroid hatching
	0, // (no graphics)
	16, // Alpha metroid
	16, // Alpha metroid
	solidEnemy, // Baby metroid egg
	solidEnemy, // Baby metroid egg
	solidEnemy, // Baby metroid egg
	0, // Baby metroid
	0, // Baby metroid
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	21, // Gamma metroid
	21, // Gamma metroid projectile
	21, // Gamma metroid projectile
	21, // Gamma metroid
	0, // (no graphics)
	0, // Gamma metroid shell
	32, // Zeta metroid hatching
	32, // Zeta metroid
	32, // Zeta metroid
	32, // Zeta metroid
	32, // Zeta metroid
	32, // Zeta metroid
	32, // Zeta metroid
	0, // Zeta metroid
	0, // Zeta metroid
	0, // Zeta metroid
	0, // Zeta metroid
	16, // Zeta metroid projectile
	37, // Omega metroid
	37, // Omega metroid
	37, // Omega metroid
	37, // Omega metroid
	37, // Omega metroid
	0, // Omega metroid
	0, // Omega metroid
	18, // Omega metroid projectile
	18, // Omega metroid projectile
	18, // Omega metroid projectile
	18, // Omega metroid projectile
	18, // Omega metroid projectile
	18, // Omega metroid projectile
	18, // Omega metroid projectile
	18, // (omega metroid projectile?)
	drainsHealth, // Metroid
	drainsHealth, // Metroid (hurt)
	solidEnemy, // Flitt
	solidEnemy, // Flitt
	0, // Stalagtite (unused)
	16, // Gravitt
	16, // Gravitt
	16, // Gravitt
	16, // Gravitt
	16, // Gravitt
	18, // Gullugg
	18, // Gullugg
	18, // Gullugg
	0, // Baby metroid egg preview
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	0, // Small health drop
	0, // Small health drop
	0, // Metroid death / missile door / screw attack explosion
	0, // Metroid death / missile door / screw attack explosion
	0, // Metroid death / missile door / screw attack explosion
	0, // Metroid death / missile door / screw attack explosion
	0, // Metroid death / missile door / screw attack explosion
	0, // Metroid death / missile door / screw attack explosion
	0, // Enemy death explosion
	0, // Enemy death explosion
	0, // Enemy death explosion
	0, // Enemy death explosion (extra frame for enemies not dropping small health)
	0, // Big energy drop
	0, // Big energy drop
	0, // Missile drop
	0, // Missile drop
	64, // Metroid Queen neck (no graphics)
	64, // Metroid Queen head left half (no graphics)
	32, // Metroid Queen projectile/head right half (no graphics)
	64, // Metroid Queen body (no graphics)
	0, // (no graphics)
	64, // Metroid Queen mouth closed (no graphics)
	64, // Metroid Queen mouth open (no graphics)
	solidEnemy, // Metroid Queen mouth stunned (no graphics)
	solidEnemy, // Missile door
	solidEnemy, // (no graphics)
	solidEnemy, // (no graphics)
	0, // (no graphics)
	0, // (no graphics)
	0, // Nothing - flitt (no graphics)
	0, // ?
];
const Rectangle*[] enemyHitboxes = [
	&hitboxBlock, // Tsumuri
	&hitboxBlock, // Tsumuri
	&hitboxBlock, // Tsumuri
	&hitboxBlock, // Tsumuri
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

const OAMEntry[][] enemySpriteTable = [
    enSpriteTsumuriHoriFrame1, // Tsumuri
    enSpriteTsumuriHoriFrame2, // Tsumuri
    enSpriteTsumuriVertFrame1, // Tsumuri
    enSpriteTsumuriVertFrame2, // Tsumuri
    enSpriteSkreekFrame1, // Skreek
    enSpriteSkreekFrame2, // Skreek
    enSpriteSkreekFrame3, // Skreek
    enSpriteSkreekFrame4, // Skreek
    enSpriteSkreekSpit, // Skreek projectile
    enSpriteDrivelFrame1, // Drivel
    enSpriteDrivelFrame2, // Drivel
    enSpriteDrivelFrame3, // Drivel
    enSpriteDrivelSpitFrame1, // Drivel projectile
    enSpriteDrivelSpitFrame2, // Drivel projectile
    enSpriteDrivelSpitFrame3, // Drivel projectile
    enSpriteDrivelSpitFrame4, // Drivel projectile
    enSpriteDrivelSpitFrame5, // Drivel projectile
    enSpriteDrivelSpitFrame6, // Drivel projectile
    enSpriteSmallBugFrame1, // Small bugs
    enSpriteSmallBugFrame2, // Small bugs
    enSpriteHornoadFrame1, // Hornoad
    enSpriteHornoadFrame2, // Hornoad
    enSpriteSenjoo, // Senjoo
    enSpriteGawronFrame1, // Gawron
    enSpriteGawronFrame2, // Gawron
    enSpriteBlankTile, // Gawron spawner?
    enSpriteBlankTile, // Gawron spawner?
    enSpriteChuteLeechFrame1, // Chute leech
    enSpriteChuteLeechFrame2, // Chute leech
    enSpriteChuteLeechFrame3, // Chute leech
    enSpriteAutrackFrame1, // (uses same spritemap as 41h autrack)
    enSpriteWallfireFrame1, // (uses same spritemap as 4Ah wallfire)
    enSpriteNeedlerFrame1, // Needler
    enSpriteNeedlerFrame2, // Needler
    enSpriteNeedlerFrame1, // Needler
    enSpriteNeedlerFrame2, // Needler
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteSkorpVert, // Skorp
    enSpriteSkorpVert, // Skorp
    enSpriteSkorpHori, // Skorp
    enSpriteSkorpHori, // Skorp
    enSpriteGlowFlyFrame1, // Glow fly
    enSpriteGlowFlyFrame2, // Glow fly
    enSpriteGlowFlyFrame3, // Glow fly
    enSpriteGlowFlyFrame4, // Glow fly
    enSpriteMoheekHoriFrame1, // Moheek
    enSpriteMoheekHoriFrame2, // Moheek
    enSpriteMoheekVertFrame1, // Moheek
    enSpriteMoheekVertFrame2, // Moheek
    enSpriteRockIcicleFrame1, // Rock icicle
    enSpriteRockIcicleFrame2, // Rock icicle
    enSpriteRockIcicleFrame3, // Rock icicle
    enSpriteRockIcicleFrame4, // Rock icicle
    enSpriteYumeeFrame1, // Yumee
    enSpriteYumeeFrame2, // Yumee
    enSpriteYumeeFrame3, // Yumee
    enSpriteYumeeFrame4, // Yumee
    enSpriteBlankTile, // Yumee spawner?
    enSpriteBlankTile, // Yumee spawner?
    enSpriteOctrollFrame1, // Octroll
    enSpriteOctrollFrame2, // Octroll
    enSpriteOctrollFrame3, // Octroll
    enSpriteAutrackFrame1, // Autrack
    enSpriteAutrackFrame2, // Autrack
    enSpriteAutrackFrame3, // Autrack
    enSpriteAutrackFrame4, // Autrack
    enSpriteAutrackShot, // Autrack projectile
    enSpriteAutoadFrame1, // Autoad
    enSpriteAutoadFrame2, // Autoad
    enSpriteSideAutoadFrame1, // Sideways Autoad (unused)
    enSpriteSideAutoadFrame2, // Sideways Autoad (unused)
    enSpriteWallfireFrame1, // Wallfire
    enSpriteWallfireFrame2, // Wallfire
    enSpriteWallfireBroken, // Wallfire
    enSpriteWallfireShotFrame1, // Wallfire projectile
    enSpriteWallfireShotFrame2, // Wallfire projectile
    enSpriteWallfireShotFrame3, // Wallfire projectile
    enSpriteWallfireShotFrame4, // Wallfire projectile
    enSpriteGunzooFrame1, // Gunzoo
    enSpriteGunzooFrame2, // Gunzoo
    enSpriteGunzooFrame3, // Gunzoo
    enSpriteGunzooShotDiagFrame1, // Gunzoo diagonal projectile
    enSpriteGunzooShotDiagFrame2, // Gunzoo diagonal projectile
    enSpriteGunzooShotDiagFrame3, // Gunzoo diagonal projectile
    enSpriteGunzooShotHoriFrame1, // Gunzoo horizontal projectile
    enSpriteGunzooShotHoriFrame2, // Gunzoo horizontal projectile (unused frame)
    enSpriteGunzooShotHoriFrame3, // Gunzoo horizontal projectile
    enSpriteGunzooShotHoriFrame4, // Gunzoo horizontal projectile
    enSpriteGunzooShotHoriFrame5, // Gunzoo horizontal projectile
    enSpriteAutomFrame1, // Autom
    enSpriteAutomFrame2, // Autom
    enSpriteAutomShotFrame1, // Autom projectile
    enSpriteAutomShotFrame2, // Autom projectile
    enSpriteAutomShotFrame3, // Autom projectile
    enSpriteAutomShotFrame4, // Autom projectile
    enSpriteAutomShotFrame5, // Autom projectile
    enSpriteShirkFrame1, // Shirk
    enSpriteShirkFrame2, // Shirk
    enSpriteSeptoggFrame1, // Septogg
    enSpriteSeptoggFrame2, // Septogg
    enSpriteMotoFrame1, // Moto
    enSpriteMotoFrame2, // Moto
    enSpriteMotoFrame3, // Moto
    enSpriteHalzyn, // Halzyn
    enSpriteRamulkenFrame1, // Ramulken
    enSpriteRamulkenFrame2, // Ramulken
    enSpriteBlankTile, // Musical stinger event trigger
    enSpriteProboscumFrame1, // (uses same spritemap as 72h proboscum)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteProboscumFrame1, // Proboscum
    enSpriteProboscumFrame2, // Proboscum
    enSpriteProboscumFrame3, // Proboscum
    enSpriteMissileBlock, // Missile block
    enSpriteArachnusFrame1, // Arachnus
    enSpriteArachnusFrame2, // Arachnus
    enSpriteArachnusFrame3, // Arachnus
    enSpriteArachnusFrame4, // Arachnus
    enSpriteArachnusFrame5, // Arachnus
    enSpriteArachnusShotFrame1, // Arachnus projectile
    enSpriteArachnusShotFrame2, // Arachnus projectile
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteItemOrb, // Plasma beam orb
    enSpriteItem, // Plasma beam
    enSpriteItemOrb, // Ice beam orb (and bent neck of Queen’s vomiting pose!?)
    enSpriteItem, // Ice beam
    enSpriteItemOrb, // Wave beam orb
    enSpriteItem, // Wave beam
    enSpriteItemOrb, // Spazer beam orb
    enSpriteItem, // Spazer beam
    enSpriteItemOrb, // Bombs orb
    enSpriteItem, // Bombs
    enSpriteItemOrb, // Screw attack orb
    enSpriteItem, // Screw attack
    enSpriteItemOrb, // Varia suit orb
    enSpriteItem, // Varia suit
    enSpriteItemOrb, // Hi-jump boots orb
    enSpriteItem, // Hi-jump boots
    enSpriteItemOrb, // Space jump orb
    enSpriteItem, // Space jump
    enSpriteItemOrb, // (spider ball orb?)
    enSpriteItem, // Spider ball
    enSpriteItemOrb, // (spring ball orb?)
    enSpriteItem, // Spring ball
    enSpriteItemOrb, // (energy tank orb?)
    enSpriteEnergyTank, // Energy tank
    enSpriteItemOrb, // (missile tank orb?)
    enSpriteMissileTank, // Missile tank
    null, // Blob thrower (sprite is written to WRAM)
    enSpriteEnergyRefill, // Energy refill
    enSpriteItemOrb, // Arachnus orb
    enSpriteMissileRefill, // Missile refill
    enSpriteBlobFrame1, // Blob thrower projectile
    enSpriteBlobFrame2, // Blob thrower projectile
    enSpriteMetroidFrame1, // Metroid
    enSpriteAlphaFace, // Metroid hatching
    enSpriteNone, // (no graphics)
    enSpriteAlphaFrame1, // Alpha metroid
    enSpriteAlphaFrame2, // Alpha metroid
    enSpriteEggFrame1, // Baby metroid egg
    enSpriteEggFrame2, // Baby metroid egg
    enSpriteEggFrame3, // Baby metroid egg
    enSpriteBabyFrame1, // Baby metroid
    enSpriteBabyFrame2, // Baby metroid
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteGammaFrame1, // Gamma metroid
    enSpriteGammaBoltFrame1, // Gamma metroid projectile
    enSpriteGammaBoltFrame2, // Gamma metroid projectile
    enSpriteGammaFrame2, // Gamma metroid
    enSpriteNone, // (no graphics)
    enSpriteGammaHusk, // Gamma metroid shell
    enSpriteZetaFrame1, // Zeta metroid hatching
    enSpriteZetaFrame2, // Zeta metroid
    enSpriteZetaFrame3, // Zeta metroid
    enSpriteZetaFrame4, // Zeta metroid
    enSpriteZetaFrame5, // Zeta metroid
    enSpriteZetaFrame6, // Zeta metroid
    enSpriteZetaFrame7, // Zeta metroid
    enSpriteZetaFrame8, // Zeta metroid
    enSpriteZetaFrame9, // Zeta metroid
    enSpriteZetaFrameA, // Zeta metroid
    enSpriteZetaFrameB, // Zeta metroid
    enSpriteZetaShot, // Zeta metroid projectile
    enSpriteOmegaFrame1, // Omega metroid
    enSpriteOmegaFrame2, // Omega metroid
    enSpriteOmegaFrame3, // Omega metroid
    enSpriteOmegaFrame4, // Omega metroid
    enSpriteOmegaFrame5, // Omega metroid
    enSpriteOmegaFrame6, // Omega metroid
    enSpriteOmegaFrame7, // Omega metroid
    enSpriteOmegaShotFrame1, // Omega metroid projectile
    enSpriteOmegaShotFrame2, // Omega metroid projectile
    enSpriteOmegaShotFrame3, // Omega metroid projectile
    enSpriteOmegaShotFrame4, // Omega metroid projectile
    enSpriteOmegaShotFrame5, // Omega metroid projectile
    enSpriteOmegaShotFrame6, // Omega metroid projectile
    enSpriteOmegaShotFrame7, // Omega metroid projectile
    enSpriteOmegaShotFrame8, // (omega metroid projectile?)
    enSpriteMetroidFrame2, // Metroid
    enSpriteMetroidFrame3, // Metroid (hurt)
    enSpriteFlittFrame1, // Flitt
    enSpriteFlittFrame2, // Flitt
    enSpriteStalagtite, // Stalagtite (unused)
    enSpriteGravittFrame1, // Gravitt
    enSpriteGravittFrame1, // Gravitt
    enSpriteGravittFrame2, // Gravitt
    enSpriteGravittFrame1, // Gravitt
    enSpriteGravittFrame3, // Gravitt
    enSpriteGulluggFrame1, // Gullugg
    enSpriteGulluggFrame2, // Gullugg
    enSpriteGulluggFrame3, // Gullugg
    enSpriteEggFrame2, // Baby metroid egg preview
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteSmallHealthFrame1, // Small health drop
    enSpriteSmallHealthFrame2, // Small health drop
    enSpriteBigExplosionFrame1, // Metroid death / missile door / screw attack explosion
    enSpriteBigExplosionFrame2, // Metroid death / missile door / screw attack explosion
    enSpriteBigExplosionFrame3, // Metroid death / missile door / screw attack explosion
    enSpriteBigExplosionFrame4, // Metroid death / missile door / screw attack explosion
    enSpriteBigExplosionFrame5, // Metroid death / missile door / screw attack explosion
    enSpriteBigExplosionFrame6, // Metroid death / missile door / screw attack explosion
    enSpriteSmallExplosionFrame1, // Enemy death explosion
    enSpriteSmallExplosionFrame2, // Enemy death explosion
    enSpriteSmallExplosionFrame3, // Enemy death explosion
    enSpriteSmallExplosionFrame4, // Enemy death explosion (extra frame for enemies not dropping small health)
    enSpriteBigHealthFrame1, // Big energy drop
    enSpriteBigHealthFrame2, // Big energy drop
    enSpriteMissileDropFrame1, // Missile drop
    enSpriteMissileDropFrame2, // Missile drop
    enSpriteNone, // Metroid Queen neck (no graphics)
    enSpriteNone, // Metroid Queen head left half (no graphics)
    enSpriteNone, // Metroid Queen projectile/head right half (no graphics)
    enSpriteNone, // Metroid Queen body (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // Metroid Queen mouth closed (no graphics)
    enSpriteNone, // Metroid Queen mouth open (no graphics)
    enSpriteNone, // Metroid Queen mouth stunned (no graphics)
    enSpriteMissileDoor, // Missile door
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // (no graphics)
    enSpriteNone, // Nothing - flitt (no graphics)
    enSpriteBlankTile, // ?
];

immutable OAMEntry[] enSpriteNone = [
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBlankTile = [
    OAMEntry(-4, -4, 0xFF, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteTsumuriHoriFrame1 = [
    OAMEntry(-8, -8, 0xB4, 0x00),
    OAMEntry(-8, 0, 0xB5, 0x00),
    OAMEntry(0, -8, 0xB6, 0x00),
    OAMEntry(0, 0, 0xB7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteTsumuriHoriFrame2 = [
    OAMEntry(-8, -8, 0xB4, 0x00),
    OAMEntry(-8, 0, 0xB5, 0x00),
    OAMEntry(0, -8, 0xB9, 0x00),
    OAMEntry(0, 0, 0xB8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteTsumuriVertFrame1 = [
    OAMEntry(-8, -8, 0xBA, 0x00),
    OAMEntry(-8, 0, 0xBB, 0x00),
    OAMEntry(0, -8, 0xBC, 0x00),
    OAMEntry(0, 0, 0xBD, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteTsumuriVertFrame2 = [
    OAMEntry(-8, -8, 0xBA, 0x00),
    OAMEntry(-8, 0, 0xBE, 0x00),
    OAMEntry(0, -8, 0xBC, 0x00),
    OAMEntry(0, 0, 0xBF, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSkreekFrame1 = [
    OAMEntry(-6,-12, 0xC0, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0, -4, 0xC3, 0x00),
    OAMEntry(0, 4, 0xC4, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSkreekFrame2 = [
    OAMEntry(-6,-12, 0xC5, 0x00),
    OAMEntry(-8, -4, 0xC6, 0x00),
    OAMEntry(-8, 4, 0xC7, 0x00),
    OAMEntry(0, -4, 0xC8, 0x00),
    OAMEntry(0, 4, 0xC9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSkreekFrame3 = [
    OAMEntry(-6,-12, 0xCA, 0x00),
    OAMEntry(-8, -4, 0xCB, 0x00),
    OAMEntry(-8, 4, 0xCC, 0x00),
    OAMEntry(0, -4, 0xCD, 0x00),
    OAMEntry(0, 4, 0xCE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSkreekFrame4 = [
    OAMEntry(-8,-12, 0xCF, 0x00),
    OAMEntry(-8, -4, 0xD0, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD1, 0x00),
    OAMEntry(0, -4, 0xD2, 0x00),
    OAMEntry(0, 4, 0xC4, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSkreekSpit = [
    OAMEntry(-4, -4, 0xD3, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteDrivelFrame1 = [
    OAMEntry(-4,-16, 0xD4, 0x00),
    OAMEntry(-4, -8, 0xD5, 0x00),
    OAMEntry(-4, 0, 0xD5, 0x20),
    OAMEntry(-4, 8, 0xD4, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelFrame2 = [
    OAMEntry(-4,-16, 0xD7, 0x00),
    OAMEntry(-4, -8, 0xD8, 0x00),
    OAMEntry(-4, 0, 0xD8, 0x20),
    OAMEntry(-4, 8, 0xD7, 0x20),
    OAMEntry(4,-16, 0xD6, 0x00),
    OAMEntry(4, 8, 0xD6, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelFrame3 = [
    OAMEntry(-4, -8, 0xDA, 0x00),
    OAMEntry(-4, 0, 0xDA, 0x20),
    OAMEntry(4, -8, 0xD9, 0x00),
    OAMEntry(4, 0, 0xD9, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelSpitFrame1 = [
    OAMEntry(-4, -4, 0xDB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelSpitFrame2 = [
    OAMEntry(-4, -4, 0xDC, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelSpitFrame3 = [
    OAMEntry(-4, -4, 0xDD, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelSpitFrame4 = [
    OAMEntry(-4, -8, 0xDE, 0x00),
    OAMEntry(-4, 0, 0xDE, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelSpitFrame5 = [
    OAMEntry(-12, -4, 0xDF, 0x00),
    OAMEntry(-10,-10, 0xE0, 0x00),
    OAMEntry(-10, 2, 0xE0, 0x20),
    OAMEntry(-4,-12, 0xE1, 0x00),
    OAMEntry(-4, 4, 0xE1, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteDrivelSpitFrame6 = [
    OAMEntry(-25, -4, 0xDF, 0x00),
    OAMEntry(-17,-17, 0xE0, 0x00),
    OAMEntry(-17, 9, 0xE0, 0x20),
    OAMEntry(-4,-20, 0xE1, 0x00),
    OAMEntry(-4, 12, 0xE1, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSmallBugFrame1 = [
    OAMEntry(-4, -8, 0xB0, 0x00),
    OAMEntry(-4, 0, 0xB1, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSmallBugFrame2 = [
    OAMEntry(-4, -8, 0xB2, 0x00),
    OAMEntry(-4, 0, 0xB3, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteHornoadFrame1 = [
    OAMEntry(-8,-12, 0xE2, 0x00),
    OAMEntry(-8, -4, 0xE3, 0x00),
    OAMEntry(-8, 4, 0xE4, 0x00),
    OAMEntry(0,-12, 0xE5, 0x00),
    OAMEntry(0, -4, 0xE6, 0x00),
    OAMEntry(0, 4, 0xE7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteHornoadFrame2 = [
    OAMEntry(-8,-12, 0xE2, 0x00),
    OAMEntry(-8, -4, 0xE3, 0x00),
    OAMEntry(-8, 4, 0xE4, 0x00),
    OAMEntry(0,-12, 0xE5, 0x00),
    OAMEntry(0, -4, 0xE8, 0x00),
    OAMEntry(0, 4, 0xE9, 0x00),
    OAMEntry(8, 4, 0xEA, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSeptoggFrame1 = [
    OAMEntry(-12, -8, 0xEB, 0x00),
    OAMEntry(-12, 0, 0xEB, 0x20),
    OAMEntry(-4,-12, 0xEC, 0x00),
    OAMEntry(-4, -4, 0xED, 0x00),
    OAMEntry(-4, 4, 0xEC, 0x20),
    OAMEntry(4, -8, 0xEF, 0x00),
    OAMEntry(4, 0, 0xEF, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSeptoggFrame2 = [
    OAMEntry(-12, -8, 0xEB, 0x00),
    OAMEntry(-12, 0, 0xEB, 0x20),
    OAMEntry(-4,-12, 0xEE, 0x00),
    OAMEntry(-4, -4, 0xED, 0x00),
    OAMEntry(-4, 4, 0xEE, 0x20),
    OAMEntry(4, -8, 0xEF, 0x00),
    OAMEntry(4, 0, 0xEF, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSenjoo = [
    OAMEntry(-8,-12, 0xB4, 0x00),
    OAMEntry(-8, -4, 0xB5, 0x00),
    OAMEntry(-8, 4, 0xB6, 0x00),
    OAMEntry(0,-12, 0xB7, 0x00),
    OAMEntry(0, -4, 0xB8, 0x00),
    OAMEntry(0, 4, 0xB9, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGawronFrame1 = [
    OAMEntry(-8, -8, 0xBC, 0x00),
    OAMEntry(-8, 0, 0xBD, 0x00),
    OAMEntry(0, -8, 0xBE, 0x00),
    OAMEntry(0, 0, 0xBF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGawronFrame2 = [
    OAMEntry(-8, -8, 0xC0, 0x00),
    OAMEntry(-8, 0, 0xC1, 0x00),
    OAMEntry(0, -8, 0xBE, 0x00),
    OAMEntry(0, 0, 0xBF, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteChuteLeechFrame1 = [
    OAMEntry(-4,-12, 0xC2, 0x00),
    OAMEntry(-4, -4, 0xC3, 0x00),
    OAMEntry(-4, 4, 0xC2, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteChuteLeechFrame2 = [
    OAMEntry(-8, -8, 0xC5, 0x00),
    OAMEntry(-8, 0, 0xC5, 0x20),
    OAMEntry(0, -8, 0xC4, 0x00),
    OAMEntry(0, 0, 0xC4, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteChuteLeechFrame3 = [
    OAMEntry(-8, -4, 0xC9, 0x00),
    OAMEntry(-8, 4, 0xCA, 0x00),
    OAMEntry(0,-12, 0xC6, 0x00),
    OAMEntry(0, -4, 0xC7, 0x00),
    OAMEntry(0, 4, 0xC8, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGulluggFrame1 = [
    OAMEntry(-12,-16, 0xCB, 0x00),
    OAMEntry(-12, -8, 0xCC, 0x00),
    OAMEntry(-12, 0, 0xCC, 0x20),
    OAMEntry(-12, 8, 0xCB, 0x20),
    OAMEntry(-4, -8, 0xCD, 0x00),
    OAMEntry(-4, 0, 0xCE, 0x00),
    OAMEntry(4, 0, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGulluggFrame2 = [
    OAMEntry(-12,-16, 0xD0, 0x00),
    OAMEntry(-12, -8, 0xD1, 0x00),
    OAMEntry(-12, 0, 0xD1, 0x20),
    OAMEntry(-12, 8, 0xD0, 0x20),
    OAMEntry(-4, -8, 0xCD, 0x00),
    OAMEntry(-4, 0, 0xCE, 0x00),
    OAMEntry(4, 0, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGulluggFrame3 = [
    OAMEntry(-12, -8, 0xD2, 0x00),
    OAMEntry(-12, 0, 0xD2, 0x20),
    OAMEntry(-4, -8, 0xCD, 0x00),
    OAMEntry(-4, 0, 0xCE, 0x00),
    OAMEntry(4, 0, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteNeedlerFrame1 = [
    OAMEntry(-8, -8, 0xE6, 0x00),
    OAMEntry(-8, 0, 0xE7, 0x00),
    OAMEntry(0, -8, 0xE8, 0x00),
    OAMEntry(0, 0, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteNeedlerFrame2 = [
    OAMEntry(-8, -8, 0xEA, 0x00),
    OAMEntry(-8, 0, 0xEB, 0x00),
    OAMEntry(0, -8, 0xEC, 0x00),
    OAMEntry(0, 0, 0xED, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSkorpVert = [
    OAMEntry(-12, -8, 0xB4, 0x00),
    OAMEntry(-12, 0, 0xB4, 0x00),
    OAMEntry(-4, -8, 0xB6, 0x00),
    OAMEntry(-4, 0, 0xB7, 0x00),
    OAMEntry(4, -8, 0xB8, 0x00),
    OAMEntry(4, 0, 0xB9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSkorpHori = [
    OAMEntry(-8,-12, 0xBA, 0x00),
    OAMEntry(-8, -4, 0xBB, 0x00),
    OAMEntry(-8, 4, 0xB4, 0x00),
    OAMEntry(0,-12, 0xBC, 0x00),
    OAMEntry(0, -4, 0xBD, 0x00),
    OAMEntry(0, 4, 0xB4, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGlowFlyFrame1 = [
    OAMEntry(-12, -4, 0xBE, 0x00),
    OAMEntry(-4, -4, 0xBF, 0x00),
    OAMEntry(4, -4, 0xC1, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGlowFlyFrame2 = [
    OAMEntry(-12, -4, 0xBE, 0x00),
    OAMEntry(-4, -4, 0xBF, 0x00),
    OAMEntry(4, -4, 0xC0, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGlowFlyFrame3 = [
    OAMEntry(-8, -8, 0xC2, 0x00),
    OAMEntry(-8, 0, 0xC3, 0x00),
    OAMEntry(0, -8, 0xC4, 0x00),
    OAMEntry(0, 0, 0xC5, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGlowFlyFrame4 = [
    OAMEntry(-8, -8, 0xC6, 0x00),
    OAMEntry(-8, 0, 0xC7, 0x00),
    OAMEntry(0, -8, 0xC8, 0x00),
    OAMEntry(0, 0, 0xC9, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteRockIcicleFrame1 = [
    OAMEntry(-4, -4, 0xD2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteRockIcicleFrame2 = [
    OAMEntry(-4, -4, 0xD3, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteRockIcicleFrame3 = [
    OAMEntry(-8, -4, 0xD4, 0x00),
    OAMEntry(0, -4, 0xD5, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteRockIcicleFrame4 = [
    OAMEntry(-8, -4, 0xD4, 0x00),
    OAMEntry(0, -4, 0xD6, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteMoheekHoriFrame1 = [
    OAMEntry(-8, -8, 0xD7, 0x00),
    OAMEntry(-8, 0, 0xD8, 0x00),
    OAMEntry(0, -8, 0xDB, 0x00),
    OAMEntry(0, 0, 0xDC, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMoheekHoriFrame2 = [
    OAMEntry(-8, -8, 0xD9, 0x00),
    OAMEntry(-8, 0, 0xDA, 0x00),
    OAMEntry(0, -8, 0xDB, 0x00),
    OAMEntry(0, 0, 0xDD, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMoheekVertFrame1 = [
    OAMEntry(-8, -8, 0xDE, 0x00),
    OAMEntry(-8, 0, 0xDF, 0x00),
    OAMEntry(0, -8, 0xE1, 0x00),
    OAMEntry(0, 0, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMoheekVertFrame2 = [
    OAMEntry(-8, -8, 0xE3, 0x00),
    OAMEntry(-8, 0, 0xE0, 0x00),
    OAMEntry(0, -8, 0xE4, 0x00),
    OAMEntry(0, 0, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteYumeeFrame1 = [
    OAMEntry(-8, -8, 0xE5, 0x00),
    OAMEntry(-8, 0, 0xE9, 0x00),
    OAMEntry(0, 0, 0xEA, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteYumeeFrame2 = [
    OAMEntry(-8, -8, 0xE5, 0x00),
    OAMEntry(-8, 0, 0xE9, 0x00),
    OAMEntry(0, 0, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteYumeeFrame3 = [
    OAMEntry(-8, -8, 0xE5, 0x00),
    OAMEntry(-8, 0, 0xE6, 0x00),
    OAMEntry(-8, 8, 0xE7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteYumeeFrame4 = [
    OAMEntry(-8, -8, 0xE5, 0x00),
    OAMEntry(-8, 0, 0xE6, 0x00),
    OAMEntry(-8, 8, 0xE8, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteFlittFrame1 = [
    OAMEntry(-8, -8, 0xCA, 0x00),
    OAMEntry(-8, 0, 0xCB, 0x00),
    OAMEntry(0, -8, 0xCC, 0x00),
    OAMEntry(0, 0, 0xCD, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteFlittFrame2 = [
    OAMEntry(-8, -8, 0xCE, 0x00),
    OAMEntry(-8, 0, 0xCF, 0x00),
    OAMEntry(0, -8, 0xD0, 0x00),
    OAMEntry(0, 0, 0xD1, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteStalagtite = [
    OAMEntry(-8, -8, 0xEC, 0x00),
    OAMEntry(-8, 0, 0xED, 0x00),
    OAMEntry(0, -4, 0xEE, 0x00),
    OAMEntry(8, -4, 0xEF, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteOctrollFrame1 = [
    OAMEntry(-8, -8, 0xB4, 0x00),
    OAMEntry(-8, 0, 0xB4, 0x20),
    OAMEntry(0,-16, 0xB5, 0x00),
    OAMEntry(0, -8, 0xB6, 0x00),
    OAMEntry(0, 0, 0xB6, 0x20),
    OAMEntry(0, 8, 0xB5, 0x20),
    OAMEntry(8, -8, 0xB7, 0x00),
    OAMEntry(8, 0, 0xB7, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOctrollFrame2 = [
    OAMEntry(-8, -8, 0xB4, 0x00),
    OAMEntry(-8, 0, 0xB4, 0x20),
    OAMEntry(0,-16, 0xBA, 0x00),
    OAMEntry(0, -8, 0xB6, 0x00),
    OAMEntry(0, 0, 0xB6, 0x20),
    OAMEntry(0, 8, 0xBA, 0x20),
    OAMEntry(8, -8, 0xB7, 0x00),
    OAMEntry(8, 0, 0xB7, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOctrollFrame3 = [
    OAMEntry(-8, -8, 0xB4, 0x00),
    OAMEntry(-8, 0, 0xB4, 0x20),
    OAMEntry(0,-16, 0xB8, 0x00),
    OAMEntry(0, -8, 0xB9, 0x00),
    OAMEntry(0, 0, 0xB9, 0x20),
    OAMEntry(0, 8, 0xB8, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteAutrackFrame1 = [
    OAMEntry(-8, -8, 0xBB, 0x00),
    OAMEntry(-8, 0, 0xBC, 0x00),
    OAMEntry(0, -8, 0xBD, 0x00),
    OAMEntry(0, 0, 0xBE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutrackFrame2 = [
    OAMEntry(-16, -8, 0xBF, 0x00),
    OAMEntry(-16, 0, 0xC0, 0x00),
    OAMEntry(-8, -8, 0xC1, 0x00),
    OAMEntry(-8, 0, 0xC2, 0x00),
    OAMEntry(0, -8, 0xBD, 0x00),
    OAMEntry(0, 0, 0xBE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutrackFrame3 = [
    OAMEntry(-24, -8, 0xBF, 0x00),
    OAMEntry(-24, 0, 0xC0, 0x00),
    OAMEntry(-16, -8, 0xC3, 0x00),
    OAMEntry(-16, 0, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC1, 0x00),
    OAMEntry(-8, 0, 0xC2, 0x00),
    OAMEntry(0, -8, 0xBD, 0x00),
    OAMEntry(0, 0, 0xBE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutrackFrame4 = [
    OAMEntry(-24, -8, 0xC5, 0x00),
    OAMEntry(-24, 0, 0xC0, 0x00),
    OAMEntry(-16, -8, 0xC3, 0x00),
    OAMEntry(-16, 0, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC1, 0x00),
    OAMEntry(-8, 0, 0xC2, 0x00),
    OAMEntry(0, -8, 0xBD, 0x00),
    OAMEntry(0, 0, 0xBE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutrackShot = [
    OAMEntry(-4, -8, 0xC6, 0x00),
    OAMEntry(-4, 0, 0xC6, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteAutoadFrame1 = [
    OAMEntry(-8,-12, 0xC8, 0x00),
    OAMEntry(-8, -4, 0xC9, 0x00),
    OAMEntry(-8, 4, 0xC8, 0x20),
    OAMEntry(0,-12, 0xCA, 0x00),
    OAMEntry(0, -4, 0xCB, 0x00),
    OAMEntry(0, 4, 0xCA, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutoadFrame2 = [
    OAMEntry(-8,-12, 0xC8, 0x00),
    OAMEntry(-8, -4, 0xCF, 0x00),
    OAMEntry(-8, 4, 0xC8, 0x20),
    OAMEntry(0,-12, 0xCC, 0x00),
    OAMEntry(0, -4, 0xCD, 0x00),
    OAMEntry(0, 4, 0xCC, 0x20),
    OAMEntry(8,-10, 0xCE, 0x00),
    OAMEntry(8, 2, 0xCE, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSideAutoadFrame1 = [
    OAMEntry(-12, -8, 0xD0, 0x00),
    OAMEntry(-12, 0, 0xD1, 0x00),
    OAMEntry(-4, -8, 0xD2, 0x00),
    OAMEntry(-4, 0, 0xD3, 0x00),
    OAMEntry(4, -8, 0xD0, 0x40),
    OAMEntry(4, 0, 0xD1, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSideAutoadFrame2 = [
    OAMEntry(-12, -8, 0xD0, 0x00),
    OAMEntry(-12, 0, 0xD4, 0x00),
    OAMEntry(-10, 8, 0xD6, 0x00),
    OAMEntry(-4, -8, 0xD7, 0x00),
    OAMEntry(-4, 0, 0xD5, 0x00),
    OAMEntry(2, 8, 0xD6, 0x40),
    OAMEntry(4, -8, 0xD0, 0x40),
    OAMEntry(4, 0, 0xD4, 0x40),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteWallfireFrame1 = [
    OAMEntry(-12, -4, 0xD8, 0x00),
    OAMEntry(-12, 4, 0xD9, 0x00),
    OAMEntry(-4, -4, 0xDA, 0x00),
    OAMEntry(-4, 4, 0xDB, 0x00),
    OAMEntry(4, -4, 0xDC, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteWallfireFrame2 = [
    OAMEntry(-12, -4, 0xDD, 0x00),
    OAMEntry(-12, 4, 0xDE, 0x00),
    OAMEntry(-4, -4, 0xDA, 0x00),
    OAMEntry(-4, 4, 0xE0, 0x00),
    OAMEntry(4, -4, 0xDC, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteWallfireBroken = [
    OAMEntry(-12, -4, 0xE5, 0x00),
    OAMEntry(-4, -4, 0xE6, 0x00),
    OAMEntry(4, -4, 0xE7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteWallfireShotFrame1 = [
    OAMEntry(-4,-12, 0xE1, 0x00),
    OAMEntry(-4, -4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteWallfireShotFrame2 = [
    OAMEntry(-4, -4, 0xE3, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteWallfireShotFrame3 = [
    OAMEntry(-8, -4, 0xE4, 0x00),
    OAMEntry(0, -4, 0xE4, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteWallfireShotFrame4 = [
    OAMEntry(-16, -4, 0xE4, 0x00),
    OAMEntry(8, -4, 0xE4, 0x40),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGunzooFrame1 = [
    OAMEntry(-12,-12, 0xB4, 0x00),
    OAMEntry(-12, -4, 0xB5, 0x00),
    OAMEntry(-12, 4, 0xB6, 0x00),
    OAMEntry(-4,-12, 0xB7, 0x00),
    OAMEntry(-4, -4, 0xB8, 0x00),
    OAMEntry(-4, 4, 0xB9, 0x00),
    OAMEntry(4,-12, 0xBA, 0x00),
    OAMEntry(4, -4, 0xBB, 0x00),
    OAMEntry(4, 4, 0xBC, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooFrame2 = [
    OAMEntry(-12,-12, 0xBD, 0x00),
    OAMEntry(-12, -4, 0xB5, 0x00),
    OAMEntry(-12, 4, 0xBF, 0x00),
    OAMEntry(-12, 12, 0xC0, 0x00),
    OAMEntry(-4,-12, 0xB7, 0x00),
    OAMEntry(-4, -4, 0xCD, 0x00),
    OAMEntry(-4, 4, 0xC1, 0x00),
    OAMEntry(-4, 12, 0xC2, 0x00),
    OAMEntry(4,-12, 0xBA, 0x00),
    OAMEntry(4, -4, 0xC3, 0x00),
    OAMEntry(4, 4, 0xC4, 0x00),
    OAMEntry(4, 12, 0xC5, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooFrame3 = [
    OAMEntry(-12,-12, 0xB4, 0x00),
    OAMEntry(-12, -4, 0xB5, 0x00),
    OAMEntry(-12, 4, 0xBF, 0x00),
    OAMEntry(-12, 12, 0xC0, 0x00),
    OAMEntry(-4,-12, 0xBE, 0x00),
    OAMEntry(-4, -4, 0xCD, 0x00),
    OAMEntry(-4, 4, 0xC1, 0x00),
    OAMEntry(-4, 12, 0xC2, 0x00),
    OAMEntry(4,-12, 0xBA, 0x00),
    OAMEntry(4, -4, 0xC3, 0x00),
    OAMEntry(4, 4, 0xC4, 0x00),
    OAMEntry(4, 12, 0xC5, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGunzooShotDiagFrame1 = [
    OAMEntry(-4, -4, 0xCE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooShotDiagFrame2 = [
    OAMEntry(-8, -4, 0xD0, 0x00),
    OAMEntry(0, -4, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooShotDiagFrame3 = [
    OAMEntry(-16, -4, 0xD2, 0x00),
    OAMEntry(-8, -4, 0xD1, 0x00),
    OAMEntry(0, -4, 0xD0, 0x00),
    OAMEntry(8, -4, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGunzooShotHoriFrame1 = [
    OAMEntry(-4, -4, 0xC6, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooShotHoriFrame2 = [
    OAMEntry(-4, -4, 0xC7, 0x00),
    OAMEntry(-4, 4, 0xC8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooShotHoriFrame3 = [
    OAMEntry(-8, -4, 0xC9, 0x00),
    OAMEntry(0, -4, 0xC9, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooShotHoriFrame4 = [
    OAMEntry(-20, -4, 0xCA, 0x00),
    OAMEntry(-12, -4, 0xCB, 0x00),
    OAMEntry(4, -4, 0xCB, 0x40),
    OAMEntry(12, -4, 0xCA, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGunzooShotHoriFrame5 = [
    OAMEntry(-24, -4, 0xCC, 0x00),
    OAMEntry(16, -4, 0xCC, 0x40),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteAutomFrame1 = [
    OAMEntry(-12,-12, 0xD3, 0x00),
    OAMEntry(-12, -4, 0xD4, 0x00),
    OAMEntry(-4,-12, 0xD5, 0x00),
    OAMEntry(-4, -4, 0xD6, 0x00),
    OAMEntry(-4, 4, 0xD7, 0x00),
    OAMEntry(4, -4, 0xD8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutomFrame2 = [
    OAMEntry(-12,-12, 0xD3, 0x00),
    OAMEntry(-12, -4, 0xD4, 0x00),
    OAMEntry(-4,-12, 0xE0, 0x00),
    OAMEntry(-4, -4, 0xD6, 0x00),
    OAMEntry(-4, 4, 0xD7, 0x00),
    OAMEntry(4, -4, 0xD8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutomShotFrame1 = [
    OAMEntry(-4, -4, 0xD9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutomShotFrame2 = [
    OAMEntry(-12, -4, 0xDA, 0x00),
    OAMEntry(-4, -4, 0xDB, 0x00),
    OAMEntry(4, -4, 0xD9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutomShotFrame3 = [
    OAMEntry(-20, -4, 0xDB, 0x00),
    OAMEntry(-12, -4, 0xDA, 0x00),
    OAMEntry(-4, -4, 0xDB, 0x00),
    OAMEntry(4, -4, 0xDA, 0x00),
    OAMEntry(12, -4, 0xD9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutomShotFrame4 = [
    OAMEntry(-20, -4, 0xDA, 0x00),
    OAMEntry(-12, -4, 0xDB, 0x00),
    OAMEntry(-4, -4, 0xDA, 0x00),
    OAMEntry(4, -4, 0xDB, 0x00),
    OAMEntry(12,-12, 0xDC, 0x00),
    OAMEntry(12, -4, 0xDD, 0x00),
    OAMEntry(12, 4, 0xDC, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAutomShotFrame5 = [
    OAMEntry(-20, -4, 0xDB, 0x00),
    OAMEntry(-12, -4, 0xDA, 0x00),
    OAMEntry(-4, -4, 0xDB, 0x00),
    OAMEntry(4, -4, 0xDA, 0x00),
    OAMEntry(12,-12, 0xDE, 0x00),
    OAMEntry(12, -4, 0xDF, 0x00),
    OAMEntry(12, 4, 0xDE, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteShirkFrame1 = [
    OAMEntry(-12,-12, 0xE1, 0x00),
    OAMEntry(-12, -4, 0xE2, 0x00),
    OAMEntry(-12, 4, 0xE3, 0x00),
    OAMEntry(-4,-12, 0xE4, 0x00),
    OAMEntry(-4, -4, 0xEF, 0x00),
    OAMEntry(-4, 4, 0xE6, 0x00),
    OAMEntry(4,-12, 0xED, 0x00),
    OAMEntry(4, -4, 0xEE, 0x00),
    OAMEntry(4, 4, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteShirkFrame2 = [
    OAMEntry(-12,-12, 0xEA, 0x00),
    OAMEntry(-12, -4, 0xEB, 0x00),
    OAMEntry(-12, 4, 0xE3, 0x00),
    OAMEntry(-4,-12, 0xEC, 0x00),
    OAMEntry(-4, -4, 0xE5, 0x00),
    OAMEntry(-4, 4, 0xE6, 0x00),
    OAMEntry(4,-12, 0xE7, 0x00),
    OAMEntry(4, -4, 0xE8, 0x00),
    OAMEntry(4, 4, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteMotoFrame1 = [
    OAMEntry(-12,-16, 0xBD, 0x00),
    OAMEntry(-12, -8, 0xBE, 0x00),
    OAMEntry(-12, 0, 0xBF, 0x00),
    OAMEntry(-4,-16, 0xC0, 0x00),
    OAMEntry(-4, -8, 0xC1, 0x00),
    OAMEntry(-4, 0, 0xC2, 0x00),
    OAMEntry(4,-16, 0xC3, 0x00),
    OAMEntry(4, -8, 0xC4, 0x00),
    OAMEntry(4, 0, 0xC5, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMotoFrame2 = [
    OAMEntry(-13,-16, 0xBD, 0x00),
    OAMEntry(-13, -8, 0xBE, 0x00),
    OAMEntry(-13, 0, 0xBF, 0x00),
    OAMEntry(-5,-16, 0xC0, 0x00),
    OAMEntry(-5, -8, 0xC6, 0x00),
    OAMEntry(-5, 0, 0xC7, 0x00),
    OAMEntry(3,-16, 0xC3, 0x00),
    OAMEntry(3, -8, 0xC8, 0x00),
    OAMEntry(3, 0, 0xC9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMotoFrame3 = [
    OAMEntry(-12,-16, 0xBD, 0x00),
    OAMEntry(-12, -8, 0xBE, 0x00),
    OAMEntry(-12, 0, 0xBF, 0x00),
    OAMEntry(-4,-16, 0xC0, 0x00),
    OAMEntry(-4, -8, 0xC6, 0x00),
    OAMEntry(-4, 0, 0xC7, 0x00),
    OAMEntry(4,-16, 0xC3, 0x00),
    OAMEntry(4, -8, 0xCA, 0x00),
    OAMEntry(4, 0, 0xCB, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteHalzyn = [
    OAMEntry(-8,-12, 0xCC, 0x00),
    OAMEntry(-8, -4, 0xCD, 0x00),
    OAMEntry(-8, 4, 0xCE, 0x00),
    OAMEntry(0,-12, 0xCF, 0x00),
    OAMEntry(0, -4, 0xD0, 0x00),
    OAMEntry(0, 4, 0xD1, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteRamulkenFrame1 = [
    OAMEntry(-16, -4, 0xD2, 0x00),
    OAMEntry(-8,-12, 0xD3, 0x00),
    OAMEntry(-8, -4, 0xD4, 0x00),
    OAMEntry(-8, 4, 0xD5, 0x00),
    OAMEntry(0,-12, 0xD6, 0x00),
    OAMEntry(0, -4, 0xD7, 0x00),
    OAMEntry(0, 4, 0xD8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteRamulkenFrame2 = [
    OAMEntry(-16, -4, 0xD2, 0x00),
    OAMEntry(-8,-12, 0xD3, 0x00),
    OAMEntry(-8, -4, 0xD4, 0x00),
    OAMEntry(-8, 4, 0xD5, 0x00),
    OAMEntry(0,-12, 0xD9, 0x00),
    OAMEntry(0, -4, 0xDA, 0x00),
    OAMEntry(0, 4, 0xDB, 0x00),
    OAMEntry(8, -8, 0xDC, 0x00),
    OAMEntry(8, 0, 0xDD, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGravittFrame1 = [
    OAMEntry(-16, -4, 0xB8, 0x00),
    OAMEntry(-8, -8, 0xB6, 0x00),
    OAMEntry(-8, 0, 0xB7, 0x00),
    OAMEntry(0, -8, 0xB4, 0x00),
    OAMEntry(0, 0, 0xB5, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGravittFrame2 = [
    OAMEntry(-16, -4, 0xB8, 0x00),
    OAMEntry(-8, -8, 0xB6, 0x00),
    OAMEntry(-8, 0, 0xB7, 0x00),
    OAMEntry(0, -8, 0xB9, 0x00),
    OAMEntry(0, 0, 0xBA, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGravittFrame3 = [
    OAMEntry(-16, -4, 0xB8, 0x00),
    OAMEntry(-8, -8, 0xB6, 0x00),
    OAMEntry(-8, 0, 0xB7, 0x00),
    OAMEntry(0, -8, 0xBB, 0x00),
    OAMEntry(0, 0, 0xBC, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteProboscumFrame1 = [
    OAMEntry(-4,-12, 0xE4, 0x00),
    OAMEntry(-4, -4, 0xE5, 0x00),
    OAMEntry(-4, 4, 0xE6, 0x00),
    OAMEntry(4,-12, 0xE7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteProboscumFrame2 = [
    OAMEntry(-4,-12, 0xE4, 0x00),
    OAMEntry(-4, -4, 0xE8, 0x00),
    OAMEntry(4,-12, 0xE7, 0x00),
    OAMEntry(4, -4, 0xE9, 0x00),
    OAMEntry(4, 4, 0xEA, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteProboscumFrame3 = [
    OAMEntry(-4,-12, 0xE4, 0x00),
    OAMEntry(-4, -4, 0xEB, 0x00),
    OAMEntry(4,-12, 0xE7, 0x00),
    OAMEntry(4, -4, 0xEC, 0x00),
    OAMEntry(12, -4, 0xED, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteArachnusFrame1 = [
    OAMEntry(-8, -8, 0xCB, 0x00),
    OAMEntry(-8, 0, 0xCC, 0x00),
    OAMEntry(0, -8, 0xCD, 0x00),
    OAMEntry(0, 0, 0xCE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteArachnusFrame2 = [
    OAMEntry(-8, -8, 0xCD, 0x40),
    OAMEntry(-8, 0, 0xCB, 0x20),
    OAMEntry(0, -8, 0xCE, 0x20),
    OAMEntry(0, 0, 0xCC, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteArachnusFrame3 = [
    OAMEntry(-16, -4, 0xB8, 0x00),
    OAMEntry(-16, 4, 0xB9, 0x00),
    OAMEntry(-8,-12, 0xBB, 0x00),
    OAMEntry(-8, -4, 0xBC, 0x00),
    OAMEntry(-8, 4, 0xBD, 0x00),
    OAMEntry(-5,-20, 0xBA, 0x00),
    OAMEntry(0,-12, 0xBF, 0x00),
    OAMEntry(0, -4, 0xC0, 0x00),
    OAMEntry(0, 4, 0xC1, 0x00),
    OAMEntry(3,-20, 0xBE, 0x00),
    OAMEntry(8,-12, 0xC2, 0x00),
    OAMEntry(8, -4, 0xC3, 0x00),
    OAMEntry(8, 4, 0xC4, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteArachnusFrame4 = [
    OAMEntry(-16, -4, 0xB8, 0x00),
    OAMEntry(-16, 4, 0xB9, 0x00),
    OAMEntry(-8,-28, 0xC5, 0x00),
    OAMEntry(-8,-20, 0xC6, 0x00),
    OAMEntry(-8,-12, 0xC7, 0x00),
    OAMEntry(-8, -4, 0xBC, 0x00),
    OAMEntry(-8, 4, 0xBD, 0x00),
    OAMEntry(0,-12, 0xC8, 0x00),
    OAMEntry(0, -4, 0xC0, 0x00),
    OAMEntry(0, 4, 0xC1, 0x00),
    OAMEntry(8,-12, 0xC2, 0x00),
    OAMEntry(8, -4, 0xC3, 0x00),
    OAMEntry(8, 4, 0xC4, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteArachnusFrame5 = [
    OAMEntry(-16,-28, 0xCF, 0x00),
    OAMEntry(-16, -4, 0xB8, 0x00),
    OAMEntry(-16, 4, 0xB9, 0x00),
    OAMEntry(-8,-28, 0xD0, 0x00),
    OAMEntry(-8,-20, 0xD1, 0x00),
    OAMEntry(-8,-12, 0xD2, 0x00),
    OAMEntry(-8, -4, 0xBC, 0x00),
    OAMEntry(-8, 4, 0xBD, 0x00),
    OAMEntry(0,-12, 0xC8, 0x00),
    OAMEntry(0, -4, 0xC0, 0x00),
    OAMEntry(0, 4, 0xC1, 0x00),
    OAMEntry(8,-12, 0xC2, 0x00),
    OAMEntry(8, -4, 0xC3, 0x00),
    OAMEntry(8, 4, 0xC4, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteArachnusShotFrame1 = [
    OAMEntry(-4, -4, 0xCA, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteArachnusShotFrame2 = [
    OAMEntry(-4, -4, 0xC9, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSmallHealthFrame1 = [
    OAMEntry(-4, -4, 0x92, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSmallHealthFrame2 = [
    OAMEntry(-4, -4, 0x93, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteBigHealthFrame1 = [
    OAMEntry(-8, -8, 0x94, 0x00),
    OAMEntry(-8, 0, 0x94, 0x20),
    OAMEntry(0, -8, 0x94, 0x40),
    OAMEntry(0, 0, 0x94, 0x60),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBigHealthFrame2 = [
    OAMEntry(-8, -8, 0x95, 0x00),
    OAMEntry(-8, 0, 0x95, 0x20),
    OAMEntry(0, -8, 0x95, 0x40),
    OAMEntry(0, 0, 0x95, 0x60),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteBigExplosionFrame1 = [
    OAMEntry(-9, -4, 0x89, 0x00),
    OAMEntry(-4,-10, 0x96, 0x20),
    OAMEntry(-4, 1, 0x96, 0x20),
    OAMEntry(1, -4, 0x89, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBigExplosionFrame2 = [
    OAMEntry(-12, -4, 0x89, 0x00),
    OAMEntry(-10,-10, 0x97, 0x00),
    OAMEntry(-10, 2, 0x97, 0x20),
    OAMEntry(-4,-16, 0x96, 0x00),
    OAMEntry(-4, 4, 0x96, 0x20),
    OAMEntry(2,-10, 0x97, 0x40),
    OAMEntry(2, 2, 0x97, 0x60),
    OAMEntry(4, -4, 0x89, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBigExplosionFrame3 = [
    OAMEntry(-18,-18, 0x97, 0x00),
    OAMEntry(-13, -4, 0x89, 0x00),
    OAMEntry(-4,-18, 0x96, 0x00),
    OAMEntry(-4, 5, 0x96, 0x20),
    OAMEntry(4,-12, 0x97, 0x40),
    OAMEntry(4, -4, 0x89, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBigExplosionFrame4 = [
    OAMEntry(-20,-20, 0x97, 0x00),
    OAMEntry(-20, 11, 0x97, 0x20),
    OAMEntry(-14, -4, 0x89, 0x00),
    OAMEntry(-4,-22, 0x96, 0x00),
    OAMEntry(-4, 8, 0x96, 0x20),
    OAMEntry(8,-16, 0x97, 0x40),
    OAMEntry(16, -4, 0x89, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBigExplosionFrame5 = [
    OAMEntry(-20, 16, 0x89, 0x00),
    OAMEntry(-16, -4, 0x89, 0x20),
    OAMEntry(-4,-20, 0x96, 0x00),
    OAMEntry(-4, 12, 0x96, 0x20),
    OAMEntry(12,-16, 0x89, 0x40),
    OAMEntry(12, 12, 0x97, 0x60),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBigExplosionFrame6 = [
    OAMEntry(-4,-20, 0x96, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteSmallExplosionFrame1 = [
    OAMEntry(-8, -8, 0x88, 0x00),
    OAMEntry(-8, 0, 0x88, 0x20),
    OAMEntry(0, -8, 0x88, 0x40),
    OAMEntry(0, 0, 0x88, 0x60),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSmallExplosionFrame2 = [
    OAMEntry(-4, -4, 0x8A, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSmallExplosionFrame3 = [
    OAMEntry(-12,-12, 0x85, 0x00),
    OAMEntry(-12, -4, 0x86, 0x00),
    OAMEntry(-12, 4, 0x85, 0x20),
    OAMEntry(-4,-12, 0x87, 0x00),
    OAMEntry(-4, 4, 0x87, 0x20),
    OAMEntry(4,-12, 0x85, 0x40),
    OAMEntry(4, -4, 0x86, 0x40),
    OAMEntry(4, 4, 0x85, 0x60),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteSmallExplosionFrame4 = [
    OAMEntry(-16,-16, 0x7B, 0x00),
    OAMEntry(-16, -8, 0x7C, 0x00),
    OAMEntry(-16, 0, 0x7C, 0x20),
    OAMEntry(-16, 8, 0x7B, 0x20),
    OAMEntry(-8,-16, 0x7D, 0x00),
    OAMEntry(-8, 8, 0x7D, 0x20),
    OAMEntry(0,-16, 0x7D, 0x40),
    OAMEntry(0, 8, 0x7D, 0x60),
    OAMEntry(8,-16, 0x7B, 0x40),
    OAMEntry(8, -8, 0x7C, 0x40),
    OAMEntry(8, 0, 0x7C, 0x60),
    OAMEntry(8, 8, 0x7B, 0x60),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteMissileDropFrame1 = [
    OAMEntry(-4, -4, 0x99, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMissileDropFrame2 = [
    OAMEntry(-4, -4, 0x99, 0x10),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] unusedEnemySprites = [
    OAMEntry(-8, -8, 0xB8, 0x00),
    OAMEntry(0, -8, 0xC8, 0x00),
    OAMEntry(8, -8, 0xD8, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xB9, 0x00),
    OAMEntry(0, -8, 0xC9, 0x00),
    OAMEntry(8, -8, 0xD9, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xC6, 0x00),
    OAMEntry(-8, 0, 0xC7, 0x00),
    OAMEntry(0, -8, 0xD6, 0x00),
    OAMEntry(0, 0, 0xD7, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xBA, 0x00),
    OAMEntry(-8, 0, 0xBB, 0x00),
    OAMEntry(0, -8, 0xCA, 0x00),
    OAMEntry(0, 0, 0xCB, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xDA, 0x00),
    OAMEntry(-8, 0, 0xDB, 0x00),
    OAMEntry(0, -8, 0xEA, 0x00),
    OAMEntry(0, 0, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xDC, 0x00),
    OAMEntry(-8, 0, 0xDD, 0x00),
    OAMEntry(0, -8, 0xEC, 0x00),
    OAMEntry(0, 0, 0xED, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xE4, 0x00),
    OAMEntry(-8, 0, 0xE4, 0x20),
    OAMEntry(0,-16, 0xD0, 0x00),
    OAMEntry(0, -8, 0xD1, 0x00),
    OAMEntry(0, 0, 0xD1, 0x20),
    OAMEntry(0, 8, 0xD0, 0x20),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xE3, 0x00),
    OAMEntry(-8, 0, 0xE3, 0x20),
    OAMEntry(0,-16, 0xD0, 0x00),
    OAMEntry(0, -8, 0xD1, 0x00),
    OAMEntry(0, 0, 0xD1, 0x20),
    OAMEntry(0, 8, 0xD0, 0x20),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-12, -8, 0xD2, 0x00),
    OAMEntry(-12, 0, 0xD2, 0x20),
    OAMEntry(-4, -8, 0xE2, 0x00),
    OAMEntry(-4, 0, 0xE2, 0x20),
    OAMEntry(4,-16, 0xE0, 0x00),
    OAMEntry(4, -8, 0xE1, 0x00),
    OAMEntry(4, 0, 0xE1, 0x20),
    OAMEntry(4, 8, 0xE0, 0x20),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-12, -8, 0xB1, 0x00),
    OAMEntry(-12, 0, 0xB2, 0x00),
    OAMEntry(-4,-16, 0xC0, 0x00),
    OAMEntry(-4, -8, 0xC1, 0x00),
    OAMEntry(-4, 0, 0xC2, 0x00),
    OAMEntry(4, -8, 0xB6, 0x00),
    OAMEntry(4, 0, 0xB7, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-12, -8, 0xB1, 0x00),
    OAMEntry(-12, 0, 0xB2, 0x00),
    OAMEntry(-4,-16, 0xC0, 0x00),
    OAMEntry(-4, -8, 0xC1, 0x00),
    OAMEntry(-4, 0, 0xC2, 0x00),
    OAMEntry(4, -8, 0xB0, 0x00),
    OAMEntry(4, 0, 0xD5, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-16,-12, 0xB3, 0x00),
    OAMEntry(-8,-12, 0xC3, 0x00),
    OAMEntry(-8, -4, 0xC4, 0x00),
    OAMEntry(-8, 4, 0xC5, 0x00),
    OAMEntry(0,-12, 0xD3, 0x00),
    OAMEntry(0, -4, 0xD4, 0x00),
    OAMEntry(0, 4, 0xD5, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-16,-12, 0xB3, 0x00),
    OAMEntry(-8,-12, 0xC3, 0x00),
    OAMEntry(-8, -4, 0xB4, 0x00),
    OAMEntry(-8, 4, 0xB5, 0x00),
    OAMEntry(0,-12, 0xD3, 0x00),
    OAMEntry(0, -4, 0xD4, 0x00),
    OAMEntry(0, 4, 0xD5, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-4, -4, 0xE5, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xBC, 0x00),
    OAMEntry(-8, 0, 0xBD, 0x00),
    OAMEntry(0, -8, 0xCC, 0x00),
    OAMEntry(0, 0, 0xCD, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -8, 0xBE, 0x00),
    OAMEntry(-8, 0, 0xBF, 0x00),
    OAMEntry(0, -8, 0xCE, 0x00),
    OAMEntry(0, 0, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-4, -8, 0xDE, 0x00),
    OAMEntry(-4, 0, 0xDE, 0x20),
    OAMEntry(metaSpriteEnd),
    OAMEntry(-8, -4, 0xDF, 0x00),
    OAMEntry(-16, -4, 0xDF, 0x40),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteMissileDoor = [
    OAMEntry(-24,-23, 0xF4, 0x20),
    OAMEntry(-16,-23, 0xF5, 0x20),
    OAMEntry(-8,-23, 0xF6, 0x20),
    OAMEntry(0,-23, 0xF6, 0x60),
    OAMEntry(8,-23, 0xF5, 0x60),
    OAMEntry(16,-23, 0xF4, 0x60),
    OAMEntry(-24, 16, 0xF4, 0x00),
    OAMEntry(-16, 16, 0xF5, 0x00),
    OAMEntry(-8, 16, 0xF6, 0x00),
    OAMEntry(0, 16, 0xF6, 0x40),
    OAMEntry(8, 16, 0xF5, 0x40),
    OAMEntry(16, 16, 0xF4, 0x40),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMissileBlock = [
    OAMEntry(-8, -8, 0xF7, 0x00),
    OAMEntry(-8, 0, 0xF8, 0x00),
    OAMEntry(0, -8, 0xF9, 0x00),
    OAMEntry(0, 0, 0xFA, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteMetroidFrame1 = [
    OAMEntry(-12,-16, 0xB4, 0x00),
    OAMEntry(-12, -8, 0xB5, 0x00),
    OAMEntry(-12, 0, 0xB6, 0x00),
    OAMEntry(-12, 8, 0xB7, 0x00),
    OAMEntry(-4,-16, 0xC4, 0x00),
    OAMEntry(-4, -8, 0xC5, 0x00),
    OAMEntry(-4, 0, 0xC6, 0x00),
    OAMEntry(-4, 8, 0xC7, 0x00),
    OAMEntry(4,-16, 0xD4, 0x00),
    OAMEntry(4, -8, 0xD5, 0x00),
    OAMEntry(4, 0, 0xD6, 0x00),
    OAMEntry(4, 8, 0xD7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAlphaFace = [
    OAMEntry(-12,-12, 0xC8, 0x00),
    OAMEntry(-12, -4, 0xC9, 0x00),
    OAMEntry(-12, 4, 0xCA, 0x00),
    OAMEntry(-4,-16, 0xD8, 0x00),
    OAMEntry(-4, -8, 0xD9, 0x00),
    OAMEntry(-4, 0, 0xDA, 0x00),
    OAMEntry(-4, 8, 0xDB, 0x00),
    OAMEntry(4,-12, 0xE8, 0x00),
    OAMEntry(4, -4, 0xE9, 0x00),
    OAMEntry(4, 4, 0xEA, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAlphaFrame1 = [
    OAMEntry(-12,-16, 0xB0, 0x00),
    OAMEntry(-12, -8, 0xB1, 0x00),
    OAMEntry(-12, 0, 0xB2, 0x00),
    OAMEntry(-12, 8, 0xB3, 0x00),
    OAMEntry(-4,-16, 0xC0, 0x00),
    OAMEntry(-4, -8, 0xC1, 0x00),
    OAMEntry(-4, 0, 0xC2, 0x00),
    OAMEntry(-4, 8, 0xC3, 0x00),
    OAMEntry(4, -9, 0xD1, 0x00),
    OAMEntry(4, -1, 0xD2, 0x00),
    OAMEntry(4, 7, 0xD3, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteAlphaFrame2 = [
    OAMEntry(-12,-16, 0xB0, 0x00),
    OAMEntry(-12, -8, 0xB1, 0x00),
    OAMEntry(-12, 0, 0xE4, 0x00),
    OAMEntry(-12, 8, 0xE5, 0x00),
    OAMEntry(-4,-16, 0xB8, 0x00),
    OAMEntry(-4, -8, 0xB9, 0x00),
    OAMEntry(-4, 0, 0xE6, 0x00),
    OAMEntry(-4, 8, 0xE7, 0x00),
    OAMEntry(4, -8, 0xD1, 0x00),
    OAMEntry(4, 0, 0xD2, 0x00),
    OAMEntry(4, 8, 0xD3, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMetroidFrame2 = [
    OAMEntry(-12,-16, 0xEB, 0x00),
    OAMEntry(-12, -8, 0xEC, 0x00),
    OAMEntry(-12, 0, 0xED, 0x00),
    OAMEntry(-12, 8, 0xEE, 0x00),
    OAMEntry(-4,-16, 0xBE, 0x00),
    OAMEntry(-4, -8, 0xC5, 0x00),
    OAMEntry(-4, 0, 0xC6, 0x00),
    OAMEntry(-4, 8, 0xBF, 0x00),
    OAMEntry(4,-16, 0xCB, 0x00),
    OAMEntry(4, -8, 0xCF, 0x00),
    OAMEntry(4, 0, 0xDF, 0x00),
    OAMEntry(4, 8, 0xEF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMetroidFrame3 = [
    OAMEntry(-12,-16, 0xB4, 0x00),
    OAMEntry(-12, -8, 0xD0, 0x00),
    OAMEntry(-12, 0, 0xDC, 0x00),
    OAMEntry(-12, 8, 0xB7, 0x00),
    OAMEntry(-4,-16, 0xC4, 0x00),
    OAMEntry(-4, -8, 0xDD, 0x00),
    OAMEntry(-4, 0, 0xDE, 0x00),
    OAMEntry(-4, 8, 0xC7, 0x00),
    OAMEntry(4,-16, 0xD4, 0x00),
    OAMEntry(4, -8, 0xD5, 0x00),
    OAMEntry(4, 0, 0xD6, 0x00),
    OAMEntry(4, 8, 0xD7, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGammaBoltFrame1 = [
    OAMEntry(-4, -4, 0xBE, 0x00),
    OAMEntry(4,-12, 0xCE, 0x00),
    OAMEntry(4, -4, 0xCF, 0x00),
    OAMEntry(12,-12, 0xBF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGammaBoltFrame2 = [
    OAMEntry(-4,-20, 0xED, 0x00),
    OAMEntry(-4,-12, 0xEE, 0x00),
    OAMEntry(-4, -4, 0xEF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGammaFrame1 = [
    OAMEntry(-12,-20, 0xB4, 0x00),
    OAMEntry(-12,-12, 0xB5, 0x00),
    OAMEntry(-12, -4, 0xB6, 0x00),
    OAMEntry(-12, 4, 0xB7, 0x00),
    OAMEntry(-12, 12, 0xB8, 0x00),
    OAMEntry(-4,-12, 0xC5, 0x00),
    OAMEntry(-4, -4, 0xC6, 0x00),
    OAMEntry(-4, 4, 0xC7, 0x00),
    OAMEntry(-4, 12, 0xC8, 0x00),
    OAMEntry(4,-20, 0xD4, 0x00),
    OAMEntry(4,-12, 0xD5, 0x00),
    OAMEntry(4, -4, 0xD6, 0x00),
    OAMEntry(4, 4, 0xD7, 0x00),
    OAMEntry(4, 12, 0xD8, 0x00),
    OAMEntry(12, -4, 0xE6, 0x00),
    OAMEntry(12, 4, 0xE7, 0x00),
    OAMEntry(12, 12, 0xE8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteGammaFrame2 = [
    OAMEntry(-16,-20, 0xB4, 0x00),
    OAMEntry(-16,-12, 0xB5, 0x00),
    OAMEntry(-16, -4, 0xB6, 0x00),
    OAMEntry(-16, 4, 0xB7, 0x00),
    OAMEntry(-16, 12, 0xB8, 0x00),
    OAMEntry(-8,-12, 0xC5, 0x00),
    OAMEntry(-8, -4, 0xBB, 0x00),
    OAMEntry(-8, 4, 0xBC, 0x00),
    OAMEntry(-8, 12, 0xBD, 0x00),
    OAMEntry(0,-20, 0xD4, 0x00),
    OAMEntry(0,-12, 0xD5, 0x00),
    OAMEntry(0, -4, 0xCB, 0x00),
    OAMEntry(0, 4, 0xCC, 0x00),
    OAMEntry(0, 12, 0xCD, 0x00),
    OAMEntry(8, -4, 0xDB, 0x00),
    OAMEntry(8, 4, 0xDC, 0x00),
    OAMEntry(8, 12, 0xDD, 0x00),
    OAMEntry(16, -4, 0xEB, 0x00),
    OAMEntry(16, 4, 0xEC, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteGammaHusk = [
    OAMEntry(-12,-20, 0xB4, 0x00),
    OAMEntry(-12,-12, 0xB5, 0x00),
    OAMEntry(-12, -4, 0xC4, 0x00),
    OAMEntry(-4,-12, 0xC5, 0x00),
    OAMEntry(-4, -4, 0xC6, 0x00),
    OAMEntry(-4, 4, 0xE5, 0x00),
    OAMEntry(-4, 12, 0xE0, 0x00),
    OAMEntry(4,-20, 0xD4, 0x00),
    OAMEntry(4,-12, 0xD5, 0x00),
    OAMEntry(4, -4, 0xD6, 0x00),
    OAMEntry(4, 4, 0xD7, 0x00),
    OAMEntry(4, 12, 0xD8, 0x00),
    OAMEntry(12, -4, 0xE6, 0x00),
    OAMEntry(12, 4, 0xE7, 0x00),
    OAMEntry(12, 12, 0xE8, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame1 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xC0, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD0, 0x00),
    OAMEntry(0, -4, 0xD1, 0x00),
    OAMEntry(0, 4, 0xD2, 0x00),
    OAMEntry(0, 12, 0xBE, 0x00),
    OAMEntry(0, 20, 0xBF, 0x00),
    OAMEntry(8, -4, 0xE1, 0x00),
    OAMEntry(8, 4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame2 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xC0, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD0, 0x00),
    OAMEntry(0, -4, 0xD1, 0x00),
    OAMEntry(0, 4, 0xD2, 0x00),
    OAMEntry(0, 12, 0xCE, 0x00),
    OAMEntry(0, 20, 0xCF, 0x00),
    OAMEntry(8, -4, 0xE1, 0x00),
    OAMEntry(8, 4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame3 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xC0, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD0, 0x00),
    OAMEntry(0, -4, 0xD1, 0x00),
    OAMEntry(0, 4, 0xD2, 0x00),
    OAMEntry(0, 12, 0xDE, 0x00),
    OAMEntry(0, 20, 0xDF, 0x00),
    OAMEntry(8, -4, 0xE1, 0x00),
    OAMEntry(8, 4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame4 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xC0, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD0, 0x00),
    OAMEntry(0, -4, 0xD1, 0x00),
    OAMEntry(0, 4, 0xD2, 0x00),
    OAMEntry(0, 12, 0xEE, 0x00),
    OAMEntry(0, 20, 0xEF, 0x00),
    OAMEntry(8, -4, 0xE1, 0x00),
    OAMEntry(8, 4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame5 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xC0, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD0, 0x00),
    OAMEntry(0, -4, 0xCA, 0x00),
    OAMEntry(0, 4, 0xCB, 0x00),
    OAMEntry(0, 12, 0xBE, 0x00),
    OAMEntry(0, 20, 0xBF, 0x00),
    OAMEntry(8, -4, 0xDA, 0x00),
    OAMEntry(8, 4, 0xDB, 0x00),
    OAMEntry(16, -4, 0xEA, 0x00),
    OAMEntry(16, 4, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame6 = [
    OAMEntry(-16,-20, 0xB3, 0x00),
    OAMEntry(-16,-12, 0xB9, 0x00),
    OAMEntry(-16, -4, 0xBA, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-20, 0xC3, 0x00),
    OAMEntry(-8,-12, 0xC9, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xD9, 0x00),
    OAMEntry(0, -4, 0xD1, 0x00),
    OAMEntry(0, 4, 0xD2, 0x00),
    OAMEntry(0, 12, 0xBE, 0x00),
    OAMEntry(0, 20, 0xBF, 0x00),
    OAMEntry(8, -4, 0xE1, 0x00),
    OAMEntry(8, 4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame7 = [
    OAMEntry(-16,-20, 0xB3, 0x00),
    OAMEntry(-16,-12, 0xB9, 0x00),
    OAMEntry(-16, -4, 0xBA, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-20, 0xBB, 0x00),
    OAMEntry(-8,-12, 0xC9, 0x00),
    OAMEntry(-8, -4, 0xC1, 0x00),
    OAMEntry(-8, 4, 0xC2, 0x00),
    OAMEntry(0,-12, 0xCC, 0x00),
    OAMEntry(0, -4, 0xD1, 0x00),
    OAMEntry(0, 4, 0xD2, 0x00),
    OAMEntry(0, 12, 0xEE, 0x00),
    OAMEntry(0, 20, 0xEF, 0x00),
    OAMEntry(8, -4, 0xE1, 0x00),
    OAMEntry(8, 4, 0xE2, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame8 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xBD, 0x00),
    OAMEntry(-8, -4, 0xE3, 0x00),
    OAMEntry(-8, 4, 0xE9, 0x00),
    OAMEntry(0,-12, 0xCD, 0x00),
    OAMEntry(0, -4, 0xD3, 0x00),
    OAMEntry(0, 4, 0xCB, 0x00),
    OAMEntry(0, 12, 0xBE, 0x00),
    OAMEntry(0, 20, 0xBF, 0x00),
    OAMEntry(8, -4, 0xDA, 0x00),
    OAMEntry(8, 4, 0xDB, 0x00),
    OAMEntry(16, -4, 0xEA, 0x00),
    OAMEntry(16, 4, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrame9 = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xBD, 0x00),
    OAMEntry(-8, -4, 0xE3, 0x00),
    OAMEntry(-8, 4, 0xE9, 0x00),
    OAMEntry(0,-12, 0xCD, 0x00),
    OAMEntry(0, -4, 0xD3, 0x00),
    OAMEntry(0, 4, 0xCB, 0x00),
    OAMEntry(0, 12, 0xCE, 0x00),
    OAMEntry(0, 20, 0xCF, 0x00),
    OAMEntry(8, -4, 0xDA, 0x00),
    OAMEntry(8, 4, 0xDB, 0x00),
    OAMEntry(16, -4, 0xEA, 0x00),
    OAMEntry(16, 4, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrameA = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xBD, 0x00),
    OAMEntry(-8, -4, 0xE3, 0x00),
    OAMEntry(-8, 4, 0xE9, 0x00),
    OAMEntry(0,-12, 0xCD, 0x00),
    OAMEntry(0, -4, 0xD3, 0x00),
    OAMEntry(0, 4, 0xCB, 0x00),
    OAMEntry(0, 12, 0xDE, 0x00),
    OAMEntry(0, 20, 0xDF, 0x00),
    OAMEntry(8, -4, 0xDA, 0x00),
    OAMEntry(8, 4, 0xDB, 0x00),
    OAMEntry(16, -4, 0xEA, 0x00),
    OAMEntry(16, 4, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaFrameB = [
    OAMEntry(-16,-12, 0xB0, 0x00),
    OAMEntry(-16, -4, 0xB1, 0x00),
    OAMEntry(-16, 4, 0xB2, 0x00),
    OAMEntry(-8,-12, 0xBD, 0x00),
    OAMEntry(-8, -4, 0xE3, 0x00),
    OAMEntry(-8, 4, 0xE9, 0x00),
    OAMEntry(0,-12, 0xCD, 0x00),
    OAMEntry(0, -4, 0xD3, 0x00),
    OAMEntry(0, 4, 0xCB, 0x00),
    OAMEntry(0, 12, 0xEE, 0x00),
    OAMEntry(0, 20, 0xEF, 0x00),
    OAMEntry(8, -4, 0xDA, 0x00),
    OAMEntry(8, 4, 0xDB, 0x00),
    OAMEntry(16, -4, 0xEA, 0x00),
    OAMEntry(16, 4, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteZetaShot = [
    OAMEntry(-4, -4, 0xDC, 0x00),
    OAMEntry(-4, 4, 0xDD, 0x00),
    OAMEntry(4, -4, 0xEC, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteOmegaFrame1 = [
    OAMEntry(-16,-16, 0xB4, 0x00),
    OAMEntry(-16, -8, 0xB5, 0x00),
    OAMEntry(-8,-24, 0xC3, 0x00),
    OAMEntry(-8,-16, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC5, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xD4, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xC9, 0x00),
    OAMEntry(16, 16, 0xCA, 0x00),
    OAMEntry(24, 0, 0xD8, 0x00),
    OAMEntry(24, 8, 0xD9, 0x00),
    OAMEntry(32, 0, 0xE8, 0x00),
    OAMEntry(32, 8, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaFrame2 = [
    OAMEntry(-16,-16, 0xB4, 0x00),
    OAMEntry(-16, -8, 0xB5, 0x00),
    OAMEntry(-8,-24, 0xC3, 0x00),
    OAMEntry(-8,-16, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC5, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xD4, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xC9, 0x00),
    OAMEntry(16, 16, 0xDA, 0x00),
    OAMEntry(24, 0, 0xD8, 0x00),
    OAMEntry(24, 8, 0xD9, 0x00),
    OAMEntry(32, 0, 0xE8, 0x00),
    OAMEntry(32, 8, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaFrame3 = [
    OAMEntry(-16,-16, 0xB4, 0x00),
    OAMEntry(-16, -8, 0xB5, 0x00),
    OAMEntry(-8,-24, 0xB3, 0x00),
    OAMEntry(-8,-16, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC5, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xE4, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xC9, 0x00),
    OAMEntry(16, 16, 0xCA, 0x00),
    OAMEntry(24, 0, 0xD8, 0x00),
    OAMEntry(24, 8, 0xD9, 0x00),
    OAMEntry(32, 0, 0xE8, 0x00),
    OAMEntry(32, 8, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaFrame4 = [
    OAMEntry(-16,-16, 0xB4, 0x00),
    OAMEntry(-16, -8, 0xB5, 0x00),
    OAMEntry(-8,-24, 0xB3, 0x00),
    OAMEntry(-8,-16, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC5, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xE4, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xC9, 0x00),
    OAMEntry(16, 16, 0xDA, 0x00),
    OAMEntry(24, 0, 0xD8, 0x00),
    OAMEntry(24, 8, 0xD9, 0x00),
    OAMEntry(32, 0, 0xE8, 0x00),
    OAMEntry(32, 8, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaFrame5 = [
    OAMEntry(-16,-16, 0xB4, 0x00),
    OAMEntry(-16, -8, 0xB5, 0x00),
    OAMEntry(-8,-24, 0xC3, 0x00),
    OAMEntry(-8,-16, 0xC4, 0x00),
    OAMEntry(-8, -8, 0xC5, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xD4, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xCB, 0x00),
    OAMEntry(16, 16, 0xDA, 0x00),
    OAMEntry(24, 8, 0xDB, 0x00),
    OAMEntry(24, 16, 0xDC, 0x00),
    OAMEntry(32, 8, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaFrame6 = [
    OAMEntry(-16,-16, 0xB6, 0x00),
    OAMEntry(-16, -8, 0xB7, 0x00),
    OAMEntry(-8,-24, 0xB8, 0x00),
    OAMEntry(-8,-16, 0xB9, 0x00),
    OAMEntry(-8, -8, 0xBA, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xBB, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xC9, 0x00),
    OAMEntry(16, 16, 0xCA, 0x00),
    OAMEntry(24, 0, 0xD8, 0x00),
    OAMEntry(24, 8, 0xD9, 0x00),
    OAMEntry(32, 0, 0xE8, 0x00),
    OAMEntry(32, 8, 0xE9, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaFrame7 = [
    OAMEntry(-16,-16, 0xB6, 0x00),
    OAMEntry(-16, -8, 0xB7, 0x00),
    OAMEntry(-8,-24, 0xB8, 0x00),
    OAMEntry(-8,-16, 0xB9, 0x00),
    OAMEntry(-8, -8, 0xBA, 0x00),
    OAMEntry(-8, 0, 0xC6, 0x00),
    OAMEntry(-8, 8, 0xC7, 0x00),
    OAMEntry(0,-16, 0xBB, 0x00),
    OAMEntry(0, -8, 0xD5, 0x00),
    OAMEntry(0, 0, 0xD6, 0x00),
    OAMEntry(0, 8, 0xD7, 0x00),
    OAMEntry(8, -8, 0xE5, 0x00),
    OAMEntry(8, 0, 0xE6, 0x00),
    OAMEntry(8, 8, 0xE7, 0x00),
    OAMEntry(16, 0, 0xC8, 0x00),
    OAMEntry(16, 8, 0xCB, 0x00),
    OAMEntry(16, 16, 0xDA, 0x00),
    OAMEntry(24, 8, 0xDB, 0x00),
    OAMEntry(24, 16, 0xDC, 0x00),
    OAMEntry(32, 8, 0xEB, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteOmegaShotFrame1 = [
    OAMEntry(-12, -4, 0xBC, 0x00),
    OAMEntry(-12, 4, 0xBD, 0x00),
    OAMEntry(-4, -4, 0xCC, 0x00),
    OAMEntry(-4, 4, 0xCD, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame2 = [
    OAMEntry(-12, -4, 0xD3, 0x00),
    OAMEntry(-12, 4, 0xE3, 0x00),
    OAMEntry(-4, -4, 0xCE, 0x00),
    OAMEntry(-4, 4, 0xCF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame3 = [
    OAMEntry(-4, -8, 0xDD, 0x00),
    OAMEntry(-4, 0, 0xDE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame4 = [
    OAMEntry(-4,-20, 0xEC, 0x00),
    OAMEntry(-4,-12, 0xED, 0x00),
    OAMEntry(-4, 4, 0xED, 0x20),
    OAMEntry(-4, 12, 0xEC, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame5 = [
    OAMEntry(-4,-24, 0xEE, 0x00),
    OAMEntry(-4, 16, 0xEE, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame6 = [
    OAMEntry(-4,-28, 0xEF, 0x00),
    OAMEntry(-4, 20, 0xEF, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame7 = [
    OAMEntry(-4, -4, 0xDF, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteOmegaShotFrame8 = [
    OAMEntry(-4, -4, 0xEA, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteEggFrame1 = [
    OAMEntry(-12,-15, 0xB4, 0x00),
    OAMEntry(-12, -7, 0xB5, 0x00),
    OAMEntry(-12, 1, 0xB4, 0x20),
    OAMEntry(-4,-14, 0xB6, 0x00),
    OAMEntry(-4, -6, 0xB7, 0x00),
    OAMEntry(-4, 2, 0xB6, 0x20),
    OAMEntry(4,-13, 0xB8, 0x00),
    OAMEntry(4, -5, 0xB9, 0x00),
    OAMEntry(4, 3, 0xB8, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteEggFrame2 = [
    OAMEntry(-12,-12, 0xB4, 0x00),
    OAMEntry(-12, -4, 0xB5, 0x00),
    OAMEntry(-12, 4, 0xB4, 0x20),
    OAMEntry(-4,-12, 0xB6, 0x00),
    OAMEntry(-4, -4, 0xB7, 0x00),
    OAMEntry(-4, 4, 0xB6, 0x20),
    OAMEntry(4,-12, 0xB8, 0x00),
    OAMEntry(4, -4, 0xB9, 0x00),
    OAMEntry(4, 4, 0xB8, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteEggFrame3 = [
    OAMEntry(-12, -9, 0xB4, 0x00),
    OAMEntry(-12, -1, 0xB5, 0x00),
    OAMEntry(-12, 7, 0xB4, 0x20),
    OAMEntry(-4,-10, 0xB6, 0x00),
    OAMEntry(-4, -2, 0xB7, 0x00),
    OAMEntry(-4, 6, 0xB6, 0x20),
    OAMEntry(4,-11, 0xB8, 0x00),
    OAMEntry(4, -3, 0xB9, 0x00),
    OAMEntry(4, 5, 0xB8, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteBabyFrame1 = [
    OAMEntry(-8, -8, 0xB0, 0x00),
    OAMEntry(-8, 0, 0xB0, 0x20),
    OAMEntry(0, -8, 0xB1, 0x00),
    OAMEntry(0, 0, 0xB1, 0x20),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBabyFrame2 = [
    OAMEntry(-8, -8, 0xB2, 0x00),
    OAMEntry(-8, 0, 0xB2, 0x20),
    OAMEntry(0, -8, 0xB3, 0x00),
    OAMEntry(0, 0, 0xB3, 0x20),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteItemOrb = [
    OAMEntry(-8, -8, 0xB0, 0x00),
    OAMEntry(-8, 0, 0xB1, 0x00),
    OAMEntry(0, -8, 0xB2, 0x00),
    OAMEntry(0, 0, 0xB3, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteItem = [
    OAMEntry(-8, -8, 0xB4, 0x00),
    OAMEntry(-8, 0, 0xB5, 0x00),
    OAMEntry(0, -8, 0xB6, 0x00),
    OAMEntry(0, 0, 0xB7, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteEnergyTank = [
    OAMEntry(-8, -8, 0xAB, 0x00),
    OAMEntry(-8, 0, 0xAC, 0x00),
    OAMEntry(0, -8, 0xAD, 0x00),
    OAMEntry(0, 0, 0xAE, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMissileTank = [
    OAMEntry(-8, -8, 0xF0, 0x00),
    OAMEntry(-8, 0, 0xF1, 0x00),
    OAMEntry(0, -8, 0xF2, 0x00),
    OAMEntry(0, 0, 0xF3, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteEnergyRefill = [
    OAMEntry(-8, -8, 0xFD, 0x00),
    OAMEntry(-8, 0, 0xFD, 0x20),
    OAMEntry(0, -8, 0xFD, 0x40),
    OAMEntry(0, 0, 0xFD, 0x60),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteMissileRefill = [
    OAMEntry(-8, -4, 0xFB, 0x00),
    OAMEntry(0, -4, 0xFC, 0x00),
    OAMEntry(metaSpriteEnd),
];

immutable OAMEntry[] enSpriteBlobFrame1 = [
    OAMEntry(-4, -4, 0xE4, 0x00),
    OAMEntry(metaSpriteEnd),
];
immutable OAMEntry[] enSpriteBlobFrame2 = [
    OAMEntry(-4, -4, 0xE5, 0x00),
    OAMEntry(metaSpriteEnd),
];
