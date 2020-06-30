----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:22:57 06/19/2018 
-- Design Name: 
-- Module Name:    FullAdder - rtl 
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

entity FullAdder is
	port   (
				a       :  in   std_logic;
				b       :  in   std_logic;
				cin     :  in   std_logic;    
				s       :  out  std_logic;
				cout    :  out  std_logic
			);	
end FullAdder;

architecture rtl of FullAdder is
begin
	s    <=  a xor b xor cin;
	cout <= (a and b) or (b and cin) or (a and cin);
end rtl;

