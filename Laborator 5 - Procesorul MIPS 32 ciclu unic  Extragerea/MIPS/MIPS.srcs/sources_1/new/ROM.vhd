----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/27/2024 12:27:52 AM
-- Design Name: 
-- Module Name: ROM - Behavioral
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

entity ROM is
    Port ( address : in STD_LOGIC_VECTOR (5 downto 0);
           data_out : out STD_LOGIC_VECTOR (31 downto 0));
end ROM;

architecture Behavioral of ROM is

type memory is array (0 to 31) of std_logic_vector (31 downto 0);
signal ROM: memory := ( B"000000_01010_01010_01010_00000_100110",
                        B"000000_00000_00000_00000_00000_100110",
                        B"000000_11110_11110_11110_00000_100110",

                        B"100011_01010_00001_0000000000000000",
                        B"001000_01010_01010_0000000000000100",
                        B"100011_01010_00010_0000000000000000",
                        
                        B"001000_00000_00000_0000000000001000",
                        
                        B"000100_00001_11110_0000000000001101",
                        
                        B"000100_00010_11110_0000000000001010",
                        
                        B"101011_00000_00001_0000000000000000",
                        B"001000_00000_00000_0000000000000100",
                        B"101011_00000_00010_0000000000000000",
                        B"001000_00000_00000_0000000000000100",
                        
                        B"000000_00001_00010_00011_00000_100010",
                        B"000111_00011_00000_0000000000000010",
                        B"000000_00010_00001_00010_00000_100010",
                        B"000010_00000000000000000000001000",
                        B"000000_00001_00010_00001_00000_100010",
                        B"000010_00000000000000000000001000",
                        
                        B"101011_00000_00001_0000000000000000",
                        B"000010_00000000000000000000010110",
                        B"101011_00000_00010_0000000000000000",
                        others => x"FFFFFFFF");

begin
    data_out <= ROM(conv_integer (address));
end Behavioral;