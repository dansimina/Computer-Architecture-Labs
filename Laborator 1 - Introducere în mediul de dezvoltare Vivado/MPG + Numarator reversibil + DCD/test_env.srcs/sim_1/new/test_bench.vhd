----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/29/2024 10:32:24 PM
-- Design Name: 
-- Module Name: test_bench - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_bench is
--  Port ( );
end test_bench;

architecture Behavioral of test_bench is

component test_env is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;

signal clk_test: STD_LOGIC;
signal btn_test: STD_LOGIC_VECTOR (4 downto 0);
signal sw_test: STD_LOGIC_VECTOR (15 downto 0);
signal led_test: STD_LOGIC_VECTOR (15 downto 0);
signal an_test: STD_LOGIC_VECTOR (7 downto 0);
signal cat_test: STD_LOGIC_VECTOR (6 downto 0);
constant perioada: TIME := 20ns;

begin

ust1: test_env port map (clk_test, btn_test, sw_test, led_test, an_test, cat_test);

process
begin
    clk_test <= '1';
    wait for perioada / 2;
    clk_test <= '0';
    wait for perioada / 2;
end process;

process
begin
-- fara MPG
--    btn_test <= "00000";
--    sw_test <= x"0001";
--    wait for perioada;
--    btn_test <= "00001";
--    sw_test <= x"0000";
--    wait for perioada * 5;
--    sw_test <= x"0001";
--    wait for perioada * 5;
--    sw_test <= x"0000";

-- cu MPG + modificat numarator pe 3 biti
    btn_test <= "00001";
    sw_test <= x"0000";
    wait for perioada * 14;
    btn_test <= "00000";
    wait for perioada * 3;
    btn_test <= "00001";
    
    wait;
end process;

end Behavioral;
