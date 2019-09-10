library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity led is
    Port (  clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63); 
            output : out std_logic_vector(0 to 63)
);
end led;

architecture Behavioral of led is

signal step_output : std_logic_vector(0 to 63);

component step_process is
    port (  clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end component;

begin

    led : step_process 
    port map (  clk => clk,
                input => input,
                key => key,
                output => output
            );

             
end Behavioral;
