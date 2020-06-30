--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:42:23 05/17/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEEFinal/RounderTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rounder
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
 
ENTITY RounderTB IS
END RounderTB;
 
ARCHITECTURE behavior OF RounderTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rounder
    PORT(
         Exp : IN  std_logic_vector(7 downto 0);
         Man : IN  std_logic_vector(26 downto 0);
         RExpMan : OUT  std_logic_vector(30 downto 0);
         isZero : OUT  std_logic;
         isInfty : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Exp : std_logic_vector(7 downto 0) := (others => '0');
   signal Man : std_logic_vector(26 downto 0) := (others => '0');

 	--Outputs
   signal RExpMan : std_logic_vector(30 downto 0);
   signal isZero : std_logic;
   signal isInfty : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal   clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rounder PORT MAP (
          Exp => Exp,
          Man => Man,
          RExpMan => RExpMan,

          isZero => isZero,
          isInfty => isInfty
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
			Exp	<= "00000001";
			Man	<= "100000000000000000000000001";
      wait for 100 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000000010";
		wait for 100 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000000011";
		wait for 100 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000000100";
		wait for 50 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000001100";
		wait for 50 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000000101";
		wait for 50 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000000110";
		wait for 50 ns;	
			Exp	<= "00000001";
			Man	<= "100000000000000000000000111";
		wait for 50 ns;	
			Exp	<= "00001001";
			Man	<= "000111001111111111111111111";
		wait for 50 ns;	
			Exp	<= "00000001";
			Man	<= "000000000000000000001110000";
		wait for 50 ns;	
			Exp	<= "00000000";
			Man	<= "111111111111111111111111110";
      -- insert stimulus here 

      wait;
   end process;

END;
