# ========================================================
# ALU Testbench Script - ModelSim (alu_test.do)
# Tests all ALU functionality as per COEN316 Lab 1
# ========================================================

add wave *

# ---------- TEST 1: LUI ----------
# func = 00 => output = y
force -freeze sim:/alu/func 00
force -freeze sim:/alu/logic_func 00
force -freeze sim:/alu/add_sub 0
force -freeze sim:/alu/x x"00000000"
force -freeze sim:/alu/y x"F0F0F0F0"
run 5 ps

# ---------- TEST 2: SET LESS THAN ----------
# func = 01 => output = 1 if x < y else 0
force -freeze sim:/alu/func 01
force -freeze sim:/alu/x x"00000002"
force -freeze sim:/alu/y x"00000008"
run 5 ps

# x > y case
force -freeze sim:/alu/x x"00000008"
force -freeze sim:/alu/y x"00000002"
run 5 ps

# ---------- TEST 3: ADD ----------
# func = 10, add_sub = 0
force -freeze sim:/alu/func 10
force -freeze sim:/alu/add_sub 0
force -freeze sim:/alu/x x"00000005"   ;# 5
force -freeze sim:/alu/y x"00000003"   ;# 3
run 5 ps

# Overflow case (pos + pos = neg): 0x7FFFFFFF + 0x00000001
force -freeze sim:/alu/x x"7FFFFFFF"
force -freeze sim:/alu/y x"00000001"
run 5 ps

# Overflow case (neg + neg = pos): 0x80000000 + 0xF0000000
force -freeze sim:/alu/x x"80000000"
force -freeze sim:/alu/y x"F0000000"
run 5 ps 

# ---------- TEST 4: SUBTRACT ----------
# func = 10, add_sub = 1
force -freeze sim:/alu/func 10
force -freeze sim:/alu/add_sub 1
force -freeze sim:/alu/x x"00000008"   ;# 8
force -freeze sim:/alu/y x"00000005"   ;# 5
run 5 ps

# Negative result: 0x00000005 - 0x00000008
force -freeze sim:/alu/x x"00000005"
force -freeze sim:/alu/y x"00000008"
run 5 ps

# Overflow case (neg - pos = pos): 0x80000000 - 0x00000001
force -freeze sim:/alu/x x"80000000"
force -freeze sim:/alu/y x"00000001"
run 5 ps

# ---------- TEST 5: LOGIC ----------
# func = 11
# (a) AND
force -freeze sim:/alu/func 11
force -freeze sim:/alu/logic_func 00
force -freeze sim:/alu/x x"F0F0F0F0"
force -freeze sim:/alu/y x"0F0F0F0F"
run 5 ps

# (b) OR
force -freeze sim:/alu/logic_func 01
run 5 ps

# (c) XOR
force -freeze sim:/alu/logic_func 10
run 5 ps

# (d) NOR
force -freeze sim:/alu/logic_func 11
run 5 ps

# ---------- TEST 6: ZERO OUTPUT ----------
# func = 10 (arith), add_sub=1, x=y -> output=0, zero=1
force -freeze sim:/alu/func 10
force -freeze sim:/alu/add_sub 1
force -freeze sim:/alu/x x"00000008"
force -freeze sim:/alu/y x"00000008"
run 5 ps

