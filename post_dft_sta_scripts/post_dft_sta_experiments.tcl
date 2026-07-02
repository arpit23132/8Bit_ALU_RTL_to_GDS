#==============================================================
# Cadence Tempus STA Script - Post-DFT Slew & Load Experiment
# Target Constraint         : Constraint C (8ns Period)
#==============================================================

# CREATE OUTPUT DIRECTORIES IF THEY DO NOT EXIST
if {![file exists post_dft_sta_reports]} {
    file mkdir post_dft_sta_reports
}
if {![file exists post_dft_sta_reports/experiments]} {
    file mkdir post_dft_sta_reports/experiments
}

set report_dir "post_dft_sta_reports/experiments"

# Read Design Database
read_lib lib/slow.lib
read_verilog dft_reports/balanced/dft_netlist_balanced.v
set_top_module ALU
read_sdc dft_reports/balanced/dft_constraints_balanced.sdc

# Disable scan-shift paths to check pure functional timing
set_case_analysis 0 [get_ports scan_en]

#--------------------------------------------------------------
# Execute Slew (0 / 0.4 / 0.8 ns) and Load (0 / 1 / 2 pF) Loops
#--------------------------------------------------------------
foreach slew {0.0 0.4 0.8} {
    foreach load {0.0 1.0 2.0} {
        set_input_transition $slew [all_inputs]
        set_load $load [all_outputs]
        report_timing -path_type full_clock > $report_dir/sweep_slew_${slew}_load_${load}_post_dft_balanced.rpt
    }
}

exit
