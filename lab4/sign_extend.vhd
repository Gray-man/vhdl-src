library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity sign_extend is
port(immediate : in std_logic_vector(15 downto 0);
	func : in std_logic_vector(1 downto 0);
	extended : out std_logic_vector(31 downto 0));
end sign_extend;

architecture sign_extend of sign_extend is 
	

begin
	process(immediate, func)
		
		variable sign : std_logic;
	begin	
			
		sign := immediate(15);		
		case func is 
			
			-- lui
			when "00" =>
				extended(31 downto 16) <= immediate;
				extended(15 downto 0) <= (others => '0');

			-- slt
			when "01" =>
				extended(31 downto 16) <= (others => sign);
				extended(15 downto 0) <= immediate;

			-- arithmetic
			when "10" =>
				extended(31 downto 16) <= (others => sign);
				extended(15 downto 0) <= immediate;

			-- logical
			when "11" =>
				extended(31 downto 16) <= (others => '0');
				extended(15 downto 0) <= immediate;

			when others =>
				null;
		end case;
	end process;
end sign_extend;

