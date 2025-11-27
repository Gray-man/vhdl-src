library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;


entity two_cpu is
port(reset : in std_logic;
clk
: in std_logic); -- intentional that there are no
end two_cpu;
-- output ports (for simplicity)
architecture rtl of
two_cpu
is
component cpu is
port(reset : in std_logic;
clk
: in std_logic;
rs_out, rt_out : out std_logic_vector(3 downto 0);
pc_out : out std_logic_vector(3 downto 0);
overflow, zero : out std_logic);
end component ;
-- declare internal signals used in the component
-- port map statements
signal rs_out0, rs_out1 : std_logic_vector(3 downto 0);
signal rt_out0, rt_out1 : std_logic_vector(3 downto 0) ;
signal pc_out0, pc_out1 : std_logic_vector(3 downto 0) ;
signal overflow0, overflow1 : std_logic;
signal zero0, zero1 : std_logic;
for MICK, KEITH :
cpu use entity WORK.cpu(rtl);
attribute DONT_TOUCH : string;
attribute DONT_TOUCH of MICK : label is "TRUE";
attribute DONT_TOUCH of KEITH : label is "TRUE";
-- the DONT_TOUCH attribute is needed for all the instances
-- of the ’cpu’ component, otherwise during implementation the
-- optimizer does some "decloning" of all into a single instance
-- and the implemented design consists of only 1 CPU with the
-- resource utilization the same as that of just the
-- original single CPU design
begin
-- component instantiation
MICK: cpu port map(reset => reset, clk => clk, rs_out => rs_out0,
rt_out => rt_out0, pc_out => pc_out0, overflow => overflow0, zero
=> zero0);
KEITH: cpu port map(reset => reset, clk => clk, rs_out => rs_out1,
rt_out => rt_out1, pc_out => pc_out1, overflow => overflow1, zero
=> zero1);
end
rtl;
