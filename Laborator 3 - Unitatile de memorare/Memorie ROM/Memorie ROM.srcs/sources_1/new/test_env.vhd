----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/13/2024 10:34:18 AM
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

type memory is array (0 to 31) of std_logic_vector (31 downto 0);
signal ROM: memory := (x"00000DAC",
                        x"00000BAC",
                        x"00000FAC",
                        x"00000CEC",
                        x"00000BEC",
                        x"000000BD",
                        x"000000AC",
                        x"FFFFFFFF",
                        others => x"00000000");

signal enable: std_logic := '0';
signal cnt: std_logic_vector (4 downto 0) := (others => '0');
signal digits: std_logic_vector (31 downto 0) := (others => '0');
begin

    -- register file in fisier separat
    connectMPG: MPG port map(enable, btn(0), clk);
    
    process(clk)
    begin
        if rising_edge (clk) and enable = '1' then
            cnt <= cnt + 1;
        end if;
    end process;

    digits <= ROM(conv_integer (cnt));
    
    connectSSD: SSD port map(clk, digits, an, cat);

end Behavioral;
