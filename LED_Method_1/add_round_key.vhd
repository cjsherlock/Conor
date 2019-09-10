library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity add_round_key is
    port(   input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63)
    );
end add_round_key;

architecture Behavioral of add_round_key is


begin
process(input,key)
    begin
        output <= key xor input;
    end process;
end Behavioral;
