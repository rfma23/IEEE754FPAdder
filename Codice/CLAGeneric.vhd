----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:32:45 05/13/2018 
-- Design Name: 
-- Module Name:    CLAGeneric - structural 
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

entity CLAGeneric is

generic(
			N       : integer := 27
		);
		
port   (
         x       :  in   std_logic_vector(N-1 downto 0);
         y       :  in   std_logic_vector(N-1 downto 0);
			op      :  in   std_logic;    
         z       :  out  std_logic_vector(N-1 downto 0);
         c_out   :  out  std_logic
      );
		
end CLAGeneric;

architecture structural of CLAGeneric is
	signal   x_temp  :    std_logic_vector(N downto 0);
	signal   y_temp  :    std_logic_vector(N downto 0);
	signal   y_c     :    std_logic_vector(N downto 0);
	signal   op_vect :    std_logic_vector(N downto 0);
	signal   c_temp  :    std_logic_vector(N downto 0);
	signal   z_temp  :    std_logic_vector(N downto 0);
	signal   g       :    std_logic_vector(N downto 0);
	signal   p       :    std_logic_vector(N downto 0);

begin
	
	--Estensione vettori
	x_temp <= '0' & x;
	y_temp <= '0' & y;
	
	--C1 se necessario
	op_vect <= (others => op);
	y_c     <= y_temp xor op_vect ;
	
	--Generazione
	g  <= x_temp and y_c; 

	--Propagazione
	p  <= x_temp or y_c;   
	
	
	--process (op, g, p, c_temp)
	--begin
	
	--C1 a C2 se necessario
	c_temp(0) <= op;
		
	--Calcolo dei riporti(carry)
	CarryLoop: for I in 0 to N-1 generate
		c_temp(I+1) <= g(I) or ( p(I) and c_temp(I) );
	end generate CarryLoop;
	
	--end process;
	
	--Calcolo della somma
	z_temp <= x_temp xor y_c xor c_temp;
	
	--Calcolo risultato e overflow
	z <= z_temp(N-1 downto 0);
	c_out <= z_temp(N);
	
end structural;

architecture structural2 of CLAGeneric is
	signal   x_temp  :    std_logic_vector(N downto 0);
	signal   y_temp  :    std_logic_vector(N downto 0);
	signal   y_c     :    std_logic_vector(N downto 0);
	signal   op_vect :    std_logic_vector(N downto 0);
	signal   c_temp  :    std_logic_vector(N downto 0);
	signal   z_temp  :    std_logic_vector(N downto 0);
	signal   g       :    std_logic_vector(N downto 0);
	signal   p       :    std_logic_vector(N downto 0);

begin
	
	--Estensione vettori
	x_temp <= '0' & x;
	y_temp <= '0' & y;
	
	--C1 se necessario
	op_vect <= (others => op);
	y_c     <= y_temp xor op_vect ;
	
	--Generazione
	g  <= x_temp and y_c; 

	--Propagazione
	p  <= x_temp or y_c;   
	
	--Altera Style
	process (op, g, p, c_temp)
	begin
	
		--C1 a C2 se necessario
		c_temp(0) <= op;
			
		--Calcolo dei riporti(carry)
		for I in 0 to N-1 loop
			c_temp(I+1) <= g(I) or ( p(I) and c_temp(I) );
		end loop;
	
	end process;
	
	--Calcolo della somma
	z_temp <= x_temp xor y_c xor c_temp;
	
	--Calcolo risultato e overflow
	z <= z_temp(N-1 downto 0);
	c_out <= z_temp(N);
	
end structural2;


