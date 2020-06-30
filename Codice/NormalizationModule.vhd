----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    15:14:25 05/17/2018
-- Design Name:
-- Module Name:    NormalizationModule - RTL
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

entity NormalizationModule is
port(
	Exp 	: in 	std_logic_vector( 7 downto 0);
	Man 	: in 	std_logic_vector(26 downto 0);
	NExp	: out std_logic_vector( 7 downto 0);
	NMan	: out std_logic_vector(26 downto 0)--;
	--UnF	: out std_logic
);
end NormalizationModule;

architecture RTL of NormalizationModule is

-- Ci dice la posizione del primo 1
COMPONENT ModPriorityEncoder
	PORT(
		input 	: IN 	std_logic_vector(26 downto 0);
		output 	: OUT std_logic_vector( 4 downto 0)
		);
END COMPONENT;


-- Shifter a sinistra di tante posizioni quanto l'output del modulo ModPriorityEncoder
COMPONENT LShifter
	PORT(
		FM2Zero 	: IN 	std_logic;
		ShiftN 	: IN 	std_logic_vector( 4 downto 0);
		ExtM 		: IN 	std_logic_vector(26 downto 0);
		ShEM 		: OUT std_logic_vector(26 downto 0)
		);
END COMPONENT;

-- Decrementare l'esponente
COMPONENT CLAGeneric

	GENERIC(
			N: integer := 8
	);

	PORT(
		x 				: IN 	std_logic_vector(N-1 downto 0);
		y 				: IN 	std_logic_vector(N-1 downto 0);
		op				: IN 	std_logic;
		z 				: OUT std_logic_vector(N-1 downto 0);
		c_out 		: OUT std_logic
	);
END COMPONENT;

-- Ci dice se possiamo fare la differenza
COMPONENT ComparatorGeneric is

	GENERIC(
			L: integer := 8
		);

	PORT(
		X    : in  std_logic_vector(L-1 downto 0);
		Y    : in  std_logic_vector(L-1 downto 0);
		diff : out std_logic_vector(L-1 downto 0);
		XLY  : out std_logic;
		XGY  : out std_logic
		);
END COMPONENT;

	signal Shift_Num 					: std_logic_vector( 4 downto 0);
	signal Real_Shift  				: std_logic_vector( 4 downto 0);
	signal Shiftable_Positions  	: std_logic_vector( 7 downto 0);
	signal Required_Shift			: std_logic_vector( 7 downto 0);
	signal Shiftable_LT_Required 	: std_logic;
	signal COut 	 					: std_logic;
	signal XGY 		 					: std_logic; 							 --not used
	signal Shift_Not_Feasible		: std_logic;							
	signal Exp_M_ShiftN				: std_logic_vector( 4 downto 0);
	signal Normalized_Man_t	 		: std_logic_vector(26 downto 0);
	signal Exp_Minus_One				: std_logic_vector( 7 downto 0);
	signal Exp_Minus_RShift			: std_logic_vector( 7 downto 0);
	signal XGY2 		 				: std_logic; 							 --not used
	signal UnF_t2 	 					: std_logic;		

begin
	
	-- A) Calcolo il numero di posizioni da shiftare
	
	A_ModPriorityEncoder: ModPriorityEncoder
	PORT MAP(
		input 	=> Man,
		output 	=> Shift_Num
	);
	
	
	-- B) Calcolo il nuovo esponente se è possibile fare la differenza altrimenti se si dovesse andare 
	--    in negativo con l'esponente lo gestisco come subnormale
	
	
	-- Calcolo il numero di posizioni shiftabili
	UNF_Handler: CLAGeneric 
	generic map(
			N => 8
	)
	 
	port map(
		x => Exp,
		y => "00000001",
		op => '1', 			-- Sottrazione
		z => Exp_Minus_One,
		c_out => COut
	);
	
	Shiftable_Positions <= "00000000" when Exp = "00000000" else Exp_Minus_One;
	
	-- Faccio un confronto fra il numero di posizioni shiftabili e il numero di posizioni che dovrei
   --	shiftare (ShiftN)
	
	-- Vettore esteso per poter realizzare il confronto poiché Ecomparator prende vettori di 8 bit
	Required_Shift <= "000" & Shift_Num;
	
	EComparator: ComparatorGeneric
	 generic map(
			L => 5
	 )

	 port map(
			X 		=> Shiftable_Positions	(4 downto 0),
			Y 		=> Required_Shift			(4 downto 0),
			diff 	=> Exp_M_ShiftN,			 -- Risultato della differenza
			XLY 	=> Shiftable_LT_Required,-- Ci segnala underflow, ovvero che dovrei shiftare più posizioni di quelle consentite.
													 -- In questo caso il risultato sarà denormalizzato
			XGY => XGY
	);
	
	-- Per ottimizzare anziché fare un comparatore a 8 bit di Shiftable_Positions e Required_Shift uso uno a 5 bit con l'accortezza che
	Shift_Not_Feasible <= '0' when not(Shiftable_Positions(7 downto 5) = "000" ) else Shiftable_LT_Required;
	
	--  C) Se non si riesce a fare la sottrazione, il risultato sarà denormalizzato e dovrò shiftare solo di
	--     tante posizioni quanto l'esponente lo consente
	
	Real_Shift   <= Shiftable_Positions (4 downto 0) when Shift_Not_Feasible = '1' else Required_Shift (4 downto 0); 
	
	-- Se non si riesce a fare la sottrazione, il risultato sarà denormalizzato, ovvero con Exp=0...
	NExp	<= "00000000" when Shift_Not_Feasible = '1' else Exp_Minus_RShift ;
	
	ShiftComparator: ComparatorGeneric
	 generic map(
			L => 8
	 )

	 port map(
			X => Exp,
			Y => Required_Shift,
			diff => Exp_Minus_RShift,	-- Risultato della differenza
			XLY => UnF_t2,
			XGY => XGY2
	);
	
	-- Facciamo lo shift richiesto
	
	Inst_LShifter: LShifter
	port map(
		FM2Zero 	=> '0',     
		ShiftN  	=> Real_Shift,	 
		ExtM 	  	=> Man,
		ShEM 		=> Normalized_Man_t
	);
	
	NMan <= Normalized_Man_t;
	
end RTL;
