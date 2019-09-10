library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

entity step_process is
    Port (  clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63); 
            output : out std_logic_vector(0 to 63)
    );
end step_process;

architecture Behavioral of step_process is

type reg_input is array(0 to 7) of std_logic_vector(0 to 63);
--signal step_key, step_state, step_state_out, step_key_out : reg_input := (others => (others => '0'));
signal step_key_to_reg, step_state_to_reg, step_state_from_reg, step_key_from_reg : reg_input := (others => (others => '0'));
signal ar0_out,s0_out,s1_out,s2_out,s3_out,s4_out,s5_out,s6_out : std_logic_vector(0 to 63);

component step is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            round_number : in integer;
            key_output : out std_logic_vector(0 to 63); 
            output : out std_logic_vector(0 to 63) 
        );
end component;

component add_round_key is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );    
end component;

component file_register is
    Port (  clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            output_state : out std_logic_vector(0 to 63);
            output_key : out std_logic_vector(0 to 63)
);
end component; 

begin


add_key_0 : add_round_key
    port map(   input => input,
                key => key,
                output => ar0_out
                );

step_gen0 : step
    port map(   input => ar0_out,
                key => key,
                round_number => 0,
                key_output => step_key_to_reg(0),
                output => step_state_to_reg(0));
 
step_gen : for i in 1 to 7 generate

    step_proc : step
    port map(   input => step_state_from_reg(i-1),
                key => step_key_from_reg(i-1),
                round_number => i,
                key_output => step_key_to_reg(i),
                output => step_state_to_reg(i) );
end generate;               

reg_gen : for i in 0 to 7 generate

    file_reg : file_register
    port map(   clk => clk,
                input => step_state_to_reg(i),
                key => step_key_to_reg(i),
                output_state => step_state_from_reg(i),
                output_key => step_key_from_reg(i));
end generate;

output <= step_state_from_reg(7);
           
end Behavioral;
