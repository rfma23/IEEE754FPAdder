----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:33:01 05/22/2018 
-- Design Name: 
-- Module Name:    TopPipelined - pipelined 
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

entity TopPipelined is
port(
	X 								: in 	std_logic_vector(31 downto 0);
	Y 								: in	std_logic_vector(31 downto 0);
	ops							: in	std_logic;
	RESET 						: in  std_logic;
	CLK							: in	std_logic;
	PreS_S_SmallestSign	  	: out std_logic := '0';
	PreS_S_GreatestSign  	: out std_logic := '0';
	PreS_S_GreatestExp		: out std_logic_vector( 7 downto 0);
	PreS_S_GreatestMantExp	: out std_logic_vector(26 downto 0);
-- PreS_S_SmallestMantExp	: out std_logic_vector(26 downto 0);
	PreS_S_SpecialResult	 	: out std_logic_vector(31 downto 0);
	PreS_S_isSpecialResult	: out std_logic;
	S_PostS_ZSign 				: out std_logic;
	S_PostS_ZExp 				: out std_logic_vector( 7 downto 0);
	S_PostS_ZMantExp  		: out std_logic_vector(26 downto 0);
--	S_PostS_SpecialResult  	: out std_logic_vector(31 downto 0);
--	S_PostS_isSpecialResult : out std_logic;
-- PostS_Result_ZExp			: out std_logic_vector( 7 downto 0);
	PostS_Result_MantNnR  	: out std_logic_vector(22 downto 0);
	ZR								: out std_logic_vector(31 downto 0)
);
end TopPipelined;

architecture pipelined of TopPipelined is

COMPONENT PreSum
	PORT(
		inX 			: in 	std_logic_vector(31 downto 0);
		inY 			: in 	std_logic_vector(31 downto 0);
		op 			: in 	std_logic;          
		SSign			: out std_logic;
		GSign 		: out std_logic;
		GExp 			: out std_logic_vector(7 downto 0);
		GMantE 		: out std_logic_vector(26 downto 0);
		SMantE 		: out std_logic_vector(26 downto 0);
		SResult 		: out std_logic_vector(31 downto 0);
		isSpecR 		: out std_logic
		);
END COMPONENT;

COMPONENT Sum
	PORT(
		SSign_in 	: in 	std_logic;
		GSign_in 	: in 	std_logic;
		GExp_in 		: in 	std_logic_vector(7 downto 0);
		GMantE_in 	: in 	std_logic_vector(26 downto 0);
		SMantE_in 	: in 	std_logic_vector(26 downto 0);
		SResult_in 	: in 	std_logic_vector(31 downto 0);
		isSpecR_in 	: in 	std_logic;          
		ZS_out 		: out std_logic;
		ZExp_out	 	: out std_logic_vector(7 downto 0);
		ZMantE_out 	: out std_logic_vector(26 downto 0);
		SResult_out : out std_logic_vector(31 downto 0);
		isSpecR_out : out std_logic
		);
	END COMPONENT;

COMPONENT ResultCorrection
	PORT(
		ZS_in 		: in 	std_logic;
		ZExp_in 		: in 	std_logic_vector( 7 downto 0);
		ZMantE_in 	: in 	std_logic_vector(26 downto 0);
		SResult_in	: in 	std_logic_vector(31 downto 0);
		isSpecR_in 	: in 	std_logic;          
		Z 				: out std_logic_vector(31 downto 0)
		);
END COMPONENT;

	signal PreS_X  		  						: std_logic_vector(31 downto 0):= (others => '0');
	signal PreS_Y 			  						: std_logic_vector(31 downto 0):= (others => '0');
	signal PreS_op 		  						: std_logic := '0';
	
	--PreSum - Sum
	signal PreS_S_SmallestSign_t	  			: std_logic	:= '0';
	signal PreS_S_GreatestSign_t	  			: std_logic	:= '0';
	signal PreS_S_GreatestExp_t	  			: std_logic_vector( 7 downto 0):= (others => '0');
	signal PreS_S_GreatestMantExp_t  		: std_logic_vector(26 downto 0):= (others => '0');
	signal PreS_S_SmallestMantExp_t  		: std_logic_vector(26 downto 0):= (others => '0');
	signal PreS_S_SpecialResult_t 			: std_logic_vector(31 downto 0):= (others => '0');
	signal PreS_S_isSpecialResult_t 			: std_logic	:= '0';
	signal PreS_S_SmallestSign_out  			: std_logic	:= '0';
	signal PreS_S_GreatestSign_out  			: std_logic	:= '0';
	signal PreS_S_GreatestExp_out	  			: std_logic_vector( 7 downto 0):= (others => '0');
	signal PreS_S_GreatestMantExp_out 		: std_logic_vector(26 downto 0):= (others => '0');
	signal PreS_S_SmallestMantExp_out 		: std_logic_vector(26 downto 0):= (others => '0');
	signal PreS_S_SpecialResult_out			: std_logic_vector(31 downto 0):= (others => '0');
	signal PreS_S_isSpecialResult_out		: std_logic	:= '0';
	
	signal S_PostS_ZSign_s2_t	      		: std_logic	:= '0';
	signal S_PostS_ZExp_s2_t  	   			: std_logic_vector( 7 downto 0):= (others => '0');
	signal S_PostS_ZMantExp_s2_t   			: std_logic_vector(26 downto 0):= (others => '0');
	signal S_PostS_SpecialResult_s2_t  		: std_logic_vector(31 downto 0):= (others => '0');
	signal S_PostS_isSpecialResult_s2_t		: std_logic	:= '0';

	signal S_PostS_ZSign_s2_out	   		: std_logic	:= '0';
	signal S_PostS_ZExp_s2_out	   			: std_logic_vector( 7 downto 0):= (others => '0');
	signal S_PostS_ZMantExp_s2_out  			: std_logic_vector(26 downto 0):= (others => '0');
	signal S_PostS_SpecialResult_s2_out 	: std_logic_vector(31 downto 0):= (others => '0');
	signal S_PostS_isSpecialResult_s2_out 	: std_logic	:= '0';
	
	signal PostS_z_t          					: std_logic_vector(31 downto 0):= (others => '0');
	


begin

----------------------------------------FRONTE DI CLOCK --------------------------------------

	--registro iniziale	
	PreS: process(CLK)
	begin
		if(CLK' event and CLK = '1') then
			if(RESET = '1') then
				PreS_X  <= (others => '0');
				PreS_Y  <= (others => '0');
				PreS_op <= '0';
			else
				PreS_X  <= X;
				PreS_Y  <= Y;
				PreS_op <= ops;
			end if;
		end if;
	end process;
	
	-- Fase Pre Somma
	
	A_PreSum: PreSum 
	PORT MAP(
		inX 		=> PreS_X,
		inY 		=> PreS_Y,
		op 		=> PreS_op,
		
		SSign 	=> PreS_S_SmallestSign_t,
		GSign 	=> PreS_S_GreatestSign_t,
		GExp 		=> PreS_S_GreatestExp_t,
		GMantE 	=> PreS_S_GreatestMantExp_t,
		SMantE 	=> PreS_S_SmallestMantExp_t,
		SResult 	=> PreS_S_SpecialResult_t,
		isSpecR 	=> PreS_S_isSpecialResult_t
	);
	
	PreS_S_SmallestSign 	 	<= PreS_S_SmallestSign_t;
	PreS_S_GreatestSign  	<= PreS_S_GreatestSign_t;
	PreS_S_GreatestExp	 	<= PreS_S_GreatestExp_t;
	PreS_S_GreatestMantExp  <= PreS_S_GreatestMantExp_t;
-- PreS_S_SmallestMantExp	<= PreS_S_SmallestMantExp_t;
	PreS_S_SpecialResult	 	<= PreS_S_SpecialResult_t;
	PreS_S_isSpecialResult	<= PreS_S_isSpecialResult_t;
	
----------------------------------------FRONTE DI CLOCK --------------------------------------

	-- registro tra pre-somma e somma
	
	PreS_S: process(CLK)
	begin
		if( CLK' event and CLK = '1' ) then
			if(RESET = '1') then
				 PreS_S_SmallestSign_out 		<= '0';
				 PreS_S_GreatestSign_out 		<= '0';
				 PreS_S_GreatestExp_out 		<= (others => '0');
				 PreS_S_GreatestMantExp_out 	<= (others => '0');
				 PreS_S_SmallestMantExp_out 	<= (others => '0');
				 PreS_S_SpecialResult_out 		<= (others => '0');
				 PreS_S_isSpecialResult_out	<= '0';
			else
				 PreS_S_SmallestSign_out 		<=  PreS_S_SmallestSign_t;
				 PreS_S_GreatestSign_out 		<=  PreS_S_GreatestSign_t;
				 PreS_S_GreatestExp_out 		<=  PreS_S_GreatestExp_t;
				 PreS_S_GreatestMantExp_out 	<=  PreS_S_GreatestMantExp_t;
				 PreS_S_SmallestMantExp_out 	<=  PreS_S_SmallestMantExp_t;
				 PreS_S_SpecialResult_out 		<=  PreS_S_SpecialResult_t;
				 PreS_S_isSpecialResult_out 	<=  PreS_S_isSpecialResult_t;
			end if;
		end if;
	end process;
	
	-- Fase Somma
	
	B_Sum: Sum 
	PORT MAP(
		SSign_in 		=>  PreS_S_SmallestSign_out,
		GSign_in			=>  PreS_S_GreatestSign_out,
		GExp_in 			=>  PreS_S_GreatestExp_out,
		GMantE_in 		=>  PreS_S_GreatestMantExp_out,
		SMantE_in 		=>  PreS_S_SmallestMantExp_out,
		SResult_in 		=>  PreS_S_SpecialResult_out,
		isSpecR_in 		=>  PreS_S_isSpecialResult_out,
		ZS_out 			=>  S_PostS_ZSign_s2_t,
		ZExp_out 		=>  S_PostS_ZExp_s2_t,
		ZMantE_out		=>  S_PostS_ZMantExp_s2_t,
		SResult_out 	=>  S_PostS_SpecialResult_s2_t,
		isSpecR_out 	=>  S_PostS_isSpecialResult_s2_t
	);
	
	S_PostS_ZSign 			 	<= S_PostS_ZSign_s2_t;
	S_PostS_ZExp 				<= S_PostS_ZExp_s2_t;
	S_PostS_ZMantExp  		<= S_PostS_ZMantExp_s2_t;
	
	
	----------------------------------------FRONTE DI CLOCK --------------------------------------
	
	-- registro tra somma e fase correttiva
	
	S_PostS: process(CLK)
	begin
		if( CLK' event and CLK = '1' ) then
			if(RESET = '1') then
				S_PostS_ZSign_s2_out 			 <= '0';
				S_PostS_ZExp_s2_out 				 <= (others => '0');
				S_PostS_ZMantExp_s2_out 		 <= (others => '0');
				S_PostS_SpecialResult_s2_out 	 <= (others => '0');
				S_PostS_isSpecialResult_s2_out <= '0';
			else
				S_PostS_ZSign_s2_out 			 <= S_PostS_ZSign_s2_t;
				S_PostS_ZExp_s2_out 				 <= S_PostS_ZExp_s2_t;
				S_PostS_ZMantExp_s2_out 		 <= S_PostS_ZMantExp_s2_t;
				S_PostS_SpecialResult_s2_out 	 <= S_PostS_SpecialResult_s2_t;
				S_PostS_isSpecialResult_s2_out <= S_PostS_isSpecialResult_s2_t;
--				S_PostS_SpecialResult 			 <= S_PostS_SpecialResult_s2_t ;
--				S_PostS_isSpecialResult 		 <=  S_PostS_isSpecialResult_s2_t;

			end if;
		end if;
	end process;
	
	-- Fase Correttiva/Normalizzazione
	
	C_ResultCorrection: ResultCorrection 
	PORT MAP(
		ZS_in 		=> S_PostS_ZSign_s2_out,
		ZExp_in 		=> S_PostS_ZExp_s2_out,
		ZMantE_in 	=> S_PostS_ZMantExp_s2_out,
		SResult_in 	=> S_PostS_SpecialResult_s2_out,
		isSpecR_in 	=> S_PostS_isSpecialResult_s2_out,
		Z 				=> PostS_z_t
	);
	
-- PostS_Result_ZExp 	<= PostS_z_t(30 downto 23);
	PostS_Result_MantNnR <= PostS_z_t(22 downto  0);
	
	----------------------------------------FRONTE DI CLOCK --------------------------------------
	-- registro finale
	
	PostS: process(CLK)
	begin
		if( CLK' event and CLK = '1' ) then
			if(RESET = '1') then
				ZR <=(others => '0');
			else
				ZR <=PostS_z_t;
			end if;
		end if;
	end process;
	

end pipelined;


