library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity next_address is
port(
	rt, rs : in std_logic_vector(31 downto 0);
	pc : in std_logic_vector(31 downto 0);
	target_address : in std_logic_vector(25 downto 0);
	branch_type : in std_logic_vector(1 downto 0);
	pc_sel : in std_logic_vector(1 downto 0);
	next_pc : out std_logic_vector(31 downto 0));
end next_address;


architecture next_address of next_address is


end next_address;


