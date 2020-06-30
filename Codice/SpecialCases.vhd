----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:31:30 05/14/2018 
-- Design Name: 
-- Module Name:    SpecialCases - structural 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SpecialCases is
	port(
		x       	  :  in   std_logic_vector(30 downto 0);
		y       	  :  in   std_logic_vector(30 downto 0);
		casoX   	  :  out  std_logic_vector( 4 downto 0);
		casoY   	  :  out  std_logic_vector( 4 downto 0);
		isSpecialC :  out  std_logic
	);
end SpecialCases;

architecture structural of SpecialCases is

	component CaseIdentifier
		port(
			e 	  : in 	std_logic_vector(	7 downto 0);
			M 	  : in 	std_logic_vector(22 downto 0);          
			Caso : out std_logic_vector(	4 downto 0)
		);
	end component;
	
	-- Esponenti
	signal eX  : std_logic_vector(7 downto 0);
	signal eY  : std_logic_vector(7 downto 0);
	
	-- Mantisse
	signal mX  : std_logic_vector(22 downto 0);
	signal mY  : std_logic_vector(22 downto 0);
	
	-- Casi (codificato in one hot)
	signal cX  : std_logic_vector(4 downto 0);
	signal cY  : std_logic_vector(4 downto 0);
	

begin

	eX  <=  x(30 downto 23);
	eY  <=  y(30 downto 23);
	
	mX  <=  x(22 downto  0);
	mY  <=  y(22 downto  0);

	X_CaseIdentifier: CaseIdentifier 
	port map(
		e => eX,
		M => mX,
		Caso => cX
	);
	
	
	Y_CaseIdentifier: CaseIdentifier 
	port map(
		e => eY,
		M => mY,
		Caso => cY 
	);
	
	
	casoX 		<= 	cX;
	casoY 		<= 	cY;
	
	-- Si segnala se si ha a che fare con un caso speciale
	isSpecialC	<= 	'0' when ( (cX(2 downto 0) = "000") and (cY(2 downto 0) = "000") ) 
				   else 	'1';

end structural;



