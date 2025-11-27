add wave -r *

# Test vectors: immediate, func
set tests {
    {16#7FFF 00}  
    {16#8000 00}
    {16#0001 01} 
    {16#FFFF 01}
    {16#7ABC 10}
    {16#8001 10}
    {16#F00F 11}
    {16#00FF 11}
}

foreach t $tests {
    set imm  [lindex $t 0]
    set func [lindex $t 1]
    force immediate $imm
    force func $func
    run 10ns
}

run 20ns

