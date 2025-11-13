# ModelSim DO file for Next-Address Unit Testing
# COEN 316 - Lab 3
# Tests all instruction types: straight-line, beq, bne, bltz, jump, jr


# Add waves to waveform viewer
add wave -divider "Inputs"
add wave -radix hexadecimal sim:/next_address/pc
add wave -radix hexadecimal sim:/next_address/rs
add wave -radix hexadecimal sim:/next_address/rt
add wave -radix hexadecimal sim:/next_address/target_address
add wave -radix hexadecimal sim:/next_address/branch_type
add wave -radix hexadecimal sim:/next_address/pc_sel
add wave -divider "Output"
add wave -radix hexadecimal sim:/next_address/next_pc

# Initialize signals
force pc 32'h00000005
force rs 32'h00000000
force rt 32'h00000000
force target_address 26'h0000000
force branch_type 2'b00
force pc_sel 2'b00

# Run for initial setup
run 10 ns

#==============================================================================
# TEST CASE 1: Straight-line execution (no branch)
# branch_type = 00, pc_sel = 00
# Expected: next_pc = PC + 1 = 5 + 1 = 6
#==============================================================================
echo "TEST 1: Straight-line execution (PC + 1)"
force pc 32'h00000005
force rs 32'h00000000
force rt 32'h00000000
force target_address 26'h0000000
force branch_type 2'b00
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 2: BEQ - Branch Equal (condition TRUE: rs = rt)
# branch_type = 01, pc_sel = 00
# Expected: next_pc = PC + 1 + sign_extended_offset
# Using offset = -3 (0xFFFD in 16-bit two's complement)
# PC = 6, offset = -3, Expected: 6 + 1 + (-3) = 4
#==============================================================================
echo "TEST 2: BEQ with rs = rt (branch taken, offset = -3)"
force pc 32'h00000006
force rs 32'h0000000A
force rt 32'h0000000A
force target_address 26'h3FFFFFD
force branch_type 2'b01
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 3: BEQ - Branch Equal (condition FALSE: rs != rt)
# branch_type = 01, pc_sel = 00
# Expected: next_pc = PC + 1 = 7 + 1 = 8
#==============================================================================
echo "TEST 3: BEQ with rs != rt (branch not taken)"
force pc 32'h00000007
force rs 32'h0000000A
force rt 32'h0000000F
force target_address 26'h3FFFFFD
force branch_type 2'b01
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 4: BNE - Branch Not Equal (condition TRUE: rs != rt)
# branch_type = 10, pc_sel = 00
# Expected: next_pc = PC + 1 + sign_extended_offset
# Using offset = -3 (0xFFFD in 16-bit two's complement)
# PC = 6, offset = -3, Expected: 6 + 1 + (-3) = 4
#==============================================================================
echo "TEST 4: BNE with rs != rt (branch taken, offset = -3)"
force pc 32'h00000006
force rs 32'h00000005
force rt 32'h0000000A
force target_address 26'h3FFFFFD
force branch_type 2'b10
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 5: BNE - Branch Not Equal (condition FALSE: rs = rt)
# branch_type = 10, pc_sel = 00
# Expected: next_pc = PC + 1 = 8 + 1 = 9
#==============================================================================
echo "TEST 5: BNE with rs = rt (branch not taken)"
force pc 32'h00000008
force rs 32'h00000014
force rt 32'h00000014
force target_address 26'h3FFFFFD
force branch_type 2'b10
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 6: BLTZ - Branch Less Than Zero (condition TRUE: rs < 0)
# branch_type = 11, pc_sel = 00
# Expected: next_pc = PC + 1 + sign_extended_offset
# Using offset = -5 (0xFFFB in 16-bit two's complement)
# PC = 10, offset = -5, Expected: 10 + 1 + (-5) = 6
#==============================================================================
echo "TEST 6: BLTZ with rs < 0 (branch taken, offset = -5)"
force pc 32'h0000000A
force rs 32'hFFFFFFF8
force rt 32'h00000000
force target_address 26'h3FFFFFB
force branch_type 2'b11
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 7: BLTZ - Branch Less Than Zero (condition FALSE: rs >= 0)
# branch_type = 11, pc_sel = 00
# Expected: next_pc = PC + 1 = 12 + 1 = 13
#==============================================================================
echo "TEST 7: BLTZ with rs >= 0 (branch not taken)"
force pc 32'h0000000C
force rs 32'h00000005
force rt 32'h00000000
force target_address 26'h3FFFFFB
force branch_type 2'b11
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 8: JUMP - Unconditional Jump
# pc_sel = 01
# Expected: next_pc = {6'b000000, target_address}
# target_address = 0x0000002 (26 bits)
# Expected: 0x00000002
#==============================================================================
echo "TEST 8: JUMP instruction (unconditional)"
force pc 32'h00000011
force rs 32'h00000000
force rt 32'h00000000
force target_address 26'h0000002
force branch_type 2'b00
force pc_sel 2'b01
run 10 ns

#==============================================================================
# TEST CASE 9: JUMP with larger target address
# pc_sel = 01
# target_address = 0x3FFFFFF (26 bits - maximum value)
# Expected: 0x03FFFFFF
#==============================================================================
echo "TEST 9: JUMP with large target address"
force pc 32'h00000015
force rs 32'h00000000
force rt 32'h00000000
force target_address 26'h3FFFFFF
force branch_type 2'b00
force pc_sel 2'b01
run 10 ns

#==============================================================================
# TEST CASE 10: JR - Jump Register
# pc_sel = 10
# Expected: next_pc = contents of rs
#==============================================================================
echo "TEST 10: JR (Jump Register) instruction"
force pc 32'h00000020
force rs 32'h00000100
force rt 32'h00000000
force target_address 26'h0000000
force branch_type 2'b00
force pc_sel 2'b10
run 10 ns

#==============================================================================
# TEST CASE 11: BEQ with positive offset
# branch_type = 01, pc_sel = 00, rs = rt
# Using offset = +5 (0x0005 in 16-bit)
# PC = 3, offset = +5, Expected: 3 + 1 + 5 = 9
#==============================================================================
echo "TEST 11: BEQ with positive offset (branch taken)"
force pc 32'h00000003
force rs 32'h00000020
force rt 32'h00000020
force target_address 26'h0000005
force branch_type 2'b01
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 12: BLTZ with zero value (edge case)
# branch_type = 11, pc_sel = 00, rs = 0
# Expected: next_pc = PC + 1 (zero is not less than zero)
#==============================================================================
echo "TEST 12: BLTZ with rs = 0 (branch not taken)"
force pc 32'h00000010
force rs 32'h00000000
force rt 32'h00000000
force target_address 26'h3FFFFFA
force branch_type 2'b11
force pc_sel 2'b00
run 10 ns

#==============================================================================
# TEST CASE 13: JR with large address in rs
# pc_sel = 10
# Expected: next_pc = contents of rs
#==============================================================================
echo "TEST 13: JR with large address"
force pc 32'h00000050
force rs 32'hDEADBEEF
force rt 32'h00000000
force target_address 26'h0000000
force branch_type 2'b00
force pc_sel 2'b10
run 10 ns

# Final run
run 10 ns

echo "========================================="
echo "All test cases completed!"
echo "Review the waveform to verify results."
echo "========================================="

# Zoom to fit all signals
wave zoom full
