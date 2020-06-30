--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:44:21 05/13/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEE754Adder/CLAGenericTB.vhd
-- Project Name:  IEEE754Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: CLAGeneric
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
 
ENTITY CLAGenericTB IS
END CLAGenericTB;
 
ARCHITECTURE behavior OF CLAGenericTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CLAGeneric
    PORT(
         x : IN  std_logic_vector(26 downto 0);
         y : IN  std_logic_vector(26 downto 0);
         op : IN  std_logic;
         z : OUT  std_logic_vector(26 downto 0);
         c_out : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(26 downto 0) := (others => '0');
   signal y : std_logic_vector(26 downto 0) := (others => '0');
   signal op : std_logic := '0';

 	--Outputs
   signal z : std_logic_vector(26 downto 0);
   signal c_out : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CLAGeneric PORT MAP (
          x => x,
          y => y,
          op => op,
          z => z,
          c_out => c_out
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
			op <= '1';
			x <= "111101111111111111111111111";
			y <= "000000000000000000000000011";
		wait for 50 ns;
			op <= '0';
			x <= "111101111111111111111111111";
			y <= "000000000000000000000000011";
      wait for 50 ns;
			op <= '0';
    		x <= "010000011110100011001100110";
			y <= "010000011110100011001100110";
		wait for 50 ns;
			op <= '1';
    		x <= "010000011110100011001100111";
			y <= "010000011110100011001100110";
		wait for 50 ns;
			op <= '0';
			x <= "011111111111111111111111111";
			y <= "000000000000000000000000011";
		wait for 50 ns;
			op <= '1';
			x <= "011111111111111111111111111";
			y <= "000000000000000000000000011";
		wait for 50 ns;
			op <= '0';
			x <= "010000011110100011001100110";
			y <= "010000011110100011001100110";
		wait for 50 ns;
			op <= '0';
			x <= "111111111111111111111111111";
			y <= "000000000000000000000000011";
		wait for 50 ns;
			op <= '1';
			x <= "000000000000000000000000011";
			y <= "000000000000000000000000011";
		wait for 50 ns;
			op <= '1';
			x <= "100000000000000000000000011";
			y <= "011111111111111111111111111";
		wait for 50 ns;
			op <= '1';
			x <= "011111111111111111111111111";
			y <= "100000000000000000000000011";
		wait for 50 ns;
			op <= '1';
			x <= "000000000000000000000000001";
			y <= "000000000000000000000000011";
		wait for 50 ns;
			op <= '1';
			x <= "000000000000000000000000011";
			y <= "000000000000000000000000001";
		wait for 50 ns;
			op <= '1';
			x <= "100000000000000000000001000";
			y <= "000010000000000000000000000";
		wait for 50 ns;
			op <= '0';
			x <= "100000000000000000000001000";
			y <= "111110000000000000000000000";
		wait;
	
	end process;
END;
