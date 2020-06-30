----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:51:17 05/12/2018 
-- Design Name: 
-- Module Name:    RShifter - Structural 
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

entity RShifter is
   port( 
      FM2Zero 	  	: in  std_logic;
      ShiftN  		: in  std_logic_vector (4 downto 0);
      ExtM    		: in  std_logic_vector (26 downto 0);
      ShEM    		: out std_logic_vector (26 downto 0)
   );
end RShifter ;

architecture structural of RShifter is

	signal primoLivello:   std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal secondoLivello: std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal terzoLivello:   std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal quartoLivello:  std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal quintoLivello:  std_logic_vector(26 downto 0) := "000000000000000000000000000";
	
begin
		
		primoLivello   <= '0' & ExtM(26 downto 1)  			when ShiftN(0) = '1' else ExtM;
		
		secondoLivello <= "00" & primoLivello(26 downto 2) 	when ShiftN(1) = '1' else primoLivello;
		
		terzoLivello   <= "0000" & secondoLivello(26 downto 4) 	when ShiftN(2) = '1' else secondoLivello;
		
		quartoLivello  <= "00000000" & terzoLivello(26 downto 8) 	when ShiftN(3) = '1' else terzoLivello;
		
		quintoLivello  <= "0000000000000000" & quartoLivello(26 downto 16)	when ShiftN(4) = '1' else quartoLivello;
		
		ShEM  <=   "000000000000000000000000000" when FM2Zero = '1'
				else quintoLivello;
end structural;

