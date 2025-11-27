

force -freeze sim:/cpu/reset 1
force -freeze sim:/cpu/clk 0
run 1ns
force -freeze sim:/cpu/reset 0
force -freeze sim:/cpu/clk 0 0, 1 1 ns -repeat 2ns
run 10ns
run  20ns
