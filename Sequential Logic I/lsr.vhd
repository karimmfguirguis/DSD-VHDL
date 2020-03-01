library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lsr is  
  port (
    clk      : in  std_logic;
    clk_enable      : in  std_logic;
    rst      : in  std_logic;
    load     : in  std_logic;
    data_in  : in  std_logic_vector(7 downto 0);
    data_out : out std_logic_vector(7 downto 0));
end entity lsr;

architecture rtl of lsr is
signal reg: std_logic_vector(7 downto 0):= (others=>'Z');
begin  -- architecture rtl

process(clk,rst)
begin
if rising_edge(clk) and clk_enable='1' then
    if rst='1' then
        reg<=(others=>'Z');
    elsif load='1' then
        reg<= data_in;
    else
        reg<= reg(6 downto 0)&'0';
    end if;
end if;
end process;

data_out<=reg;

end architecture rtl;
