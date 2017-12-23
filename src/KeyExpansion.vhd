library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;

entity KeyExpansion is
    port(
        key_i : in bit128;
        recon_i : in bit8;
        expansion_key_o : out bit128
    );
end entity;

architecture KeyExpansion_arch of KeyExpansion is
    signal key_save : type_state;
    signal new_key : type_state;
    signal key_column : row_state;
    signal tampon : row_state;
    signal tampon2 : row_state;

    component Sbox
        port(
            SBOX_I : in bit8;
            SBOX_O : out bit8
        );
    end component;

    component RotWord
        port(
            column_i : in row_state;
            column_o : out row_state
        );
    end component;

    begin
    g0 : for i in 0 to 3 generate
        g1 : for j in 0 to 3 generate
            key_save(i)(j) <= key_i(127-32*j-8*i downto 120-32*j-8*i );
        end generate;
    end generate;
    g11:for i in 0 to 3 generate
        key_column(i)<= key_save(i)(3); -- on extrait la premiere
    end generate;

    R0 : RotWord
    port map(
        column_i => key_column,
        column_o => tampon
    );

    g2 : for i in 0 to 3 generate
        S0 : Sbox
        port map(
            SBOX_I => tampon(i),
            SBOX_O => tampon2(i)
        );
    end generate g2;
    
    gt : for i in 0 to 3 generate -- permière colonne
        i0 : if i = 0 generate
            new_key(i)(0) <= key_save(i)(0) XOR tampon2(i) XOR recon_i;
        end generate;
        i1 : if i > 0 generate
            new_key(i)(0) <= key_save(i)(0) XOR tampon2(i);
        end generate;
    end generate;

    g3 : for j in 1 to 3 generate -- les autres colones
        g33 : for i in 0 to 3 generate
            new_key(i)(j) <= key_save(i)(j) XOR new_key(i)(j-1);
        end generate;
    end generate;

    g4 : for i in 0 to 3 generate
        g5 : for j in 0 to 3 generate
            expansion_key_o(127-32*j-8*i downto 120-32*j-8*i ) <= new_key(i)(j);
        end generate g5;
	end generate g4;

end architecture;

configuration KeyExpansion_conf of KeyExpansion is
    for KeyExpansion_arch
        for R0 : RotWord
            use entity lib_src.RotWord(rotword_arch);
        end for;
        for g2 
            for S0 : Sbox
                use entity lib_src.Sbox(sbox_arch);
            end for;
        end for;
    end for;
end configuration;


    