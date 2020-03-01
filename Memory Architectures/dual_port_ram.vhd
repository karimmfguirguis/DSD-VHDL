library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity dual_port_ram is

  generic (
    ADDR_WIDTH : natural := 8;
    DATA_WIDTH : natural := 9);

  port (
    clk   : in  std_logic;
    wr    : in  std_logic;
    addra : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    dia   : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    rd    : in  std_logic;
    addrb : in  std_logic_vector(ADDR_WIDTH-1 downto 0);
    dib   : out std_logic_vector(DATA_WIDTH-1 downto 0));

end entity dual_port_ram;

architecture rtl of dual_port_ram is

type ram_t is array (0 to 2**ADDR_WIDTH -1) of std_logic_vector (DATA_WIDTH-1 downto 0);
signal ram: ram_t;

begin  -- architecture rtl

process (clk)
    begin 
    if rising_edge (clk) then
        if wr = '1' then
            ram ( TO_INTEGER (unsigned(addra)) ) <= dia;
        end if;
        if rd = '1' then
            dib <= ram ( TO_INTEGER (unsigned(addrb)) );
        end if;
     end if;
end process;

end architecture rtl;
