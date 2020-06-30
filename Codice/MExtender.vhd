----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:45:34 05/12/2018 
-- Design Name: 
-- Module Name:    MExtender - RTL 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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


entity MExtender is
   port( 
      isSub   : in   std_logic;
      M       : in   std_logic_vector (22 downto 0);
      ExtM    : out  std_logic_vector (26 downto 0)      
   );
end MExtender ;

architecture structural of MExtender is
begin
    ExtM <= not(isSub) & M & "000";
end structural; 

