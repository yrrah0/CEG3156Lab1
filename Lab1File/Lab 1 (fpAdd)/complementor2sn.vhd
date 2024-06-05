LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY complementor2sn IS
  generic( bit_size : positive := 8);
  port( X : IN std_logic_vector(bit_size-1 DOWNTO 0); 
    EN : IN std_logic;
    Y : OUT std_logic_vector(bit_size-1 DOWNTO 0));
END complementor2sn;

ARCHITECTURE struct OF complementor2sn IS
	SIGNAL C: std_logic_vector(bit_size downto 0);
BEGIN
  C(0) <= EN;
  ha : FOR i IN 0 TO bit_size-1 GENERATE
    hai : work.half_adder(struct) 
	   port map (X(i) xor EN, C(i), Y(i), C(i+1));
  END GENERATE ha;
END struct;