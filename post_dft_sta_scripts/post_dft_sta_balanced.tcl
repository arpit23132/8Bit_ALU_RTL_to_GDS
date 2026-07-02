#==============================================================
# Cadence Tempus STA Script - Post-DFT STA (Balanced Case)
# Target Constraint         : Constraint C (8ns Period)
#==============================================================

# CREATE OUTPUT DIRECTORIES IF THEY DO NOT EXIST
if {![file exists post_dft_sta_reports]} {
    file mkdir post_dft_sta_reports
}
if {![file exists post_dft_sta_reports/balanced]} {
    file mkdir post_dft_sta_reports/balanced
}

set report_dir "post_dft_sta_reports/balanced"

#--------------------------------------------------------------
# Read Timing Models and Netlist
#--------------------------------------------------------------
read_lib lib/slow.lib
read_verilog dft_reports/balanced/dft_netlist_balanced.v
set_top_module ALU

#--------------------------------------------------------------
# Read Timing Constraints
#--------------------------------------------------------------
read_sdc dft_reports/balanced/dft_constraints_balanced.sdc

# Disable scan-shift paths to check pure functional timing
set_case_analysis 0 [get_ports scan_en]

#--------------------------------------------------------------
# GBA Timing Reports (Default Mode)
#--------------------------------------------------------------
report_timing -path_type full_clock > $report_dir/gba_setup_post_dft_balanced.rpt
report_timing -early -path_type full_clock > $report_dir/gba_hold_post_dft_balanced.rpt

#--------------------------------------------------------------
# PBA Timing Reports (Path-Based Slew Propagation)
#--------------------------------------------------------------
report_timing -retime path_slew_propagation -max_path 50 -nworst 50 -path_type full_clock > $report_dir/pba_setup_post_dft_balanced.rpt
report_timing -retime path_slew_propagation -early -max_path 50 -nworst 50 -path_type full_clock > $report_dir/pba_hold_post_dft_balanced.rpt

#--------------------------------------------------------------
# Generate Structural, Quality, & Physical Audits
#--------------------------------------------------------------
check_timing > $report_dir/check_timing_post_dft_balanced.rpt
report_clocks > $report_dir/clocks_post_dft_balanced.rpt
report_constraints -all_violators > $report_dir/violations_post_dft_balanced.rpt

exit
