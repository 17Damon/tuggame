library WORK;
library IEEE;
use IEEE.std_logic_1164.all;
entity TUGGAME is
port (
		clk_50MHz : in std_logic;
		k1 : in std_logic;
		k2 : in std_logic;
		rst : in std_logic;--reset current single game   
		nrst : in std_logic;--reset whole game
		left_tube : out std_logic_vector(6 downto 0);
		right_tube : out std_logic_vector(6 downto 0);
		led : out std_logic_vector(6 downto 0);
		beep : out std_logic
);
end entity TUGGAME;
architecture tug_game of TUGGAME is
signal clk_25HzOut_sig : std_logic;
signal clk_10kHzOut_sig :std_logic;
signal k1_sig : std_logic;
signal k1_posedge_sig : std_logic;
signal k1_negedge_sig : std_logic;
signal k2_sig : std_logic;
signal k2_posedge_sig : std_logic;
signal k2_negedge_sig : std_logic;
signal rst_sig : std_logic;
signal rst_posedge_sig : std_logic;
signal rst_negedge_sig : std_logic;
signal nrst_sig : std_logic;
signal nrst_posedge_sig : std_logic;
signal nrst_negedge_sig : std_logic;
signal left_score_sig : natural range 0 to 3;
signal right_score_sig : natural range 0 to 3;
signal code_sig : std_logic_vector(3 downto 0);
signal left_play_sig : std_logic;
signal right_play_sig : std_logic;

component CLKDIVIDE
port (
	clk_50MHz : in std_logic;
	clk_10kHz : buffer std_logic;
	clk_25Hz : buffer std_logic
);
end component;
component PREVENTJITTER
port (
	clk_50MHz : in std_logic;
	k1_in : in std_logic;
	k1_out : out std_logic;
	k1_posedge : out std_logic;
	k1_negedge : out std_logic
);
end component;
component TUGCONTROL
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
end component;
component LEDCONTROL
port (
	clk_50MHz : in std_logic;
	code : in std_logic_vector(3 downto 0);
	led : out std_logic_vector(6 downto 0)
);
end component;
component DIGITALTUBE
port (
	clk_50MHz : in std_logic;
	left_score : in natural range 0 to 3;
	right_score : in natural range 0 to 3;
	left_tube : out std_logic_vector(6 downto 0);
	right_tube : out std_logic_vector(6 downto 0)
);
end component;
component PLAYMUSIC
port (
	clk_50MHz : in std_logic;
	nrst_negedge : in std_logic;
	left_play : in std_logic;
	right_play : in std_logic;
	beep : out std_logic
);
end component;
begin
	U1:CLKDIVIDE port map(clk_50MHz, clk_10kHzOut_sig, clk_25HzOut_sig);
	U2:PREVENTJITTER port map(clk_50MHz, k1, k1_sig, k1_posedge_sig, k1_negedge_sig);
	U3:PREVENTJITTER port map(clk_50MHz, k2, k2_sig, k2_posedge_sig, k2_negedge_sig);
	U4:PREVENTJITTER port map(clk_50MHz, rst, rst_sig, rst_posedge_sig, rst_negedge_sig);
	U5:PREVENTJITTER port map(clk_50MHz, nrst, nrst_sig, nrst_posedge_sig, nrst_negedge_sig);
	U6:TUGCONTROL port map(clk_50MHz, k1_negedge_sig, k2_negedge_sig, rst_negedge_sig, nrst_negedge_sig, left_score_sig, right_score_sig, code_sig, left_play_sig, right_play_sig);
	U7:LEDCONTROL port map(clk_50MHz, code_sig, led);
	U8:DIGITALTUBE port map(clk_50MHz, left_score_sig, right_score_sig, left_tube, right_tube);
	U9:PLAYMUSIC port map(clk_50MHz, nrst_negedge_sig, left_play_sig, right_play_sig, beep);
end tug_game;