library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;


entity shiftRow_tb is 
begin
end shiftRow_tb;

architecture shiftRow_tb_arch of shiftRow_tb is
	component ShiftRow
		port(
			data_i : in type_state;
			data_o : out type_state
		);
	end component;

	signal data_i_s : type_state;
	signal data_o_s : type_state;

	begin 
		DUT : ShiftRow 
		port map (
			data_i => data_i_s,
			data_o => data_o_s );

		data_i_s <= ((x"00", x"01" , x"02", x"03"),
				(x"10", x"11" , x"12", x"13"),
				(x"20", x"21" , x"22", x"23"),
				(x"30", x"31" , x"32", x"33"));

		
end shiftRow_tb_arch ;

configuration ShiftRow_tb_conf of shiftRow_tb is 
	for shiftRow_tb_arch
		for DUT : ShiftRow
			use entity lib_src.ShiftRow(shiftRow_arch);
		end for;
	end for;
end ShiftRow_tb_conf;


