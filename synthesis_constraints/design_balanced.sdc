#==============================================================
# Synopsys Design Constraints (SDC)
# Optimization Case   : Balanced Target (Optimized Area-Delay Product)
# Project             : 8-bit ALU
#==============================================================

#--------------------------------------------------------------
# Clock Definition
#--------------------------------------------------------------
# Creates a clock named 'clk' with a period of 8.0ns (125.0 MHz) mapped to the clk port
# (Strikes a balance, giving Genus flexibility to trade off drive strength and cell area)
create_clock -name clk -period 8 [get_ports clk]

# Defines the rise and fall transition times (slew rate) for the clock network
set_clock_transition -rise 0.4 [get_clocks clk]
set_clock_transition -fall 0.4 [get_clocks clk]

# Models clock jitter and skew margin for setup timing analysis
set_clock_uncertainty -setup 0.4 [get_clocks clk]

#--------------------------------------------------------------
# Input Constraints
#--------------------------------------------------------------
# Models the external input transition drive (slew) arriving at the input ports
set_input_transition 0.2 [get_ports in1]
set_input_transition 0.2 [get_ports in2]
set_input_transition 0.2 [get_ports sel]

#--------------------------------------------------------------
# Output Constraints
#--------------------------------------------------------------
# Applies a standard capacitive load of 1 unit to the output ports to simulate loading effects
set_load 1 [get_ports out1]
set_load 1 [get_ports out2]
