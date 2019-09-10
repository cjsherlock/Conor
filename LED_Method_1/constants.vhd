library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

package constants is

    constant rounds: integer := 32;
    constant keylength: integer := 64;
    subtype nibble is std_logic_vector(3 downto 0);
    type matrix is array (natural range <>, natural range <>) of nibble;
    subtype gf_nibble is std_logic_vector(0 to 3);
    type gf_matrix is array (natural range <>, natural range <>) of gf_nibble;
    type nibble_array is array (natural range <>) of nibble;
    constant mds: gf_matrix :=
           ((x"4", x"1", x"2", x"2"),
            (x"8", x"6", x"5", x"6"),
            (x"b", x"e", x"a", x"9"),
            (x"2", x"2", x"f", x"b") );
    constant sbox: nibble_array := 
    (x"c", x"5", x"6", x"b", x"9", x"0", x"a", x"d", x"3", x"e", x"f", x"8", x"4", x"7", x"1", x"2");   
    type reg_file is array (0 to 7) of std_logic_vector(0 to 63);
    type r_const is array (0 to 31) of std_logic_vector(5 downto 0);
    constant r_constant : r_const := 
        ("000001","000011","000111","001111","011111","111110","111101","111011",
         "110111","101111","011110","111100","111001","110011","100111","001110",
         "011101","111010","110101","101011","010110","101100","011000","110000",
         "100001","000010","000101","001011","010111","101110","011100","111000");
         
     constant gf_mult : gf_matrix :=
    (
    (x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0", x"0" ),
    (x"0", x"1", x"2", x"3", x"4", x"5", x"6", x"7", x"8", x"9", x"a", x"b", x"c", x"d", x"e", x"f" ),
    (x"0", x"2", x"4", x"6", x"8", x"a", x"c", x"e", x"3", x"1", x"7", x"5", x"b", x"9", x"f", x"d" ),
    (x"0", x"3", x"6", x"5", x"c", x"f", x"a", x"9", x"b", x"8", x"d", x"e", x"7", x"4", x"1", x"2" ),
    (x"0", x"4", x"8", x"c", x"3", x"7", x"b", x"f", x"6", x"2", x"e", x"a", x"5", x"1", x"d", x"9" ),
    (x"0", x"5", x"a", x"f", x"7", x"2", x"d", x"8", x"e", x"b", x"4", x"1", x"9", x"c", x"3", x"6" ),
    (x"0", x"6", x"c", x"a", x"b", x"d", x"7", x"1", x"5", x"3", x"9", x"f", x"e", x"8", x"2", x"4" ),
    (x"0", x"7", x"e", x"9", x"f", x"8", x"1", x"6", x"d", x"a", x"3", x"4", x"2", x"5", x"c", x"b" ),
    (x"0", x"8", x"3", x"b", x"6", x"e", x"5", x"d", x"c", x"4", x"f", x"7", x"a", x"2", x"9", x"1" ),
    (x"0", x"9", x"1", x"8", x"2", x"b", x"3", x"a", x"4", x"d", x"5", x"c", x"6", x"f", x"7", x"e" ),
    (x"0", x"a", x"7", x"d", x"e", x"4", x"9", x"3", x"f", x"5", x"8", x"2", x"1", x"b", x"6", x"c" ),
    (x"0", x"b", x"5", x"e", x"a", x"1", x"f", x"4", x"7", x"c", x"2", x"9", x"d", x"6", x"8", x"3" ),
    (x"0", x"c", x"b", x"7", x"5", x"9", x"e", x"2", x"a", x"6", x"1", x"d", x"f", x"3", x"4", x"8" ),
    (x"0", x"d", x"9", x"4", x"1", x"c", x"8", x"5", x"2", x"f", x"b", x"6", x"3", x"e", x"a", x"7" ),
    (x"0", x"e", x"f", x"1", x"d", x"3", x"2", x"c", x"9", x"7", x"6", x"8", x"4", x"a", x"b", x"5" ),
    (x"0", x"f", x"d", x"2", x"9", x"6", x"4", x"b", x"1", x"e", x"c", x"3", x"8", x"7", x"5", x"a" )
    );
     end constants;  