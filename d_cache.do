add wave -r *

force clk 0 0, 1 5ns -repeat 10ns
force reset 1
run 20ns
force reset 0

# WRITE PHASE
for {set i 0} {$i < 32} {incr i} {
    # convert 0..31 into 5-bit binary
    set a [format "%05b" $i]

    # write data = i + 256 (0x100)
    set d [expr {$i + 256}]
    set d32 [format "%032b" $d]

    force address $a
    force d_in $d32
    force data_write 1

    run 10ns
}

# READ PHASE
force data_write 0
for {set i 0} {$i < 32} {incr i} {
    set a [format "%05b" $i]
    force address $a
    run 10ns
}

run 20ns


