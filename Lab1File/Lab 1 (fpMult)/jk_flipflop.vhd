LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY jk_flipflop IS
  port ( Preset_not, J, K, Clk, Clear_not : IN STD_LOGIC;
    Q, Q_not : OUT STD_LOGIC);
END jk_flipflop;

ARCHITECTURE struct OF jk_flipflop IS
  SIGNAL nand_j, nand_k, nand_jk, int_Q, int_Q_not : STD_LOGIC;
BEGIN
  nand_j <= J nand int_Q_not;
  nand_k <= not K nand int_Q;
  nand_jk <= nand_j nand nand_k;
  f0 : ENTITY work.d_flipflop(struct)
    port map (Preset_not, nand_jk, Clk, Clear_not, int_Q, int_Q_not);
  Q <= int_Q;
  Q_not <= int_Q_not;
END struct;