----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2024 04:00:42 PM
-- Design Name: 
-- Module Name: REG_FILE - Behavioral
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

entity REG_FILE is
    Port ( clk : in STD_LOGIC;
           RegWr : in STD_LOGIC;
           RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
end REG_FILE;

architecture Behavioral of REG_FILE is

type memory is array (0 to 31) of std_logic_vector (31 downto 0);
signal MEM: memory := ( x"00000001",
                        x"00000001",
                        others => x"00000000");

begin
    
    RD1 <= MEM(conv_integer(RA1));
    RD2 <= MEM(conv_integer(RA2));
    
    process(clk)
    begin
        if rising_edge(clk) and RegWr = '1' then
            MEM(conv_integer(WA)) <= WD;
        end if;
    end process;

end Behavioral;
