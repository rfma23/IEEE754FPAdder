--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   22:46:02 05/16/2018
-- Design Name:
-- Module Name:   Z:/Desktop/IEEEFinal/LsbRoundingIncrementTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: LsbRoundingIncrement
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

ENTITY LsbRoundingIncrementTB IS
END LsbRoundingIncrementTB;

ARCHITECTURE behavior OF LsbRoundingIncrementTB IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT LsbRoundingIncrement
    PORT(
         LSB : IN  std_logic;
         G : IN  std_logic;
         R : IN  std_logic;
         S : IN  std_logic;
         Incr : OUT  std_logic
        );
    END COMPONENT;


   --Inputs
   signal LSB : std_logic := '0';
   signal G : std_logic := '0';
   signal R : std_logic := '0';
   signal S : std_logic := '0';

 	--Outputs
   signal Incr : std_logic;
   -- No clocks detected in port list. Replace <clock> below with
   -- appropriate port name

   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: LsbRoundingIncrement PORT MAP (
          LSB => LSB,
          G => G,
          R => R,
          S => S,
          Incr => Incr
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
      wait for 50ns;
			LSB <= '0';
			G   <= '0';
			R   <= '0';
			S   <= '0';
		wait for 50ns;
			LSB <= '0';
			G   <= '0';
			R   <= '0';
			S   <= '1';
		wait for 50ns;
			LSB <= '0';
			G   <= '0';
			R   <= '1';
			S   <= '0';
		wait for 50ns;
			LSB <= '0';
			G   <= '0';
			R   <= '1';
			S   <= '1';
		wait for 50ns;
			LSB <= '0';
			G   <= '1';
			R   <= '0';
			S   <= '0';
		wait for 50ns;
			LSB <= '0';
			G   <= '1';
			R   <= '0';
			S   <= '1';
		wait for 50ns;
			LSB <= '0';
			G   <= '1';
			R   <= '1';
			S   <= '0';
		wait for 50ns;
			LSB <= '0';
			G   <= '1';
			R   <= '1';
			S   <= '1';
		wait for 50ns;
			LSB <= '1';
			G   <= '0';
			R   <= '0';
			S   <= '0';
		wait for 50ns;
			LSB <= '1';
			G   <= '0';
			R   <= '0';
			S   <= '1';
		wait for 50ns;
			LSB <= '1';
			G   <= '0';
			R   <= '1';
			S   <= '0';
		wait for 50ns;
			LSB <= '1';
			G   <= '0';
			R   <= '1';
			S   <= '1';
		wait for 50ns;
			LSB <= '1';
			G   <= '1';
			R   <= '0';
			S   <= '0';
		wait for 50ns;
			LSB <= '1';
			G   <= '1';
			R   <= '0';
			S   <= '1';
		wait for 50ns;
			LSB <= '1';
			G   <= '1';
			R   <= '1';
			S   <= '0';
		wait for 50ns;
			LSB <= '1';
			G   <= '1';
			R   <= '1';
			S   <= '1'; 
      wait;
   end process;

END;
