library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;
entity DIGITALTUBE is
port (
	clk_50MHz : in std_logic;
	left_score : in natural range 0 to 3;
	right_score : in natural range 0 to 3;
	left_tube : out std_logic_vector(6 downto 0);
	right_tube : out std_logic_vector(6 downto 0)
);
end entity DIGITALTUBE;
architecture digital_tube of DIGITALTUBE is
signal left_tube_sig : std_logic_vector(6 downto 0);
signal left_tube_r_sig : std_logic_vector(6 downto 0);
signal right_tube_sig : std_logic_vector(6 downto 0);
signal right_tube_r_sig : std_logic_vector(6 downto 0);


begin
	left_tube <= left_tube_r_sig;
	right_tube <= right_tube_r_sig;
	process(clk_50MHz)
		begin
			if rising_edge(clk_50MHz) then
				case (left_score) is---------------gfedcba
						when 0 =>  left_tube_sig <= "0111111";
						when 1 =>  left_tube_sig <= "0000110";
						when 2 =>  left_tube_sig <= "1011011";
						when 3 =>  left_tube_sig <= "1001111";
						when others =>  left_tube_sig <= "1100110";
				end case;
				case (right_score) is---------gfedcba
						when 0 =>  right_tube_sig <= "0111111";
						when 1 =>  right_tube_sig <= "0000110";
						when 2 =>  right_tube_sig <= "1011011";
						when 3 =>  right_tube_sig <= "1001111";
						when others =>  right_tube_sig <= "1100110";
				end case;
			end if;
		end process;
	process(clk_50MHz)
		begin
			left_tube_r_sig <= left_tube_sig;
			right_tube_r_sig <= right_tube_sig;
		end process;
end digital_tube;



