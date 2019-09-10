library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use work.constants.all;

entity mix_cols is
    port (  input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end mix_cols;

architecture Behavioral of mix_cols is

begin
    process(input)
    variable tmp : std_logic_vector(0 to 63);
    variable index : integer;
    begin
    index := 0;
    tmp := x"0000000000000000";
    for i in 0 to 3 loop       
        tmp(index  to index + 3) := 
        gf_mult(to_integer(unsigned(mds(0,0))),to_integer(unsigned(input(index to index+3)))) xor
        gf_mult(to_integer(unsigned(mds(0,1))),to_integer(unsigned(input(index+16 to index+3+16)))) xor    
        gf_mult(to_integer(unsigned(mds(0,2))),to_integer(unsigned(input(index+32 to index+3+32)))) xor
        gf_mult(to_integer(unsigned(mds(0,3))),to_integer(unsigned(input(index+48 to index+3+48))));  
             
        tmp(index +16 to index + 19) := 
        gf_mult(to_integer(unsigned(mds(1,0))),to_integer(unsigned(input(index to index+3)))) xor
        gf_mult(to_integer(unsigned(mds(1,1))),to_integer(unsigned(input(index+16 to index+3+16)))) xor    
        gf_mult(to_integer(unsigned(mds(1,2))),to_integer(unsigned(input(index+32 to index+3+32)))) xor
        gf_mult(to_integer(unsigned(mds(1,3))),to_integer(unsigned(input(index+48 to index+3+48))));                        
                    
        tmp(index + 32 to index + 35) := 
        gf_mult(to_integer(unsigned(mds(2,0))),to_integer(unsigned(input(index to index+3)))) xor
        gf_mult(to_integer(unsigned(mds(2,1))),to_integer(unsigned(input(index+16 to index+3+16)))) xor    
        gf_mult(to_integer(unsigned(mds(2,2))),to_integer(unsigned(input(index+32 to index+3+32)))) xor
        gf_mult(to_integer(unsigned(mds(2,3))),to_integer(unsigned(input(index+48 to index+3+48))));                    
                    
        tmp(index +48 to index + 51) := 
        gf_mult(to_integer(unsigned(mds(3,0))),to_integer(unsigned(input(index to index+3)))) xor
        gf_mult(to_integer(unsigned(mds(3,1))),to_integer(unsigned(input(index+16 to index+3+16)))) xor    
        gf_mult(to_integer(unsigned(mds(3,2))),to_integer(unsigned(input(index+32 to index+3+32)))) xor
        gf_mult(to_integer(unsigned(mds(3,3))),to_integer(unsigned(input(index+48 to index+3+48))));     
                                
        index := index + 4;
    end loop;

        output <= tmp;
    end process;

end Behavioral;
