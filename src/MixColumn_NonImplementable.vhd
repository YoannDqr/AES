library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity mixColumn is 
    port(
        data_i : in column_state;
        data_o : out column_state
    );
end entity mixColumn;

architecture mixColumn_arch of mixColumn is
    type mat is array(0 to 3) of column_state;
    constant matriceChange : mat := (
    (X"02", X"03", X"01", X"01"),
    (X"01", X"02", X"03", X"01"),
    (X"01", X"01", X"02", X"03"),
    (X"03", X"01", X"01", X"02")); 

begin

    P0 : process(data_i)
        variable produit : column_state;
        begin
        l1 : for i in 0 to 3 loop
            produit(i) := X"00";
            l2 : for k in 0 to 3 loop
                i1 : if matriceChange(i)(k) >= X"02" then -- multipication par 2 ou 3
                    produit(i) := produit(i) xor ( data_i(k)(6 downto 0)&'0' xor ( b"000" & data_i(k)(7) & data_i(k)(7) & '0' & data_i(k)(7) & data_i(k)(7) ) );
                end if;
                i2: if matriceChange(i)(k) = X"01" or matriceChange(i)(k) = X"03" then --multiplication par 1 ou 3
                    produit(i) := produit(i) xor data_i(k);
                end if;
            end loop;
            data_o(i) <= produit(i);
        end loop;
    end process;

end;

