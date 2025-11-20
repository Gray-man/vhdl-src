library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity sign_extend is
port(immediate : in std_logic_vector(15 downto 0);
	extended : out std_logic_vector(31 downto 0));
end sign_extend;

architecture sign_extend of sign_extend is 
	
	signal sign : std_logic;

begin
	process(immediate)
	begin	
		sign <= immediate(15);
		extended(31 downto 16) <= (others => sign);
		extended(15 downto 0) <= immediate;
	end process;
end sign_extend;

