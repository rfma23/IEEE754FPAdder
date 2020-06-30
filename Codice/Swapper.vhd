----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:45:35 05/13/2018 
-- Design Name: 
-- Module Name:    Swapper - structural 
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

entity Swapper is

port(
		A       :    in   std_logic_vector(31  downto 0);
		B       :    in   std_logic_vector(31  downto 0);
		GNum    :    out  std_logic_vector(31  downto 0);
		SNum    :    out  std_logic_vector(31  downto 0);
		EDiff   :    out  std_logic_vector( 4  downto 0);
		FM2Zero :    out  std_logic;
		Swapped :    out  std_logic
	);
end Swapper;


architecture structural of Swapper is

	component ComparatorGeneric is
	
	generic(
			L: integer := 8
		);
	
	port(
		X    : in  std_logic_vector(L-1 downto 0);
		Y    : in  std_logic_vector(L-1 downto 0);          
		diff : out std_logic_vector(L-1 downto 0);
		XLY  : out std_logic;
		XGY  : out std_logic
		);
	end component;
	
	signal    EAGEB     :  std_logic;
	signal    EALEB     :  std_logic;
	signal    MAGMB     :  std_logic;
	signal    MALMB     :  std_logic;
	signal 	 EDiff_t   :  std_logic_vector(7 downto 0);
	signal 	 MDiff_t   :  std_logic_vector(22 downto 0);
	signal 	 GMux1     :  std_logic_vector(31 downto 0);
	signal 	 GMux0     :  std_logic_vector(31 downto 0);
	signal 	 SMux1     :  std_logic_vector(31 downto 0);
	signal 	 SMux0     :  std_logic_vector(31 downto 0);

begin

	 EComparator: ComparatorGeneric
	 
	 generic map(
			L => 8
	 )
		
	 port map(
			X => A(30 downto 23),
			Y => B(30 downto 23),
			diff => EDiff_t,
			XLY => EALEB,
			XGY => EAGEB
	);
		
	
	MComparator: ComparatorGeneric
	
	 generic map(
			L => 23
	 )
		
	 port map(
			X => A(22 downto 0),
			Y => B(22 downto 0) ,
			diff => MDiff_t,
			XLY => MALMB,
			XGY => MAGMB
	 );
	
	GMux1   <= A     when EAGEB = '1' else B;
	GMux0   <= B     when EALEB = '1' else A;
	GNum    <= GMux1 when MALMB = '1' else GMux0;
	
	SMux1   <= B     when EAGEB = '1' else A;
	SMux0   <= A     when EALEB = '1' else B;
	SNum    <= SMux1 when MALMB = '1' else SMux0;

	EDiff   <= EDiff_t(4 downto 0);
	FM2Zero <= '0' when (EDiff_t(7 downto 5) = "000") else '1';
	
	Swapped <= ( not(EAGEB) and MALMB ) or EALEB;
	
	
end structural;



