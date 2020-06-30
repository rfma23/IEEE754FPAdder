----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:08:59 05/17/2018 
-- Design Name: 
-- Module Name:    PriorityEncoder - structural 
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

entity ModPriorityEncoder is
	port(
			input 	: in 	std_logic_vector(26 downto 0);
			output 	: out	std_logic_vector( 4 downto 0)
	);
end ModPriorityEncoder;

architecture rtl of ModPriorityEncoder is

begin
		output	<= 	"00000"	when input(26) = '1' 
					else	"00001"	when input(26 downto 25) = "01" 
					else	"00010"	when input(26 downto 24) = "001"
					else	"00011"	when input(26 downto 23) = "0001"
					else	"00100"	when input(26 downto 22) = "00001"
					else	"00101"	when input(26 downto 21) = "000001"
					else	"00110"	when input(26 downto 20) = "0000001"
					else	"00111"	when input(26 downto 19) = "00000001"
					else	"01000"	when input(26 downto 18) = "000000001"
					else	"01001"	when input(26 downto 17) = "0000000001"
					else	"01010"	when input(26 downto 16) = "00000000001"
					else	"01011"	when input(26 downto 15) = "000000000001"
					else	"01100"	when input(26 downto 14) = "0000000000001"
					else	"01101"	when input(26 downto 13) = "00000000000001"
					else	"01110"	when input(26 downto 12) = "000000000000001"
					else	"01111"	when input(26 downto 11) = "0000000000000001"
					else	"10000"	when input(26 downto 10) = "00000000000000001"
					else	"10001"	when input(26 downto  9) = "000000000000000001"
					else	"10010"	when input(26 downto  8) = "0000000000000000001"
					else	"10011"	when input(26 downto  7) = "00000000000000000001"
					else	"10100"	when input(26 downto  6) = "000000000000000000001"
					else	"10101"	when input(26 downto  5) = "0000000000000000000001"
					else	"10110"	when input(26 downto  4) = "00000000000000000000001"
					else	"10111"	when input(26 downto  3) = "000000000000000000000001"
					else	"11000"	when input(26 downto  2) = "0000000000000000000000001"
					else	"11001"	when input(26 downto  1) = "00000000000000000000000001"
					else	"11010"	when input(26 downto  0) = "000000000000000000000000001"
					else	"11011"	when input(26 downto  0) = "000000000000000000000000000"
					else	"-----";
					
					-- Ci dava problemi con i DC
					-- Sarebbe stato così:			 
					-- else	"00001"	when input = "01---------------------------" 
					-- else	"00010"	when input = "001--------------------------"

end rtl;

