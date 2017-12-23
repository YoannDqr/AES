library IEEE;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;
use lib_src.all;

entity AESRound is
port(	text_i : in bit128;
	currentkey_i : in bit128;
	data_o : out bit128;
	clock_i : in std_logic;
	resetb_i : in std_logic;
	enableMixcolumns_i : in std_logic;
	enableRoundcomputing_i : in std_logic);
end entity AESRound;

architecture AESRound_arch of AESRound is
component AddRoundKey
port( data_i : in type_state;
      key_i : in type_state;
      data_o : out type_state);
end component;
component mixColumn
port( data_i : in type_state;
      enableMixColumns_i : in std_logic;
      data_o : out type_state);
end component;
component ShiftRow
port( data_i : in type_state;
      data_o : out type_state);
end component;
component SubBytes
port( data_i : in type_state;
      data_o : out type_state);
end component;
signal data_s : type_state;
signal textState_s : type_state;
signal currentStateKey_s : type_state;
signal inputAddRoundkey_s : type_state;
signal outputAddRoundKey_s : type_state;
signal inputSubBytes_s : type_state;
signal outputSubBytes_s : type_state;
signal outputShiftRow_s : type_state;
signal outputMixColumns_s : type_state;
signal vectorAddRoundkey_s : bit128;
begin
	inputSubBytes_s <= data_s;
	U0 : SubBytes
	port map(
		data_i => inputSubBytes_s,
		data_o => outputSubBytes_s);

	U1 : ShiftRow
	port map(
		data_i => outputSubBytes_s,
		data_o => outputShiftRow_s);

	U2 : mixColumn
	port map(
		data_i => outputShiftRow_s,
		enableMixColumns_i => enableMixColumns_i,
		data_o => outputMixColumns_s);

	U3 : AddRoundkey
	port map(
		data_i => inputAddRoundKey_s,
		key_i => currentStateKey_s,
		data_o => outputAddRoundkey_s);

	-- convert text on 128bits to type state
	F0 : for i in 0 to 3 generate
		F1 : for j in 0 to 3 generate
			textState_s(i)(j) <= text_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	-- convert type state in 128bits vector
	F2 : for i in 0 to 3 generate
		F3 : for j in 0 to 3 generate
			data_o(127-32*j-8*i downto 120-32*j-8*i) <= data_s(i)(j);
		end generate;
	end generate;

	-- convert current key to type state
	F4 : for i in 0 to 3 generate
		F5 : for j in 0 to 3 generate
			currentStateKey_s(i)(j) <= currentKey_i(127-32*j-8*i downto 120-32*j-8*i);
		end generate;
	end generate;

	-- select AddRoundKey function input according to round computing (initial or next others)
	inputAddRoundKey_s <= outputMixColumns_s when enableRoundcomputing_i = '1' else textState_s;

	-- store AddRoundKey function output
	P0 : process(outputAddRoundkey_s, clock_i, resetb_i)
	begin
		if resetb_i = '0' then
			F6 : for i in 0 to 3 loop
				F7 : for j in 0 to 3 loop
					data_s(i)(j) <= (others => '0');
				end loop;
			end loop;
		elsif (rising_edge(clock_i)) then
			data_s <= outputAddRoundkey_s;
		end if;
	end process P0;
end architecture AESRound_arch;

configuration AESRound_configuration of AESRound is
for AESRound_arch
	for U0 : SubBytes
		use entity lib_src.SubBytes(subBytes_arch);
	end for;
	for U1 : ShiftRow
		use entity lib_src.ShiftRow(shiftRow_arch);
	end for;
	for U2 : mixColumn
		use entity lib_src.mixColumn(mixColumn_arch);
	end for;
	for U3 : AddRoundKey
		use entity lib_src.AddRoundKey(addRoundKey_arch);
	end for;
end for;
end configuration;

