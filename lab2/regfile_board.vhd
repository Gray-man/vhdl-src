library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity regfile_board is
port(   din_in : in std_logic_vector(3 downto 0);
	reset : in std_logic;
	clk : in std_logic;
	write : in std_logic;
	read_a_in : in std_logic_vector(1 downto 0);
	read_b_in : in std_logic_vector(1 downto 0);
	write_address_in : in std_logic_vector(1 downto 0);
	out_a_out : out std_logic_vector(3 downto 0);
	out_b_out : out std_logic_vector(3 downto 0));
end regfile_board;

architecture regfile_board of regfile_board is

	type REG_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);

	signal register_array : REG_ARRAY;
	signal din, out_a, out_b : std_logic_vector(31 downto 0);
	signal read_a, read_b, write_address : std_logic_vector(4 downto 0);
begin

	din(3 downto 0) <= din_in(3) & din_in(2) & din_in(1) & din_in(0);
	read_a(1 downto 0) <= read_a_in(1) & read_a_in(0);
	read_b(1 downto 0) <= read_b_in(1) & read_b_in(0);
	write_address(1 downto 0) <= write_address_in(1) & write_address_in(0);

	din(31 downto 4) <= (others => '0');
	read_a(4 downto 2) <= (others => '0');
	read_b(4 downto 2) <= (others => '0');
	write_address(4 downto 2) <= (others => '0');
	
	process(din, reset, clk, write, read_a, read_b, write_address) 

	begin
	
	-- write data

		if (rising_edge(clk) and write = '1') then
			
			register_array(to_integer(unsigned(write_address))) <= din;
			
		end if;	
	
	-- reset

		if (reset = '1') then
			for i in 0 to 31 loop
			
				register_array(i) <= "00000000000000000000000000000000";
		
			end loop;
		end if;
	
	-- read data

		out_a <= register_array(to_integer(unsigned(read_a)));
		out_b <= register_array(to_integer(unsigned(read_b)));
	end process;

	out_a_out <= out_a(3 downto 0);
	out_b_out <= out_b(3 downto 0);

end regfile_board;

