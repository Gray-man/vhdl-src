library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity d_cache is
port(clk : in std_logic;
	reset : in std_logic;
	data_write : in std_logic;
	address : in std_logic_vector(4 downto 0);
	d_in : in std_logic_vector(31 downto 0);
	d_out : out std_logic_vector(31 downto 0));
end d_cache;

architecture d_cache of d_cache is


	type MEM_ARRAY is array (0 to 31) of std_logic_vector(31 downto 0);

	signal dcache_array : MEM_ARRAY;

begin
	process(clk, reset, data_write, address, d_in) 

	begin
	
	-- write data

		if (rising_edge(clk) and data_write = '1') then
			
			dcache_array(to_integer(unsigned(address))) <= d_in;
			
		end if;	
	
	-- reset

		if (reset = '1') then
			for i in 0 to 31 loop
			
				dcache_array(i) <= "00000000000000000000000000000000";
		
			end loop;
		end if;
	
	-- read data

		d_out <= dcache_array(to_integer(unsigned(address)));

	end process;
end d_cache;
