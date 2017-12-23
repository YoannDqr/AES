library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;


entity KeyExpansion_IO_tb is 
begin
end KeyExpansion_IO_tb;

architecture KeyExpansion_IO_tb_arch of KeyExpansion_IO_tb is
	component KeyExpansion_IO
		port(
			key_i : in bit128;
			expansion_key_o : out bit128;
			clock_i : in std_logic;
			reset_i : in std_logic;
			start_i : in std_logic;
			round_i : in bit4;
			end_o : out std_logic
		);
	end component;

        signal key_i_s : bit128 := X"2b7e151628aed2a6abf7158809cf4f3c";
		signal clock_s : std_logic;
		signal reset_s : std_logic := '0';
        signal expansionkey_s : bit128;
		signal end_s : std_logic:='0';
		signal enable_s : std_logic := '0';
		signal round_s : bit4 := "0001";

	begin 
		DUT : KeyExpansion_IO
		port map (
			key_i => key_i_s,
            expansion_key_o => expansionkey_s,
			clock_i => clock_s,
			reset_i => reset_s,
			round_i => round_s,
			start_i => enable_s,
			end_o => end_s
		);

	a:process
	begin
	clock_s <='0';
	enable_s <= '1';
	reset_s <= '0';
	round_s <= "0001";
	wait for 10 ns;
	reset_s <= '1';
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';	
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	wait for 10 ns;
	clock_s <='0';
	wait for 10 ns;
	clock_s <='1';
	round_s <= "0001";
	wait for 10 ns;
	clock_s <='0';
	end process;



		
		
end architecture KeyExpansion_IO_tb_arch;

configuration KeyExpansion_IO_tb_conf of KeyExpansion_IO_tb is 
	for KeyExpansion_IO_tb_arch
		for DUT : KeyExpansion_IO
			use entity lib_src.KeyExpansion_IO(KeyExpansion_IO_arch);
		end for;
	end for;
end KeyExpansion_IO_tb_conf;


