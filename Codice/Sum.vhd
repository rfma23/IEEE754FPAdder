----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:40:18 05/16/2018 
-- Design Name: 
-- Module Name:    Sum - structural 
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


entity Sum is
	port(
		SSign_in		:  in  	std_logic;								--
		GSign_in  	:  in  	std_logic; 								--
		GExp_in	 	:  in  	std_logic_vector( 7 downto 0);	--
		GMantE_in	:	in 	std_logic_vector(26 downto 0); 	--
		SMantE_in	:	in 	std_logic_vector(26 downto 0);	--
		SResult_in	:	in 	std_logic_vector(31 downto 0);
		isSpecR_in	:  in  	std_logic;
		ZS_out		:  out  	std_logic;								--
		ZExp_out		:  out  	std_logic_vector( 7 downto 0);	--
		ZMantE_out	:	out	std_logic_vector(26 downto 0);	--
		SResult_out	:	out 	std_logic_vector(31 downto 0);
		isSpecR_out	:  out  	std_logic
	);
end Sum;

 architecture RTL of Sum is

COMPONENT CLAGeneric
	
	GENERIC(
			N: integer
	);
	
	PORT(
		x 				: IN 	std_logic_vector(N-1 downto 0);
		y 				: IN 	std_logic_vector(N-1 downto 0);
		op				: IN 	std_logic;          
		z 				: OUT std_logic_vector(N-1 downto 0);
		c_out 		: OUT std_logic
	);
END COMPONENT;

	signal OpLogic : std_logic;
	signal ExpOF	: std_logic;
	signal OFvector: std_logic_vector( 7 downto 0);
	signal MAdd_OF	: std_logic;
	signal ZManTemp: std_logic_vector(26 downto 0);
	signal InftySR : std_logic_vector(31 downto 0);
	signal ZExpTemp: std_logic_vector( 7 downto 0);

begin
	
	ZS_out	<= GSign_in;
	
	OpLogic	<=	SSign_in xor GSign_in;
	
	A_CLAGeneric: CLAGeneric 
	generic map (
			N => 27
	)
	
	port map(
		x     => GMantE_in,
		y     => SMantE_in,
		op    => OpLogic,
		z     => ZManTemp,
		c_out => MAdd_OF
	);
	
	ZMantE_out <= ZManTemp when MAdd_OF = '0' else ('1' & ZManTemp(26 downto 1)) ;
	
	OFvector <= "0000000" & MAdd_OF;
	
	B_CLAGeneric: CLAGeneric 
	generic map (
			N => 8
	)
		
	port map(
		x => GExp_in,
		y => OFVector,
		op => '0',
		z => ZExpTemp,
		c_out => ExpOF -- Non faccio caso al OF tanto non può verificarsi, 
							-- al massimo OFVector vale 1, per verifarsi ExpOF
							-- Exp dovrebbe valere 255 ma se vale 255 è stato 
							-- già gestito come caso speciale.
	);
	
	--Se entrambi subnormali e somma normale, aumenta 1 all'esponente
	--Se entrambi normali e somma subnormale, decrementa 1 all'esponente
	--(da normali a subnormali può verificarsi solo quando Exp=00000001
	
	ZExp_out 	<= "00000001" 	when (GExp_in = "00000000" and
											   ZManTemp (26) = '1') else 
						"00000000" 	when (GEXp_in = "00000001" and
												MAdd_OF		  = '0'	and
											   ZManTemp (26) = '0') else 
						ZExpTemp;   
						--Altrimenti quello calcolato
					
	
	InftySR	<= GSign_in & "1111111100000000000000000000000";
						
	SResult_out <= SResult_in 	when isSpecR_in = '1'      else
						InftySR		when ZExpTemp = "11111111" else
						SResult_in; --Not a SR
						
	isSpecR_out <= isSpecR_in 	when isSpecR_in = '1'      else
						'1'			when ZExpTemp = "11111111" else
						isSpecR_in; --0

end RTL;

