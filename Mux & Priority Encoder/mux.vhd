library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.math_real.all;

entity mux is
  port (
    a        : in  std_logic_vector(3 downto 0);
    b        : in  std_logic_vector(3 downto 0);
    c        : in  std_logic_vector(3 downto 0);
    d        : in  std_logic_vector(3 downto 0);
    sel      : in  std_logic_vector(1 downto 0);
    selected : out std_logic_vector(3 downto 0)
    --selected1 : out std_logic_vector(3 downto 0);
    --selected2 : out std_logic_vector(3 downto 0)
    );
end entity mux;

architecture rtl of mux is

begin  -- architecture rtl

  with sel select
    selected <= a when "00",
                b when "01",
                c when "10",
                d when others;
                
--    selected <= a when sel = "00" else
--                 b when sel = "01" else
--                 c when sel = "10" else
--                 d;
                 
                
--    process(a,b,c,d)
--    begin
--    if(sel="00")then
--        selected <= a;
--    elsif(sel="01") then
--        selected <= b;
--    elsif(sel="10") then
--        selected <= c;
--    else
--        selected <= d;
--    end if;
--    end process;
    
                                                        
           
end architecture rtl;
