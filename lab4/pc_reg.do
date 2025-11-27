
radix -unsigned
force -freeze reset 1
force -freeze clk 0
run 1ns

force -freeze reset 0
force -freeze clk 0 0, 1 1ns -repeat 2ns
force d x"00000001" 
run 10ns

force d x"00000002"
run 10ns
force d x"DEADBEEF"
run 10ns 
