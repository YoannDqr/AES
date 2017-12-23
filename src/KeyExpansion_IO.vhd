library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;

entity KeyExpansion_IO is
    port(
        key_i : in bit128;
        expansion_key_o : out bit128;
        clock_i : in std_logic;
        reset_i : in std_logic;
        start_i : in std_logic;
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
    
    signal memory : bit128 := X"00000000000000000000000000000000";
    signal memory_sortie_s : bit128;
    signal memory_table_s : key_memory := (others => X"00000000000000000000000000000000");
    signal rcon_s : bit8:= rcon(0);
    signal counter_s : integer range 0 to 11 := 0;
    signal start_s : std_logic;
    signal round_s : bit4;
    begin
    S0 : KeyExpansion
    port map(
        key_i => memory,
        recon_i => rcon_s,
        expansion_key_o => memory_sortie_s
    );
    
    round_s <= round_i;
    PO: process(clock_i, start_s, reset_i, start_i, round_s)
    begin
        if start_i = '1' then
            start_s <= start_i;
        end if;

        if clock_i'event and clock_i = '1' and start_s = '1' and reset_i = '1' then
            if counter_s = 11 then
                expansion_key_o <= memory_table_s(conv_integer(unsigned(round_s)));
                memory_table_s <= memory_table_s;
                end_o <= '1';   
            else
                if(counter_s = 0) then
                    memory <= key_i;
                    memory_table_s(0) <= key_i;
                    rcon_s <= rcon(0);
                else
                    memory_table_s(counter_s) <= memory_sortie_s;
                    memory <= memory_sortie_s;
                    rcon_s <= rcon(counter_s);  
                end if;
                    counter_s <= counter_s + 1; 
                 
            end if;
        elsif reset_i = '0' then
            counter_s <= 0;
            memory <= X"00000000000000000000000000000000";
            memory_table_s <= (others => X"00000000000000000000000000000000");
        end if;

    end process;
    
end architecture;

configuration KeyExpansion_IO_conf of KeyExpansion_IO is
    for KeyExpansion_IO_arch
        for S0 : KeyExpansion
            use entity lib_src.KeyExpansion(KeyExpansion_arch);
        end for;
    end for;
end configuration;
