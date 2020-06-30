----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    22:29:53 05/16/2018 
-- Design Name: 
-- Module Name:    LsbRoundingIncrement - structural 
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

entity LsbRoundingIncrement is
	port(
		LSB	: in	std_logic;
		G		: in	std_logic;
		R		: in	std_logic;
		S		: in	std_logic;
		Incr	: out	std_logic
	);
end LsbRoundingIncrement;

architecture structural of LsbRoundingIncrement is

		signal input  : std_logic_vector( 0 to 3);
		signal output : std_logic;
		
begin
	
	input <= 	LSB & G & R & S;
	
	-- Tabella della verità che ci dice quando aumentare di 1 la mantissa.
	with input select
		output 	<= '0' when "0000",
						'0' when "0001",
						'0' when "0010",
						'0' when "0011",
						'0' when "0100",
						'1' when "0101",					
						'1' when "0110",
						'1' when "0111",
						'0' when "1000",
						'0' when "1001",
						'0' when "1010",
						'0' when "1011",
						'1' when "1100",
						'1' when "1101",
						'1' when "1110",
						'1' when "1111",
						'-' when others;
	Incr <= output;
end structural;

