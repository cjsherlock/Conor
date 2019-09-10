library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity shift_rows is
     port ( input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end shift_rows;

architecture Behavioral of shift_rows is

begin
    process(input)
    variable tmp : std_logic_vector(0 to 63);
    begin
        tmp := input;
        tmp(16 to 19) := input(20 to 23);
        tmp(20 to 23) := input(24 to 27);
        tmp(24 to 27) := input(28 to 31);
        tmp(28 to 31) := input(16 to 19);
        
        tmp(32 to 35) := input(40 to 43);
        tmp(36 to 39) := input(44 to 47);
        tmp(40 to 43) := input(32 to 35);
        tmp(44 to 47) := input(36 to 39);
        
        tmp(48 to 51) := input(60 to 63);
        tmp(52 to 55) := input(48 to 51);
        tmp(56 to 59) := input(52 to 55);
        tmp(60 to 63) := input(56 to 59);
        
        output <= tmp;
    end process;

end Behavioral;
