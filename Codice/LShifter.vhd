----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:01:13 05/12/2018 
-- Design Name: 
-- Module Name:    LShifter - structural 
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

entity LShifter is
   port( 
      FM2Zero : in  std_logic;
      ShiftN  : in  std_logic_vector (4 downto 0);
      ExtM    : in  std_logic_vector (26 downto 0);
      ShEM    : out std_logic_vector (26 downto 0)
   );
end LShifter ;

architecture structural of LShifter is
	signal primoLivello:   std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal secondoLivello: std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal terzoLivello:   std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal quartoLivello:  std_logic_vector(26 downto 0) := "000000000000000000000000000";
	signal quintoLivello:  std_logic_vector(26 downto 0) := "000000000000000000000000000";
begin
		primoLivello 	<= ExtM				(25 downto 0) & '0' when ShiftN(0) = '1' else ExtM;
		secondoLivello <= primoLivello	(24 downto 0) & "00" when ShiftN(1) = '1' else primoLivello;
		terzoLivello 	<= secondoLivello	(22 downto 0) & "0000" when ShiftN(2) = '1' else secondoLivello;
		quartoLivello 	<= terzoLivello	(18 downto 0) & "00000000" when ShiftN(3) = '1' else terzoLivello;
		quintoLivello 	<= quartoLivello	(10 downto 0) & "0000000000000000" when ShiftN(4) = '1' else quartoLivello;
		ShEM <=  quintoLivello when FM2Zero = '0' else "000000000000000000000000000";
end structural;

