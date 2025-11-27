library IEEE;
use IEEE.std_logic_1164.all;

entity five_cpu is
    port(
        reset : in std_logic;
        clk   : in std_logic
    );
end five_cpu;

architecture rtl of five_cpu is

    component cpu is
        port(
            reset : in std_logic;
            clk   : in std_logic;
            rs_out, rt_out : out std_logic_vector(3 downto 0);
            pc_out : out std_logic_vector(3 downto 0);
            overflow, zero : out std_logic
        );
    end component;

    -- Internal signals for 5 CPUs
    signal rs_out0, rs_out1, rs_out2, rs_out3, rs_out4 : std_logic_vector(3 downto 0);
    signal rt_out0, rt_out1, rt_out2, rt_out3, rt_out4 : std_logic_vector(3 downto 0);
    signal pc_out0, pc_out1, pc_out2, pc_out3, pc_out4 : std_logic_vector(3 downto 0);
    signal overflow0, overflow1, overflow2, overflow3, overflow4 : std_logic;
    signal zero0, zero1, zero2, zero3, zero4 : std_logic;

    -- Use RTL architecture of cpu
    for C0, C1, C2, C3, C4 : cpu use entity WORK.cpu(rtl);

    -- Declare DONT_TOUCH attribute
    attribute DONT_TOUCH : string;
    attribute DONT_TOUCH of C0 : label is "TRUE";
    attribute DONT_TOUCH of C1 : label is "TRUE";
    attribute DONT_TOUCH of C2 : label is "TRUE";
    attribute DONT_TOUCH of C3 : label is "TRUE";
    attribute DONT_TOUCH of C4 : label is "TRUE";

begin

    -- Instantiate 5 CPU cores
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

end rtl;

