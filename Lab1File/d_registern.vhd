LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY d_registern IS
  generic( bit_size : integer := 8);
  port( Preset_not : IN STD_LOGIC; 
    D : IN STD_LOGIC_VECTOR(bit_size-1 DOWNTO 0);
    ld, shl, shr, shl_insert, shr_insert, Clk, Clear_not : IN STD_LOGIC;
    Q, Q_not : OUT STD_LOGIC_VECTOR(bit_size-1 DOWNTO 0));
END d_registern;

ARCHITECTURE struct OF d_registern IS
  SIGNAL int_Q : STD_LOGIC_VECTOR(bit_size-1 DOWNTO 0);
  SIGNAL gnd : STD_LOGIC := '0';
BEGIN
  r7 : ENTITY work.d_register1(struct)
    port map(Preset_not, D(bit_size-1), int_Q(bit_size-2), shr_insert, ld, shl, shr, Clk, Clear_not, int_Q(bit_size-1), Q_not(bit_size-1));
  r : FOR i IN bit_size-2 DOWNTO 1 GENERATE
    ri : ENTITY work.d_register1(struct)
	   port map(Preset_not, D(i), int_Q(i-1), int_Q(i+1), ld, shl, shr, Clk, Clear_not, int_Q(i), Q_not(i));
  END GENERATE r;
  r0 : ENTITY work.d_register1(struct)
    port map(Preset_not, D(0), shl_insert, int_Q(1), ld, shl, shr, Clk, Clear_not, int_Q(0), Q_not(0));
  Q <= int_Q;
END struct;
