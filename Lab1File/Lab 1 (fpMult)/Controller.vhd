LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_misc.ALL;

ENTITY Controller IS
  port( E_difference : IN std_logic_vector(7 DOWNTO 0);
    Mantissa : IN std_logic_vector(9 DOWNTO 0);
	 BIG_ALU_V, Clk, Reset_not: IN std_logic; 
    MantissaS_ld, MantissaS_shr, Mantissa_ld, Mantissa_shl, Renormalize : OUT std_logic;
	 E_signal : OUT std_logic_vector(1 DOWNTO 0));
END Controller;

ARCHITECTURE struct OF Controller IS
  SIGNAL int_normalized : std_logic;
  SIGNAL int_timer_signal : std_logic_vector(1 DOWNTO 0);
  SIGNAL int_timer_Z : std_logic;
  SIGNAL int_FSM_Q : std_logic_vector(2 DOWNTO 0);
  SIGNAL int_FSM_State : std_logic_vector(7 DOWNTO 0);
  SIGNAL int_V_in, int_V : std_logic;
BEGIN
  int_normalized <= Mantissa(9) or not or_reduce(Mantissa(8 DOWNTO 0));	

  timer_signal_encoder : ENTITY work.encoder_4to2
    port map ('1', '0', not int_timer_Z and int_FSM_State(3), int_FSM_State(1), int_timer_Signal);
  
  timer : ENTITY work.jk_countern_sync(struct)
    generic map(7)
	 port map ('1', E_difference(6 DOWNTO 0), int_timer_signal, Clk, Reset_not, open, open, int_timer_Z, open);
	
  FSM : ENTITY work.Control_FSM(struct)
    port map (int_timer_Z, int_normalized, Clk, Reset_not, int_FSM_Q, open);
	 
  state_decoder : ENTITY work.decoder_3to8(struct)
    port map (int_FSM_Q, int_FSM_State);
	 
  MantissaS_ld <= int_FSM_State(1);
  MantissaS_shr <= int_FSM_State(3);
  Mantissa_ld <= int_FSM_State(2) or int_FSM_State(7);
  Mantissa_shl <= (int_FSM_State(6) or int_FSM_State(5)) and not int_normalized;
  Renormalize <= int_FSM_State(6);
  
  E_signal_encoder : ENTITY work.encoder_4to2
    port map ('1', int_FSM_State(2) and BIG_ALU_V, (int_FSM_State(6) or int_FSM_State(5)) and not int_normalized, int_FSM_State(1) or int_FSM_State(7), E_signal);
  
END struct;