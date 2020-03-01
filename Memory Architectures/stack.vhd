library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity stack is

  generic (
    ADDR_WIDTH : natural := 8;
    DATA_WIDTH : natural := 5);

  port (
    clk   : in  std_logic;
    push  : in  std_logic;
    empty : out std_logic;
    di    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    pop   : in  std_logic;
    full  : out std_logic;
    do    : out std_logic_vector(DATA_WIDTH-1 downto 0));

end entity stack;

architecture rtl of stack is

begin  -- architecture rtl

end architecture rtl;
