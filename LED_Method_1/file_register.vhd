library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity file_register is
    Port (  clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63)
);
end file_register;

architecture Behavioral of file_register is

begin

    process(clk)
    begin
        if(rising_edge(clk)) then
            output <= input;
        end if;
    end process;

end Behavioral;
