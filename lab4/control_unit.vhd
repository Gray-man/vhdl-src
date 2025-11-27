library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity control_unit is
port(opcode : in std_logic_vector(5 downto 0);
	fn : in std_logic_vector(5 downto 0);
	reg_write : out std_logic;
	reg_dst : out std_logic;
	reg_in_src : out std_logic;
	alu_src : out std_logic;
	add_sub : out std_logic;
	data_write : out std_logic;
	logic_func : out std_logic_vector(1 downto 0);
	func : out std_logic_vector(1 downto 0);
	branch_type : out std_logic_vector(1 downto 0);
	pc_sel : out std_logic_vector(1 downto 0));
end control_unit;

architecture control_unit of control_unit is
begin
	process(opcode, fn)
		variable control_signal_vector : std_logic_vector(13 downto 0);
	begin
		-- reg_write(bit 13), reg_dst(bit 12), reg_in_src(bit 11), alu_src(bit 10), add_sub(bit 9), data_write(bit 8)
		-- logic_func(bits 7 & 6), func(bits 5 & 4), branch_type(bits 3 & 2), pc_sel(bits 1 & 0)
		
		control_signal_vector := "00000000000000";		

		if opcode = "000000" then
			case fn is
				-- add
				when "100000" => control_signal_vector := "11100000100000";

				-- sub
				when "100010" => control_signal_vector := "11101000100000";

				-- slt
				when "101010" => control_signal_vector := "11100000010000";

				-- and
				when "100100" => control_signal_vector := "11101000110000";

				-- or
				when "100101" => control_signal_vector := "11100001110000";

				-- xor
				when "100110" => control_signal_vector := "11100010110000";

				-- nor
				when "100111" => control_signal_vector := "11100011110000";

				-- jr
				when "001000" => control_signal_vector := "00000000000010";
				
				when others => null;
			end case;
		else
			case opcode is
				-- lui	
				when "001111" => control_signal_vector := "10110000000000";

				-- addi
				when "001000" => control_signal_vector := "10110000100000";

				-- slti
				when "001010" => control_signal_vector := "10110000010000";

				-- andi
				when "001100" => control_signal_vector := "10110000110000";

				-- ori
				when "001101" => control_signal_vector := "10110001110000";

				-- xori
				when "001110" => control_signal_vector := "10110010110000";

				-- lw
				when "100011" => control_signal_vector := "10010000100000";

				-- sw
				when "101011" => control_signal_vector := "00010100100000";

				-- j
				when "000010" => control_signal_vector := "00000000000001";

				-- bltz
				when "000001" => control_signal_vector := "00000000001100";

				-- beq
				when "000100" => control_signal_vector := "00000000000100";

				-- bne
				when "000101" => control_signal_vector := "00000000001000";
				
				when others => null;
			end case;
		end if;

		reg_write <= control_signal_vector(13);
		reg_dst <= control_signal_vector(12);
		reg_in_src <= control_signal_vector(11);  
		alu_src <= control_signal_vector(10);
		add_sub <= control_signal_vector(9);
		data_write <= control_signal_vector(8);
		logic_func <= control_signal_vector(7 downto 6);
		func <= control_signal_vector(5 downto 4);
	        branch_type <= control_signal_vector(3 downto 2);
	       	pc_sel <= control_signal_vector(1 downto 0);
	end process;
end control_unit;
