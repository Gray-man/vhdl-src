
# Usage:
#   vsim -do test_datapath.do

# compile
vcom datapath.vhd

# simulate
#vsim work.datapath

# optionally focus on top-level ports only:
# add wave clk reset pc_sel branch_type func logic_func add_sub reg_in_src reg_write data_write alu_src reg_dst opcode fn overflow zero

# create clock: 10 ns period (50 MHz). adjust if you want different.
force clk 0 0ns, 1 1ns -repeat 2ns

# initial reset
force reset 1
run 5ns
force reset 0

# default baseline values (all zeros)
force reg_write 0
force reg_dst 0
force reg_in_src 0
force alu_src 0
force add_sub 0
force data_write 0
force logic_func 00
force func 00
force branch_type 00
force pc_sel 00
run 20ns

# 00000
# addi r1, r0, 1
# 001000 00000 00001 00000 00000 000001

force reg_write 1
force reg_dst 0
force reg_in_src 1
force alu_src 1
force add_sub 0
force data_write 0
force logic_func 00
force func 10
force branch_type 00
force pc_sel 00
run 20ns

# 00001
# addi r2, r0, 2
# 001000 00000 00010 00000 00000 000010

force reg_write 1
force reg_dst 0
force reg_in_src 1
force alu_src 1
force add_sub 0
force data_write 0
force logic_func 00
force func 10
force branch_type 00
force pc_sel 00
run 20ns

# 00010
# add r2, r2, r1
# 000000 00010 00001 00010 00000 100000

force reg_write 1
force reg_dst 1
force reg_in_src 1
force alu_src 0
force add_sub 0
force data_write 0
force logic_func 00
force func 10
force branch_type 00
force pc_sel 00
run 20ns

# 00011
# jump 00010
# 000010 00000 00000 00000 00000 000010

force reg_write 0
force reg_dst 0
force reg_in_src 0
force alu_src 0
force add_sub 0
force data_write 0
force logic_func 00
force func 00
force branch_type 00
force pc_sel 01
run 20ns


