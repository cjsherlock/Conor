library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity package_zybo is
    Port (  --clk : in std_logic;
        input : in std_logic_vector(0 to 7);
        ctrl : in std_logic_vector(0 to 7); 
        output : out std_logic_vector(0 to 7)
);
end package_zybo;

architecture Behavioral of package_zybo is
signal zybo_output,zybo_input,zybo_key : std_logic_vector(0 to 63);
component led is
    Port (  clk : in std_logic;
            input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63); 
            output : out std_logic_vector(0 to 63)
);
end component;
begin

    led_l : led 
    port map (  input => zybo_input,
                key => zybo_key,
                clk => ctrl(0),
                output => zybo_output
            );
            
zybo_input(0 to 7) <= input;
zybo_key(0 to 7) <= input;
output <= zybo_output(0 to 7);
end Behavioral;
