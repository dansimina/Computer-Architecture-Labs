----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 12:03:23 AM
-- Design Name: 
-- Module Name: test_env - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is

component MPG is
    Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

component SSD is
    Port ( clk : in STD_LOGIC;
           digits : in STD_LOGIC_VECTOR (31 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component RAM is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDRESS : in STD_LOGIC_VECTOR (5 downto 0);
           DI : in STD_LOGIC_VECTOR (31 downto 0);
           DO : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal counter: std_logic_vector (5 downto 0) := "000000";
signal en0, en1: std_logic := '0';
signal digits: std_logic_vector (31 downto 0) := x"00000000";

begin

connectMPG0: MPG port map(en0, btn(0), clk);
connectMPG1: MPG port map(en1, btn(1), clk);

process(clk, btn(2)) 
begin
    if btn(2) = '1' then
        counter <= "000000";
    elsif rising_edge(clk) and en0 = '1' then
        counter <= counter + 1;
    end if;
end process;

connectRAM: RAM port map(clk, '1', en1, counter, digits, digits);
digits <= digits(29 downto 0) & "00";

connectSSD: SSD port map(clk, digits, an, cat);

end Behavioral;
