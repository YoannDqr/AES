library lib_src;
use lib_src.all;

configuration AES_tb_configuration of AES_tb is
for AES_tb_arch
	for DUT : AES
		for AES_arch
			for U0 : KeyExpansion_I_O
				use entity lib_src.KeyExpansion_I_O(KeyExpansion_I_O_arch);
			end for;
			for U1 : FSM_AES
				use entity lib_src.FSM_AES(FSM_AES_arch);
			end for;
			for U2 : AESRound
				use entity lib_src.AESRound(AESRound_arch);
			end for;
		end for;
	end for;
end for;
end configuration AES_tb_configuration;
