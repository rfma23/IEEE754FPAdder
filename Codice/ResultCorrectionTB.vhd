--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:22:14 05/17/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEEFinal/ResultCorrectionTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ResultCorrection
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ResultCorrectionTB IS
END ResultCorrectionTB;
 
ARCHITECTURE behavior OF ResultCorrectionTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ResultCorrection
    PORT(
         ZS_in : IN  std_logic;
         ZExp_in : IN  std_logic_vector(7 downto 0);
         ZMantE_in : IN  std_logic_vector(26 downto 0);
         SResult_in : IN  std_logic_vector(31 downto 0);
         isSpecR_in : IN  std_logic;
         Z : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ZS_in : std_logic := '0';
   signal ZExp_in : std_logic_vector(7 downto 0) := (others => '0');
   signal ZMantE_in : std_logic_vector(26 downto 0) := (others => '0');
   signal SResult_in : std_logic_vector(31 downto 0) := (others => '0');
   signal isSpecR_in : std_logic := '0';

 	--Outputs
   signal Z : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ResultCorrection PORT MAP (
          ZS_in => ZS_in,
          ZExp_in => ZExp_in,
          ZMantE_in => ZMantE_in,
          SResult_in => SResult_in,
          isSpecR_in => isSpecR_in,
          Z => Z
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
			ZS_in 	  <= 	'1';
         ZExp_in 	  <=  "00001001";
         ZMantE_in  <=  "001111111111111111111111111";
         SResult_in <= "10101010101010101010101010101010";
         isSpecR_in <= '0';
		wait for 100 ns;	
			ZS_in 	  <= 	'1';
         ZExp_in 	  <=  "00001001";
         ZMantE_in  <=  "000111001111111111111111111";
         SResult_in <=  "10101010101010101010101010101010";
         isSpecR_in <= '0';
		wait for 100 ns;	
			ZS_in 	  <= 	'1';
         ZExp_in 	  <=  "00001001";
         ZMantE_in  <=  "001111001111111111111111111";
         SResult_in <=  "10101010101010101010101010101010";
         isSpecR_in <= '0';
		wait for 100 ns;	
			ZS_in 	  <= 	'1';
         ZExp_in 	  <=  "00000001";
         ZMantE_in  <=  "000000000000000000001110000";
         SResult_in <=  "10101010101010101010101010101010";
         isSpecR_in <=  '0';
		-- Subnormale
		wait for 100 ns;	
			ZS_in 	  <= 	'0';
         ZExp_in 	  <=  "00000000";
         ZMantE_in  <=  "000000010000000000000001000";
         SResult_in <=  "10101010101010101010101010101010";
         isSpecR_in <=  '0';
		wait for 100 ns;	
			ZS_in 	  <= 	'0';
         ZExp_in 	  <=  "00000001";
         ZMantE_in  <=  "011111111000000000000000000";
         SResult_in <=  "10101010101010101010101010101010";
         isSpecR_in <=  '0';
      wait;
   end process;

END;
