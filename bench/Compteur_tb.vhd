library lib_src;
library IEEE;
library thirdparty ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
use thirdparty.crypt_pack.all;

entity compteur_tb is
end entity;

architecture compteur_tb_arch of compteur_tb is
component compteur is
    port(
        clock_i : in std_logic;
        reset_i : in std_logic;
        enable_i : in std_logic;
        init_i : in std_logic;
        counter_o : out bit4
    );
end component;

signal clock : std_logic;
signal reset: std_logic;
signal counter : bit4;
signal init : std_logic;
begin
U0 : compteur
	port map(
		clock_i => clock,
        reset_i => reset,
        enable_i => '1',
        init_i => init,
        counter_o => counter
    );

a:process
begin 
clock <= '0';
reset <= '1';
init <= '1';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '1';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '0';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '1';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '0';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '1';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '0';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '1';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '0';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '1';
wait for 100 ns;
reset <= '0';
init <= '0';
clock <= '0';

end process;
end architecture;

configuration compteur_tb_conf of compteur_tb is
    for compteur_tb_arch
        for U0 : compteur
            use entity lib_src.Compteur(Compteur_arch);
        end for;
    end for;
end compteur_tb_conf;
