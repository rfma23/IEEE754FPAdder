--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:34:31 05/14/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEE754Adder/SpecialCasesTB.vhd
-- Project Name:  IEEE754Adder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: SpecialCases
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
 
ENTITY SpecialCasesTB IS
 END SpecialCasesTB;

  ARCHITECTURE behavior OF SpecialCasesTB IS 

  -- Component Declaration
  COMPONENT SpecialCases
	PORT(
		x : IN std_logic_vector(31 downto 0);
		y : IN std_logic_vector(31 downto 0);          
		casoX : OUT std_logic_vector(4 downto 0);
		casoY : OUT std_logic_vector(4 downto 0);
		isSpecialC : OUT std_logic
		);
	END COMPONENT;
	
	signal 	x 				:	std_logic_vector(31 downto 0);
	signal	y 				:  std_logic_vector(31 downto 0);          
	signal	casoX	  	 	:  std_logic_vector(	4 downto 0);
	signal	casoY			:  std_logic_vector(	4 downto 0);
	signal	isSpecialC 	:  std_logic;
	
	signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
          

 BEGIN

  -- Component Instantiation
      uut: SpecialCases 
		port map(
			x => x,
			y => y,
			casoX => casoX,
			casoY => casoY,
			isSpecialC => isSpecialC
		);


  clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
	-- "0 11111111 10000000000000000000000"
   stim_proc: process
   begin
    wait for 100ns;
		x <= "01111111100000000000000000000000"; -- + Infinito
		y <= "11111111100000000000000000000000"; -- - Infinito
	 wait for 100ns;
		x <= "01111111100000000000000000000001"; --   NaN
		y <= "11111111100000000000000000000000"; -- - Infinito
	 wait for 100ns;
		x <= "01011111100000000000000000000000"; -- 	 Normale
		y <= "10000000000000000000000000000000"; --   SubNormale
	 wait for 100ns;
		x <= "00000000000000000000000000000000"; -- 	 Zero
		y <= "10000000000000000000000000000000"; --   SubNormale
	 wait for 100ns;
		x <= "00000000000000000000000000000000"; -- 	 Zero
		y <= "10000000100000000000000000000000"; --   Normale
	 wait for 100ns;
		x <= "00000000000000000000000001000000"; -- 	 Subnormale
		y <= "10000000100000000000000000000000"; --   Normale
	 wait;
	 
   end process;

END;
