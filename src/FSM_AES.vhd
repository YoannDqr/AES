library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library thirdparty;
use thirdparty.crypt_pack.all;

entity FSM_AES is
    Port ( resetb_i : in  STD_LOGIC;
           clock_i : in  STD_LOGIC;
           start_i : in  STD_LOGIC;
		end_key_expander_i : in std_logic;
		reset_key_expander_o : out std_logic;
		start_key_expander_o : out std_logic;
		round_key_expander_o : out bit4;

		enableMixcolumns_o : out std_logic;
		enableRoundcomputing_o : out std_logic;
		enableOutput_o : out std_logic;
		done_o : out std_logic);
end FSM_AES;

architecture FSM_AES_arch  of FSM_AES is
type state_type is (reset, hold, init, start_keyexpand, wait_keyexpand, round0, roundn, lastround, done);
signal present_state, next_state : state_type;
signal counter_s : integer range 0 to 10;
begin

sequentiel : process(clock_i, resetb_i, counter_s)
begin
	if resetb_i = '0' then
		present_state <= reset;
	elsif rising_edge(clock_i) then
		present_state <= next_state;
		if (present_state = round0) then
		  counter_s <= 1;
		elsif (present_state = roundn) then
		  counter_s <= counter_s + 1;
		end if;
	end if;
end process;

C0 : process(present_state, start_i, counter_s, end_key_expander_i)
begin
	case present_state is
		when reset => 
				next_state <= hold;
		when hold =>
				if start_i = '1' then
					next_state <= init;
				else
					next_state <= hold;
				end if;
		when init => 
				if (end_key_expander_i = '1') then
					next_state <= round0;
				else
					next_state <= start_keyexpand;
				end if;
		when start_keyexpand =>
				next_state <= wait_keyexpand;
		when wait_keyexpand => 
				if (end_key_expander_i = '1') then 
					next_state <= round0;
				else
					next_state <= wait_keyexpand;
				end if;
		when round0 =>  
				next_state <= roundn;
		when roundn =>
				if counter_s = 9 then
					next_state <= lastround;
				else
					next_state <= roundn;
				end if;
		when lastround => 
				next_state <= done;
		when done =>
				next_state <= hold;
	end case;
end process C0;

C1 : process(present_state, counter_s)
begin
	case present_state is
		when reset => 
			reset_key_expander_o <= '0';
			start_key_expander_o <= '0';
			round_key_expander_o <= X"0";
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '0';
			enableOutput_o <= '0';
			done_o <= '0';
		when hold =>
			reset_key_expander_o <= '1';
			start_key_expander_o <= '0';
			round_key_expander_o <= X"0";
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '0';
			enableOutput_o <= '0';
			done_o <= '0';
		when init =>
			reset_key_expander_o <= '1';
			start_key_expander_o <= '0';
			round_key_expander_o <= X"0";
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '0';
			enableOutput_o <= '0';
			done_o <= '1';
		when start_keyexpand =>
			reset_key_expander_o <= '1';
			start_key_expander_o <= '1';
			round_key_expander_o <= X"0";
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '0';
			enableOutput_o <= '0';
			done_o <= '1';
		when wait_keyexpand => 
			reset_key_expander_o <= '1';
			start_key_expander_o <= '1';
			round_key_expander_o <= X"0";
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '0';
			enableOutput_o <= '0';
			done_o <= '1';
		when round0 => 
			reset_key_expander_o <= '1';
			start_key_expander_o <= '0';
			round_key_expander_o <= X"0";
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '0';
			enableOutput_o <= '0';
			done_o <= '1';
		when roundn =>
			reset_key_expander_o <= '1';
			start_key_expander_o <= '0';
			round_key_expander_o <= conv_std_logic_vector(counter_s,4);
			enableMixColumns_o <= '1';
			enableRoundcomputing_o <= '1';
			enableOutput_o <= '0';
			done_o <= '1';
		when lastround =>
			reset_key_expander_o <= '1';
			start_key_expander_o <= '0';
			round_key_expander_o <= conv_std_logic_vector(counter_s,4);
			enableMixColumns_o <= '0';
			enableRoundcomputing_o <= '1';
			enableOutput_o <= '0';
			done_o <= '1';
		when done =>
			reset_key_expander_o <= '1';
			start_key_expander_o <= '0';
			round_key_expander_o <= conv_std_logic_vector(counter_s,4);
			enableMixColumns_o <= '0';
			enableRoundcomputing_o <= '1';
			enableOutput_o <= '1';
			done_o <= '0';
	end case;
end process C1;

end FSM_AES_arch;

