----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/18/2024 11:04:11 PM
-- Design Name: 
-- Module Name: test_bench_reg_file - Behavioral
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

entity test_bench_reg_file is
--  Port ( );
end test_bench_reg_file;

architecture Behavioral of test_bench_reg_file is

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

signal clk_test: STD_LOGIC := '0';
signal RegWr_test: STD_LOGIC := '0';
signal RA1_test: STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
signal RA2_test: STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
signal WA_test: STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
signal WD_test: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal RD1_test: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
signal RD2_test: STD_LOGIC_VECTOR (31 downto 0) := (others => '0');
constant perioada: TIME := 20ns;

begin

ust: REG_FILE port map (clk_test, RegWr_test, RA1_test, RA2_test, WA_test, WD_test, RD1_test, RD2_test);

process
begin
clk_test <= '1';
wait for perioada/2;
clk_test <= '0';
wait for perioada/2;
end process;

process
begin

RegWr_test <= '1';
WA_test <= "00001";
WD_test <= x"AAAAAAAA";
wait for perioada;
WA_test <= "00010";
WD_test <= x"BBBBBBBB";
wait for perioada;
WA_test <= "00011";
WD_test <= x"CCCCCCCC";
wait for perioada;
RegWr_test <= '0';
wait for perioada;
WA_test <= "00011";
WD_test <= x"EEEEEEEE";
wait for perioada * 3;

RA1_test <= "00001";
RA2_test <= "00011";

wait for perioada * 3;

RA1_test <= "00010";
wait;
end process;

end Behavioral;
