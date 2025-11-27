
add wave -r *

# Test that i_cache will output correct values of rs, rt, rd
force mem_address 00000
run 10 ns
force mem_address 00001
run 10 ns
force mem_address 00010
run 10 ns
force mem_address 00011
run 10 ns
force mem_address 00100
run 10 ns
force mem_address 00101
run 10 ns


