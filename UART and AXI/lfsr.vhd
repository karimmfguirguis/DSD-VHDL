library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity lfsr is

  generic (
    SEED : std_logic_vector(1 to 16) := X"DEAD");
  port (
    clk      : in  std_logic;
    rand_bit : out std_logic);          --rightmost bit
end entity lfsr;

architecture rtl of lfsr is

signal reg: std_logic_vector (15 downto 0):= SEED;
  
begin  -- architecture rtl

process (clk)
variable xor_out: std_logic;
begin
    if rising_edge(clk) then
        xor_out:=  reg(0) xor reg(2) xor reg(3) xor reg(5);
        reg <= xor_out & reg(15 downto 1);
    end if;
end process;

rand_bit<= reg(0);

end architecture rtl;
