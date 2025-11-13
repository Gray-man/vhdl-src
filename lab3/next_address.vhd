library IEEE;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;


entity next_address is
port(
	rt, rs : in std_logic_vector(31 downto 0);
	-- two register inputs
	pc : in std_logic_vector(31 downto 0);
	target_address : in std_logic_vector(25 downto 0);
	branch_type : in std_logic_vector(1 downto 0);
	pc_sel : in std_logic_vector(1 downto 0);
	next_pc : out std_logic_vector(31 downto 0));
end next_address ;

architecture next_address of next_address is 

begin

	process(rt, rs, pc, target_address, branch_type, pc_sel)
	begin
		case pc_sel is

			-- no unconditional jump
			when "00" => 
				case branch_type is

				       -- straight-line execution	
					when "00" =>
						next_pc <= pc + x"00000001";

					-- beq
					when "01" =>
						if (rs = rt) then
							next_pc <= pc + x"00000001" + offset;
						else
							next_pc <= pc + x"00000001";
						end if;

					-- bne
					when "10" =>
						if (rs /= rt) then
							next_pc <=  pc + x"00000001" + offset;
						else
							next_pc <= pc + x"00000001";
						end if;
					
					-- bltz
					when "11" =>
						if (rs < 0) then
							next_pc <= pc + x"00000001" + offset;
						else
							next_pc <= pc + x"00000001";
						end if;
				end case;

			-- jump
			when "01" => 
				;

			-- jump register
			when "10" => 
				;

			-- unused
			when others => pc <= (others => 'X');
		end case;
	end process;
end next_address;
