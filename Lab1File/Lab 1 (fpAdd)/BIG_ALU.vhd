LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY BIG_ALU IS
  port( A : IN STD_LOGIC_VECTOR(11 DOWNTO 0); 
    B : IN STD_LOGIC_VECTOR(7 DOWNTO 0); 
    invert_A, invert_B : IN STD_LOGIC;
    Result : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);
	 N, V : OUT STD_LOGIC);
END BIG_ALU;

ARCHITECTURE struct OF BIG_ALU IS
  SIGNAL int_A, int_B, xorA, xorB, int_S, int_Result : STD_LOGIC_VECTOR(11 DOWNTO 0);
  SIGNAL int_C : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL int_V : STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
  int_A <= A;
  int_B <= "01" & B & "00";
  int_C(0) <= invert_A xor invert_B;
  cla4 : FOR i IN 0 TO 2 GENERATE
    xorAB : FOR j IN 0 TO 3 GENERATE
	   xorA(4*i+j) <= int_A(4*i+j) xor (invert_A and not invert_B);
		xorB(4*i+j) <= int_B(4*i+j) xor (invert_B and not invert_A);
	 END GENERATE xorAB;	
    cla4i : entity work.cla4(struct)
	   port map (xorA(4*i+3 DOWNTO 4*i), xorB(i*4+3 DOWNTO i*4), int_C(i), int_S(i*4+3 DOWNTO i*4), int_C(i+1), int_V(i));
  END GENERATE cla4;
  
  complementor : ENTITY work.complementor2sn(struct)
    generic map (12)
    port map (int_S, int_S(11), int_Result);
  
  Result <= int_Result;
  N <= int_S(11) xor (invert_A and invert_B);
  V <= int_V(2); 
END struct;