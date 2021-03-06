----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2018 03:29:22 PM
-- Design Name: 
-- Module Name: gray_counter - Behavioral
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
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity gray_counter is
port (
    clk      : in  std_logic;
    rst      : in  std_logic;
    load     : in  std_logic;
    data_in  : in  std_logic_vector(3 downto 0);
    data_out : out std_logic_vector(3 downto 0));
end gray_counter;


architecture Behavioral of gray_counter is
signal count: std_logic_vector(3 downto 0):= "0000"; 

begin

process(clk,rst)
begin
if rising_edge(clk) then
    if rst='1' then
        count<=(others=>'0');
    elsif load='1' then
        count<= data_in;
    else
         count<= count + '1' ;
    end if;
end if;
end process;

data_out(3) <= count(3);
data_out(2) <= count(3) xor count(2) ;
data_out(1) <= count(2) xor count(1) ;
data_out(0) <= count(1) xor count(0) ;

end Behavioral;
