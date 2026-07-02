#==============================================================
# Cadence Tempus STA Script - Netlist B (Tight Timing Case)
# Target Constraint         : Constraint C (8ns Period)
#==============================================================

# CREATE OUTPUT DIRECTORIES IF THEY DO NOT EXIST
if {![file exists sta_reports]} {
    file mkdir sta_reports
}
if {![file exists sta_reports/tight_timing]} {
    file mkdir sta_reports/tight_timing
}

set report_dir "sta_reports/tight_timing"

#--------------------------------------------------------------
# Read Timing Models and Netlist
#--------------------------------------------------------------
read_lib lib/slow.lib
read_verilog synthesis_outputs/tight_timing_case/synthesized_netlist_tight_timing.v
set_top_module ALU

#--------------------------------------------------------------
# Read Timing Constraints
#--------------------------------------------------------------
read_sdc synthesis_constraints/design_balanced.sdc 

#--------------------------------------------------------------
# GBA Timing Reports (Default Mode)
#--------------------------------------------------------------
report_timing > $report_dir/gba_setup_tight_timing.rpt
report_timing -early > $report_dir/gba_hold_tight_timing.rpt

#--------------------------------------------------------------
# PBA Timing Reports (Path-Based Slew Propagation)
#--------------------------------------------------------------
report_timing -retime path_slew_propagation \
   -max_path 50 -nworst 50 -path_type full_clock > $report_dir/pba_setup_tight_timing.rpt

report_timing -retime path_slew_propagation -early \
   -max_path 50 -nworst 50 -path_type full_clock > $report_dir/pba_hold_tight_timing.rpt

#--------------------------------------------------------------
# Generate Structural & Quality Audits
#--------------------------------------------------------------
check_timing > $report_dir/check_timing_tight_timing.rpt
report_clocks > $report_dir/clocks_tight_timing.rpt
report_constraints -all_violators > $report_dir/violations_tight_timing.rpt
report_annotated_parasitics > $report_dir/parasitics_tight_timing.rpt

exit
