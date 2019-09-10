library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_step_process is
--  Port ( );
end tb_step_process;

architecture Behavioral of tb_step_process is
    signal clk : std_logic := '0';
    signal input, key, output : std_logic_vector(0 to 63); 
    constant clk_period : time := 20ns;
begin

led : entity work.step_process
    port map(   clk=> clk,
                input => input,
                key => key,
                output => output);

clk_process :process
begin
    clk <= '0';
    wait for clk_period/2;  
    clk <= '1';
    wait for clk_period/2;  
end process;

stim_proc: process
begin

input <= x"0000000000000000";
key <= x"0000000000000000";
wait for clk_period;

input <= x"a7f1d92a82c8d8fe";
key <= x"434d98558ce2b347";
wait for clk_period;

input <= x"0123456789abcdef";
key <= x"0123456789abcdef";
wait for clk_period;

end process;

end Behavioral;
