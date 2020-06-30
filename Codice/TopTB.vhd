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

ENTITY TopTB IS
END TopTB;

ARCHITECTURE behavior OF TopTB IS

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
   begin	
		-- Zero 3 (Denormalizzati)
			wait for clk_period/2;
			wait for clk_period;
			X		<= "00000011000000000000000001110000";     -- DEC 1.17551  E-38 HEX 0x00800070
			Y 		<= "00000011000000000000000011111000";     -- DEC 1.1755291E-38 HEX 0x008000f8
			ops	<= '1';                                   -- Segno +
		-- Expected Res BIN 00000000000000000000000000000000   DEC Zero.         HEX 0x80000088 

	
		-- Normal (+) 1 Exp=
		wait for clk_period;
			X		<= "00010000100000000000000000000000";     -- DEC 5.0487098 E-29 HEX 0x10800000
			Y 		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			ops	<= '0';                                    -- Segno +
		-- Expected Res   BIN 00010001000000000000000000000000 DEC 1.00974196E-28 HEX 0x11000000 


		-- Normal (+) 2 Exp=
		wait for clk_period;
			X		<= "00010000100000000000000000000001";     -- DEC 5.0487098 E-29 HEX 0x10800000
			Y 		<= "00010000100000000000000000000000";     -- DEC 5.0487104 E-29 HEX 0x10800001
			ops	<= '0';                                    -- Segno +
		-- Expected Res   BIN 00010001000000000000000000000000 DEC 1.00974196E-28 HEX 0x11000000 


		-- Normal (-) 1 Exp=
		wait for clk_period;
			X		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			Y 		<= "00010000100000000000000000000000";     -- DEC 5.0487098 E-29 HEX 0x10800000
			ops	<= '1';                                    -- Segno -
		-- Expected Res   BIN 00000101000000000000000000000000 DEC 6.018531  E-36 HEX 0x05000000


		-- Normal (-) 2 Exp=
		wait for clk_period;
			X		<= "00010000100000000000000000000000";     -- DEC 5.0487098 E-29 HEX 0x10800000
			Y 		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			ops	<= '1';                                    -- Segno -
		-- Expected Res   BIN 10000101000000000000000000000000 DEC-6.018531  E-36 HEX 0x85000000


		-- Normal (+) 1 Exp\neq
      wait for clk_period;
			X		<= "00010010100000000000000000000000";     -- DEC 8.0779357 E-28 HEX 0x12800000
			Y 		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			ops	<= '0';                                    -- Segno +
		-- Expected Res   BIN 00010010100010000000000000000000 DEC 8.58280664E-28 HEX 0x12880000


		-- Normal (+) 2 Exp\neq
		wait for clk_period;
			X		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			Y 		<= "00010010100000000000000000000000";     -- DEC 8.0779357 E-28 HEX 0x12800000
			ops	<= '0';                                    -- Segno +
		-- Expected Res   BIN 00010010100010000000000000000000 DEC 8.58280664E-28 HEX 0x12880000
		
		
		-- Normal (-) 1 Exp\neq
		wait for clk_period;
			X		<= "00010010100000000000000000000001";     -- DEC 8.077937  E-38 HEX 0x12800001
			Y 		<= "00010000100000000000000000000000";     -- DEC 5.0487098 E-29 HEX 0x10800000
			ops	<= '1';                                    -- Segno -
		-- Expected Res   BIN 00010010011100000000000000000010 DEC 7.5730657E-28 HEX 0x12700002 


		-- Normal (-) 2 Exp\neq
		wait for clk_period;
			X		<= "00010000100000000000000000000000";     -- DEC 5.0487098 E-29 HEX 0x10800000
			Y 		<= "00010010100000000000000000000001";     -- DEC 8.077937  E-28 HEX 0x12800001
			ops	<= '1';                                    -- Segno -
		-- Expected Res   BIN 10010010011100000000000000000010 DEC-7.5730657E-28 HEX 0x92700002
		
		
		-- Normal-Subnormal (+) 1
		wait for clk_period;
			X		<= "00000000100000001000000000000000";     -- DEC 1.1800861 E-38 HEX 0x00808000
			Y 		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			ops	<= '0';                                    -- Segno +
		-- Expected Res   BIN 00000000100000011000000000000000 DEC 1.189269 E-38 HEX 0x00818000
		
		
		-- Normal-Subnormal (+) 2
		wait for clk_period;
			X		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			Y 		<= "00000000100000001000000000000000";     -- DEC 1.1800861 E-38 HEX 0x00808000
			ops	<= '0';                                    -- Segno +
		-- Expected Res   BIN 00000000100000011000000000000000 DEC 1.189269  E-38 HEX 0x00818000
		
		
		-- Normal-Subnormal (-) 1
		wait for clk_period;
			X		<= "00000000100000001000000000000000";     -- DEC 1.1800861 E-38 HEX 0x00808000
			Y 		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 00000000011111111000000000000000   DEC 1.1663108E-38 HEX 0x007f8000
		
		
		-- Normal-Subnormal (-) 2
		wait for clk_period;
			X		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			Y 		<= "00000000100000001000000000000000";     -- DEC 1.1800861 E-38 HEX 0x00808000
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 10000000011111111000000000000000   DEC-1.1663108E-38 HEX 0x807f8000 
		
		
		-- Subnormal behaving as Zero (+) 1
		wait for clk_period;
			X		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			Y 		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 00010000100000000000000000000001   DEC 5.0487104E-29 HEX 0x10800001 
		
		
		-- Subnormal behaving as Zero (+) 2
		wait for clk_period;
			X		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			Y 		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 00010000100000000000000000000001   DEC 5.0487104E-29 HEX 0x10800001 
		
		
		-- Subnormal behaving as Zero (-) 1
		wait for clk_period;
			X		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			Y 		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 00010000100000000000000000000001   DEC 5.0487104E-29 HEX 0x10800001 
		
		
		-- Subnormal behaving as Zero (-) 2
		wait for clk_period;
			X		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			Y 		<= "00010000100000000000000000000001";     -- DEC 5.0487104 E-29 HEX 0x10800001
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 10010000100000000000000000000001   DEC-5.0487104E-29 HEX 0x908000011
		
		-- PureSubNormal (+) 1
		wait for clk_period;
			X		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			Y 		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 00000000000000010000000000000001   DEC 9.1837  E-41  HEX 0x00010001 
		
		
		-- PureSubNormal (+) 2
		wait for clk_period;
			X		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			Y 		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 00000000000000010000000000000001   DEC 9.1837  E-41  HEX 0x00010001 
		
		
		-- PureSubNormal (-) 1
		wait for clk_period;
			X		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			Y 		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 00000000000000001111111111111111   DEC 9.1834   E-41  HEX 0x0000ffff
		
		
		-- PureSubNormal (-) 2
		wait for clk_period;
			X		<= "00000000000000000000000000000001";     -- DEC 1.4       E-45 HEX 0x00000001
			Y 		<= "00000000000000010000000000000000";     -- DEC 9.18355.  E-41 HEX 0x00010000
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 10000000000000001111111111111111   DEC -9.1834 E-41 HEX 0x8000ffff
		
		--Subnormal special
		 wait for clk_period;
			X		<= "00000000100000000000000001110000";     -- DEC 1.17551  E-38 HEX 0x00800070
			Y 		<= "00000000100000000000000011111000";     -- DEC 1.1755291E-38 HEX 0x008000f8
			ops	<= '1';
		-- Expected Res BIN 10000000000000000000000010001000   DEC -1.9.   E-43 HEX 0x80000088
			
		--Subnormal special
		 wait for clk_period;
			X		<= "00000000000000000000000011111000";     -- DEC 3.48     E-43 HEX 0x000000f8
			Y 		<= "00000000000000000000000001110000";     -- DEC 1.9      E-43 HEX 0x00000088
			ops	<= '1';
		-- Expected Res BIN 00000000000000000000000010001000   DEC  1.9.   E-43 HEX 0x80000088
		
		-- NaN 1
		wait for clk_period;
			X		<= "01111111110000000000000000000001";     -- DEC NaN            HEX 0x7fc00001
			Y 		<= "00010000100000000000000000000000";     -- DEC 5.0487098 E-29 HEX 0x10800000
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 01111111111111111111111111111111   DEC NaN            HEX 0x7fffffff 
		
		
		-- NaN 2
		wait for clk_period;
			X		<= "01111111100000000000000000000000";     -- DEC +Infinity      HEX 0x7f800000
			Y 		<= "01111111100000000000000000000000";     -- DEC +Infinity      HEX 0x7f800000
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 01111111111111111111111111111111   DEC NaN            HEX 0x7fffffff 
		
		
		-- NaN 3
		wait for clk_period;
			X		<= "01111111100000000000000000000000";     -- DEC +Infinity      HEX 0x7f800000
			Y 		<= "11111111100000000000000000000000";     -- DEC -Infinity      HEX 0xff800000
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 01111111111111111111111111111111   DEC NaN            HEX 0x7fffffff 
		
		
		-- Infinity 1
		wait for clk_period;
			X		<= "01111111011111111111111111111111";     -- DEC 3.402823 E 38  HEX 0x7f7fffff
			Y 		<= "01111111000000000000000000000011";     -- DEC 4.2.     E-45  HEX 0x00000003
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 01111111100000000000000000000000   DEC +Infinity     HEX 0x7f800000 
  
  
		-- Infinity 2
		wait for clk_period;
			X		<= "11111111000000000000000000000011";     -- DEC-4.2.     E-45  HEX 0x80000003
			Y 		<= "11111111011111111111111111111111";     -- DEC-3.402823 E 38  HEX 0xff7fffff
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 11111111100000000000000000000000   DEC -Infinity     HEX 0xff800000 
		
		
		-- Not Really Infinity 1
		wait for clk_period;
			X		<= "01111111011111111111111111111111";     -- DEC 3.402823 E 38  HEX 0x7f7fffff
			Y 		<= "00000000000000000000000000000011";     -- DEC 4.2.     E-45  HEX 0x00000003
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 01111111011111111111111111111111   DEC 3.402823 E 38 HEX 0x7f7fffff 
		
		
		-- Not Really Infinity 2
		wait for clk_period;
			X		<= "10000000000000000000000000000011";     -- DEC-4.2.     E-45  HEX 0x80000003
			Y 		<= "11111111011111111111111111111111";     -- DEC-3.402823 E 38  HEX 0xff7fffff
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 11111111011111111111111111111111   DEC-3.402823 E 38 HEX 0xff7fffff 
  
  
		-- Operand Zero 1
		wait for clk_period;
			X		<= "00000000000000000000000000000000";     -- DEC 0              HEX 0x00000000
			Y 		<= "01110111000000000000000000011111";     -- DEC 2.596158 E 33  HEX 0x7700001f
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 01110111000000000000000000011111   DEC 2.596158 E 33 HEX 0x7700001f 
		
		
		-- Operand Zero 2
		wait for clk_period;
			X		<= "00000000000000000000000000000000";     -- DEC 0              HEX 0x00000000
			Y 		<= "01110111000000000000000000011111";     -- DEC 2.596158 E 33  HEX 0x7700001f
			ops	<= '1';                                    -- Segno -
		-- Expected Res BIN 11110111000000000000000000011111   DEC-2.596158 E 33 HEX 0xf700001f 	
		
		
		-- Zero (Denormalizzati)
		wait for clk_period;
			X		<= "00000000011111111111111111111111";     -- DEC 1.175494 E-38  HEX 0x007fffff
			Y 		<= "10000000011111111111111111111111";     -- DEC-1.175494 E-38  HEX 0x807fffff
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 00000000000000000000000000000000   DEC Zero.         HEX 0x00000000 
		
		
		-- (Denormalizzati = Normalizzato) 1
		wait for clk_period;
			X		<= "00000000011111111111111111111111";     -- DEC 1.175494 E-38  HEX 0x007fffff
			Y 		<= "00000000011111111111111111111111";     -- DEC 1.175494 E-38  HEX 0x007fffff
			ops	<= '0';                                    -- Segno +
		-- Expected Res BIN 00000000111111111111111111111110   DEC 2.596158 E 33 HEX 0x00fffffe 
		
		
		-- (Denormalizzati = Normalizzato) 2
		wait for clk_period;
			X		<= "00000000011111111111111111111111";     -- DEC 1.175494 E-38  HEX 0x007fffff
			Y 		<= "10000000011111111111111111111111";     -- DEC-1.175494 E-38  HEX 0x807fffff
			ops	<= '1';                                    -- Segno -
		-- Expected Res  BIN 00000000111111111111111111111110  DEC 2.596158 E 33 HEX 0x00fffffe 
		
		
		-- (Arrotondamento a infinito)
		wait for clk_period;
			X		<= "01111111011111111111111111111111";     -- DEC 3.4028235 E 38 HEX 0x7f7fffff
			Y 		<= "01111110000000000000000000000011";     -- DEC 4.253531  E 37 HEX 0x7e000003
			ops	<= '0';                                    -- Segno +
		-- Expected Res  BIN 01111111100000000000000000000000  DEC +Infinity     HEX 0x7f800000 
      wait;
   end process;
	
	stim_proc2: process
	
		file filePointer 	: text is in "testbench.txt";
		variable input 	: line;
		variable lnscorta : line; --- per qualche motivo vede sempre una riga vuota
		variable op1 		: std_logic_vector(31 downto 0);
		variable op2 		: std_logic_vector(31 downto 0);
		variable sign		: std_logic;
		variable expected : std_logic_vector(31 downto 0);
	
	begin  
     wait for 100 ns; 
	  
	  while( not endfile(filePointer)) LOOP
		-- Operando 1
		readline(filePointer, input);
		read(input, op1);
		
		-- Operando 2
		readline(filePointer, input);
		read(input, op2);
		
		-- Segno
		readline(filePointer, input);
		read(input, sign);
		
		-- Risultato Atteso
		readline(filePointer, input);
		read(input, expected);
		
		-- Riga in più
		readline(filePointer, input);
		
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