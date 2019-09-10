library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity step_process is
    Port (  --clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63); 
            output : out std_logic_vector(0 to 63)
    );
end step_process;

architecture Behavioral of step_process is

signal ar0_out,s0_out,s1_out,s2_out,s3_out,s4_out,s5_out,s6_out : std_logic_vector(0 to 63);

component step is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            round_number : in integer;
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

add_key_0 : add_round_key
    port map(   input => input,
                key => key,
                output => ar0_out
                );

step0 : step
    port map(   input => ar0_out,
                key => key,
                round_number => 0,
                output => s0_out);
                
step1 : step
    port map(   input => s0_out,
                key => key,
                round_number => 1,
                output => s1_out);

step2 : step
    port map(   input => s1_out,
                key => key,
                round_number => 2,
                output => s2_out);

step3 : step
    port map(   input => s2_out,
                key => key,
                round_number => 3,
                output => s3_out);

step4 : step
    port map(   input => s3_out,
                key => key,
                round_number => 4,
                output => s4_out);

step5 : step
    port map(   input => s4_out,
                key => key,
                round_number => 5,
                output => s5_out);
                
step6 : step
    port map(   input => s5_out,
                key => key,
                round_number => 6,
                output => s6_out);
                 
step7 : step
    port map(   input => s6_out,
                key => key,
                round_number => 7,
                output => output);

end Behavioral;
