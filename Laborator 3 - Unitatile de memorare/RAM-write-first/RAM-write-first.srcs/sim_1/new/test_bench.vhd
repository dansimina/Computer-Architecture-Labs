----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 12:14:40 AM
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

component RAM is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDRESS : in STD_LOGIC_VECTOR (7 downto 0);
           DI : in STD_LOGIC_VECTOR (31 downto 0);
           DO : out STD_LOGIC_VECTOR (7 downto 0));
end component;

begin


end Behavioral;
