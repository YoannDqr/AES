--Yoann DEQUEKER
--Transformation subBytes

library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity subBytes is 
    port(
        data_i : in type_state;
        data_o : out type_state
    );
end entity subBytes;

architecture subBytes_arch of subBytes is

    component Sbox
        port(
            SBOX_I : in bit8;
            SBOX_O : out bit8
        );
    end component;

begin

    l1 : for i in 0 to 3 generate
        l2 : for j in 0 to 3 generate
            U0 : Sbox
            port map (
                SBOX_I => data_i(i)(j),
                SBOX_O => data_o(i)(j)
            );
        end generate l2;
    end generate l1;

end architecture subBytes_arch;

configuration subBytes_conf of subBytes is
    for subBytes_arch
        for l1
			for l2
				for U0 : Sbox 
					use entity lib_src.Sbox(sbox_arch);
				end for;
			end for;
		end for;
    end for;
end configuration;