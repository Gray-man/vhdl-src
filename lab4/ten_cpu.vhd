library IEEE;
use IEEE.std_logic_1164.all;

entity ten_cpu is
    port(
        reset : in std_logic;
        clk   : in std_logic
    );
end ten_cpu;

architecture rtl of ten_cpu is

    component cpu is
        port(
            reset : in std_logic;
            clk   : in std_logic;
            rs_out, rt_out : out std_logic_vector(3 downto 0);
            pc_out : out std_logic_vector(3 downto 0);
            overflow, zero : out std_logic
        );
    end component;

    -- Internal signals for 10 CPUs
    signal rs_out0, rs_out1, rs_out2, rs_out3, rs_out4,
           rs_out5, rs_out6, rs_out7, rs_out8, rs_out9 : std_logic_vector(3 downto 0);

    signal rt_out0, rt_out1, rt_out2, rt_out3, rt_out4,
           rt_out5, rt_out6, rt_out7, rt_out8, rt_out9 : std_logic_vector(3 downto 0);

    signal pc_out0, pc_out1, pc_out2, pc_out3, pc_out4,
           pc_out5, pc_out6, pc_out7, pc_out8, pc_out9 : std_logic_vector(3 downto 0);

    signal overflow0, overflow1, overflow2, overflow3, overflow4,
           overflow5, overflow6, overflow7, overflow8, overflow9 : std_logic;

    signal zero0, zero1, zero2, zero3, zero4,
           zero5, zero6, zero7, zero8, zero9 : std_logic;

    for C0, C1, C2, C3, C4, C5, C6, C7, C8, C9 : cpu use entity WORK.cpu(rtl);

    -- DONT_TOUCH attribute declaration
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of C0 : label is "TRUE";
    attribute DONT_TOUCH of C1 : label is "TRUE";
    attribute DONT_TOUCH of C2 : label is "TRUE";
    attribute DONT_TOUCH of C3 : label is "TRUE";
    attribute DONT_TOUCH of C4 : label is "TRUE";
    attribute DONT_TOUCH of C5 : label is "TRUE";
    attribute DONT_TOUCH of C6 : label is "TRUE";
    attribute DONT_TOUCH of C7 : label is "TRUE";
    attribute DONT_TOUCH of C8 : label is "TRUE";
    attribute DONT_TOUCH of C9 : label is "TRUE";

begin

    C0: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out0, rt_out => rt_out0,
                     pc_out => pc_out0, overflow => overflow0, zero => zero0);

    C1: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out1, rt_out => rt_out1,
                     pc_out => pc_out1, overflow => overflow1, zero => zero1);

    C2: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out2, rt_out => rt_out2,
                     pc_out => pc_out2, overflow => overflow2, zero => zero2);

    C3: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out3, rt_out => rt_out3,
                     pc_out => pc_out3, overflow => overflow3, zero => zero3);

    C4: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out4, rt_out => rt_out4,
                     pc_out => pc_out4, overflow => overflow4, zero => zero4);

    C5: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out5, rt_out => rt_out5,
                     pc_out => pc_out5, overflow => overflow5, zero => zero5);

    C6: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out6, rt_out => rt_out6,
                     pc_out => pc_out6, overflow => overflow6, zero => zero6);

    C7: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out7, rt_out => rt_out7,
                     pc_out => pc_out7, overflow => overflow7, zero => zero7);

    C8: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out8, rt_out => rt_out8,
                     pc_out => pc_out8, overflow => overflow8, zero => zero8);

    C9: cpu port map(reset => reset, clk => clk,
                     rs_out => rs_out9, rt_out => rt_out9,
                     pc_out => pc_out9, overflow => overflow9, zero => zero9);

end rtl;

