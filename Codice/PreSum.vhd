----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:42:16 05/14/2018 
-- Design Name: 
-- Module Name:    PreSum - structural 
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

entity PreSum is
port(
		inX   	:  in   	std_logic_vector(31 downto 0);
		inY 		:  in   	std_logic_vector(31 downto 0);
		op   		:  in		std_logic;
		SSign		:  out  	std_logic;
		GSign  	:  out  	std_logic;
		GExp	 	:  out  	std_logic_vector( 7 downto 0);
		GMantE	:	out 	std_logic_vector(26 downto 0);
		SMantE	:	out 	std_logic_vector(26 downto 0);
		SResult	:	out 	std_logic_vector(31 downto 0);
		isSpecR	:  out  	std_logic
	);
end PreSum;

architecture RTL of PreSum is

	COMPONENT SwapperNew
	PORT(
		A 				: IN 	std_logic_vector(31 downto 0);
		B 				: IN 	std_logic_vector(31 downto 0);          
		GNum 			: OUT std_logic_vector(31 downto 0);
		SNum 			: OUT std_logic_vector(31 downto 0);
		EDiff 		: OUT std_logic_vector(	4 downto 0);
		FM2Zero 		: OUT std_logic;
		Swapped 		: OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT SpecialCases
	PORT(
		x 				: IN 	std_logic_vector(30 downto 0);
		y 				: IN 	std_logic_vector(30 downto 0);          
		casoX 		: OUT std_logic_vector(	4 downto 0);
		casoY 		: OUT std_logic_vector(	4 downto 0);
		isSpecialC 	: OUT std_logic
		);
	END COMPONENT;
	
	COMPONENT SCHandler
	PORT(
		op 			: IN 	std_logic;
		CaseX 		: IN 	std_logic_vector(	2 downto 0);
		CaseY 		: IN 	std_logic_vector(	2 downto 0);
		X 				: IN 	std_logic_vector(31 downto 0);
		Y 				: IN 	std_logic_vector(31 downto 0);          
		SCResult 	: OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
	COMPONENT MExtender
	PORT(
		isSub 		: IN 	std_logic;
		M 				: IN 	std_logic_vector(22 downto 0);          
		ExtM 			: OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RShifter
	PORT(
		FM2Zero 		: IN 	std_logic;
		ShiftN 		: IN 	std_logic_vector(	4 downto 0);
		ExtM 			: IN 	std_logic_vector(26 downto 0);          
		ShEM 			: OUT std_logic_vector(26 downto 0)
		);
	END COMPONENT;
	
	signal 	SwapGNum_Out	 : std_logic_vector(31 downto 0);
	signal 	SwapSNum_Out	 : std_logic_vector(31 downto 0);
	signal	SwapEDiff_Out	 : std_logic_vector(	4 downto 0);
	signal	SwapFM2Zero_Out : std_logic;
	signal	SwapSwapped_Out : std_logic;
	
	signal 	SMExt_Out		 : std_logic_vector(26 downto 0);
	signal 	GMExt_Out		 : std_logic_vector(26 downto 0);
	
	signal	SCcasoX_Out 	 : std_logic_vector(	4 downto 0);
	signal	SCcasoY_Out 	 : std_logic_vector(	4 downto 0);
	
	signal	isGSubnormal	 : std_logic;
	signal	isSSubnormal	 : std_logic;
	
	signal 	BxorOp			 : std_logic_vector(31 downto 0);
	
	
begin
	
	-- Cambio segno al operando due se l'op è sottrazione
	BxorOp <= ((inY(31) xor op) & inY(30 downto 0));
	
	A_Swapper: SwapperNew PORT MAP(
		A 			=> inX,
		B 			=> BxorOp,
		GNum 		=> SwapGNum_Out,
		SNum 		=> SwapSNum_Out,
		EDiff 	=> SwapEDiff_Out,
		FM2Zero 	=> SwapFM2Zero_Out,
		Swapped 	=> SwapSwapped_Out
	);
	
	SSign <= SwapSNum_Out(31);
	GSign <= SwapGNum_Out(31);
	GExp 	<= SwapGNum_Out(30 downto 23);
	
	Corrective_RShifter: RShifter 
	PORT MAP(
		FM2Zero => SwapFM2Zero_Out,
		ShiftN => SwapEDiff_Out,
		ExtM => SMExt_Out,
		ShEM => SMantE
	);
	
	SC_SpecialCases: SpecialCases 
	PORT MAP(
		x => inX(30 downto 0),
		y => inY(30 downto 0),
		casoX => SCcasoX_Out,
		casoY => SCcasoY_Out,
		isSpecialC => isSpecR
	);
	
	isGSubnormal <= '1' when (SCcasoX_Out(3)='1' and SwapSwapped_Out ='0') 
								or  (SCcasoY_Out(3)='1' and SwapSwapped_Out ='1')
								else '0';
	isSSubnormal <= '1' when (SCcasoY_Out(3)='1' and SwapSwapped_Out ='0') 
								or  (SCcasoX_Out(3)='1' and SwapSwapped_Out ='1')
								else '0';
								
	G_MExtender: MExtender 
	PORT MAP(
		isSub 	=> isGSubnormal,
		M 			=> SwapGNum_Out(22 downto 0),
		ExtM 		=> GMantE
	);
	
	S_MExtender: MExtender 
	PORT MAP(
		isSub 	=> isSSubnormal,
		M 			=> SwapSNum_Out(22 downto 0),
		ExtM 		=> SMExt_Out
	);
	
	A_SCHandler: SCHandler 
	PORT MAP(
		op => op,
		CaseX => SCcasoX_Out(2 downto 0),
		CaseY => SCcasoY_Out(2 downto 0),
		X => inX,
		Y => inY,
		SCResult => SResult
	);
	

end RTL;

