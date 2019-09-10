library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity add_constants is
    port (  input : in std_logic_vector(0 to 63);
            round_constant : in std_logic_vector(5 downto 0);
            output : out std_logic_vector(0 to 63)
        );
end add_constants;

architecture Behavioral of add_constants is

begin
   
    process(input,round_constant)
    variable tmp : std_logic_vector(0 to 63) := x"0000000000000000";
    variable key_size : std_logic_vector(7 downto 0) := x"40";
    begin
        tmp(0 to 3)   := x"0" xor key_size(7 downto 4);
        tmp(16 to 19) := x"1" xor key_size(7 downto 4);
        tmp(32 to 35) := x"2" xor key_size(3 downto 0);
        tmp(48 to 51) := x"3" xor key_size(3 downto 0);
        tmp(4 to 7)   := "0"&round_constant(5 downto 3);
        tmp(20 to 23) := "0"&round_constant(2 downto 0);
        tmp(36 to 39) := "0"&round_constant(5 downto 3);
        tmp(52 to 55) := "0"&round_constant(2 downto 0);   
        
        output <= input xor tmp;
    end process;

end Behavioral;
