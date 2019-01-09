library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
entity TUGCONTROL is
port (
	clk_50MHz : in std_logic;
	k1_negedge : in std_logic;
	k2_negedge : in std_logic;
	rst_negedge : in std_logic;
	nrst_negedge : in std_logic;
	left_score : out natural range 0 to 3;
	right_score : out natural range 0 to 3;
	code : out std_logic_vector(3 downto 0);
	left_play : out std_logic;
	right_play : out std_logic
);
end entity TUGCONTROL;
architecture tug_control of TUGCONTROL is

signal left_score_sig : natural range 0 to 3 := 0;
signal right_score_sig : natural range 0 to 3 := 0;
signal code_sig : std_logic_vector(3 downto 0) := "0011";
signal left_play_sig : std_logic := '0';
signal right_play_sig : std_logic := '0';
begin
	left_score <= left_score_sig;
	right_score <= right_score_sig;
	left_play <= left_play_sig;
	right_play <= right_play_sig;
	code <= code_sig;
	process(clk_50MHz, nrst_negedge, rst_negedge, k1_negedge, k2_negedge)
	variable running_var : std_logic := '1';
	variable running_g_var : std_logic := '1';
	variable left_play_var : std_logic := '0';
	variable right_play_var : std_logic := '0';
	variable left_score_var : natural range 0 to 3 := 0;
	variable right_score_var : natural range 0 to 3 := 0;
	variable code_var : std_logic_vector(3 downto 0) := "0011";
		begin
			if rising_edge(clk_50MHz) then
				if (nrst_negedge = '1') then--rest whole game
					if rising_edge(clk_50MHz) then
						left_score_var := 0;
						right_score_var := 0;
						code_var := "0011";
						running_var := '1';
						running_g_var := '1';
					end if;
				elsif (rst_negedge = '1') then--rest current single game
					if rising_edge(clk_50MHz) then
						if (running_g_var = '1') then
							code_var := "0011";
							running_var := '1';
						end if;
					end if;
				else
					if (running_var = '1') then
						if (k1_negedge = '1') then
								code_var := code_var - 1; --light led move to left
								if (code_var = "0000") then
									left_score_var := left_score_var + 1;
									if ((left_score_var + right_score_var) = 3) then
										running_g_var := '0';
										if (left_score_var > right_score_var) then
											left_play_var := '1';
										else
											right_play_var := '1';
										end if;
									end if;
									running_var := '0';
								end if;
						elsif (k2_negedge = '1') then
								code_var := code_var + 1; --light led move to right
								if (code_var = "0110") then
									right_score_var := right_score_var + 1;
									if ((left_score_var + right_score_var) = 3) then
										running_g_var := '0';
										if (left_score_var > right_score_var) then
											left_play_var := '1';
										else
											right_play_var := '1';
										end if;
									end if;
									running_var := '0';
								end if;
							end if;
					end if;
				end if;
				if (left_play_var = '1' or right_play_var = '1') then
					if (left_play_var = '1') then
						left_play_sig <= '1';--play left music
						right_play_sig <= '0';
						left_play_var := '0';
						right_play_var := '0';
					else
						left_play_sig <= '0';
						right_play_sig <= '1';--play right music
						left_play_var := '0';
						right_play_var := '0';
					end if;
				else
					left_play_sig <= '0';
					right_play_sig <= '0';
				end if;
			end if;
			left_score_sig <= left_score_var;
			right_score_sig <= right_score_var;
			code_sig <= code_var; 
		end process;
end tug_control;
