LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY half_adder IS
  port( A, Cin : IN std_logic; 
    S, Cout : OUT std_logic);
END half_adder;

ARCHITECTURE struct OF half_adder IS
BEGIN
	S <= A XOR Cin;
	Cout <= A AND Cin;
END struct;