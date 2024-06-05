LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_register1 IS
  port( Preset_not, Di, Qim1, Qip1, ld, shl, shr, Clk, Clear_not : IN STD_LOGIC;
    Q, Q_not : OUT STD_LOGIC);
END d_register1;

ARCHITECTURE struct OF d_register1 IS
  SIGNAL int_Y, int_D, int_Q : STD_LOGIC;
BEGIN
  m0 : ENTITY work.mux_1to2(struct)
    port map (ld, int_Q, Di, int_Y);
  m1 : ENTITY work.mux_2to4(struct)
    port map (shl, shr, int_Y, Qim1, Qip1, int_Q, int_D);
  f0: ENTITY work.d_flipflop(struct)
    port map (Preset_not, int_D, Clk, Clear_not, int_Q, Q_not);
  Q <= int_Q;
END struct;
