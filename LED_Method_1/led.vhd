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

signal step_output : std_logic_vector(0 to 63) := (others => '0');
--signal key,input : std_logic_vector(0 to 63) := x"0123456789abcdef";

component step_process is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end component;

component file_register is
    port (  input : in std_logic_vector(0 to 63);
            clk : in std_logic;
            output : out std_logic_vector(0 to 63) 
    );
end component;
begin

    led : step_process 
    port map (  input => input,
                key => key,
                output => step_output
            );

    file_reg : file_register
    port map (  clk => clk,
                input => step_output,
                output => output
             );
             
end Behavioral;
