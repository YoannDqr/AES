library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;
entity RotWord is
    port(
        column_i : in row_state; -- not column state because keys are stocked into type_state. 
        column_o : out row_state 
    );
end entity;

architecture RotWord_arch of RotWord is
    begin
    g1 : for i in 0 to 2 generate
        column_o(i) <= column_i(i + 1);
    end generate;
    column_o(3) <= column_i(0);
end architecture;