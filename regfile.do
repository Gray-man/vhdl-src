# ========================================================
# Register File Testbench - ModelSim (regfile_test.do)
# Tests all functionality of 32x32 Register File
# ========================================================

add wave *

# ---------- INITIAL CONDITIONS ----------
force -freeze sim:/regfile/clk 0 0, 1 2 ps -repeat 4 ps
force -freeze sim:/regfile/reset 0
force -freeze sim:/regfile/write 0
force -freeze sim:/regfile/din x"00000000"
force -freeze sim:/regfile/read_a "00000"
force -freeze sim:/regfile/read_b "00000"
force -freeze sim:/regfile/write_address "00000"
run 10 ps


# ---------- TEST 6: RESET ----------
# Clear all registers and verify zeroed outputs
force -freeze sim:/regfile/reset 1
run 10 ps
force -freeze sim:/regfile/reset 0
run 10 ps

# Verify R1 and R31 are cleared
force -freeze sim:/regfile/read_a "00001"
force -freeze sim:/regfile/read_b "11111"
run 10 ps

# ---------- TEST 1: WRITE TO MULTIPLE REGISTERS ----------
# Write unique hex pattern to all 32 registers
# Data = address repeated in each byte (e.g., R5 = 0x05050505)
for {set i 0} {$i < 32} {incr i} {
    set hex [format "%02X" $i]
    force -freeze sim:/regfile/write 1
    force -freeze sim:/regfile/write_address [format "%05b" $i]
    force -freeze sim:/regfile/din x"${hex}${hex}${hex}${hex}"
    run 10 ps
}
force -freeze sim:/regfile/write 0

# ---------- TEST 2: READ TEST ----------
# Verify known register contents
force -freeze sim:/regfile/read_a "00001"  ;# R1 -> expect 0x01010101
force -freeze sim:/regfile/read_b "11111"  ;# R31 -> expect 0x1F1F1F1F
run 10 ps

# ---------- TEST 3: NO-WRITE CONDITION ----------
# Attempt to write when write=0 (should not change register)
force -freeze sim:/regfile/write 0
force -freeze sim:/regfile/write_address "00010"
force -freeze sim:/regfile/din x"DEADBEEF"
run 10 ps

# Verify R2 remains 0x02020202
force -freeze sim:/regfile/read_a "00010"
run 10 ps

# ---------- TEST 4: OVERWRITE TEST ----------
# Overwrite R10 with a new value
force -freeze sim:/regfile/write 1
force -freeze sim:/regfile/write_address "01010"  ;# R10
force -freeze sim:/regfile/din x"CAFEBABE"
run 10 ps
force -freeze sim:/regfile/write 0

# Verify new value
force -freeze sim:/regfile/read_a "01010"
run 10 ps

# ---------- TEST 5: ASYNCHRONOUS READ ----------
# Change read addresses without clock edge
force -freeze sim:/regfile/read_a "00100"  ;# R4
force -freeze sim:/regfile/read_b "00011"  ;# R3
run 10 ps

force -freeze sim:/regfile/read_a "11111"  ;# R31
force -freeze sim:/regfile/read_b "00000"  ;# R0
run 10 ps



