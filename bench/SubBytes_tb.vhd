library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;


entity SubBytes_tb is 
begin
end SubBytes_tb;

architecture SubBytes_tb_arch of SubBytes_tb is
	component SubBytes 
		port(
			data_i : in type_state;
			data_o : out type_state
		);
	end component;

	signal data_i_s : type_state;
	signal data_o_s : type_state;

	begin 
		DUT : SubBytes 
		port map (
			data_i => data_i_s,
			data_o => data_o_s );

		data_i_s <= ((x"00", x"01" , x"02", x"03"),
				(x"10", x"11" , x"12", x"13"),
				(x"20", x"21" , x"22", x"23"),
				(x"30", x"31" , x"32", x"33"));

		
end SubBytes_tb_arch ;

configuration SubBytes_tb_conf of SubBytes_tb is 
	for SubBytes_tb_arch
		for DUT : SubBytes
			use entity lib_src.SubBytes(subBytes_arch);
		end for;
	end for;
end SubBytes_tb_conf;


