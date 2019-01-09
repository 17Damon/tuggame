library IEEE;
use IEEE.std_logic_1164.all;
entity LEDCONTROL is
port (
	clk_50MHz : in std_logic;
	code : in std_logic_vector(3 downto 0);
	led : out std_logic_vector(6 downto 0)
);
end entity LEDCONTROL;
architecture led_control of LEDCONTROL is
begin
	process(clk_50MHz)
		begin
			case (code) is
				when "0000" => led <= "1000000";
				when "0001" => led <= "0100000";
				when "0010" => led <= "0010000";
				when "0011" => led <= "0001000";
				when "0100" => led <= "0000100";
				when "0101" => led <= "0000010";
				when "0110" => led <= "0000001";
				when others => led <= "0000000";
			end case;
		end process;
end led_control;
