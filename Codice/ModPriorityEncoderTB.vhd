--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:37:18 05/17/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEEFinal/ModPriorityEncoderTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ModPriorityEncoder
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
 
ENTITY ModPriorityEncoderTB IS
END ModPriorityEncoderTB;
 
ARCHITECTURE behavior OF ModPriorityEncoderTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ModPriorityEncoder
    PORT(
         input  : IN   std_logic_vector(26 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(26 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ModPriorityEncoder PORT MAP (
          input => input,
          output => output
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
		wait for 40 ns;	
			input	<= "000000000000000000000000001";
		wait for 40 ns;	
			input	<= "000000000000000000000000000";
      wait for 40 ns;	
			input	<= "100000000000000000000000000";
		wait for 40 ns;	
			input	<= "010000000000000000000000000";
		wait for 40 ns;	
			input	<= "001000000000000000000000000";
		wait for 40 ns;	
			input	<= "000100000000000000000000000";
		wait for 40 ns;	
			input	<= "000010000000000000000000000";
		wait for 40 ns;	
			input	<= "000001000000000000000000000";
		wait for 40 ns;	
			input	<= "000000100000000000000000000";
		wait for 40 ns;	
			input	<= "000000010000000001000000000";
		wait for 40 ns;	
			input	<= "000000001000000000000100000";
		wait for 40 ns;	
			input	<= "000000000100000000010000000";
		wait for 40 ns;	
			input	<= "000000000010000000000010000";
		wait for 40 ns;	
			input	<= "000000000001000100000000000";
		wait for 40 ns;	
			input	<= "000000000000100000010000000";
		wait for 40 ns;	
			input	<= "000000000000010000000010000";
		wait for 40 ns;	
			input	<= "000000000000001000000000000";
		wait for 40 ns;	
			input	<= "000000000000000100000000000";
		wait for 40 ns;	
			input	<= "000000000000000010000000000";
		wait for 40 ns;	
			input	<= "000000000000000001000000000";
		wait for 40 ns;	
			input	<= "000000000000000000100001000";
		wait for 40 ns;	
			input	<= "000000000000000000010010000";	
		wait for 40 ns;	
			input	<= "000000000000000000001000010";	
		wait for 40 ns;	
			input	<= "000000000000000000000101100";	
		wait for 40 ns;	
			input	<= "000000000000000000000011100";
		wait for 40 ns;	
			input	<= "000000000000000000000001100";
		wait for 40 ns;	
			input	<= "000000000000000000000000100";
		wait for 40 ns;	
			input	<= "000000000000000000000000010";
      wait;
   end process;

END;
