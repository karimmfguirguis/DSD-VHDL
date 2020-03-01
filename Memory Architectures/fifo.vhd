library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use ieee.std_logic_unsigned.all;

entity fifo is
  generic (
    ADDR_WIDTH : natural := 3;
    DATA_WIDTH : natural := 8);

  port (
    clk   : in  std_logic;
    wr    : in  std_logic;
    di    : in  std_logic_vector(DATA_WIDTH-1 downto 0);
    rd    : in  std_logic;
    do    : out std_logic_vector(DATA_WIDTH-1 downto 0);
    empty : out std_logic;
    full  : out std_logic);

end entity fifo;

architecture rtl of fifo is

type fifo_t is array (0 to 2**ADDR_WIDTH -1) of std_logic_vector (DATA_WIDTH-1 downto 0);
signal fifo: fifo_t;

signal rd_ptr: std_logic_vector(ADDR_WIDTH downto 0):= (others=>'0');
signal wr_ptr: std_logic_vector(ADDR_WIDTH downto 0):= (others=>'0');
signal full_flag, empty_flag: std_logic :='0';

begin  -- architecture rtl

process (clk)
    begin
      if rising_edge (clk) then
        if wr = '1' and full_flag='0' then
           fifo ( TO_INTEGER (unsigned( wr_ptr(ADDR_WIDTH-1 downto 0) ))) <= di;
           wr_ptr<= std_logic_vector (unsigned (wr_ptr) + 1);  
        end if;     
        if rd = '1' and empty_flag = '0' then
           do <=  fifo ( TO_INTEGER (unsigned(rd_ptr(ADDR_WIDTH-1 downto 0) )));
           rd_ptr<= std_logic_vector (unsigned (rd_ptr) + 1);    
        end if;  
      end if;   
end process;

full_flag <= '1' when 
    rd_ptr(ADDR_WIDTH) /= wr_ptr(ADDR_WIDTH) and rd_ptr(ADDR_WIDTH-1 downto 0) = wr_ptr(ADDR_WIDTH-1 downto 0) else
    '0';
empty_flag <= '1' when wr_ptr = rd_ptr else '0';

empty <= empty_flag;
full <= full_flag;

end architecture rtl;
