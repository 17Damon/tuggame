library IEEE;
use IEEE.std_logic_1164.all;
entity CLKDIVIDE is
port (
	clk_50MHz : in std_logic;
	clk_10kHz : buffer std_logic;
	clk_25Hz : buffer std_logic
);
end entity CLKDIVIDE;
architecture clk_divide of CLKDIVIDE is
signal cnt10k : natural range  0 to 2500;
signal cnt25 : natural range 0 to 1000000;
begin
	process(clk_50MHz)
		begin	
			if (clk_50MHz'event and clk_50MHz = '1') then
				if (cnt10k = 2499) then
					cnt10k <= 0;
					clk_10kHz <= not clk_10kHz;
				else
					cnt10k <= cnt10k + 1;
				end if;
				if (cnt25 = 999999) then
					cnt25 <= 0;
					clk_25Hz <= not clk_25Hz;
				else
					cnt25 <= cnt25 + 1;
				end if;
			end if;
		end process;
end clk_divide;
