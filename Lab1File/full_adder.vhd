LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY full_adder IS
  port( A, B, Cin : IN std_logic; 
    S, Cout : OUT std_logic);
END full_adder;

ARCHITECTURE struct OF full_adder IS
  SIGNAL xor0, and0, and1: std_logic;
BEGIN
  xor0 <= A xor B;
  S <= xor0 xor Cin;
  and0 <= A and B;
  and1 <= xor0 and Cin;
  Cout <= and0 or and1;
END struct;