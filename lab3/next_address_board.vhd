library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity next_address is
port(
	rt_in, rs_in : in std_logic_vector(1 downto 0);
	pc_in : in std_logic_vector(2 downto 0);
	target_address_in : in std_logic_vector(2 downto 0);
	branch_type : in std_logic_vector(1 downto 0);
	pc_sel : in std_logic_vector(1 downto 0);
	next_pc_out : out std_logic_vector(2 downto 0));
end next_address;

architecture next_address of next_address is

	signal rt, rs, pc, next_pc : std_logic_vector(31 downto 0);
	signal target_address : std_logic_vector(25 downto 0);

begin

	rt(1 downto 0) <= rt_in(1) & rt_in(0);
	rs(1 downto 0) <= rs_in(1) & rs_in(1);
	pc(2 downto 0) <= pc_in(2) & pc_in(1) & pc_in(0);
	target_address(2 downto 0) <= target_address_in(2) & target_address_in(1) & target_address_in(0); 

	rt(31 downto 2) <= (others => '0');
	rs(31 downto 2) <= (others => '0');
	pc(31 downto 3) <= (others => '0');
	target_address(25 downto 3) <= (others => '0');
	

	process(rt, rs, pc, target_address, branch_type, pc_sel)

		variable signed_offset : signed(15 downto 0);
	begin

		case pc_sel is

			-- no unconditional jump
			when "00" =>

				-- straight-line execution
				case branch_type is
					when "00" =>
						next_pc <= pc + x"00000001";

					-- beq
					when "01" =>
						signed_offset := signed(target_address(15 downto 0));
						if (rs = rt) then
							next_pc <= pc + to_integer(resize(signed_offset, pc'length)) + x"00000001";
						else
							next_pc <= pc + x"00000001";
						end if;

					-- bne
					when "10" =>
						signed_offset := signed(target_address(15 downto 0));
						if (rs /= rt) then
							next_pc <= pc + to_integer(resize(signed_offset, pc'length)) + x"00000001";
						else
							next_pc <= pc + x"00000001";
						end if;

					-- bltz
					when "11" =>
						signed_offset := signed(target_address(15 downto 0));
						if (rs < 0) then
							next_pc <= pc + to_integer(resize(signed_offset, pc'length)) + x"00000001";
						else
							next_pc <= pc + x"00000001";
						end if;
					when others => null;
				end case;

			-- unconditional jump
			when "01" =>
				next_pc <= "000000" & target_address;

			-- jump register
			when "10" =>
				next_pc <= rs;

			-- unused
			when others  =>
				next_pc <= (others => 'X'); 
		end case;

	end process;
	
	next_pc_out(2 downto 0) <= next_pc(2 downto 0);

end next_address;


