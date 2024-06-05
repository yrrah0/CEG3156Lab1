library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity encoder_4to2 is
  port(Y0, Y1, Y2, Y3 : in STD_LOGIC;
    A : out STD_LOGIC_VECTOR(1 downto 0));
end encoder_4to2;
 
architecture struct of encoder_4to2 is
begin
  A(1) <= Y3 or Y2;
  A(0) <= Y3 or Y1;
end struct;