----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 10:53:31 AM
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

signal cnt: std_logic_vector (31 downto 0) := x"00000000";
signal en: std_logic := '0';
signal dir: std_logic := '0';
signal dcd_out: std_logic_vector (7 downto 0) := x"00";

begin
--    led <= sw;       -- conecteaz? switch-uri la led-uri 
--    an(7 downto 4) <= "1111";     -- dezactiveaz? anozii superiori 
--    an(3 downto 0) <= btn(3 downto 0);  -- conecteaz? anozii inferiori la butoane 
--    cat <= (others=>'0');     -- activeaz? catozii SSD 
    
    conectareMPG: MPG port map (en, btn(0), clk);
    
--    en <= btn(0);
    dir <= sw(0);
    
    --Numarator reversibil
    process(clk)
    begin
        
        if rising_edge(clk) then 
            if en = '1' then
                if dir = '0' then
                    cnt <= cnt + 1;
                else
                    cnt <= cnt - 1;
                end if;
            end if;
        end if;
    end process;
    
    conectareSSD: SSD port map(clk, cnt, an, cat);
    
end Behavioral;
