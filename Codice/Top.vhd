----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:57:44 05_16_2018 
-- Design Name: 
-- Module Name:    Top - fullyCombinatorial 
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

entity Top is
port(
	X 								: in 	std_logic_vector(31 downto 0);
	Y 								: in	std_logic_vector(31 downto 0);
	ops							: in	std_logic;
   PreS_S_SmallestSign    	: out std_logic;
	PreS_S_GreatestSign    	: out std_logic;
	PreS_S_GreatestExp     	: out std_logic_vector( 7 downto 0);
	PreS_S_GreatestMantExp  : out std_logic_vector(26 downto 0);
	PreS_S_SmallestMantExp  : out std_logic_vector(26 downto 0);
	PreS_S_SpecialResult    : out std_logic_vector(31 downto 0);
	PreS_S_isSpecialResult  : out std_logic;
	S_PostS_ZSign				: out std_logic;
	S_PostS_ZExp	   		: out std_logic_vector( 7 downto 0);
	S_PostS_ZMantExp   		: out std_logic_vector(26 downto 0);
	ZR								: out std_logic_vector(31 downto 0)
);
end Top;


architecture fullyCombinatorial of Top is

COMPONENT PreSum
	PORT(
		inX 			: IN  std_logic_vector(31 downto 0);
		inY 			: IN  std_logic_vector(31 downto 0);
		op 			: IN  std_logic;          
		SSign			: OUT std_logic;
		GSign 		: OUT std_logic;
		GExp 			: OUT std_logic_vector(7 downto 0);
		GMantE 		: OUT std_logic_vector(26 downto 0);
		SMantE 		: OUT std_logic_vector(26 downto 0);
		SResult 		: OUT std_logic_vector(31 downto 0);
		isSpecR 		: OUT std_logic
		);
END COMPONENT;

COMPONENT Sum
	PORT(
		SSign_in 	: IN 	std_logic;
		GSign_in 	: IN 	std_logic;
		GExp_in 		: IN 	std_logic_vector(7 downto 0);
		GMantE_in 	: IN 	std_logic_vector(26 downto 0);
		SMantE_in 	: IN 	std_logic_vector(26 downto 0);
		SResult_in 	: IN 	std_logic_vector(31 downto 0);
		isSpecR_in 	: IN 	std_logic;          
		ZS_out 		: OUT std_logic;
		ZExp_out	 	: OUT std_logic_vector(7 downto 0);
		ZMantE_out 	: OUT std_logic_vector(26 downto 0);
		SResult_out : OUT std_logic_vector(31 downto 0);
		isSpecR_out : OUT std_logic
		);
	END COMPONENT;

COMPONENT ResultCorrection
	PORT(
		ZS_in 		: IN 	std_logic;
		ZExp_in 		: IN 	std_logic_vector( 7 downto 0);
		ZMantE_in 	: IN 	std_logic_vector(26 downto 0);
		SResult_in	: IN 	std_logic_vector(31 downto 0);
		isSpecR_in 	: IN 	std_logic;          
		Z 				: OUT std_logic_vector(31 downto 0)
		);
END COMPONENT;

	
	signal	PreS_S_SmallestSign_s		: std_logic;
	signal	PreS_S_GreatestSign_s		: std_logic;
	signal	PreS_S_GreatestExp_s			: std_logic_vector( 7 downto 0);
	signal	PreS_S_GreatestMantExp_s 	: std_logic_vector(26 downto 0);
	signal	PreS_S_SmallestMantExp_s 	: std_logic_vector(26 downto 0);
	signal	PreS_S_SpecialResult_s		: std_logic_vector(31 downto 0);
	signal	PreS_S_isSpecialResult_s	: std_logic;
	signal	S_PostS_ZSign_s2 				: std_logic;
	signal	S_PostS_ZExp_s2				: std_logic_vector( 7 downto 0);
	signal	S_PostS_ZMantExp_s2			: std_logic_vector(26 downto 0);
	signal	S_PostS_SpecialResult_s2 	: std_logic_vector(31 downto 0);
	signal	S_PostS_isSpecialResult_s2 : std_logic;

begin
	
	A_PreSum: PreSum 
	PORT MAP(
		inX 			=> X,
		inY 			=> Y,
		op 			=> ops,
		SSign 		=> PreS_S_SmallestSign_s,
		GSign 		=> PreS_S_GreatestSign_s,
		GExp 			=> PreS_S_GreatestExp_s,
		GMantE 		=> PreS_S_GreatestMantExp_s,
		SMantE 		=> PreS_S_SmallestMantExp_s,
		SResult 		=> PreS_S_SpecialResult_s,
		isSpecR 		=> PreS_S_isSpecialResult_s
	);

	B_Sum: Sum 
	PORT MAP(
		SSign_in 	=> PreS_S_SmallestSign_s,
		GSign_in 	=> PreS_S_GreatestSign_s,
		GExp_in		=> PreS_S_GreatestExp_s,
		GMantE_in 	=> PreS_S_GreatestMantExp_s,
		SMantE_in 	=> PreS_S_SmallestMantExp_s,
		SResult_in 	=> PreS_S_SpecialResult_s,
		isSpecR_in 	=> PreS_S_isSpecialResult_s,
		ZS_out 		=> S_PostS_ZSign_s2,
		ZExp_out 	=> S_PostS_ZExp_s2,
		ZMantE_out 	=> S_PostS_ZMantExp_s2,
		SResult_out => S_PostS_SpecialResult_s2,
		isSpecR_out => S_PostS_isSpecialResult_s2
	);
	
	C_ResultCorrection: ResultCorrection 
	PORT MAP(
		ZS_in 		=> S_PostS_ZSign_s2,
		ZExp_in 		=> S_PostS_ZExp_s2,
		ZMantE_in 	=> S_PostS_ZMantExp_s2,
		SResult_in 	=> S_PostS_SpecialResult_s2,
		isSpecR_in 	=> S_PostS_isSpecialResult_s2,
		Z => ZR
	);
	
	--estrazione segnali interni
	PreS_S_SmallestSign 		<= PreS_S_SmallestSign_s;
	PreS_S_GreatestSign  	<= PreS_S_GreatestSign_s;
	PreS_S_GreatestExp  		<= PreS_S_GreatestExp_s;
	PreS_S_GreatestMantExp 	<= PreS_S_GreatestMantExp_s;
	PreS_S_SmallestMantExp  <= PreS_S_SmallestMantExp_s;
	PreS_S_SpecialResult 	<= PreS_S_SpecialResult_s;
	PreS_S_isSpecialResult  <= PreS_S_isSpecialResult_s;
	S_PostS_ZSign	 			<= S_PostS_ZSign_s2;
	S_PostS_ZExp	    		<= S_PostS_ZExp_s2;
	S_PostS_ZMantExp    		<= S_PostS_ZMantExp_s2;
--	S_PostS_SpecialResult 	<= S_PostS_SpecialResult_s2;
--	S_PostS_isSpecialResult <= S_PostS_isSpecialResult_s2;

end fullyCombinatorial;
