library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.math_real.all;

entity comp_mux is
  port (
    in0    : in  std_logic_vector(3 downto 0);
    in1    : in  std_logic_vector(3 downto 0);
    op     : in  std_logic_vector(1 downto 0);
    output : out std_logic_vector(3 downto 0));
end entity comp_mux;

architecture rtl of comp_mux is

begin  -- architecture rtl

    
    output <= std_logic_vector(signed(in0) + signed(in1))                                when op = "00" else
              std_logic_vector(abs(signed(in0) - signed(in1)))                           when op = "01" else
              in0 or in1                                                                 when op = "10" else
              std_logic_vector(shift_left(unsigned(in0),TO_INTEGER(abs(signed(in1)))))   when op = "11" and in1(3)='1' else
              std_logic_vector(shift_right(unsigned(in0),TO_INTEGER(abs(signed(in1)))))  when op = "11" and in1(3)='0';
              
              

end architecture rtl;
