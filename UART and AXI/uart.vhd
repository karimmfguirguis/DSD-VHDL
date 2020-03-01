library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uart is
  generic (BAUD: integer:= 57600);
  port (
    clk       : in  std_logic;          -- 115.2MHz
    data_bits : in  std_logic_vector(7 downto 0);
    data_val  : in  std_logic;
    ready     : out std_logic;
    TX        : out std_logic);
end entity uart;

architecture rtl of uart is

constant clk_count_max: integer:= 115200 / BAUD;
signal clk_count: integer:= 1;
signal clk_en: std_logic :='1';
signal ready_sig: std_logic :='1';
signal count: integer:=0;

begin  -- architecture rtl


process (clk)
begin
    if rising_edge(clk) then
        if data_val='1' then  
            if clk_count = clk_count_max then
                clk_en <= '1';
                clk_count <= 1;
            else
                clk_en <= '0';
                clk_count<= clk_count+1;
            end if;
        end if;
    end if;
end process;

process (clk, data_val)
variable num_of_ones: integer:=0;
variable parity: integer:=0;
begin
    if rising_edge(clk) then  
        if clk_en = '1' then
        
            if data_val='1' then
                case count is
                    when 0 =>
                        TX <= '0';
                        ready_sig <= '0';
                    when 9 =>
                        for i in 0 to 7 loop
                            if data_bits(i) = '1' then
                                num_of_ones := num_of_ones+1;
                            end if;
                        end loop;
                        parity := num_of_ones mod 2;
                        if parity = 0 then
                            TX <= '1';
                        else 
                            TX <= '0';
                        end if;                    
                    when 10 =>
                        TX <= '1';
                    when 11 =>
                        TX <= '1';
                        ready_sig <= '1';
                    when others =>
                        TX <= data_bits(count-1); 
                 end case;
                 
                 if count = 11 then
                    count <= 0;
                 else
                    count <= count +1;
                 end if;
            end if;  
            
       end if;  
    end if;
end process;

ready<= ready_sig;
end architecture rtl;
