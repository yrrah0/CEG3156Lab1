LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY Control_FSM IS
  port( in1, in0, Clk, Reset_not : IN std_logic; 
    Q, Q_not : OUT std_logic_vector(2 DOWNTO 0));
END Control_FSM;

ARCHITECTURE struct OF Control_FSM IS
  SIGNAL int_D, int_Q, int_Q_not : std_logic_vector(2 DOWNTO 0);
  SIGNAL and0, and1 : std_logic;
BEGIN
  and0 <= int_Q(1) and int_Q_not(0);
  and1 <= int_Q_not(2) and int_Q(0);

  int_D(2) <= int_Q(2) or and0;
  int_D(1) <= and0 or and1;
  int_D(0) <= (in0 and int_Q(2) and int_Q(1)) or (not in1 and and1) or (int_Q_not(2) and int_Q_not(1)) or (not in0 and int_Q(2) and int_Q(0)) or (not in1 and not in0 and int_Q(0));
  
  ff : FOR i IN 0 TO 2 GENERATE
    ffi : ENTITY work.d_flipflop(struct)
      port map('1', int_D(i), Clk, Reset_not, int_Q(i), int_Q_not(i));
  END GENERATE ff;
  
  Q <= int_Q;
  Q_not <= int_Q_not;
END struct;