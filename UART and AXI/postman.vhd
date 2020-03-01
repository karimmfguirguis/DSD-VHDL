library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity postman is

  generic (
    SEED : std_logic_vector(1 to 16) := X"BEEF");  -- for lfsr

  port (
    clk       : in  std_logic;
    data_bits : out std_logic_vector(7 downto 0);
    data_val  : out std_logic;          -- AXI valid
    ready     : in  std_logic);         -- AXI ready
end entity postman;

architecture rtl of postman is

  component lfsr
    port (clk      : in  std_logic;
          rand_bit : out std_logic);
  end component ;
  
  signal lfsr_out: std_logic;
  signal sending_flag: std_logic;
  signal count: integer:= 0;
   
  type rom_t is array(0 to 14) of std_logic_vector(data_bits'range);
  signal rom : rom_t := ("01010110",    -- V
                         "01100001",    -- a
                         "01101100",    -- l
                         "01100001",    -- a
                         "01110010",    -- r
                         "00100000",    -- 
                         "01101101",    -- m
                         "01101111",    -- o
                         "01110010",    -- r
                         "01100111",    -- g
                         "01101000",    -- h
                         "01110101",    -- u
                         "01101100",    -- l
                         "01101001",    -- i
                         "01110011");   -- s

begin  -- architecture rtl

lfsr_comp: lfsr port map (clk,lfsr_out);

process (clk)
begin 
    if rising_edge (clk) then
        if ready = '1' then
            if lfsr_out = '1' then
                data_bits <= rom(count);
                if count = 14 then
                    count<= 0;
                else
                    count<= count + 1;
                end if;
                data_val <= '1';
            else
                data_val <= '0';
            end if;
        end if;
     end if;
end process;
        

end architecture rtl;
