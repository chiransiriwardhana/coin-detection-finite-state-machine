----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/20/2021 12:32:14 PM
-- Design Name: 
-- Module Name: coin_detector - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity coin_detector is
    Port ( X , Y, Z: in STD_LOGIC;
           Clock : in STD_LOGIC;
           Reset: in std_logic;
           P1, P2, P5 : out STD_LOGIC
           );
end coin_detector;

architecture Behavioral of coin_detector is
    type state_type is (p, q, r, s, t, u, v);
    signal next_state: state_type;
begin
    process(Reset, Clock)
        begin
            if Reset = '1' then
                next_state <= p;
                P1 <= '0';
                P2 <= '0';
                P5 <='0';
                
            elsif rising_edge(Clock) then
                next_state <= p;               
                case next_state is
                      when p =>
                            if Z = '1' then
                                next_state <= q;
                            else
                                next_state <= p;
                            end  if;
                            P1 <= '0';
                            P2 <= '0';
                            P5 <='0';
                       when q =>
                            if Y = '1' then
                                next_state <= r;
                            elsif Z = '0' then
                                P1 <= '1';
                                next_state <= p;                             
                            else 
                                next_state <= q;
                             end if;
                       when r =>
                            if X = '1' then
                                next_state <= t;
                            elsif Y = '0' then
                                next_state <= s;
                            else
                                next_state <= r;
                            end if;
                            
                        when s =>
                            if Z = '0' then
                                next_state <= p;
                                P5 <= '1';
                            else
                                next_state <= s;
                             end if;   
                         when t =>
                             if X = '0' then
                                next_state <= u;
                             else
                                next_state <= t;
                             end if;
                         when u =>
                              if Y = '0' then
                                next_state <= v;
                              else
                                next_state <= u;
                              end if;
                         when v => 
                              if Z = '0' then
                                next_state <= p;
                                P2 <= '1';
                              else
                                next_state <= v;
                              end if;
               end case;
            end if;
    end process;
end Behavioral;
