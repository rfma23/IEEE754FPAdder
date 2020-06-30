----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    13:57:03 04/05/2018
-- Design Name:
-- Module Name:    casiInput - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CaseIdentifier is
 port(e: in std_logic_vector(7 downto 0);
	M: in std_logic_vector(22 downto 0);
	Caso: out std_logic_vector(4 downto 0));

end CaseIdentifier;

architecture structural of CaseIdentifier is

signal eAlmenoUno:std_logic;
signal eTuttiUno: std_logic;
signal eZero: std_logic;
signal mAlmenoUno:std_logic;

begin
	eAlmenoUno <= '0' when e = "00000000" else '1';
	eTuttiUno  <= '1' when e = "11111111" else '0';
	mAlmenoUno <= '0' when m = "00000000000000000000000" else '1';
	
	Caso(4)    <= eAlmenoUno and not(eTuttiUno); 		--normale
	Caso(3)    <= mAlmenoUno and not(eAlmenoUno); 		--subnormale
	Caso(2)    <= not(mAlmenoUno) and not(eAlmenoUno); --zero
	Caso(1)    <= mAlmenoUno and eTuttiUno; 				--NaN
	Caso(0)    <= not(mAlmenoUno) and eTuttiUno; 		--infinito

end structural;
