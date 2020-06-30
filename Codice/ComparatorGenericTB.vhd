--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:43:51 05/13/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEE754Adder/ComparatorGenericTB.vhd
-- Project Name:  IEEE754Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ComparatorGeneric
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
 
ENTITY ComparatorGenericTB IS
END ComparatorGenericTB;
 
ARCHITECTURE behavior OF ComparatorGenericTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ComparatorGeneric
    PORT(
         X : IN  std_logic_vector(7 downto 0);
         Y : IN  std_logic_vector(7 downto 0);
         diff : OUT  std_logic_vector(7 downto 0);
         XLY : OUT  std_logic;
         XGY : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal X : std_logic_vector(7 downto 0) := (others => '0');
   signal Y : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal diff : std_logic_vector(7 downto 0);
   signal XLY : std_logic;
   signal XGY : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ComparatorGeneric PORT MAP (
          X => X,
          Y => Y,
          diff => diff,
          XLY => XLY,
          XGY => XGY
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
		--Diff funziona solo se EX>EY
      -- hold reset state for 100 ns.
      wait for 100 ns;
    		ex <= "11111111";
			ey <= "00000011";
		wait for 100 ns;
    		ex <= "00000011";
			ey <= "11111111";
		wait for 100 ns;
		   ex <= "11111111";
			ey <= "11111111";
		wait for 100 ns;
		   ex <= "00000000";
			ey <= "00000000";
      wait;
   end process;

END;
