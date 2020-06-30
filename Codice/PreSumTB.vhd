--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:08:06 05/14/2018
-- Design Name:   
-- Module Name:   Z:/Desktop/IEEEFinal/PreSumTB.vhd
-- Project Name:  IEEEFinal
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PreSum
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
 
ENTITY PreSumTB IS
END PreSumTB;
 
ARCHITECTURE behavior OF PreSumTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PreSum
    PORT(
         inX : IN  std_logic_vector(31 downto 0);
         inY : IN  std_logic_vector(31 downto 0);
         op : IN  std_logic;
         SSign : OUT  std_logic;
         GSign : OUT  std_logic;
         GExp : OUT  std_logic_vector(7 downto 0);
         GMantE : OUT  std_logic_vector(26 downto 0);
         SMantE : OUT  std_logic_vector(26 downto 0);
         SResult : OUT  std_logic_vector(31 downto 0);
         isSpecR : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal inX : std_logic_vector(31 downto 0) := (others => '0');
   signal inY : std_logic_vector(31 downto 0) := (others => '0');
   signal op : std_logic := '0';

 	--Outputs
   signal SSign : std_logic;
   signal GSign : std_logic;
   signal GExp : std_logic_vector(7 downto 0);
   signal GMantE : std_logic_vector(26 downto 0);
   signal SMantE : std_logic_vector(26 downto 0);
   signal SResult : std_logic_vector(31 downto 0);
   signal isSpecR : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PreSum PORT MAP (
          inX => inX,
          inY => inY,
          op => op,
          SSign => SSign,
          GSign => GSign,
          GExp => GExp,
          GMantE => GMantE,
          SMantE => SMantE,
          SResult => SResult,
          isSpecR => isSpecR
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
			inX <= "00010000100000000000000000000000";
			inY <= "00010000100000000000000000000001";
			op	 <= '0';
      wait for 100 ns;
    		inX <= "01000001111010001100110011000000";
			inY <= "01000001111010001100110011000001";
			op	 <= '0';
      wait for 100 ns;
    		inX <= "01000001111010001100110011000000";
			inY <= "11000001111010001100110011000000";
			op	 <= '0';
		wait for 100 ns;
    		inX <= "01000001111010001100110011000000";
			inY <= "11000001111010001100110011000000";
			op	 <= '1';
		wait for 100 ns;
    		inX <= "01000001111010001100110011000000";
			inY <= "11111111111010001100110011000000";
			op	 <= '1';
		wait for 100 ns;
    		inX <= "01000001111010001100110011000000";
			inY <= "11111111111010001100110011000000";
			op	 <= '1';
		wait for 50 ns;	
			inX <= "00010000100000000000000000000001";
			inY <= "00000000000000000000000000000010";
			op	 <= '0';
		wait for 50 ns;
			inX <= "01111111011111111111111111111111";
			inY <= "00000000000000000000000000000011";
			op	 <= '0';
		wait for 50 ns;
			inX <= "00000000100000000000000000011111";
			inY <= "00000000100000000000000000010001";
			op	 <= '1';
		wait for 50 ns;
			inX <= "00000000011111111111111111111111";
			inY <= "00000000011111111111111111111111";
			op	 <= '0';
		wait for 50 ns;
			inX <= "00010010100000000000000000000001";
			inY <= "00010000100000000000000000000000";
			op	 <= '1';
		--SubNormal
		wait for 50 ns;
			inX <= "00000000000000010000000000000000";
			inY <= "00000000000000000000000000000001";
			op	 <= '0';
		wait for 50 ns;
			inX <= "00000000100000001000000000000000";     
			inY <= "00000000000000010000000000000000"; 
			op	 <= '1';	
      wait;
   end process;

END;
