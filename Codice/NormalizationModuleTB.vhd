--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   18:42:41 05/21/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEEFinal/NormalizationModuleTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: NormalizationModule
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
 
ENTITY NormalizationModuleTB IS
END NormalizationModuleTB;
 
ARCHITECTURE behavior OF NormalizationModuleTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT NormalizationModule
    PORT(
         Exp   : IN   std_logic_vector( 7 downto 0);
         Man   : IN   std_logic_vector(26 downto 0);
         NExp  : OUT  std_logic_vector( 7 downto 0);
         NMan  : OUT  std_logic_vector(26 downto 0);
         UnF   : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Exp  : std_logic_vector( 7 downto 0) := (others => '0');
   signal Man  : std_logic_vector(26 downto 0) := (others => '0');

 	--Outputs
   signal NExp : std_logic_vector( 7 downto 0);
   signal NMan : std_logic_vector(26 downto 0);
   signal UnF 	: std_logic;
	
	--Signals
   signal   clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: NormalizationModule PORT MAP (
          Exp  => Exp,
          Man  => Man,
          NExp => NExp,
          NMan => NMan,
          UnF  => UnF
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
			Exp	<= "00000001";
			Man	<= "000000000000000000001110000";
		wait for 50 ns;	
			Exp	<= "00000111";
			Man	<= "000100000000000000001110000";
		wait for 50 ns;	
			Exp	<= "10011111";
			Man	<= "000000000000000000000000001";
      wait;
   end process;

END;
