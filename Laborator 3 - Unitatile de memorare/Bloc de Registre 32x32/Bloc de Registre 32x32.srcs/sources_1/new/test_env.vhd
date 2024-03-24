----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2024 11:22:15 AM
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

component REG_FILE is
    Port ( clk : in STD_LOGIC;
           RegWr : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
end component;

signal cnt: std_logic_vector (4 downto 0) := (others => '0');
signal enable: std_logic := '0';
signal rst: std_logic := '0';

signal RegWr: std_logic := '0';
signal RD1: std_logic_vector(31 downto 0) := (others => '0');
signal RD2: std_logic_vector(31 downto 0) := (others => '0');
signal DIGITS: std_logic_vector(31 downto 0) := (others => '0');

begin
    connectMPG1: MPG port map(enable, btn(0), clk);
    connectMPG2: MPG port map(RegWr, btn(1), clk);
    rst <= btn(2);
    
    process(clk, rst)
    begin
        if rst = '1' then 
            cnt <= "00000";
        end if;
        
        if rising_edge (clk) and enable = '1' then
            cnt <= cnt + 1;
        end if;
    end process;
    
    DIGITS <= RD1 + RD2;
    
    connectREG_FILE: REG_FILE port map (clk, RegWr, cnt, cnt, cnt, DIGITS, RD1, RD2);
    connectSSD: SSD port map(clk, DIGITS, an, cat);

end Behavioral;
