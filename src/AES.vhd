library IEEE;
library lib_src;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
library thirdparty;
use thirdparty.crypt_pack.all;

entity AES is
port(	clock_i : in std_logic;
	reset_i : in std_logic;
	start_i : in std_logic;
	key_i : in  bit128;
	data_i : in bit128;
	data_o : out bit128;
	aes_on_o : out std_logic);
end entity AES;

architecture AES_arch of AES is
component KeyExpansion_IO
    Port ( key_i : in  bit128;
	   clock_i : in std_logic;
	   reset_i : in std_logic;
	   start_i : in std_logic;
	   round_i : in bit4;
	   end_o : out std_logic;
           expansion_key_o : out bit128);
end component;
component FSM_AES 
    Port ( resetb_i : in  std_logic;
           clock_i : in  std_logic;
           start_i : in  std_logic;
	   reset_key_expander_o : out std_logic;
	   start_key_expander_o : out std_logic;
	   round_key_expander_o : out bit4;
	   end_key_expander_i : in std_logic;
	   enableMixcolumns_o : out std_logic;
	   enableRoundcomputing_o : out std_logic;
	   enableOutput_o : out std_logic;
	   done_o : out std_logic);
end component;
component AESRound
port(	text_i : in bit128;
	currentkey_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic);
end component;

signal resetb_s : std_logic;
signal reset_keyexpander_s : std_logic;
signal start_keyexpander_s : std_logic;
signal round_keyexpander_s : bit4;
signal end_keyexpander_s : std_logic;
signal data_s : bit128;
signal outputKeyExpander_s : bit128;
signal enableMixcolumns_s : std_logic;
signal enableRoundcomputing_s : std_logic;

signal enableOutput_s : std_logic;

begin 
	-- positive reset
	resetb_s <= not reset_i;

	-- key expander component
	U0 : KeyExpansion_IO
	port map( key_i => key_i,
	   clock_i => clock_i,
	   reset_i => reset_keyexpander_s,
	   start_i => start_keyexpander_s,
	   round_i => round_keyexpander_s,
	   end_o => end_keyexpander_s,
           expansion_key_o => outputKeyExpander_s);

	U1 : FSM_AES 
	Port map( 
		resetb_i => resetb_s,
		clock_i => clock_i,
		start_i => start_i,
		reset_key_expander_o => reset_keyexpander_s,
		start_key_expander_o => start_keyexpander_s,
		round_key_expander_o => round_keyexpander_s,
		end_key_expander_i => end_keyexpander_s,
		enableMixcolumns_o => enableMixColumns_s, 
		enableRoundComputing_o => enableRoundComputing_s,
	        enableOutput_o => enableOutput_s,
	        done_o => aes_on_o);

	U2 : AESRound
	port map(
		text_i => data_i,
		currentkey_i => outputKeyExpander_s,
		data_o => data_s,
		clock_i => clock_i,
		resetb_i => resetb_s,
		enableMixcolumns_i => enableMixColumns_s, 
		enableRoundcomputing_i => enableRoundComputing_s);

	data_o <= data_s when enableOutput_s = '1' else (others => 'Z');
end architecture AES_arch;

configuration AES_configuration of AES is
	for AES_arch
		for U0 : KeyExpansion_IO
			use entity lib_src.KeyExpansion_IO(KeyExpansion_IO_arch);
		end for;
		for U1 : FSM_AES
			use entity lib_src.FSM_AES(FSM_AES_arch);
		end for;
		for U2 : AESRound
			use entity lib_src.AESRound(AESRound_arch);
		end for;
	end for;
end configuration AES_configuration;


