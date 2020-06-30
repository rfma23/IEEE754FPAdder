--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:59:29 05/16/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEEFinal/SumTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Sum
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
 
ENTITY SumTB IS
END SumTB;
 
ARCHITECTURE behavior OF SumTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sum
    PORT(
         SSign_in 	: IN  std_logic;
         GSign_in 	: IN  std_logic;
         GExp_in 		: IN  std_logic_vector(7 downto 0);
         GMantE_in 	: IN  std_logic_vector(26 downto 0);
         SMantE_in 	: IN  std_logic_vector(26 downto 0);
         SResult_in 	: IN  std_logic_vector(31 downto 0);
         isSpecR_in 	: IN  std_logic;
         ZS_out 		: OUT  std_logic;
         ZExp_out 	: OUT  std_logic_vector(7 downto 0);
         ZMantE_out 	: OUT  std_logic_vector(26 downto 0);
         SResult_out : OUT  std_logic_vector(31 downto 0);
         isSpecR_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal SSign_in 	: std_logic := '0';
   signal GSign_in 	: std_logic := '0';
   signal GExp_in 	: std_logic_vector(7 downto 0) := (others => '0');
   signal GMantE_in 	: std_logic_vector(26 downto 0) := (others => '0');
   signal SMantE_in 	: std_logic_vector(26 downto 0) := (others => '0');
   signal SResult_in : std_logic_vector(31 downto 0) := (others => '0');
   signal isSpecR_in : std_logic := '0';

 	--Outputs
   signal ZS_out 		: std_logic;
   signal ZExp_out 	: std_logic_vector(7 downto 0);
   signal ZMantE_out : std_logic_vector(26 downto 0);
   signal SResult_out: std_logic_vector(31 downto 0);
   signal isSpecR_out: std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sum PORT MAP (
          SSign_in 	 => SSign_in,
          GSign_in 	 => GSign_in,
          GExp_in 	 => GExp_in,
          GMantE_in 	 => GMantE_in,
          SMantE_in 	 => SMantE_in,
          SResult_in  => SResult_in,
          isSpecR_in  => isSpecR_in,
          ZS_out 		 => ZS_out,
          ZExp_out 	 => ZExp_out,
          ZMantE_out  => ZMantE_out,
          SResult_out => SResult_out,
          isSpecR_out => isSpecR_out
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
		wait for 50 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '1';
         GExp_in 		<= "00000001";
         GMantE_in 	<= "100000001000000000000000000";
         SMantE_in 	<= "000000010000000000000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0'; 
		wait for 50 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '1';
         GExp_in 		<= "00000001";
         GMantE_in 	<= "000000000000000000011111000";
         SMantE_in 	<= "000000000000000000001110000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
			
		wait for 50 ns;
    		SSign_in 	<= '1';
         GSign_in 	<= '0';
         GExp_in 		<= "00000001";
         GMantE_in 	<= "000000000000000000011111000";
         SMantE_in 	<= "000000000000000000001110000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
			
		wait for 100 ns;
			SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "10000001";
         GMantE_in 	<= "100000000000000000000000000";
         SMantE_in 	<= "100000000000000000000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 100 ns;
			SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "00100001";
         GMantE_in 	<= "100000000000000000000001000";
         SMantE_in 	<= "100000000000000000000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
      wait for 100 ns;
			SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "10000011";
         GMantE_in 	<= "111010001100110011000001000";
         SMantE_in 	<= "111010001100110011000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
      wait for 100 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "10000011";
         GMantE_in 	<= "101010001100110011000001000";
         SMantE_in 	<= "101010001100110011000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 100 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "11111110";
         GMantE_in 	<= "101010001100110011000001000";
         SMantE_in 	<= "101010001100110011000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 100 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "01111111";
         GMantE_in 	<= "101010001100110011000001000";
         SMantE_in 	<= "101010001100110011000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 50 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "11111110";
         GMantE_in 	<= "111111111111111111111111000";
         SMantE_in 	<= "100000000000000000000011000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 50 ns;
    		SSign_in 	<= '1';
         GSign_in 	<= '0';
         GExp_in 		<= "00000001";
         GMantE_in 	<= "100000000000000000011111000";
         SMantE_in 	<= "100000000000000000010001000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 50 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "00000000";
         GMantE_in 	<= "011111111111111111111111000";
         SMantE_in 	<= "011111111111111111111111000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 50 ns;
    		SSign_in 	<= '1';
         GSign_in 	<= '0';
         GExp_in 		<= "00100101";
         GMantE_in 	<= "100000000000000000000001000";
         SMantE_in 	<= "000010000000000000000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		-- SubNormal
		wait for 50 ns;
    		SSign_in 	<= '0';
         GSign_in 	<= '0';
         GExp_in 		<= "00000000";
         GMantE_in 	<= "000000010000000000000000000";
         SMantE_in 	<= "000000000000000000000001000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
		wait for 50 ns;
    		SSign_in 	<= '1';
         GSign_in 	<= '0';
         GExp_in 		<= "00000001";
         GMantE_in 	<= "100000001000000000000000000";
         SMantE_in 	<= "000000010000000000000000000";
         SResult_in 	<= "01010101010101010101010101010101";
         isSpecR_in 	<= '0';
      wait;
   end process;

END;
