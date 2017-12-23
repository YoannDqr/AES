library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity mixColumn is 
    port(
        data_i : in type_state;
        enableMixColumns_i : in std_logic;
        data_o : out type_state
    );
end entity mixColumn;

architecture mixColumn_arch of mixColumn is
    type mat is array(0 to 3) of column_state;
    constant matriceChange : mat := (
    (X"02", X"03", X"01", X"01"),
    (X"01", X"02", X"03", X"01"),
    (X"01", X"01", X"02", X"03"),
    (X"03", X"01", X"01", X"02")); 
    signal produit : type_state;
    

begin

    l1 : for k in 3 downto 0 generate 
        produit(0)(k) <= ((data_i(0)(k)(6 downto 0)&'0') xor ( b"000" & data_i(0)(k)(7) & data_i(0)(k)(7) & '0' & data_i(0)(k)(7) & data_i(0)(k)(7)))
                        xor
                         ((data_i(1)(k)(6 downto 0)&'0') xor ( b"000" & data_i(1)(k)(7) & data_i(1)(k)(7) & '0' & data_i(1)(k)(7) & data_i(1)(k)(7)) XOR data_i(1)(k))
                        xor data_i(2)(k) XOR data_i(3)(k);


        produit(1)(k) <= ((data_i(1)(k)(6 downto 0)&'0') xor ( b"000" & data_i(1)(k)(7) & data_i(1)(k)(7) & '0' & data_i(1)(k)(7) & data_i(1)(k)(7)))
                        XOR 
                         ((data_i(2)(k)(6 downto 0)&'0') xor ( b"000" & data_i(2)(k)(7) & data_i(2)(k)(7) & '0' & data_i(2)(k)(7) & data_i(2)(k)(7)) XOR data_i(2)(k))
                        XOR data_i(0)(k) XOR data_i(3)(k);


        produit(2)(k) <= ((data_i(2)(k)(6 downto 0)&'0') xor ( b"000" & data_i(2)(k)(7) & data_i(2)(k)(7) & '0' & data_i(2)(k)(7) & data_i(2)(k)(7)))
                        XOR 
                         ((data_i(3)(k)(6 downto 0)&'0') xor ( b"000" & data_i(3)(k)(7) & data_i(3)(k)(7) & '0' & data_i(3)(k)(7) & data_i(3)(k)(7)) XOR data_i(3)(k))
                        XOR data_i(0)(k) XOR data_i(1)(k);


        produit(3)(k) <= ((data_i(3)(k)(6 downto 0)&'0') xor ( b"000" & data_i(3)(k)(7) & data_i(3)(k)(7) & '0' & data_i(3)(k)(7) & data_i(3)(k)(7)))
                        XOR 
                         ((data_i(0)(k)(6 downto 0)&'0') xor ( b"000" & data_i(0)(k)(7) & data_i(0)(k)(7) & '0' & data_i(0)(k)(7) & data_i(0)(k)(7)) XOR data_i(0)(k))
                        XOR data_i(2)(k) XOR data_i(1)(k);
    end generate;
    data_o <= produit when enableMixColumns_i = '1' else data_i;
end;

