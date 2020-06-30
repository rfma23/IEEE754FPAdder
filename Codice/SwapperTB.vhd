--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:28:50 05/13/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEE754Adder/SwapperTB.vhd
-- Project Name:  IEEE754Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Swapper
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
 
ENTITY SwapperTB IS
END SwapperTB;
 
ARCHITECTURE behavior OF SwapperTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Swapper
    PORT(
         A : IN  std_logic_vector(31 downto 0);
         B : IN  std_logic_vector(31 downto 0);
         GNum : OUT  std_logic_vector(31 downto 0);
         SNum : OUT  std_logic_vector(31 downto 0);
         EDiff : OUT  std_logic_vector(4 downto 0);
         FM2Zero : OUT  std_logic;
         Swapped : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(31 downto 0) := (others => '0');
   signal B : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal GNum : std_logic_vector(31 downto 0);
   signal SNum : std_logic_vector(31 downto 0);
   signal EDiff : std_logic_vector(4 downto 0);
   signal FM2Zero : std_logic;
   signal Swapped : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 50 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Swapper PORT MAP (
          A => A,
          B => B,
          GNum => GNum,
          SNum => SNum,
          EDiff => EDiff,
          FM2Zero => FM2Zero,
          Swapped => Swapped
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
    		A <= "01010101000000000000000000000011";
			B <= "01010101000000000000000000000000";
		wait for 100 ns;
			A <= "01000001111010001100110011000000";
			B <= "01000001111010001100110011000001";
		wait for 100 ns;
			A <= "01010101000000000000000000000000";
			B <= "01110101000000000000000000001001";
		wait for 100 ns;
			A <= "01110101000000000000000000000000";
			B <= "01010101000000000000000000000011";
		wait for 100 ns;
			A <= "01010101000000000000000000000000";
			B <= "01010101000000000000000010001000";
		wait for 100 ns;
			A <= "01010101000000000000000010000000";
			B <= "01010101000000000000000000000000";
		wait for 100 ns;
			A <= "01011111000000000000000000000000";
			B <= "01010101000000000000000010001000";
		wait for 100 ns;
			A <= "01010101000000000000000010001000";
			B <= "01011111000000000000000000000000";
		wait for 50 ns;	
			A <= "00000000000000000000000000000010";
			B <= "00010000100000000000000000000001";
		wait;
	end process;

END;
