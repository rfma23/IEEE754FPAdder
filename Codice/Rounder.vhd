----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:20:11 05/16/2018 
-- Design Name: 
-- Module Name:    Rounder - structural 
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

entity Rounder is
port(
		Exp		:  in   	std_logic_vector(7 downto 0);
		Man		:  in   	std_logic_vector(26 downto 0);
		RExpMan	:	out	std_logic_vector(30 downto 0);
		isZero	:  out   std_logic;
		isInfty	:  out   std_logic
);
end Rounder;

architecture structural of Rounder is

	component CLAGeneric
	
		generic(
			N: integer := 23
		);
	
		port(
			x     :  in   std_logic_vector(N-1 downto 0);
         y     :  in   std_logic_vector(N-1 downto 0);
			op    :  in   std_logic;
         z     :  out  std_logic_vector(N-1 downto 0);
         c_out :  out  std_logic
		);

	end component;
	
	component LsbRoundingIncrement
	PORT(
		LSB 		: IN  std_logic;
		G 			: IN  std_logic;
		R 			: IN  std_logic;
		S 			: IN  std_logic;          
		Incr	   : OUT std_logic
		);
	END COMPONENT;
	
	signal MIncr	:	std_logic;
	signal MZVec	:	std_logic_vector(22 downto 0);
	signal EZVec	:	std_logic_vector( 7 downto 0);
	signal TempM	:	std_logic_vector(22 downto 0);
	signal TempE	:	std_logic_vector( 7 downto 0);
	signal MAddOF	:	std_logic;
	signal EAddOF	:	std_logic;
	

begin
	
	-- Aumento la mantissa se necessario (indicato da LSBRounder)
	MZVec 	<= "0000000000000000000000" & MIncr;
	
	-- Aumento l'esponente se c'è un overflow di mantissa
	EZVec 	<= "0000000" & MAddOF;
	
	A_LsbRoundingIncrement: LsbRoundingIncrement 
	port map (
		LSB   => Man(3),
		G 	   => Man(2),
		R     => Man(1),
		S     => Man(0),
		Incr  => MIncr
	);
	
	CLA_M: CLAGeneric
	generic map (
			 N => 23
	)
	
	port map (
		x     => Man(25 downto 3),
		y     =>	MZVec,
		op    => '0',
      z     => TempM,
      c_out =>	MAddOF
	);
	
	-- Quando il numero è denormalizzato e da round passa a normalizzato al aumentare 
	-- la mantissa si aumenta di uno l'esponente poiché si verificherà di sicuro OF
	
	CLA_E: CLAGeneric
	generic map (
			 N => 8
	)
	
	port map (
		x     => Exp,
		y     => EZVec,
		op    => '0',
      z     => TempE,
      c_out =>	EAddOF
	);
	
	RExpMan	<= TempE & TempM;
	
	-- Vogliamo Subnormali in output.
	--Se anziche avere subnormali vogliamo forzare a zero (azzerare mantissa) sarà 
	-- isZero <= '1' when TempE		= "00000000" or Man(26) = '0' else '0';
	isZero	<= '0';
	
	
	-- Segnala che si deve forzare la mantissa a zero se l'exp diventa tutti 1 altrimenti potrebbe essere 
	-- interpretato come NaN se non azzero la mantissa.
	isInfty 	<= '1' when ( TempE 	= "11111111" or EAddOF 	= '1' ) else '0';
	
end structural;