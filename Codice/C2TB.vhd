--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:05:00 05/13/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEE754Adder/C2TB.vhd
-- Project Name:  IEEE754Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: C2
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
 
ENTITY C2TB IS
END C2TB;
 
ARCHITECTURE behavior OF C2TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT C2
    PORT(
         x    : IN   std_logic_vector(7 downto 0);
         x_c2 : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal x_c2 : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal 	clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: C2 PORT MAP (
          x => x,
          x_c2 => x_c2
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
    		x <= "00000000";
		wait for 100 ns;
			x <= "01010101";
		wait for 100 ns;
			x <= "11111111";
		wait for 100 ns;
			x <= "00000001"; --expected tutti 1
		wait for 100 ns;
			x <= "10001000";
		wait;
	
	end process;
END;
