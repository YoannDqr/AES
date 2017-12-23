library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity RotWord_tb is 
begin
end RotWord_tb;

architecture RotWord_tb_arch of RotWord_tb is
	component RotWord 
		port (
			column_i : in row_state;
			column_o : out row_state
		);
	end component;
	signal column_i_s : row_state;
	signal column_o_s : row_state;

	begin 
		DUT : RotWord 
		port map (
			column_i => column_i_s,
			column_o => column_o_s );

		column_i_s <= (X"00", X"01", X"02", X"03");  

end RotWord_tb_arch ;

configuration RotWord_tb_conf of RotWord_tb is 
	for RotWord_tb_arch
		for DUT : RotWord
			use entity lib_src.RotWord(RotWord_arch);
		end for;
	end for;
end RotWord_tb_conf;