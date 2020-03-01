library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
--use ieee.math_real.all;

entity prior_enc is
  port (
    r      : in  std_logic_vector(3 downto 0);
    code   : out std_logic_vector(1 downto 0);
    active : out std_logic);
end entity prior_enc;

architecture rtl of prior_enc is

begin  -- architecture rtl

    
--    code <= "11" when r = "1---" else
--            "10" when r = "01--" else
--            "01" when r = "001-" else
--            "00" when others;
            
      active <= '0' when r = "0000" else '1';
      
--      code <= "11" when r = "1000" or r = "1001" or r = "1010" or r = "1011" or r = "1100" or r = "1101" or r = "1110" or r = "1111" else
--              "10" when r = "0100" or r = "0101" or r = "0110" or r = "0111" else
--              "01" when r = "0010" or r = "0011"  else
--              "00";
              
       with r select
       code <= "11" when "1000" | "1001" | "1010" | "1011" | "1100" | "1101" | "1110" | "1111",
               "10" when "0100" | "0101" | "0110" | "0111",
               "01" when "0010" | "0011",
               "00" when others;        
            
            

end architecture rtl;
