library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.constants.all;

entity step is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            round_number : in integer;
            key_output : out std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end step;

architecture Behavioral of step is

signal r0_out,r1_out,r2_out,r3_out : std_logic_vector(0 to 63);
signal rc0,rc1,rc2,rc3 : std_logic_vector(5 downto 0);

component round is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            round_constant : in std_logic_vector(5 downto 0);
            output : out std_logic_vector(0 to 63) 
        );
end component;

component add_round_key is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );    
end component;

begin

rc0 <= r_constant(round_number*4);
rc1 <= r_constant((round_number*4)+1);
rc2 <= r_constant((round_number*4)+2);
rc3 <= r_constant((round_number*4)+3);


round0 : round
    port map (  input => input,
                key => key,
                round_constant => rc0,
                output => r0_out);

round1 : round
    port map (  input => r0_out,
                key => key,
                round_constant => rc1,
                output => r1_out);
                
round2 : round
    port map (  input => r1_out,
                key => key,
                round_constant => rc2,
                output => r2_out);
                                
round3 : round
    port map (  input => r2_out,
                key => key,
                round_constant => rc3,
                output => r3_out);   
                                                     
add_key : add_round_key
    port map (  input => r3_out,
                key => key,
                output => output);
key_output <= key;
end Behavioral;