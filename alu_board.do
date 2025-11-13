# INPUTS

add wave sim:/alu/x
add wave sim:/alu/y
add wave sim:/alu/add_sub
add wave sim:/alu/logic_func
add wave sim:/alu/func
add wave sim:/alu/output 
add wave sim:/alu/overflow
add wave sim:/alu/zero
add wave sim:/alu/x
add wave sim:/alu/y
add wave sim:/alu/add_sub_out
add wave sim:/alu/logic_unit_out

# OUTPUT TESTS
# Output = y
force sim:/alu/func 00
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# Output = 000...MSB
force sim:/alu/func 01
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# Output = adder_subtract 
force sim:/alu/func 10
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# Output = logic_unit
force sim:/alu/func 11
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# LOGIC UNIT TESTS
# AND
force sim:/alu/func 11
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# OR 
force sim:/alu/func 11
force sim:/alu/logic_func 01
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# XOR
force sim:/alu/func 11
force sim:/alu/logic_func 10
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run  

# NOR
force sim:/alu/func 11
force sim:/alu/logic_func 11
force sim:/alu/x  32'h0006
force sim:/alu/y 32'h0007
force sim:/alu/add_sub 0
run
  
# Overflow
force sim:/alu/func 10
force sim:/alu/logic_func 00
force sim:/alu/x  32'hFFFF
force sim:/alu/y 32'hFFFF
force sim:/alu/add_sub 0
run

force sim:/alu/func 10
force sim:/alu/logic_func 00
force sim:/alu/x  32'hB
force sim:/alu/y 32'hB
force sim:/alu/add_sub 0
run

# Zero
force sim:/alu/func 10
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0000
force sim:/alu/y 32'h0000
force sim:/alu/add_sub 0
run

# Subtraction
force sim:/alu/func 10
force sim:/alu/logic_func 00
force sim:/alu/x  32'h0004
force sim:/alu/y 32'h0001
force sim:/alu/add_sub 1 
run
