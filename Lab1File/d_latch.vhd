LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_latch IS
  port( Preset_not, D, En, Clear_not: IN STD_LOGIC;
    Q, Q_not : OUT STD_LOGIC);
END d_latch;

ARCHITECTURE struct OF d_latch IS
  SIGNAL int_nand_D, int_nand_D_not, int_and_D, int_and_D_not, int_Q, int_Q_not : STD_LOGIC;
BEGIN
  int_nand_D <= En nand D;
  int_nand_D_not <= En nand (not D);
  int_and_D <= int_nand_D and int_Q_not;
  int_and_D_not <= int_nand_D_not and int_Q;
  int_Q <= int_and_D nand Preset_not;
  int_Q_not <= int_and_D_not nand Clear_not;
  Q <= int_Q;
  Q_not <= int_Q_not;
END struct;
