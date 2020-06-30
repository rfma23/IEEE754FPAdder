-- TestBench Template

  LIBRARY ieee;
  USE ieee.std_logic_1164.ALL;
  USE ieee.numeric_std.ALL;

  ENTITY SCHandlerTB IS
  END SCHandlerTB;

  ARCHITECTURE behavior OF SCHandlerTB IS

  -- Component Declaration
  COMPONENT SCHandler
	PORT(
		op : IN std_logic;
		CaseX : IN std_logic_vector(2 downto 0);
		CaseY : IN std_logic_vector(2 downto 0);
		X : IN std_logic_vector(31 downto 0);
		Y : IN std_logic_vector(31 downto 0);
		SCResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	signal op       : std_logic := '0';
	signal CaseX    : std_logic_vector(2 downto 0) := (others => '0');
	signal CaseY    : std_logic_vector(2 downto 0) := (others => '0');
	signal X        : std_logic_vector(31 downto 0) := (others => '0');
	signal Y        : std_logic_vector(31 downto 0) := (others => '0');
	signal SCResult : std_logic_vector(31 downto 0);

	signal clk: std_logic := '0';
   constant clk_period : time := 10 ns;

  BEGIN

  -- Component Instantiation
      uut: SCHandler PORT MAP(
			op => op,
			CaseX => CaseX,
			CaseY => CaseY,
			X => X ,
			Y => Y ,
			SCResult => SCResult
			);


  clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
    wait for 100ns;
     op <= '0';
     CaseX <="000";
     CaseY <="000";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
    wait for 100ns;
     op <= '0';
     CaseX <="001";
     CaseY <="000";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="010";
     CaseY <="000";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="100";
     CaseY <="000";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="000";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="001";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="010";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="001";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '1';
     CaseX <="001";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '1';
     CaseX <="001";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="01000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="010";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="100";
     CaseY <="001";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="000";
     CaseY <="010";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="001";
     CaseY <="010";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="010";
     CaseY <="010";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="100";
     CaseY <="010";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="000";
     CaseY <="100";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";	
	 wait for 100ns;
     op <= '0';
     CaseX <="001";
     CaseY <="100";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="010";
     CaseY <="100";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait for 100ns;
     op <= '0';
     CaseX <="100";
     CaseY <="100";
	  X <="11000001101110000000000000000000";
     Y <="11000010011001000000000000000000";
	 wait;
	 
   end process;

END;