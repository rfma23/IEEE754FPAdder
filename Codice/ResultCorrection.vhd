----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:45:31 05/17/2018 
-- Design Name: 
-- Module Name:    ResultCorrection - RTL 
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

entity ResultCorrection is
	port(
		ZS_in			:  in  	std_logic;								
		ZExp_in		:  in  	std_logic_vector( 7 downto 0);	
		ZMantE_in	:	in		std_logic_vector(26 downto 0);	
		SResult_in	:	in 	std_logic_vector(31 downto 0);
		isSpecR_in	:  in  	std_logic;
		Z				:	out	std_logic_vector(31 downto 0)
	);
end ResultCorrection;

architecture RTL of ResultCorrection is
	
	COMPONENT Rounder
	PORT(
		Exp 		: in 	std_logic_vector(7 downto 0);
		Man 		: in 	std_logic_vector(26 downto 0);          
		RExpMan 	: out std_logic_vector(30 downto 0);
		isZero 	: out std_logic;
		isInfty 	: out std_logic
		);
	END COMPONENT;
	
	COMPONENT NormalizationModule
	PORT(
		Exp 		: in 	std_logic_vector(7 downto 0);
		Man 		: in	std_logic_vector(26 downto 0);       
		NExp 		: out std_logic_vector(7 downto 0);
		NMan 		: out std_logic_vector(26 downto 0)--;
		--UnF 		: out std_logic
		);	
	END COMPONENT;
	
	
	signal GeneratedResult 	: std_logic_vector(31 downto 0);
	signal SpecialResult 	: std_logic_vector(31 downto 0);
	signal ZeroEM				: std_logic_vector(30 downto 0);
	signal InftyEM				: std_logic_vector(30 downto 0);
	signal ZExpAndMan		 	: std_logic_vector(30 downto 0);
	signal GenExpAndMan		: std_logic_vector(30 downto 0);
	signal NExp					: std_logic_vector( 7 downto 0);
	signal NMan					: std_logic_vector(26 downto 0);
	signal RisZero				: std_logic;
	signal RisInfty			: std_logic;
	signal isZero				: std_logic;
	signal isInfty				: std_logic;
	--signal ExpUF				: std_logic;


begin
	ZeroEM					<= (others => '0');
	InftyEM					<= "1111111100000000000000000000000";
	
	A_NormalizationModule: NormalizationModule 
	PORT MAP(
		Exp 		=> ZExp_in,
		Man 		=> ZMantE_in,
		NExp 		=> NExp,
		NMan 		=> NMan--,
		--UnF 		=> ExpUF
	);
	
	A_Rounder: Rounder 
	PORT MAP(
		Exp 		=> NExp,
		Man 		=> NMan,
		RExpMan 	=> GenExpAndMan,
		isZero 	=> RisZero,
		isInfty 	=> RisInfty
	);
	
	isZero  <= RisZero;-- or ExpUF;
	isInfty <= RisInfty;
	
	ZExpAndMan			<= GenExpAndMan 	when isZero 	= '0' and RisInfty = '0' else
								ZeroEM			when isZero 	= '1'	else
								InftyEM			when isInfty 	= '1'	else
								"0011001100110011001100110011001"; 
								-- Non si usano i DC per poter distinguere la sorgente del risultato
								
								
	SpecialResult 		<= SResult_in;
	
	GeneratedResult 	<= ZS_in & ZExpAndMan;
	
	-- Fornisci come risultato quello generato se non si ha a che vedere con un caso speciale
	-- altrimenti quello speciale calcolato con gli appositi moduli.
	Z <= GeneratedResult when isSpecR_in = '0' else SpecialResult;

end RTL;

