library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.constants.all;

entity sub_cells is
    port (  input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end sub_cells;

architecture Behavioral of sub_cells is

begin
    process(input)
    begin
        for i in 0 to 15 loop
            output(i*4 to ((i*4)+3)) <= sbox(to_integer(unsigned(input(i*4 to ((i*4)+3)))));
        end loop;
    end process;

end Behavioral;
