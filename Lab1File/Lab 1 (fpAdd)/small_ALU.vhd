LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


ENTITY small_ALU IS
  PORT ( A, B : IN std_logic_vector(6 downto 0); 
    Result : OUT std_logic_vector(7 downto 0);
    N, V : OUT std_logic);
END small_ALU;

ARCHITECTURE struct OF small_ALU IS
  SIGNAL int_A, int_B, int_S, int_Result : std_logic_vector(7 downto 0);
  SIGNAL int_C : std_logic_vector(2 downto 0);
  SIGNAL int_V : std_logic_vector(1 downto 0);
BEGIN
	int_A <= '0' & A;
	int_B(7) <= '1';
	int_B_not : for i in 6 downto 0 generate
	  int_B(i) <= not B(i);
	end generate int_B_not;
	int_C(0) <= '1';
	cla4 : FOR i IN 0 TO 1 GENERATE
	   cla4i : ENTITY work.cla4(struct)
         PORT MAP (int_A(4*i+3 downto 4*i), int_B(4*i+3 downto 4*i), int_C(i), int_S(4*i+3 downto 4*i), int_C(i+1), int_V(i));
	END GENERATE cla4;
	
	complementor : ENTITY work.complementor2sn(struct)
	  port map (int_S, int_S(7), int_Result);
  
  Result <= int_Result;
  N <= int_S(7);
  V <= int_V(1);
END struct;