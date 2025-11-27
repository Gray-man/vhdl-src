library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity pc_reg is 
port(clk : in std_logic;
	reset: in std_logic;
	d : in std_logic_vector(31 downto 0);
	q : out std_logic_vector(31 downto 0));
end pc_reg;


architecture pc_reg of pc_reg is 
begin
	process(clk, reset)
	begin
		if reset = '1' then
			q <= (others => '0');
		elsif rising_edge(clk) then
			q <= d;
		end if;
	end process;
end pc_reg;
