#==============================================================
# Cadence Innovus Clock Tree Synthesis (CTS) Script
# Target Design            : ALU (Utilisation 0.5)
# Sequential Flop Count   : 152 Flops
# Output Directories       : Synchronized to pd_reports/cts_reports/ & pd_snapshots/
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR CTS REPORTS ---
if {![file exists pd_reports/cts_reports]} { file mkdir pd_reports/cts_reports }

# --- 1. RESTORE THE PLACEMENT DATABASE ---
if {[file exists pd_snapshots/alu_placement_05.enc.dat]} {
    restoreDesign pd_snapshots/alu_placement_05.enc.dat ALU
} else {
    puts "ERROR: Placement snapshot not found! Run placement.tcl first."
    return
}

puts "========================================================"
puts " Starting Clock Tree Synthesis (CTS)...                 "
puts "========================================================"

# --- 2. CONFIGURE CCOPT PROPERTIES & CHOOSE CLOCK BUFFERS ---
# Using the modern set_ccopt_property syntax to avoid the obsolete warning
set_ccopt_property buffer_cells {CLKBUFX3 CLKBUFX2 CLKBUFX8 CLKBUFX12 CLKBUFX16 CLKBUFX20 CLKINVX3 CLKINVX2 CLKINVX8 CLKINVX12 CLKINVX16}

# --- 3. GENERATE AND LOAD CLOCK SPECIFICATION ---
# FIXED: Changed -views {views} to the correct analysis view name: {view1}
create_ccopt_clock_tree_spec -file pd_scripts/ccopt_alu.spec -keep_all_sdc_clocks -views {view1}
source pd_scripts/ccopt_alu.spec

# --- 4. RUN CLOCK TREE SYNTHESIS ---
ccopt_design -check_prerequisites
ccopt_design

# --- 5. GENERATE CLEAN POST-CTS REPORTS ---
puts "========================================================"
puts " Generating Post-CTS Verification Reports...            "
puts "========================================================"

# Post-CTS timing evaluation accounting for insertion delay and real clock skew
report_timing -early -view {view1} -max_paths 100 > pd_reports/cts_reports/timing_post_cts_early.txt
report_timing -late  -view {view1} -max_paths 100 > pd_reports/cts_reports/timing_post_cts_late.txt

# Core area and power tracking logs
report_area -detail                           > pd_reports/cts_reports/area_post_cts.rpt
report_power -rail_analysis_format VS -outfile pd_reports/cts_reports/power_post_cts.rpt

# --- 6. SAVE CTS DATABASE SNAPSHOT ---
saveDesign pd_snapshots/alu_cts_05.enc

puts "========================================================"
puts " Clock Tree Synthesis executed successfully!             "
puts " Snapshot saved cleanly to pd_snapshots/alu_cts_05.enc  "
puts "========================================================"
