library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;

entity mixColumn_tb is
begin
end;

architecture mixColumn_tb_arch of mixColumn_tb is
    component mixColumn
        port(
            data_i : in type_state;
            enableMixColumns_i : in std_logic;
            data_o : out type_state
        );
    end component;

    signal data_i_s : type_state;
    signal enableMixColumns_s : std_logic := '1';
    signal data_o_s : type_state;

    begin
        DUT : mixColumn
        port map(
            data_i => data_i_s,
            enableMixColumns_i => enableMixColumns_s,
            data_o => data_o_s
        );

        data_i_s <= (
            (X"db", X"f2", X"01", X"c6"),
            (X"13", X"0a", X"01", X"c6"),
            (X"53", X"22", X"01", X"c6"),
            (X"45", X"5c", X"01", X"c6")
        );        
end;

configuration mixColumn_tb_conf of mixColumn_tb is
    for mixColumn_tb_arch
        for DUT : mixColumn
            use entity lib_src.mixColumn(mixColumn_arch);
        end for;
    end for;
end;