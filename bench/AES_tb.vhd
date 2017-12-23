library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;
use lib_src.all;

entity AES_tb is
end entity AES_tb;

architecture AES_tb_arch of AES_tb is
component AES
port(	clock_i : in std_logic;
	reset_i : in std_logic;
	start_i : in std_logic;
	key_i : in  bit128;
        data_i : in bit128;
	data_o : out bit128;
	aes_on_o : out std_logic);
end component;
signal data_is : bit128;
signal key_is : bit128;
signal data_os : bit128;
signal done_os : std_logic;
signal reset_is : std_logic;
signal clock_is : std_logic;
signal start_is : std_logic;
begin 
	DUT : AES
	port map(
		clock_i => clock_is,
		reset_i => reset_is,
		start_i => start_is,
		key_i => key_is,
		data_i => data_is,
		data_o => data_os,
		aes_on_o => done_os);

	P0 : process
	begin
		data_is <= X"526573746f20656e2076696c6c65203f";
		key_is <= X"2b7e151628aed2a6abf7158809cf4f3c";
		wait for 3000 ns;
		data_is <= X"3243f6a8885a308d313198a2e0370734";
		wait;
	end process P0;

	P1 : process
	begin 
		reset_is <= '1';
		wait for 10 ns;
		reset_is <= '0';
		wait;
	end process P1;

	P2 : process
	begin 
		start_is <= '0';
		wait for 100 ns;
		start_is <= '1';
		wait for 120 ns;
		start_is <= '0';
		wait for 3000 ns;
		start_is <= '1';
		wait for 120 ns;
		start_is <= '0';
		wait;
	end process P2;

	Pclk : process
	begin 
		clock_is <= '0';
		wait for 50 ns;
		clock_is <= '1';
		wait for 50 ns;
	end process Pclk;

end architecture AES_tb_arch;


