## =========================================================
## Register File Board Wrapper Constraints
## Target Board: Digilent Nexys A7-100T
## Design: regfile_board.vhd (4-bit version of regfile)
## =========================================================

## --------------------------
## Clock (Manual via Switch)
## --------------------------
## Use SW2 as manual clock toggle
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk]
set_property PACKAGE_PIN M13 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

## --------------------------
## Control Inputs (Switches)
## --------------------------
## reset → SW1
## write → SW0
set_property PACKAGE_PIN L16 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

set_property PACKAGE_PIN J15 [get_ports {write}]
set_property IOSTANDARD LVCMOS33 [get_ports {write}]

## --------------------------
## Data and Address Switches
## --------------------------
## din_in(3:0)           → SW15–SW12
## read_a_in(1:0)        → SW11–SW10
## read_b_in(1:0)        → SW9–SW8
## write_address_in(1:0) → SW7–SW6
## clk                   → SW2
## reset                 → SW1
## write                 → SW0

set_property PACKAGE_PIN V10 [get_ports {din_in[3]}]
set_property PACKAGE_PIN U11 [get_ports {din_in[2]}]
set_property PACKAGE_PIN U12 [get_ports {din_in[1]}]
set_property PACKAGE_PIN H6 [get_ports {din_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {din_in[*]}]

set_property PACKAGE_PIN T13 [get_ports {read_a_in[1]}]
set_property PACKAGE_PIN R16 [get_ports {read_a_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {read_a_in[*]}]

set_property PACKAGE_PIN U8 [get_ports {read_b_in[1]}]
set_property PACKAGE_PIN T8 [get_ports {read_b_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {read_b_in[*]}]

set_property PACKAGE_PIN R13 [get_ports {write_address_in[1]}]
set_property PACKAGE_PIN U18 [get_ports {write_address_in[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {write_address_in[*]}]

## --------------------------
## LEDs (Outputs)
## --------------------------
## out_a_out(3:0) → LD15–LD12
## out_b_out(3:0) → LD10–LD7

set_property PACKAGE_PIN V11 [get_ports {out_a_out[3]}]
set_property PACKAGE_PIN V12 [get_ports {out_a_out[2]}]
set_property PACKAGE_PIN V14 [get_ports {out_a_out[1]}]
set_property PACKAGE_PIN V15 [get_ports {out_a_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_a_out[*]}]

set_property PACKAGE_PIN U14 [get_ports {out_b_out[3]}]
set_property PACKAGE_PIN T15 [get_ports {out_b_out[2]}]
set_property PACKAGE_PIN V16 [get_ports {out_b_out[1]}]
set_property PACKAGE_PIN U16 [get_ports {out_b_out[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_b_out[*]}]

