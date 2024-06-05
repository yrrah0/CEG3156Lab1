LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY cla4 IS
  port( A, B : IN std_logic_vector(3 DOWNTO 0);
    Cin : IN std_logic;  
    S : OUT std_logic_vector(3 DOWNTO 0);
	 Cout, V : OUT std_logic);
END cla4;

ARCHITECTURE struct OF cla4 IS
  SIGNAL C : std_logic_vector(4 DOWNTO 0);
  SIGNAL G, P : std_logic_vector(3 DOWNTO 0);
BEGIN
  C(0) <= Cin;
  fa : FOR i IN 0 TO 3 GENERATE
	 fai : ENTITY work.full_adder(struct)
	   port map (A(i), B(i), C(i), S(i), open);
	 G(i) <= A(i) and B(i);
    P(i) <= A(i) or B(i);
  END GENERATE fa;
  
  -- TODO: Don't trust quartus to efficiently implement this, perform optimalization manually 
  C(1) <= G(0) or (P(0) and C(0));
  C(2) <= G(1) or (P(1) and G(0)) or (P(1) and P(0) and C(0));
  C(3) <= G(2) or (P(2) and G(1)) or (P(2) and P(1) and G(0)) or (P(2) and P(1) and P(0) and C(0));
  C(4) <= G(3) or (P(3) and G(2)) or (P(3) and P(2) and G(1)) or (P(3) and P(2) and P(1) and G(0)) or (P(3) and P(2) and P(1) and P(0) and C(0));
  
  Cout <= C(4);
  V <= C(4) xor C(3);
END struct;