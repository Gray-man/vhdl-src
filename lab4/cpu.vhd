library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity cpu is
port(clk : in std_logic;
	reset : in std_logic;
	rs_out, rt_out, pc_out : out std_logic_vector(31 downto 0);
	zero, overflow : out std_logic);
end cpu;

architecture cpu of cpu is
	
	-- next-address signals
	signal rs_int, rt_int, pc_int, next_pc_int : std_logic_vector(31 downto 0);
	signal branch_type_int, pc_sel_int : std_logic_vector(1 downto 0);

	-- i-cache signals
	signal instruction_int : std_logic_vector(31 downto 0);
	
	-- register file signals
	signal reg_address_int : std_logic_vector(4 downto 0);
	signal din_int : std_logic_vector(31 downto 0);
	signal reg_write_int, reg_dst_int : std_logic;

	-- sign-extend signals
	signal extended_int : std_logic_vector(31 downto 0);
	signal func_int : std_logic_vector(1 downto 0);

	-- alu signals 
	signal alu_y_int : std_logic_vector(31 downto 0);
	signal alu_output_int : std_logic_vector(31 downto 0);
	signal dcache_address_int : std_logic_vector(4 downto 0);
	signal logic_func_int : std_logic_vector(1 downto 0);
	signal add_sub_int : std_logic;
	signal alu_src_int : std_logic;

	-- d-cache signals
	signal d_out_int : std_logic_vector(31 downto 0);
	signal data_write_int : std_logic;
	signal reg_in_src_int : std_logic;

begin
	pc_reg : entity work.pc_reg(pc_reg)
		port map(clk => clk,
			reset => reset,
			d => next_pc_int,
			q => pc_int);

	i_cache : entity work.i_cache(i_cache)
		port map(mem_address => pc_int(4 downto 0),
			instruction => instruction_int);

	regfile: entity work.regfile(regfile)
		port map(clk => clk,
			reset => reset,
			din => din_int,
			write => reg_write_int,
			read_a => instruction_int(25 downto 21),
			read_b => instruction_int(20 downto 16),
			write_address => reg_address_int,
			out_a => rs_int,
			out_b => rt_int);

	alu : entity work.alu(alu)
		port map(x => rs_int,
			y => alu_y_int,
			add_sub => add_sub_int,
			logic_func => logic_func_int,
			func => func_int,
			output => alu_output_int,
			zero => zero,
			overflow => overflow);

	d_cache : entity work.d_cache(d_cache)
		port map(clk => clk,
			reset => reset,
			data_write => data_write_int,
			address => alu_output_int(4 downto 0),
			d_in => rt_int,
			d_out => d_out_int);

	control_unit : entity work.control_unit(control_unit)
		port map(opcode => instruction_int(31 downto 26),
			fn => instruction_int(5 downto 0),
			reg_write => reg_write_int,
			reg_dst => reg_dst_int,
			reg_in_src => reg_in_src_int,
			alu_src => alu_src_int,
			add_sub => add_sub_int,
			data_write => data_write_int,
			logic_func => logic_func_int, 
			func => func_int,
			branch_type => branch_type_int,
			pc_sel => pc_sel_int);

	next_address : entity work.next_address(next_address)
		port map(pc_sel => pc_sel_int,
			branch_type => branch_type_int,
			rs => rs_int,
			rt => rt_int,
			pc => pc_int,
			target_address => instruction_int(25 downto 0),
			next_pc => next_pc_int);

	sign_extend : entity work.sign_extend(sign_extend)
		port map(immediate => instruction_int(15 downto 0),
			func => func_int,
			extended => extended_int);

	-- multiplexor control signals
	
	reg_address_int <= instruction_int(20 downto 16) when reg_dst_int = '0' else
			   instruction_int(15 downto 11) when reg_dst_int = '1';
	
	alu_y_int <= rt_int when alu_src_int = '0' else
		     extended_int when alu_src_int = '1';
	
	din_int <= d_out_int when reg_in_src_int = '0' else
	   	   alu_output_int when reg_in_src_int = '1';
	
	pc_out <= pc_int;
	rs_out <= rs_int;
	rt_out <= rt_int;
end cpu;

