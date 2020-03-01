library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity unlocker is

  port (
    rst    : in  std_logic;
    clk    : in  std_logic;
    psw    : in  std_logic;
    unlock : out std_logic);

end entity unlocker;

architecture rtl of unlocker is

type States_type is (start_s, num1_s, num2_s, num3_s, num4_s, num5_s);
signal state: states_type;

begin  -- architecture rtl

safe: process (clk, rst) is
begin
  if rst='1' then
        state <= start_s;
  elsif rising_edge(clk) then
    case state is
    
        when start_s =>
            case psw is
                when '0' =>
                    state<= start_s;
                when '1' =>
                    state<= num1_s;
             end case;
             
        when num1_s =>
             case psw is
                 when '0' =>
                     state<= start_s;
                 when '1' =>
                     state<= num2_s;
              end case;     

        when num2_s =>
             case psw is
                 when '0' =>
                     state<= num3_s;
                 when '1' =>
                     state<= start_s;
              end case;   
              
        when num3_s =>
               case psw is
                   when '0' =>
                       state<= start_s;
                   when '1' =>
                       state<= num4_s;
                end case;

        when num4_s =>
               case psw is
                   when '0' =>
                       state<= num5_s;
                   when '1' =>
                       state<= start_s;
                end case;
                
        when num5_s =>
             state<= start_s;  
                      
        when others =>
             state <= start_s;        
    end case;
  end if;
end process safe;

safe_out: process (state)
begin
    if state = num5_s then
        unlock<='1';
    else
        unlock<='0';
    end if;
end process safe_out;

end architecture rtl;
