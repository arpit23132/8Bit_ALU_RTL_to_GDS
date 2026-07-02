#==============================================================
# Synopsys Design Constraints (SDC)
# Optimization Case   : Tight Timing Target (Maximum Speed, High Drive Strength)
# Project             : 8-bit ALU
#==============================================================

#--------------------------------------------------------------
# Clock Definition
#--------------------------------------------------------------
# Creates a highly aggressive clock named 'clk' with a period of 4ns (250 MHz) mapped to the clk port
# (Forces Genus to upscale cells to higher drive strengths to close the critical path)
create_clock -name clk -period 4 [get_ports clk]

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
# Applies a heavy capacitive load of 1pF to the output ports to simulate external loading
# (Increases the output delay penalty, compounding the stress on timing closure)
set_load 1 [get_ports out1]
set_load 1 [get_ports out2]
