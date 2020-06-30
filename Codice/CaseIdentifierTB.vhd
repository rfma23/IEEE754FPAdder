--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   14:28:50 04/05/2018
-- Design Name:
-- Module Name:   /home/ise/casisticheInput/tbCasiInput.vhd
-- Project Name:  casisticheInput
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: casiInput
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

ENTITY tbCasiInput IS
END tbCasiInput;

ARCHITECTURE behavior OF CaseIdentifierTB IS

    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT CaseIdentifier
    PORT(
         e : IN  std_logic_vector(7 downto 0);
         M : IN  std_logic_vector(22 downto 0);
         Caso : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal e : std_logic_vector(7 downto 0) := (others => '0');
   signal M : std_logic_vector(22 downto 0) := (others => '0');

 	--Outputs
   signal Caso : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with
   -- appropriate port name
	signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: CaseIdentifier PORT MAP (
          e => e,
          M => M,
          Caso => Caso
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

			e <= "00000001";
			M <= "00000000000000000000000"; --normale
		wait for 100 ns;
			e <= "00000001";
			M <= "10000000000000000000000"; --normale 2
		wait for 100 ns;
			e <= "00000000";
			M <= "10000000000000000000000"; --subnormale
		wait for 100 ns;
			e <= "00000000";
			M <= "00000000000000000000000"; --zero
		wait for 100 ns;
			e <= "11111111";
			M <= "00000000000000000000001"; --NaN
		wait for 100 ns;
			e <= "11111111";
			M <= "00000000000000000000000"; --infinito


      -- insert stimulus here

      wait;
   end process;

END;
