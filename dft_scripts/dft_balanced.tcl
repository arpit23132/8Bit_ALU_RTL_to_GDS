#==============================================================
# Cadence Genus DFT Script - Balanced Case Only
# Mode                      : Legacy UI Forced Fallback
# Target Base Constraint    : Constraint C (design_balanced.sdc)
#==============================================================

# FORCE GENUS TO ACCEPT SENIORS' LEGACY SYNTAX
set_db common_ui false

# CREATE OUTPUT DIRECTORIES IF THEY DO NOT EXIST
if {![file exists dft_reports]} {
    file mkdir dft_reports
}
if {![file exists dft_reports/balanced]} {
    file mkdir dft_reports/balanced
}

set report_dir "dft_reports/balanced"

#--------------------------------------------------------------
# Specify Search Paths & Load Tech Library
#--------------------------------------------------------------
set_attribute lib_search_path ./lib /
set_attribute hdl_search_path ./synthesis_outputs/balanced_case /
set_attribute library slow.lib /

# Read the post-synthesis gate-level netlist (Not RTL)
read_hdl synthesized_netlist_balanced.v
elaborate ALU

# Read the standard reference Constraint C (8ns)
read_sdc synthesis_constraints/design_balanced.sdc
report timing -lint > $report_dir/dft_timing_lint_balanced.rep

#--------------------------------------------------------------
# DFT Configuration & Violation Fixing
#--------------------------------------------------------------
set_attribute dft_scan_style muxed_scan /
define_dft shift_enable -active high -create_port scan_en
define_dft test_clock clk

report dft_setup > $report_dir/dft_setup_balanced.rep
check_dft_rules > $report_dir/dft_rules_balanced.rep

# Fix any mapping and clock/asynchronous resets violations
fix_dft_violations -test_control scan_en -async_set -async_reset -clock

# Map standard flip-flops to scan equivalents
synthesize -to_mapped -incremental

#--------------------------------------------------------------
# Scan Chain Synthesis & Assembly
#--------------------------------------------------------------
set_attribute dft_min_number_of_scan_chains 1 [find / -design *]
set_attribute dft_mix_clock_edges_in_scan_chains true [find / -design *]

# 1. Run connection preview without inline shell redirection
connect_scan_chains -auto_create_chains -preview [find / -design ALU]

# 2. Execute actual scan chain stitching
connect_scan_chains -auto_create_chains [find / -design ALU]

# 3. Report the generated chain structure using the correct tool command
report dft_chains > $report_dir/dft_scan_preview_balanced.rep

report qor > $report_dir/dft_qor_balanced.rep

#--------------------------------------------------------------
# Export Post-DFT Databases
#--------------------------------------------------------------
write_hdl -mapped > $report_dir/dft_netlist_balanced.v
write_scandef > $report_dir/dft_netlist_balanced.def
write_sdc > $report_dir/dft_constraints_balanced.sdc
write_atpg -cadence > $report_dir/atpg_balanced.atpg

#--------------------------------------------------------------
# Export Analysis Reports
#--------------------------------------------------------------
report gates > $report_dir/dft_gates_balanced.rep
report dft_registers > $report_dir/dft_registers_balanced.rep
report timing > $report_dir/dft_timing_balanced.rep
report power > $report_dir/dft_power_balanced.rep
report area > $report_dir/dft_area_balanced.rep
report summary > $report_dir/dft_summary_balanced.rep

exit
