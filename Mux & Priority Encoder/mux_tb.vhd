library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

-------------------------------------------------------------------------------

entity mux_tb is

end entity mux_tb;

-------------------------------------------------------------------------------

architecture sim of mux_tb is

  component mux is
    port (
      a        : in  std_logic_vector(3 downto 0);
      b        : in  std_logic_vector(3 downto 0);
      c        : in  std_logic_vector(3 downto 0);
      d        : in  std_logic_vector(3 downto 0);
      sel      : in  std_logic_vector(1 downto 0);
      selected : out std_logic_vector(3 downto 0));
  end component mux;

  -- component ports
  signal a        : std_logic_vector(3 downto 0):= X"0";
  signal b        : std_logic_vector(3 downto 0):= X"1";
  signal c        : std_logic_vector(3 downto 0):= X"2";
  signal d        : std_logic_vector(3 downto 0):= X"3";
  signal sel      : std_logic_vector(1 downto 0) := "00";
  signal selected : std_logic_vector(3 downto 0);

begin  -- architecture sim

  -- component instantiation
  DUT: mux
    port map (
      a        => a,
      b        => b,
      c        => c,
      d        => d,
      sel      => sel,
      selected => selected);

  sel <= "01" after 10 ns,
         "10" after 20 ns,
         "11" after 30 ns;
  

end architecture sim;

-------------------------------------------------------------------------------
