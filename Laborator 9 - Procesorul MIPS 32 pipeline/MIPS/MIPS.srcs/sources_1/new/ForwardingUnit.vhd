----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/24/2024 09:56:55 AM
-- Design Name: 
-- Module Name: ForwardingUnit - Behavioral
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

entity ForwardingUnit is
    Port ( clk : in STD_LOGIC;
           ID_EX_RS : in STD_LOGIC_VECTOR (4 downto 0);
           ID_EX_RT : in STD_LOGIC_VECTOR (4 downto 0);
           EX_MEM_RegWrite : in STD_LOGIC;
           EX_MEM_RD : in STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_RD : in STD_LOGIC_VECTOR (4 downto 0);
           MEM_WB_RegWrite : in STD_LOGIC;
           ForwardA : out STD_LOGIC_VECTOR (1 downto 0);
           ForwardB : out STD_LOGIC_VECTOR (1 downto 0));
end ForwardingUnit;

architecture Behavioral of ForwardingUnit is

begin

    process(clk)
    begin
        if (MEM_WB_RegWrite = '1' and (MEM_WB_RD /= "00000") and (EX_MEM_RD /= ID_EX_RS) and (MEM_WB_RD = ID_EX_RS)) then
            ForwardA <= "01";
        end if;

        if (MEM_WB_RegWrite = '1' and (MEM_WB_RD /= "00000") and (EX_MEM_RD /= ID_EX_RT) and (MEM_WB_RD = ID_EX_RT)) then 
            ForwardB <= "01";
        end if;
        
        if (EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd = ID/EX.RegisterRs)); 
            ForwardA = 10
        end if;
        
        if (EX/MEM.RegWrite and (EX/MEM.RegisterRd != 0) and (EX/MEM.RegisterRd = ID/EX.RegisterRt));
        ForwardB = 10
        end if;
    end process;    

end Behavioral;
