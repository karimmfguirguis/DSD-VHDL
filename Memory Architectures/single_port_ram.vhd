library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity single_port_ram is

  generic (
    MODE       : string  := "write_first";
    ADDR_WIDTH : natural := 10;
    DATA_WIDTH : natural := 8);

  port (
    clk  : in  std_logic;
    ce   : in  std_logic;
    wr   : in  std_logic;
    rd   : in  std_logic;
    addr : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    di   : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    do   : out std_logic_vector(DATA_WIDTH-1 downto 0));

end entity single_port_ram;

architecture rtl of single_port_ram is

type ram_t is array (0 to 2**ADDR_WIDTH -1) of std_logic_vector (DATA_WIDTH-1 downto 0);
signal ram: ram_t;

begin  -- architecture rtl

process (clk)
begin 
    if ce = '1' then
        if rising_edge (clk) then
            if wr = '1' then
                ram ( TO_INTEGER (unsigned(addr)) ) <= di;
            end if;
            if rd = '1' then
                do <= ram ( TO_INTEGER (unsigned(addr)) );
            end if;
         end if;
    end if;
end process;

end architecture rtl;
