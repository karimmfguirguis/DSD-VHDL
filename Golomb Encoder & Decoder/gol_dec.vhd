library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity gol_dec is
  port (
    codeword : in  std_logic_vector(5 downto 0);
    symbol   : out std_logic_vector(3 downto 0)
    );
end entity gol_dec;

architecture rtl of gol_dec is
  signal q     : std_logic_vector(1 downto 0);
  signal r     : std_logic_vector(1 downto 0);
  signal r_pad : std_logic_vector(5 downto 0);
begin  -- architecture rtl

q <= "11" when codeword(2)='1' else
     "10" when codeword(3)='1' else
     "01" when codeword(4)='1' else
     "00" when codeword(5)='1';

r(1) <= codeword(to_integer(4-unsigned(q)));
r(0) <= codeword(to_integer(3-unsigned(q)));

symbol<= q&r;

end architecture rtl;
