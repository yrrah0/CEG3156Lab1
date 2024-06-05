LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_misc.ALL;

-- | S(1) | S(0) | Q_(t+1) |
-- | ---- | ---- | ------- |
-- |   0  |   0  |  Q_t    |
-- |   0  |   1  |  Q_t+1  |
-- |   0  |   0  |  Q_t-1  |
-- |   1  |   1  |  Load   |

ENTITY jk_countern_sync IS
  generic (bit_size: positive := 4);
  port (Preset_not : IN std_logic;
    D : IN std_logic_vector(bit_size-1 DOWNTO 0);
	 S : IN std_logic_vector(1 DOWNTO 0);
    Clk, Clear_not : IN std_logic;
    Q, Q_not : OUT std_logic_vector (bit_size-1 DOWNTO 0);
    Z, V : OUT std_logic);
END jk_countern_sync;

ARCHITECTURE struct OF jk_countern_sync IS
  SIGNAL int_Q, int_Q_not, int_JK : std_logic_vector(bit_size-1 DOWNTO 0);
  SIGNAL int_load : std_logic;
BEGIN
  int_load <= S(1) and S(0);

  m0 : ENTITY work.mux_2to4(struct)
    port map (S(0), S(1), '0', '1', '1', D(0), int_JK(0));
  ff0 : ENTITY work.jk_flipflop(struct)
    port map (Preset_not, int_JK(0), int_JK(0) xor int_load, Clk, Clear_not, int_Q(0), int_Q_not(0));

  ff : FOR i IN 1 TO bit_size-1 GENERATE
    mi: ENTITY work.mux_2to4(struct)
      port map (S(0), S(1), '0', and_reduce(int_Q(i-1 DOWNTO 0)), and_reduce(int_Q_not(i-1 DOWNTO 0)), D(i), int_JK(i));
    ci: ENTITY work.jk_flipflop(struct)
      port map (Preset_not, int_JK(i), int_JK(i) xor int_load, Clk, Clear_not, int_Q(i), int_Q_not(i));
  END GENERATE ff;

  Q <= int_Q;
  Q_not <= int_Q_not;
  Z <= and_reduce(int_Q_not);
  V <= and_reduce(int_Q);
END struct;