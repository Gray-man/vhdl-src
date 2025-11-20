library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity i_cache is
port( mem_address : in std_logic_vector(4 downto 0);
	opcode : out std_logic_vector(5 downto 0);
	fn : out std_logic_vector(5 downto 0);
	rs, rt, rd : out std_logic_vector(4 downto 0);
	immediate : out std_logic_vector(15 downto 0);
	target_address : out std_logic_vector(25 downto 0));
end i_cache;


architecture i_cache of i_cache is
	
	type INSTR_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);
	
	signal instruction_array : INSTR_ARRAY;
	signal instruction : std_logic_vector(31 downto 0);

begin
	process(mem_address)

	begin

		instruction_array(0) <= x"20010001"; -- addi r1, r0, 1
		instruction_array(1) <= x"20020002"; -- addi r2, r0, 2
		instruction_array(2) <= x"00411020"; -- add r2, r2, r1
		instruction_array(3) <= x"08000002"; -- jump 00010
		instruction_array(4) <= x"00000000"; -- don't care

		instruction <= instruction_array(to_integer(unsigned(mem_address)));
		
		opcode <= instruction(31 downto 26);
		rs <= instruction(25 downto 21);
		rt <= instruction(20 downto 16);
		rd <= instruction(15 downto 11);
		fn <= instruction(5 downto 0);
		immediate <= instruction(15 downto 0);
		target_address <= instruction(25 downto 0);
	end process;
end i_cache;


