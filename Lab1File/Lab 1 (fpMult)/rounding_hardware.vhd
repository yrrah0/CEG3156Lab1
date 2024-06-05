LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY rounding_hardware IS
  port( 
	 E_in : IN std_logic_vector(6 DOWNTO 0);
    M_in : IN std_logic_vector(9 DOWNTO 0);
	 E_V : OUT std_logic;
    E_out : OUT std_logic_vector(6 DOWNTO 0);
	 M_out : OUT std_logic_vector(7 DOWNTO 0);
	 M_loopback : OUT std_logic_vector(9 downto 0));
END rounding_hardware;

ARCHITECTURE struct OF rounding_hardware IS
  SIGNAL int_CM : std_logic_vector(9 DOWNTO 0);
  SIGNAL int_M_out : std_logic_vector(8 DOWNTO 0);
  SIGNAL int_CE : std_logic_vector(7 DOWNTO 0);

BEGIN
  int_CM(0) <= M_in(0);
  haM : FOR i IN 0 TO 8 GENERATE
    haMi : ENTITY work.half_adder(struct)
	   PORT MAP (M_in(i+1), int_CM(i), int_M_out(i), int_CM(i+1));
  END GENERATE haM;
  
  int_CE(0) <= int_CM(9);
  haE : FOR i IN 0 TO 6 GENERATE
    haEi : ENTITY work.half_adder(struct)
	   PORT MAP (E_in(i), int_CE(i), E_out(i), int_CE(i+1));
  END GENERATE haE;
  
  E_V <= int_CE(7);
  M_out <= int_M_out(7 downto 0);
  M_loopback <= int_M_out & '0';
END struct;