library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity datapath is
port(clk : in std_logic;
	reset : in std_logic;
	pc_sel : in std_logic_vector(1 downto 0);
	branch_type : in std_logic_vector(1 downto 0);
	func : in std_logic_vector(1 downto 0);
	logic_func : in std_logic_vector(1 downto 0);
	add_sub : in std_logic;
	reg_in_src : in std_logic;
	reg_write : in std_logic;
	data_write : in std_logic;
	alu_src : in std_logic;
	reg_dst : in std_logic;
	opcode : out std_logic_vector(5 downto 0);
	fn : out std_logic_vector(5 downto 0);
	overflow, zero : out std_logic;
	rs, rt, pc : out std_logic_vector(31 downto 0));
end entity datapath;

architecture datapath of datapath is
	
	-- next-address signals
	signal rs_int, rt_int, pc_int, next_pc_int : std_logic_vector(31 downto 0);

	-- i-cache signals
	signal instruction_int : std_logic_vector(31 downto 0);
	signal mem_address_int : std_logic_vector(4 downto 0);

	signal target_address_int : std_logic_vector(25 downto 0) := instruction_int(25 downto 0);
	signal rs_address_int : std_logic_vector(4 downto 0) := instruction_int(25 downto 21);
       	signal rt_address_int : std_logic_vector(4 downto 0) := instruction_int(20 downto 16);
	signal rd_address_int : std_logic_vector(4 downto 0) := instruction_int(15 downto 11);
	signal immediate_int : std_logic_vector(15 downto 0) := instruction_int(15 downto 0);

	-- register file signals
	signal reg_address_int : std_logic_vector(4 downto 0);
	signal din_int : std_logic_vector(31 downto 0);

	-- sign-extend signals
	signal extended_int : std_logic_vector(31 downto 0);

	-- alu signals 
	signal alu_y_int : std_logic_vector(31 downto 0);
	signal alu_output_int : std_logic_vector(31 downto 0);
	signal dcache_address_int : std_logic_vector(4 downto 0);

	-- d-cache signals
	signal d_out_int : std_logic_vector(31 downto 0);

begin
	next_address : entity work.next_address(next_address)
		port map(pc_sel => pc_sel,
			branch_type => branch_type,
			rs => rs_int,
			rt => rt_int,
			pc => pc_int,
			target_address => target_address_int,
			next_pc => next_pc_int);

	i_cache : entity work.i_cache(i_cache)
		port map(mem_address => mem_address_int,
			instruction => instruction_int);

	regfile: entity work.regfile(regfile)
		port map(clk => clk,
			reset => reset,
			din => din_int,
			write => reg_write,
			read_a => rs_address_int,
			read_b => rt_address_int,
			write_address => reg_address_int,
			out_a => rs_int,
			out_b => rt_int);

	alu : entity work.alu(alu)
		port map(x => rs_int,
			y => alu_y_int,
			add_sub => add_sub,
			logic_func => logic_func,
			func => func,
			output => alu_output_int,
			zero => zero,
			overflow => overflow);

	sign_extend : entity work.sign_extend(sign_extend)
		port map(immediate => immediate_int,
			func => func,
			extended => extended_int);

	d_cache : entity work.d_cache(d_cache)
		port map(clk => clk,
			reset => reset,
			data_write => data_write,
			address => dcache_address_int,
			d_in => rt_int,
			d_out => d_out_int);

	pc_reg : entity work.pc_reg(pc_reg)
		port map(clk => clk,
			reset => reset,
			d => next_pc_int,
			q => pc_int);

	process(clk, reset, reg_write, reg_dst, reg_in_src, alu_src, add_sub, data_write, logic_func, func, branch_type, pc_sel)
	begin

		mem_address_int <= pc_int(4 downto 0);

		-- multiplexor control signals
		case reg_dst is 
			when '0' => reg_address_int <= rt_address_int;
			when '1' => reg_address_int <= rd_address_int;
			when others => null;
		end case;

		case alu_src is 
			when '0' => alu_y_int <= rt_int;
			when '1' => alu_y_int <= extended_int;
			when others => null;
		end case;
		
		dcache_address_int <= alu_output_int(4 downto 0);
		
		case reg_in_src is 
			when '0' => din_int <= d_out_int;
			when '1' => din_int <= alu_output_int;
			when others => null;
		end case;
		
		opcode <= instruction_int(31 downto 26);
		fn <= instruction_int(5 downto 0);
		pc <= pc_int;
		rs <= rs_int;
		rt <= rt_int;
	end process;
end architecture datapath;

