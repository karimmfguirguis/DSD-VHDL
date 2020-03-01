----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/17/2019 02:25:55 PM
-- Design Name: 
-- Module Name: Division_ROM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.Numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Division_ROM is

  generic (W: integer:= 8; DIVISOR: integer:= 2);
  Port (data_in: in std_logic_vector  (W-1 downto 0);
        clk: in std_logic;
        r,q: out std_logic_vector  (W-1 downto 0) );
        
end Division_ROM;

architecture Behavioral of Division_ROM is

type rom_t is array (0 to 2**W -1) of std_logic_vector (W-1 downto 0);


function quotient (rom_size: integer;
                   divisor_val : integer)
                   return rom_t is

    variable  rom_temp: rom_t;

    begin
      for i in 0 to rom_size-1 loop
        rom_temp (i) := "00000011";
      end loop;
     return rom_temp;
end quotient;

function remainder (rom_size: integer;
                   divisor_val : integer)
                   return rom_t is

    variable  rom_temp: rom_t;

    begin
      for i in 0 to rom_size-1 loop
        rom_temp (i) := "00000010";
      end loop;
     return rom_temp;
end remainder;

constant R_ROM: rom_t := quotient(2**W -1, DIVISOR );
constant Q_ROM: rom_t := remainder(2**W -1, DIVISOR );

begin

process (clk)
begin 
    if rising_edge(clk) then
        q<= Q_ROM ( TO_INTEGER (unsigned(data_in)) );
        r<= R_ROM ( TO_INTEGER (unsigned(data_in)) );
    end if;
end process ;

end Behavioral;
