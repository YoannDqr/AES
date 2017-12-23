library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity addRoundKey is
    port(
        data_i : in type_state;
        key_i : in type_state;
        data_o : out type_state
    );
end entity addRoundKey;

architecture addRoundKey_arch of addRoundKey is  
begin
    l1 : for i in 0 to 3 generate
        l2 : for j in 0 to 3 generate
            data_o(i)(j) <= key_i(i)(j) xor data_i(i)(j);
        end generate;
    end generate;
end;