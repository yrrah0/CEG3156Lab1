LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY decoder_3to8 IS
  port( A : IN std_logic_vector(2 downto 0); 
    Y : OUT  std_logic_vector(7 downto 0));
END decoder_3to8;

ARCHITECTURE struct OF decoder_3to8 IS
BEGIN
  Y(0) <= not A(2) and not A(1) and not A(0); -- 000
  Y(1) <= not A(2) and not A(1) and A(0); -- 001
  Y(2) <= not A(2) and A(1) and not A(0); -- 010
  Y(3) <= not A(2) and A(1) and A(0); -- 011
  Y(4) <= A(2) and not A(1) and not A(0); -- 100
  Y(5) <= A(2) and not A(1) and A(0); -- 101
  Y(6) <= A(2) and A(1) and not A(0); -- 110
  Y(7) <= A(2) and A(1) and A(0); -- 111
END struct;