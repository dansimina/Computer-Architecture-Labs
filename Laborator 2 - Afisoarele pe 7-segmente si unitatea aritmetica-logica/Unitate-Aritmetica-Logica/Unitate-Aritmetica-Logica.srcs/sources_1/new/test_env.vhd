----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2024 03:03:19 PM
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

signal digits: std_logic_vector (31 downto 0) := x"00000000";

signal enable: std_logic := '0';
signal cnt: std_logic_vector (1 downto 0) := "00";

begin
    connectMPG: MPG port map (enable, btn(0), clk); 
    
    led(7 downto 0) <= sw(7 downto 0);
    
    process(clk)
    begin
        if rising_edge(clk) and enable = '1' then
            cnt <= cnt + 1;
        end if;
    end process;
    
    process(cnt)
    variable firstNumber: std_logic_vector (31 downto 0) := x"00000000";
    variable secondNumber: std_logic_vector (31 downto 0) := x"00000000";
    variable result: std_logic_vector (31 downto 0) := x"00000000";
    begin
        case cnt is
            when "00" => firstNumber := x"0000000" & sw(3 downto 0);
                         secondNumber := x"0000000" & sw(7 downto 4);
                         result := firstNumber + secondNumber;
            when "01" => firstNumber := x"0000000" & sw(3 downto 0);
                         secondNumber := x"0000000" & sw(7 downto 4);
                         result := firstNumber - secondNumber;
            when "10" => result := x"00000" & "00" & sw(7 downto 0) & "00";
            when "11" => result := x"000000" & "00" & sw(7 downto 2);
            when others => result := x"00000000";
        end case;
        
        if result = 0 then 
            led(8) <= '1';
        else
            led(8) <= '0';
        end if;
        
        digits <= result;
    end process;
    
    connectSDD: SSD port map (clk, digits, an, cat);
end Behavioral;
