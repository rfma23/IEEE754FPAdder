--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:08:12 05/12/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEE754Adder/RShifterTB.vhd
-- Project Name:  IEEE754Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: RShifter
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
 
ENTITY RShifterTB IS
END RShifterTB;
 
ARCHITECTURE behavior OF RShifterTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RShifter
    PORT(
			isSubnormal	: IN	std_logic;
         FM2Zero : IN  std_logic;
         ShiftN : IN  std_logic_vector(4 downto 0);
         ExtM : IN  std_logic_vector(26 downto 0);
         ShEM : OUT  std_logic_vector(26 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal FM2Zero : std_logic := '0';
	signal isSubnormal  : std_logic := '0';
   signal ShiftN : std_logic_vector(4 downto 0) := (others => '0');
   signal ExtM : std_logic_vector(26 downto 0) := (others => '0');

 	--Outputs
   signal ShEM : std_logic_vector(26 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RShifter PORT MAP (
			 isSubnormal => isSubnormal,
          FM2Zero => FM2Zero,
          ShiftN => ShiftN,
          ExtM => ExtM,
          ShEM => ShEM
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
			FM2Zero <= '0';
			ShiftN <= "00001";
			ExtM <= "000000000000000000000000011";
		wait for 100 ns;
			FM2Zero <= '1';
			ShiftN <="00001";
			ExtM <= "000000000000011110111011010";
		wait for 100 ns;
			FM2Zero <= '0';
			ShiftN <= "00010";
			ExtM <= "000000000000000000000000011";
		wait for 100 ns;
			FM2Zero <= '0';
			ShiftN <= "00001";
			ExtM <= "000000000000000000000000111";
		wait for 100 ns;
			FM2Zero <= '0';
			ShiftN <= "00011";
			ExtM <= "000000000000000000001110111";
		wait for 100 ns;
			FM2Zero <= '0';
			ShiftN <= "01101";
			ExtM <= "111011111011110111101110111";
		wait;
	end process;
	
END;