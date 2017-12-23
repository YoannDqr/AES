library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;

entity KeyExpansion_IO is
    port(
        key : in bit128;
        expansionkey_o : out bit128;
        clock : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        round_i : in bit4;
        end_o : out std_logic
    );
end entity;

architecture KeyExpansion_IO_arch of KeyExpansion_IO is 
    component KeyExpansion
        port(
            key_i : in bit128;
            recon_i : in bit8;
            expansion_key_o : out bit128
        );
    end component;
    signal memory : key_memory := (others => X"00000000000000000000000000000000");
    begin
    memory(0) <= key;
    g1 : for i in 1 to 10 generate
        S0 : KeyExpansion
        port map(
            key_i => memory(i-1),
            recon_i => rcon(i-1),
            expansion_key_o => memory(i)
        );
    end generate g1;
    expansionkey_o <= memory(conv_integer(unsigned(round_i)));

end architecture;

configuration KeyExpansion_IO_conf of KeyExpansion_IO is
    for KeyExpansion_IO_arch
        for g1 
            for S0 : KeyExpansion
                use entity lib_src.KeyExpansion(KeyExpansion_arch);
            end for;
        end for;
    end for;
end configuration;
