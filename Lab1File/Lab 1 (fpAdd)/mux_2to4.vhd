LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_2to4 IS
  port( sel0, sel1, in0, in1, in2, in3 : IN STD_LOGIC;
    y : OUT STD_LOGIC);
END mux_2to4;

ARCHITECTURE struct OF mux_2to4 IS
  SIGNAL and0, and1, and2, and3 : STD_LOGIC;
BEGIN
  and0 <= not sel1 and not sel0 and in0;
  and1 <= not sel1 and sel0 and in1;
  and2 <= sel1 and not sel0 and in2;
  and3 <= sel1 and sel0 and in3;
  y <= and0 or and1 or and2 or and3;
END struct;
