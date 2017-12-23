library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;

entity addRoundKey_tb is
begin
end;

architecture addRoundKey_tb_arch of addRoundKey_tb is
    component addRoundKey
        port(
            data_i : in type_state;
            key_i : in type_state;
            data_o : out type_state
        );
    end component;

    signal data_i_s : type_state;
    signal key_i_s : type_state;
    signal data_o_s : type_state;

    begin
        DUT : addRoundKey
        port map(
            data_i => data_i_s,
            key_i => key_i_s,
            data_o => data_o_s
        );

        data_i_s <= (
            (X"04", X"E0", X"48", X"28"),
            (X"66", X"CB", X"F8", X"06"),
            (X"81", X"19", X"D3", X"26"),
            (X"E5", X"9A", X"7A", X"4C")
        );

        key_i_s <= (
            (X"A0", X"88", X"23", X"2A"),
            (X"FA", X"54", X"A3", X"6C"),
            (X"FE", X"2C", X"39", X"76"),
            (X"17", X"B1", X"39", X"05")
        );        
end;

configuration addRoundKey_tb_conf of addRoundKey_tb is
    for addRoundKey_tb_arch
        for DUT : addRoundKey
            use entity lib_src.addRoundKey(addRoundKey_arch);
        end for;
    end for;
end;