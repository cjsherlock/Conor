library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


entity round is
    port (  input : in std_logic_vector(0 to 63);
            key : in std_logic_vector(0 to 63);
            round_constant : in std_logic_vector(5 downto 0);
            output : out std_logic_vector(0 to 63) 
        );
end round;

architecture Behavioral of round is
signal add_const_out,sub_cells_out,shift_rows_out : std_logic_vector(0 to 63);

--component add_round_key is
--    port (  input : in std_logic_vector(0 to 63);
--            key : in std_logic_vector(0 to 63);
--            output : out std_logic_vector(0 to 63) 
--        );    
--end component;

component add_constants is
    port (  input : in std_logic_vector(0 to 63);
            round_constant : in std_logic_vector(5 downto 0);
            output : out std_logic_vector(0 to 63) 
        );
end component;

component sub_cells is
    port (  input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
        );
end component;

component shift_rows is
    port (  input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
    );
end component;


component mix_cols is
    port (  input : in std_logic_vector(0 to 63);
            output : out std_logic_vector(0 to 63) 
    );
end component;

begin

--step_add_round_key : add_round_key
--    port map (  input => input,
--                key => key,
--                output => add_round_key_out);
                
step_add_constants : add_constants
    port map (  input => input,
                round_constant => round_constant,
                output => add_const_out);
                
step_sub_cells : sub_cells
    port map(   input => add_const_out,
                output => sub_cells_out);
                
step_shift_rows : shift_rows
    port map(   input => sub_cells_out,
                output => shift_rows_out);
                
step_mix_cols : mix_cols
    port map(   input => shift_rows_out,
                output => output);
                
end Behavioral;
