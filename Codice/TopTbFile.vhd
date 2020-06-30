--------------------------------------------------------------------------------
-- Company:
-- Engineers: Rafael Mosca and Kevin Guglielmetti
--
-- Create Date:   22:03:44 05/17/2018
-- Design Name:
-- Module Name:   Z:/Desktop/IEEEFinal/TopTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: Top
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.std_logic_textio.ALL;

LIBRARY STD;
use STD.textio.all;

ENTITY TopTBFile IS
END TopTBFile;

ARCHITECTURE behavior OF TopTBFile IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT Top
    PORT(
         X 								: IN   std_logic_vector(31 downto 0);
         Y 								: IN   std_logic_vector(31 downto 0);
         ops 							: IN   std_logic;
         PreS_S_SmallestSign 		: OUT  std_logic;
         PreS_S_GreatestSign 		: OUT  std_logic;
         PreS_S_GreatestExp 		: OUT  std_logic_vector( 7 downto 0);
         PreS_S_GreatestMantExp 	: OUT  std_logic_vector(26 downto 0);
         PreS_S_SmallestMantExp 	: OUT  std_logic_vector(26 downto 0);
         PreS_S_SpecialResult 	: OUT  std_logic_vector(31 downto 0);
         PreS_S_isSpecialResult 	: OUT  std_logic;
         S_PostS_ZSign 				: OUT  std_logic;
         S_PostS_ZExp 				: OUT  std_logic_vector( 7 downto 0);
         S_PostS_ZMantExp 			: OUT  std_logic_vector(26 downto 0);
--       S_PostS_SpecialResult 	: OUT  std_logic_vector(31 downto 0);
--       S_PostS_isSpecialResult : OUT  std_logic;
         ZR 							: OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal X   : std_logic_vector(31 downto 0) := (others => '0');
   signal Y   : std_logic_vector(31 downto 0) := (others => '0');
   signal ops : std_logic := '0';

 	--Outputs
   signal PreS_S_SmallestSign 	: std_logic;
   signal PreS_S_GreatestSign		: std_logic;
   signal PreS_S_GreatestExp 		: std_logic_vector( 7 downto 0);
   signal PreS_S_GreatestMantExp : std_logic_vector(26 downto 0);
   signal PreS_S_SmallestMantExp : std_logic_vector(26 downto 0);
   signal PreS_S_SpecialResult 	: std_logic_vector(31 downto 0);
   signal PreS_S_isSpecialResult : std_logic;
   signal S_PostS_ZSign 			: std_logic;
   signal S_PostS_ZExp 				: std_logic_vector( 7 downto 0);
   signal S_PostS_ZMantExp 		: std_logic_vector(26 downto 0);
-- signal S_PostS_SpecialResult 	: std_logic_vector(31 downto 0);
-- signal S_PostS_isSpecialResult: std_logic;
   signal ZR 							: std_logic_vector(31 downto 0);

	-- Verifica Testbench 
	
	signal testPassed 				:	std_logic;
	signal expectedResult			: 	std_logic_vector(31 downto 0) := (others => '0');
	
   --clock
   signal   clk						: std_logic := '0';
   constant clk_period 				: time := 70 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: Top PORT MAP (
          X 							=> X,
          Y 							=> Y,
          ops 							=> ops,
          PreS_S_SmallestSign	   => PreS_S_SmallestSign,
          PreS_S_GreatestSign 	=> PreS_S_GreatestSign,
          PreS_S_GreatestExp 		=> PreS_S_GreatestExp,
          PreS_S_GreatestMantExp => PreS_S_GreatestMantExp,
          PreS_S_SmallestMantExp => PreS_S_SmallestMantExp,
          PreS_S_SpecialResult 	=> PreS_S_SpecialResult,
          PreS_S_isSpecialResult => PreS_S_isSpecialResult,
          S_PostS_ZSign 			=> S_PostS_ZSign,
          S_PostS_ZExp 				=> S_PostS_ZExp,
          S_PostS_ZMantExp 		=> S_PostS_ZMantExp,
--        S_PostS_SpecialResult 	=> S_PostS_SpecialResult,
--        S_PostS_isSpecialResult=> S_PostS_isSpecialResult,
          ZR => ZR
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	-- Segnale Funzionamento test
	testPassed <= '1' when expectedResult = ZR else '0';

   -- Stimulus process
	stim_proc: process
	
		file filePointer 	: text is in "tbmany.txt";
		variable inputStream	: line;
		variable lnscorta 	: line; --- per qualche motivo vede sempre una riga vuota
		variable op1 			: std_logic_vector(31 downto 0);
		variable op2 			: std_logic_vector(31 downto 0);
		variable sign			: std_logic;
		variable expected 	: std_logic_vector(31 downto 0);
	
	begin  
     wait for 100 ns; 
	  
	  while( not endfile(filePointer)) LOOP
		-- Operando 1
		readline(filePointer, inputStream);
		read(inputStream, op1);
		
		-- Operando 2
		readline(filePointer, inputStream);
		read(inputStream, op2);
		
		-- Segno
		readline(filePointer, inputStream);
		read(inputStream, sign);
		
		-- Risultato Atteso
		readline(filePointer, inputStream);
		read(inputStream, expected);
		
		-- Assegna i dati letti alle porte/segnali
		X 					<= op1;
		Y 					<= op2;
		ops 				<= sign;
		expectedResult <= expected; 
		
		wait for clk_period;
	  END LOOP;
			wait;
	end process;

END;