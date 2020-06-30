----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    
-- Design Name: 
-- Module Name:    SCHandler - structural 
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

entity SCHandler is
   port( 
      op       : in   std_logic;
      CaseX    : in   std_logic_vector (2 downto 0);
      CaseY    : in   std_logic_vector (2 downto 0);
      X        : in   std_logic_vector (31 downto 0);
      Y        : in   std_logic_vector (31 downto 0);
      SCResult : out  std_logic_vector (31 downto 0)
   );
end SCHandler ;

architecture structural of SCHandler is
	
	signal XisNorm   : std_logic;
	signal XisZero   : std_logic;
	signal XisNan    : std_logic;
	signal XisPInfty : std_logic;
	signal XisNInfty : std_logic;
	signal YisNorm   : std_logic;
	signal YisNan    : std_logic;
	signal YisZero   : std_logic;
	signal YisPInfty : std_logic;
	signal YisNInfty : std_logic;
	
	signal isSum     : std_logic;
	signal isDiff    : std_logic;
	
	signal MY     : std_logic_vector (31 downto 0);
	signal NaN    : std_logic_vector (31 downto 0);
	signal Zero   : std_logic_vector (31 downto 0);
	signal PInfty : std_logic_vector (31 downto 0);
	signal NInfty : std_logic_vector (31 downto 0);
	signal NotaSC : std_logic_vector (31 downto 0);
	
begin

	-- Segnali temp
	isSum 	 <= '1' when op='0' else '0';
	isDiff 	 <= '1' when op='1' else '0';
	XisNorm   <= '1' when CaseX = "000" else '0';
	XisZero   <= CaseX(2);
	XisNaN    <= CaseX(1);
	XisPInfty <= CaseX(0) and not(X(31));
	XisNInfty <= CaseX(0) and X(31);
	
	YisNorm   <=  '1' when CaseY = "000" else '0';
	YisZero   <=  CaseY(2);
	YisNaN    <=  CaseY(1);
	YisPInfty <= (CaseY(0) and not(Y(31)) and isSum)  or (CaseY(0) and Y(31) and isDiff);
	YisNInfty <= (CaseY(0) and not(Y(31)) and isDiff) or (CaseY(0) and Y(31) and isSum);
	
	NaN      <= "01111111111111111111111111111111";
	PInfty   <= "01111111100000000000000000000000";
	NInfty   <= "11111111100000000000000000000000";
	Zero     <= "00000000000000000000000000000000";
	NotASC   <= "01010101010101010101010101010101";
	MY			<= (Y(31) xor op) & Y(30 downto 0);
	
	--Calculate Special Result
	SCResult <= NaN   when ((XisPInfty and YisNInfty)
							  or  (XisNInfty and YisPInfty)
							  or  (XisPInfty and YisPInfty)
							  or  (XisNaN) or (YisNaN))
							  = '1'
							
			else PInfty when ((XisPInfty and YisPInfty)
							  or  (XisPinfty and YisNInfty)
							  or  (XisPinfty and (YisNorm or YisZero))
							  or 	(YisPinfty and (XisNorm or XisZero)))
							  = '1'
			else NInfty when ((XisNInfty and YisNInfty)
							  or  (XisNinfty and (YisNorm or YisZero))
							  or  (YisNinfty and (XisNorm or XisZero)))
							  = '1'
							  
			else X    	when ((YisZero and XisNorm) = '1')
			
			else Y      when ((XisZero and YisNorm and isSum) = '1')
			else MY     when ((XisZero and YisNorm and isDiff) = '1')
			
			else Zero 	when ((XisZero and YisZero) = '1')
			
			else NotASC;

end structural;