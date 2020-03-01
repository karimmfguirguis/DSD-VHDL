library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity gol_enc is
  port (
    symbol   : in  std_logic_vector(3 downto 0);
    codeword : out std_logic_vector(5 downto 0));
end entity gol_enc;

architecture rtl of gol_enc is
  signal q       : std_logic_vector(3 downto 0);
  signal unary_q : std_logic_vector(5 downto 0) := (others => '0');
  signal code    : std_logic_vector(5 downto 0);
  signal r       : std_logic_vector(1 downto 0);
  signal r_pad   : std_logic_vector(5 downto 0);
  signal temp    : std_logic_vector(5 downto 0) := "100000";
begin  -- architecture rtl

-------------------------------------------------------------------------------
q <= std_logic_vector(shift_right(unsigned(symbol), 2));
r <= std_logic_vector(unsigned(symbol) - unsigned(shift_left(unsigned(q), 2)));
-------------------------------------------------------------------------------

unary_q <= std_logic_vector ( shift_right ( unsigned(temp) , to_integer( unsigned(q) ) )  );
r_pad <=  std_logic_vector ( shift_right ( unsigned(r&"0000") , TO_INTEGER( unsigned(q)+1 ) )  );
code <= unary_q or r_pad;







end architecture rtl;

