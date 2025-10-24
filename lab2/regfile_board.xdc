## =========================================================
## Register File Board Wrapper Constraints
## Target Board: Digilent Nexys A7-100T
## Design: regfile_board.vhd (4-bit version of regfile)
## =========================================================

## --------------------------
## Clock (Manual via Switch)
## --------------------------
## Use SW10 as manual clock toggle
set_property PACKAGE_PIN W13 [get_ports {clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

## --------------------------
## Control Inputs (Switches)
## --------------------------
## reset → SW11
## write → SW12
set_property PACKAGE_PIN V2 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

set_property PACKAGE_PIN U1 [get_ports {write}]
set_property IOSTANDARD LVCMOS33 [get_ports {write}]

## --------------------------
## Data and Address Switches
## --------------------------
## din_in(3:0)           → SW0–SW3
## read_a_in(1:0)        → SW4–SW5
## read_b_in(1:0)        → SW6–SW7
## write_address_in(1:0) → SW8–SW9
## clk                   → SW10
## reset                 → SW11
## write                 → SW12

set_property PACKAGE_PIN V17 [get_ports {din_in[0]}]
set_property PACKAGE_PIN V16 [get_ports {din_in[1]}]
set_property PACKAGE_PIN W16 [get_ports {din_in[2]}]
set_property PACKAGE_PIN W17 [get_ports {din_in[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {din_in[*]}]

set_property PACKAGE_PIN W15 [get_ports {read_a_in[0]}]
set_property PACKAGE_PIN V15 [get_ports {read_a_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {read_a_in[*]}]

set_property PACKAGE_PIN W14 [get_ports {read_b_in[0]}]
set_property PACKAGE_PIN V14 [get_ports {read_b_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {read_b_in[*]}]

set_property PACKAGE_PIN V13 [get_ports {write_address_in[0]}]
set_property PACKAGE_PIN V12 [get_ports {write_address_in[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {write_address_in[*]}]

## --------------------------
## LEDs (Outputs)
## --------------------------
## out_a_out(3:0) → LD0–LD3
## out_b_out(3:0) → LD4–LD7

set_property PACKAGE_PIN U16 [get_ports {out_a_out[0]}]
set_property PACKAGE_PIN E19 [get_ports {out_a_out[1]}]
set_property PACKAGE_PIN U19 [get_ports {out_a_out[2]}]
set_property PACKAGE_PIN V19 [get_ports {out_a_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_a_out[*]}]

set_property PACKAGE_PIN W18 [get_ports {out_b_out[0]}]
set_property PACKAGE_PIN U15 [get_ports {out_b_out[1]}]
set_property PACKAGE_PIN U14 [get_ports {out_b_out[2]}]
set_property PACKAGE_PIN V14 [get_ports {out_b_out[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {out_b_out[*]}]

