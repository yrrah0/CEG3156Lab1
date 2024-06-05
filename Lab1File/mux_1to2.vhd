LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY mux_1to2 IS
  port( sel0, in0, in1 : IN STD_LOGIC;
    y : OUT STD_LOGIC);
END mux_1to2;

ARCHITECTURE struct OF mux_1to2 IS
  SIGNAL and0, and1 : STD_LOGIC;
BEGIN
  and0 <= (not sel0) and in0;
  and1 <= sel0 and in1;
  y <= and0 or and1;
END struct;
