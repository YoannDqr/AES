library IEEE;
use IEEE.numeric_std.all;
use IEEE.std_logic_1164.all;
library thirdparty;
use thirdparty.crypt_pack.all;
library lib_src;

entity Compteur is
    port(
        clock_i : in std_logic;
        reset_i : in std_logic;
        enable_i : in std_logic;
        init_i : in std_logic;
        counter_o : out bit4
    );
end entity;
architecture Compteur_arch of Compteur is
    signal count_s : integer range 0 to 15 := 0;
    begin
    process(clock_i, reset_i)
        begin
        if reset_i = '1' then count_s <= 0;
        else
            if clock_i'event and clock_i = '1' then
                if enable_i = '1' then 
                    if init_i = '1' then count_s <= 0;
                    else count_s <= count_s + 1;
                    end if;
                else 
                    count_s <= count_s;
                end if;
            end if;
        end if; --pas besoin de else dans un process de test d'un front montant
    end process;
    counter_o <=std_logic_vector(to_unsigned(count_s, 4));
end architecture;
