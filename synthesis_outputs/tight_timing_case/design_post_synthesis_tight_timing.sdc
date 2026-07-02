# ####################################################################

#  Created by Genus(TM) Synthesis Solution 19.13-s073_1 on Mon Jun 29 02:36:58 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design ALU

create_clock -name "clk" -period 4.0 -waveform {0.0 2.0} [get_ports clk]
set_clock_transition 0.4 [get_clocks clk]
set_load -pin_load 1.0 [get_ports {out1[7]}]
set_load -pin_load 1.0 [get_ports {out1[6]}]
set_load -pin_load 1.0 [get_ports {out1[5]}]
set_load -pin_load 1.0 [get_ports {out1[4]}]
set_load -pin_load 1.0 [get_ports {out1[3]}]
set_load -pin_load 1.0 [get_ports {out1[2]}]
set_load -pin_load 1.0 [get_ports {out1[1]}]
set_load -pin_load 1.0 [get_ports {out1[0]}]
set_load -pin_load 1.0 [get_ports {out2[7]}]
set_load -pin_load 1.0 [get_ports {out2[6]}]
set_load -pin_load 1.0 [get_ports {out2[5]}]
set_load -pin_load 1.0 [get_ports {out2[4]}]
set_load -pin_load 1.0 [get_ports {out2[3]}]
set_load -pin_load 1.0 [get_ports {out2[2]}]
set_load -pin_load 1.0 [get_ports {out2[1]}]
set_load -pin_load 1.0 [get_ports {out2[0]}]
set_clock_gating_check -setup 0.0 
set_input_transition 0.2 [get_ports {in1[7]}]
set_input_transition 0.2 [get_ports {in1[6]}]
set_input_transition 0.2 [get_ports {in1[5]}]
set_input_transition 0.2 [get_ports {in1[4]}]
set_input_transition 0.2 [get_ports {in1[3]}]
set_input_transition 0.2 [get_ports {in1[2]}]
set_input_transition 0.2 [get_ports {in1[1]}]
set_input_transition 0.2 [get_ports {in1[0]}]
set_input_transition 0.2 [get_ports {in2[7]}]
set_input_transition 0.2 [get_ports {in2[6]}]
set_input_transition 0.2 [get_ports {in2[5]}]
set_input_transition 0.2 [get_ports {in2[4]}]
set_input_transition 0.2 [get_ports {in2[3]}]
set_input_transition 0.2 [get_ports {in2[2]}]
set_input_transition 0.2 [get_ports {in2[1]}]
set_input_transition 0.2 [get_ports {in2[0]}]
set_input_transition 0.2 [get_ports {sel[3]}]
set_input_transition 0.2 [get_ports {sel[2]}]
set_input_transition 0.2 [get_ports {sel[1]}]
set_input_transition 0.2 [get_ports {sel[0]}]
set_wire_load_mode "enclosed"
set_clock_uncertainty -setup 0.4 [get_clocks clk]
