library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity Sbox_tb is 
begin
end Sbox_tb;

architecture Sbox_tb_arch of Sbox_tb is
	component Sbox 
		port (
			SBOX_I : in std_logic_vector(7 downto 0);
			SBOX_O : out std_logic_vector(7 downto 0)
		);
	end component;
	signal SBOX_I_s : std_logic_vector(7 downto 0);
	signal SBOX_O_s : std_logic_vector(7 downto 0);

	begin 
		DUT : Sbox 
		port map (
			SBOX_I => SBOX_I_s,
			SBOX_O => SBOX_O_s );

		SBOX_I_s <= x"50" ;

end Sbox_tb_arch ;

configuration Sbox_tb_conf of Sbox_tb is 
	for Sbox_tb_arch
		for DUT : Sbox
			use entity lib_src.Sbox(Sbox_arch);
		end for;
	end for;
end Sbox_tb_conf;


