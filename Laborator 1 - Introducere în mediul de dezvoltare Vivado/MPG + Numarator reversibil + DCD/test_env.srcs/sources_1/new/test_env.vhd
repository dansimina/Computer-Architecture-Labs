----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/29/2024 10:23:15 PM
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

signal cnt: std_logic_vector (2 downto 0) := "000";
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
    
    --DCD 3:8
    process(cnt)
    begin
        case cnt is
            when "000" => dcd_out <= "00000001";
            when "001" => dcd_out <= "00000010";
            when "010" => dcd_out <= "00000100";
            when "011" => dcd_out <= "00001000";
            when "100" => dcd_out <= "00010000";
            when "101" => dcd_out <= "00100000";
            when "110" => dcd_out <= "01000000";
            when "111" => dcd_out <= "10000000";
            when others => dcd_out <= x"00";
        end case;
    end process;
    
    led(7 downto 0) <= dcd_out;
    led(12 downto 8) <= "00000";
    led(15 downto 13) <= cnt;
    
end Behavioral;
