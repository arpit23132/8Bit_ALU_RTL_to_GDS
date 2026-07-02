#==============================================================
# Cadence Tempus STA Script - Parametric Experiments
# Evaluation Netlist        : Netlist A (Min Area Case)
# Target Base Constraint    : Constraint C (design_balanced.sdc)
#==============================================================

# CREATE EXPERIMENT DIRECTORIES IF THEY DO NOT EXIST
if {![file exists sta_reports]} {
    file mkdir sta_reports
}
if {![file exists sta_reports/experiments]} {
    file mkdir sta_reports/experiments
}

set report_dir "sta_reports/experiments"

#--------------------------------------------------------------
# Read Timing Models and Baseline Netlist A
#--------------------------------------------------------------
read_lib lib/slow.lib
read_verilog synthesis_outputs/min_area_case/synthesized_netlist_min_area.v
set_top_module ALU
read_sdc synthesis_constraints/design_balanced.sdc

#--------------------------------------------------------------
# EXPERIMENT 1: Clock Slew Sweeps
#--------------------------------------------------------------

# Case 1: 0 ns Slew (Ideal Edge)
set_clock_transition 0.0 [get_clocks clk]
report_timing > $report_dir/setup_slew_0ns.rpt
report_timing -early > $report_dir/hold_slew_0ns.rpt

# Case 2: 0.8 ns Slew (Slow Edge)
set_clock_transition 0.8 [get_clocks clk]
report_timing > $report_dir/setup_slew_0.8ns.rpt
report_timing -early > $report_dir/hold_slew_0.8ns.rpt

#--------------------------------------------------------------
# EXPERIMENT 2: Output Load Sweeps
#--------------------------------------------------------------
# Reset clock transition back to baseline default (0.4 ns)
set_clock_transition 0.4 [get_clocks clk]

# Case 1: No Output Load (0 pf)
set_load 0.0 [all_outputs]
report_timing > $report_dir/setup_load_0.rpt
report_timing -early > $report_dir/hold_load_0.rpt

# Case 2: Double Output Load (2 pf)
set_load 2.0 [all_outputs]
report_timing > $report_dir/setup_load_2.rpt
report_timing -early > $report_dir/hold_load_2.rpt

exit
