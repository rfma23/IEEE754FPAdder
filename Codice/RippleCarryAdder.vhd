----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:34:34 06/19/2018 
-- Design Name: 
-- Module Name:    RippleCarryAdder - RTL 
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

entity RippleCarryAdder is

generic(	
		N: Integer := 27
	);
	
port(
	x       :  in   std_logic_vector(N-1 downto 0);
   y       :  in   std_logic_vector(N-1 downto 0);
	op		  :  in 	 std_logic;
	z		  :  out  std_logic_vector(N-1 downto 0);
	cout	  :  out	 std_logic
	);
	
end RippleCarryAdder;

architecture RTL of RippleCarryAdder is

	COMPONENT FullAdder
	PORT(
		a 		: IN 	std_logic;
		b 		: IN 	std_logic;
		cin 	: IN 	std_logic;          
		s 		: OUT std_logic;
		cout 	: OUT std_logic
		);
	END COMPONENT;

	signal   x_temp  :    std_logic_vector(N downto 0);
	signal   y_temp  :    std_logic_vector(N downto 0);
	signal   y_c     :    std_logic_vector(N downto 0);
	signal   op_vect :    std_logic_vector(N downto 0);
	signal   z_temp  :    std_logic_vector(N downto 0);

	
	signal   temp    :    std_logic_vector(N+1 downto 0);
	
begin

	--Estensione vettori
	x_temp <= '0' & x;
	y_temp <= '0' & y;
	
	--C1 se necessario
	op_vect <= (others => op);
	y_c     <= y_temp xor op_vect ;
	
	--C1 a C2 se necessario
	temp(0) <= op;
	
	FaCascade: for I in 0 to N generate
		FA_i: FullAdder 
		PORT MAP(
		a 		=> y_c(I),
		b 		=> x_temp(I),
		cin 	=> temp(I),
		s 		=> z_temp(I),
		cout 	=> temp(I+1) 
		);
	end generate FaCascade;
	
	--Calcolo risultato e overflow
	z 		 <= z_temp(N-1 downto 0);
	cout   <= z_temp(N);

end RTL;

