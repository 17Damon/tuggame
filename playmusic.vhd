library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity PLAYMUSIC is
port (
	clk_50MHz : in std_logic;
	nrst_negedge : in std_logic;
	left_play : in std_logic;
	right_play : in std_logic;
	beep : out std_logic
);
end entity PLAYMUSIC;
architecture beh of PLAYMUSIC is
signal beep_sig : std_logic := '1';

begin
	beep <= beep_sig;
		
	process(clk_50MHz, nrst_negedge, left_play, right_play)
		variable L_5 : std_logic_vector(15 downto 0) := conv_std_logic_vector(63775, 16);
		variable L_6 : std_logic_vector(15 downto 0) := conv_std_logic_vector(56818, 16);
		variable M_1 : std_logic_vector(15 downto 0) := conv_std_logic_vector(47801, 16);
		variable M_2 : std_logic_vector(15 downto 0) := conv_std_logic_vector(42589, 16);
		variable M_3 : std_logic_vector(15 downto 0) := conv_std_logic_vector(37936, 16);
		variable M_5 : std_logic_vector(15 downto 0) := conv_std_logic_vector(31887, 16);
		variable M_6 : std_logic_vector(15 downto 0) := conv_std_logic_vector(28409, 16);
		variable M_7 : std_logic_vector(15 downto 0) := conv_std_logic_vector(25303, 16);
		variable H_1 : std_logic_vector(15 downto 0) := conv_std_logic_vector(23900, 16);
		variable H_2 : std_logic_vector(15 downto 0) := conv_std_logic_vector(21276, 16);
		variable H_3 : std_logic_vector(15 downto 0) := conv_std_logic_vector(18968, 16);
		variable H_4 : std_logic_vector(15 downto 0) := conv_std_logic_vector(17895, 16);
		variable H_5 : std_logic_vector(15 downto 0) := conv_std_logic_vector(15943, 16);
		variable H_6 : std_logic_vector(15 downto 0) := conv_std_logic_vector(14204, 16);
		variable H_7 : std_logic_vector(15 downto 0) := conv_std_logic_vector(12709, 16);
		variable TIME_VAR : std_logic_vector(23 downto 0) := conv_std_logic_vector(12000000, 24);
		variable count_var : std_logic_vector(15 downto 0);
		variable count_end_var : std_logic_vector(15 downto 0);
		variable count1_var : std_logic_vector(23 downto 0);
		variable state1_var : std_logic_vector(7 downto 0);
		variable left_play_var : std_logic := '0';
		variable right_play_var : std_logic := '0';
		begin
			if rising_edge(clk_50MHz) then
			if (nrst_negedge = '1') then
				left_play_var := '0';
				right_play_var := '0';
				beep_sig <= '1';
			else
				if (left_play_var = '0' and right_play_var = '0') then
					beep_sig <= '1';
					if (left_play = '1') then
						left_play_var := '1';
					end if;
					if (right_play = '1') then
						right_play_var := '1';
					end if;
				elsif (left_play_var = '1' or right_play_var = '1') then
					count_var := count_var + conv_std_logic_vector(1, 16);
					if (count_var = count_end_var) then
						count_var := conv_std_logic_vector(0, 16);
						beep_sig <= not beep_sig;
					end if;
					if (count1_var < conv_std_logic_vector(12000000, 24)) then
						count1_var := count1_var + 1;
					else
						if (left_play_var = '1') then
							count1_var := conv_std_logic_vector(0, 24);
							if (conv_integer(state1_var) = 147) then
							--if (conv_integer(state1_var) = 10) then
								state1_var := conv_std_logic_vector(0, 8);
								left_play_var := '0';
								right_play_var := '0';
							else
								state1_var := state1_var + 1;
							end if;
							case (conv_integer(state1_var)) is
								when 0 | 1 => count_end_var := L_5;
								when 2 | 3 | 4 | 5 | 6 | 7 | 8 => count_end_var := M_1;
								when 9 | 10 => count_end_var := M_3;
								when 11 | 12 | 13 | 14 => count_end_var := M_2;
								when 15 => count_end_var := M_1;
								when 16 | 17 => count_end_var := M_2;
								when 18 | 19 => count_end_var := M_3;
								when 20 | 21 | 22 | 23 | 24 => count_end_var := M_1;
								when 25 | 26 => count_end_var := M_3;
								when 27 | 28 => count_end_var := M_5;
								when 29 | 30 | 31 | 32 | 33 => count_end_var := M_6;
								when 34 | 35 | 36 | 37 | 38 => count_end_var := M_6;
								when 39 | 40 | 41 | 42 => count_end_var := M_5;
								when 43 | 44 | 45 => count_end_var := M_3;
								when 46 | 47 => count_end_var := M_1;
								when 48 | 49 | 50 | 51 => count_end_var := M_2;
								when 52 => count_end_var := M_1;
								when 53 | 54 => count_end_var := M_2;
								when 55 | 56 => count_end_var := M_3;
								when 57 | 58 | 59 | 60 => count_end_var := M_1;
								when 61 | 62 | 63 => count_end_var := L_6;
								when 64 | 65 => count_end_var := M_5;
								when 66 | 67 | 68 | 69 => count_end_var := M_1;
								when 70 | 71 | 72 | 73 => count_end_var := M_1;
								when 74 | 75 => count_end_var := M_6;
								when 76 | 77 | 78 | 79 => count_end_var := M_5;
								when 80 | 81 | 82 => count_end_var := M_3;
								when 83 | 84 => count_end_var := M_1;
								when 85 | 86 | 87 | 88 => count_end_var := M_2;
								when 89 => count_end_var := M_1;
								when 90 | 91 => count_end_var := M_2;
								when 92 | 93 => count_end_var := M_6;
								when 94 | 95 | 96 | 97 => count_end_var := M_5;
								when 98 | 99 | 100 => count_end_var := M_3;
								when 101 | 102 => count_end_var := M_5;
								when 103 | 104 | 105 | 106 => count_end_var := M_6;
								when 107 | 108 | 109 | 110 => count_end_var := M_6;
								when 111 | 112 => count_end_var := H_1;
								when 113 | 114 | 115 | 116 => count_end_var := M_5;
								when 117 | 118 | 119 => count_end_var := M_3;
								when 120 | 121 => count_end_var := M_1;
								when 122 | 123 | 124 | 125 => count_end_var := M_2;
								when 126 => count_end_var := M_1;
								when 127 | 128 => count_end_var := M_2;
								when 129 | 130 => count_end_var := M_3;
								when 131 | 132 | 133 | 134 => count_end_var := M_1;
								when 135 | 136 | 137 => count_end_var := L_6;
								when 138 | 139 => count_end_var := M_5;
								when 140 | 141 | 142 | 143 => count_end_var := M_1;
								when 144 | 145 | 146 | 147 => count_end_var := M_1;
								when others => count_end_var := conv_std_logic_vector(0, 16);
							end case;
						elsif (right_play_var = '1') then
							count1_var := conv_std_logic_vector(0, 24);
							if (conv_integer(state1_var) = 139) then
							--if (conv_integer(state1_var) = 147) then
								state1_var := conv_std_logic_vector(0, 8);
								left_play_var := '0';
								right_play_var := '0';
							else
								state1_var := state1_var + 1;
							end if;
							case (conv_integer(state1_var)) is
							when 0 | 1 | 2 | 3  => count_end_var := M_3;
							when 4 | 5 | 6 => count_end_var := M_5;
							when 7 => count_end_var := M_6;
							when 8 | 9 | 10 => count_end_var := H_1;
							when 11 => count_end_var := H_2;
							when 12 => count_end_var := M_6;
							when 13 => count_end_var := H_1;
							when 14 | 15 => count_end_var := M_5;
							when 16 | 17 | 18 => count_end_var := H_5;
							when 19 => count_end_var := H_1;
							when 20 => count_end_var := H_6;
							when 21 => count_end_var := H_5;
							when 22 => count_end_var := H_3;
							when 23 => count_end_var := H_5;
							when 24 | 25 | 26 | 27 | 28 | 29 | 30 | 31 | 32 | 33 | 34 => count_end_var := H_2;
							when 35 => count_end_var := H_3;
							when 36 | 37 => count_end_var := M_7;
							when 38 | 39 => count_end_var := M_6;
							when 40 | 41 | 42 => count_end_var := M_5;
							when 43 => count_end_var := M_6;
							when 44 | 45 => count_end_var := H_1;
							when 52 => count_end_var := M_6;
							when 53 => count_end_var := M_5;
							when 54 => count_end_var := M_5;
							when 55 => count_end_var := H_1;
							when 56 | 57 | 58 | 59 | 60 | 61 | 62 | 63 => count_end_var := M_5;
							when 64 | 65 | 66 => count_end_var := H_3;
							when 67 => count_end_var := H_5;
							when 68 | 69 => count_end_var := M_7;
							when 70 | 71 => count_end_var := H_2;
							when 72 => count_end_var := M_6;
							when 73 => count_end_var := H_1;
							when 74 | 75 | 76  | 77 | 78 | 79 => count_end_var := M_5;
							when 80 => count_end_var := M_3;
							when 81 => count_end_var := M_5;
							when 82 | 83 => count_end_var := M_3;
							when 84 => count_end_var := M_5;
							when 85 => count_end_var := M_6;
							when 86 => count_end_var := M_7;
							when 87 => count_end_var := H_2;
							when 88 | 89 | 90 | 91 | 92 | 93 => count_end_var := M_6;
							when 94 => count_end_var := M_5;
							when 95 => count_end_var := M_6;
							when 96 | 97 | 98 => count_end_var := H_1;
							when 99 => count_end_var := H_2;
							when 100 | 101 | 102 => count_end_var := H_5;
							when 103 => count_end_var := H_3;
							when 104 | 105 => count_end_var := H_2;
							when 106 => count_end_var := H_3;
							when 107 => count_end_var := H_2;
							when 108 | 109 => count_end_var := H_1;
							when 110 => count_end_var := M_6;
							when 111 => count_end_var := M_5;
							when 112 | 113 | 114 | 115 => count_end_var := M_3;
							when 116 | 117 => count_end_var := H_1;
							when 118 => count_end_var := M_6;
							when 119 => count_end_var := H_1;
							when 120 => count_end_var := M_6;
							when 121 | 122 => count_end_var := M_3;
							when 123 => count_end_var := H_2;
							when 124 => count_end_var := M_3;
							when 125 => count_end_var := M_5;
							when 126 => count_end_var := M_6;
							when 127 => count_end_var := H_1;
							when 128 | 129 | 130 | 131 | 132 | 133 | 134 | 135 | 136 | 137 | 138 | 139 => count_end_var := M_5;
							when others => count_end_var := conv_std_logic_vector(0, 16);
						end case;
						end if;
					end if;
				else
					left_play_var := '0';
					right_play_var := '0';
					beep_sig <= '1';
				end if;
			end if;
		end if;
		end process;
end beh;

