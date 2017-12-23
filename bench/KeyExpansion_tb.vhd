library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;


entity KeyExpansion_tb is 
begin
end KeyExpansion_tb;

architecture KeyExpansion_tb_arch of KeyExpansion_tb is
	component KeyExpansion 
		port(
            key_i : in bit128;
            recon_i : in bit8;
            expansion_key_o : out bit128
		);
	end component;

        signal key_i_s : bit128;
        signal recon_i_s : bit8;
        signal expansion_key_o_s : bit128;

	begin 
		DUT : KeyExpansion 
		port map (
			key_i => key_i_s,
            recon_i => recon_i_s,
            expansion_key_o => expansion_key_o_s  );

        key_i_s <= X"2b7e151628aed2a6abf7158809cf4f3c";
		recon_i_s <= X"01";

		
end KeyExpansion_tb_arch ;

configuration KeyExpansion_tb_conf of KeyExpansion_tb is 
	for KeyExpansion_tb_arch
		for DUT : KeyExpansion
			use entity lib_src.KeyExpansion(KeyExpansion_arch);
		end for;
	end for;
end KeyExpansion_tb_conf;


