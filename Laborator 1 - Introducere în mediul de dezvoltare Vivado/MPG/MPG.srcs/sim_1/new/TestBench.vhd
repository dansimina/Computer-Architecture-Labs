----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/03/2024 10:20:39 PM
-- Design Name: 
-- Module Name: TestBench - Behavioral
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

entity TestBench is
--  Port ( );
end TestBench;

architecture Behavioral of TestBench is

component MPG is
    Port ( enable : out STD_LOGIC;
           btn : in STD_LOGIC;
           clk : in STD_LOGIC);
end component;

signal enable_test: std_logic := '0';
signal btn_test: std_logic := '0';
signal clk_test: std_logic := '0';
constant perioada: TIME := 20ns;

begin
--pt a vedea ceva pune MPG pe 3 biti
ust: MPG port map(enable_test, btn_test, clk_test);

process
begin
clk_test <= '1';
wait for perioada/2;
clk_test <= '0';
wait for perioada/2;
end process;

process
begin
--wait for perioada * 2;
--btn_test <= '1';
--wait for perioada * 2;
--btn_test <= '0';
--wait for perioada;
--btn_test <= '1';
--wait for perioada * 4;
--btn_test <= '0';
--wait for perioada * 4;
--btn_test <= '1';
btn_test <= '1';
wait for perioada * 14;
btn_test <= '0';
wait for perioada * 3;
btn_test <= '1';
--wait for perioada * 14;
--btn_test <= '0';
--wait for perioada * 3;
--btn_test <= '1';
wait;
end process;

end Behavioral;
