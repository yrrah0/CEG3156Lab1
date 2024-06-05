LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_flipflop IS
  port( Preset_not, D, Clk, Clear_not: IN STD_LOGIC;
    Q, Q_not : OUT STD_LOGIC);
END d_flipflop;

ARCHITECTURE struct OF d_flipflop IS
  SIGNAL int_Q, Clk_not : STD_LOGIC;
BEGIN
  Clk_not <= not Clk;
  master : ENTITY work.d_latch(struct)
    port map (Preset_not, D, Clk_not, Clear_not, int_Q, open);
  slave : ENTITY work.d_latch(struct)
    port map (Preset_not, int_Q, Clk, Clear_not, Q, Q_not);
END struct;
