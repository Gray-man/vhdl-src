library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;

entity alu_board is 
port(x_in, y_in : in std_logic_vector(3 downto 0);
	add_sub : in std_logic;
	logic_func : in std_logic_vector(1 downto 0);
	func : in std_logic_vector(1 downto 0);
	output_out : out std_logic_vector(3 downto 0);
	overflow : out std_logic;
	zero : out std_logic);
end alu_board;

architecture alu_board of alu_board is

signal x, y, output: std_logic_vector(31 downto 0);
signal add_sub_out : std_logic_vector(31 downto 0);
signal logic_unit_out : std_logic_vector(31 downto 0);
begin

x(3 downto 0) <= x_in(3) & x_in(2) & x_in(1) & x_in(0);
y(3 downto 0) <= y_in(3) & y_in(2) & y_in(1) & y_in(0);
x(31 downto 4) <= (others => '0');
y(31 downto 4) <= (others => '0');

	-- process for adder_subtract
	process(x, y, add_sub)
	begin
		if (add_sub = '0') then
			add_sub_out <= x + y;
		else
			add_sub_out <= x - y;
		end if;
	end process;

	-- process for logic_unit
	process(x, y, logic_func)
	begin
		case logic_func is
			when "00" => logic_unit_out <= x and y;
			when "01" => logic_unit_out <= x or y;
			when "10" => logic_unit_out <= x xor y;
			when "11" => logic_unit_out <= x nor y;
			when others => logic_unit_out <= (others => 'X');
		end case;
	end process;

	-- process for overflow
	process(x, y, add_sub, add_sub_out)
	begin
		-- If adding, overflow = ABC' + A'B'C, A = x(31), B = y(31), C = add_sub_out(31)
		if (add_sub = '0') then
			overflow <= (x_in(3) and y_in(3) and (not add_sub_out(3))) or
				    ((not x_in(3)) and (not y_in(3)) and add_sub_out(3));
		-- If subtracting, overflow = AB'C' + A'BC
		else
			overflow <= (x_in(3) and (not y_in(3)) and (not add_sub_out(3))) or
				    ((not x_in(3)) and y_in(3) and add_sub_out(3));
		end if;	
	end process;

	-- process for zero
	process(add_sub_out)
	begin
		if (add_sub_out = "00000000000000000000000000000000") then
			zero <= '1';
		else
			zero <= '0';
		end if;
	end process;

	-- process for output mux
	process(func, y, add_sub_out, logic_unit_out)
	begin
		case func is 
			when "00" => output <= y;
			when "01" => output <= "0000000000000000000000000000000" & add_sub_out(31); 
			when "10" => output <= add_sub_out;
			when "11" => output <= logic_unit_out;
			when others => output <= (others => 'X');
		end case;
	end process;


output_out(3 downto 0) <= output(3 downto 0);


end alu_board;


