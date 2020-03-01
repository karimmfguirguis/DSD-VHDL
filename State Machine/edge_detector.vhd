library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity edge_detector is

  port (
    rst    : in  std_logic;
    clk    : in  std_logic;
    strobe : in  std_logic;
    p1     : out std_logic;
    p2     : out std_logic;
    p3     : out std_logic);

end entity edge_detector;

architecture rtl of edge_detector is

type States_type is (zero_s, one_s, edge_s, delay_s);
signal state_1: states_type;
signal state_2: states_type;
signal state_3: states_type;

begin  -- architecture rtl

fsm1: process (clk, rst) is
begin
  if rst='1' then
        state_1 <= zero_s;
  elsif rising_edge(clk) then
    case state_1 is
    
        when zero_s =>
            case strobe is
                when '0' =>
                    state_1<= zero_s;
                when '1' =>
                    state_1<= edge_s;
             end case;
             
        when edge_s =>
            case strobe is
                when '0' =>
                    state_1<= zero_s;
                when '1' =>
                    state_1<= one_s;
             end case;        

        when one_s =>
            case strobe is
                when '0' =>
                    state_1<= zero_s;
                when '1' =>
                    state_1<= one_s;
             end case;
        
        when others =>
             state_1 <= zero_s;        
    end case;
  end if;
end process fsm1;

fsm1_out: process (state_1)
begin
    case state_1 is
        when zero_s =>
            p1<='0';
        when edge_s =>
            p1<='1';
        when one_s =>
            p1<='0';
    end case;
end process fsm1_out;
----------------------------------------------------------------
fsm2: process (clk, rst) is
begin
  if rst='1' then
      state_2 <= zero_s;
      p2<='0';
  elsif rising_edge(clk) then
    case state_2 is
        when zero_s =>
            case strobe is
                when '0' =>
                    state_2<= zero_s;
                    p2<='0';
                when '1' =>
                    state_2<= one_s;
                    p2<='1';
             end case;   

        when one_s =>
            case strobe is
                when '0' =>
                    state_2<= zero_s;
                    p2<='0';
                when '1' =>
                    state_2<= one_s;
                    p2<='0';
             end case;      

        when others =>
             state_2 <= zero_s;
             p2<= '0';   
    end case;
  end if;
end process fsm2;
---------------------------------------------------------
fsm3: process (clk, rst) is
begin
  if rst='1' then
        state_3 <= zero_s;
        p3<='0';
  elsif rising_edge(clk) then
    case state_3 is
    
        when zero_s =>
            case strobe is
                when '0' =>
                    state_3<= zero_s;
                    p3<='0';
                when '1' =>
                    state_3<= delay_s;
                    p3<='1';
             end case;
             
        when delay_s =>
            
            case strobe is
                when '0' =>
                    state_3<= zero_s;
                    p3<='0';
                when '1' =>
                    state_3<= one_s;
                    p3<='0';
             end case;        

        when one_s =>
            case strobe is
                when '0' =>
                    state_3<= zero_s;
                    p3<='0';
                when '1' =>
                    state_3<= one_s;
                    p3<='0';
             end case;
             
        when others =>
                  state_3 <= zero_s;
                  p3<= '0';       
    end case;
  end if;
end process fsm3;

end architecture rtl;
