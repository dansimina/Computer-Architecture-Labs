----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/20/2024 12:06:35 AM
-- Design Name: 
-- Module Name: RAM - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDRESS : in STD_LOGIC_VECTOR (5 downto 0);
           DI : in STD_LOGIC_VECTOR (31 downto 0);
           DO : out STD_LOGIC_VECTOR (31 downto 0));
end RAM;

architecture Behavioral of RAM is

type memory is array (0 to 7) of std_logic_vector(31 downto 0);
signal RAM: memory := (others=>x"00000000"); 

begin

    process(clk)
    begin
        if rising_edge(clk) then
            if EN = '1' then 
                if WE = '1' then
                    RAM(conv_integer(ADDRESS)) <= DI;
                    DO <= DI;
                else
                    DO <= RAM(conv_integer(ADDRESS));
                end if;
            end if;
        end if;
    end process;

end Behavioral;
