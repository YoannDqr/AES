library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity shiftRow is
    port(
        data_i : in type_state;
        data_o : out type_state
    );
end entity shiftRow;

architecture shiftRow_arch of shiftRow is  
begin
    l1 : for i in 0 to 3 generate
        l2 : for j in 0 to 3 generate
                data_o(i)(j) <= data_i(i)((i + j ) mod 4);
        end generate;
    end generate;
end;