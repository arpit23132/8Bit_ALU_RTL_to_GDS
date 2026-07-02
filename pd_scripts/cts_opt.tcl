#==============================================================
# Cadence Innovus Post-CTS Timing Optimization Script
# Target Design            : ALU (Utilisation 0.5)
# Stage                    : Setup & Hold DRC Slack Correction
# Output Directories       : Synchronized to pd_reports/optimised_cts_reports/ & pd_snapshots/
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR OPTIMIZATION REPORTS ---
if {![file exists pd_reports/optimised_cts_reports]} { file mkdir pd_reports/optimised_cts_reports }

# --- 1. RESTORE THE CTS DATABASE ---
if {[file exists pd_snapshots/alu_cts_05.enc.dat]} {
    restoreDesign pd_snapshots/alu_cts_05.enc.dat ALU
} else {
    puts "ERROR: CTS snapshot not found! Run cts.tcl first."
    return
}

puts "========================================================"
puts " Starting Post-CTS Timing Optimization...               "
puts "========================================================"

# --- 2. RUN SETUP AND HOLD OPTIMIZATION ---
# Optimizing setup timing violations based on the real clock tree
puts "-> Fixing Setup Violations..."
optDesign -postCTS

# Optimizing hold timing violations by padding logic paths with minimum delay cells
puts "-> Fixing Hold Violations..."
optDesign -postCTS -hold

# --- 3. GENERATE POST-OPTIMIZATION TIMING & DESIGN LOGS ---
puts "========================================================"
puts " Generating Post-CTS Optimization Reports...           "
puts "========================================================"

# Timing reports with propagating actual clock network effects
report_timing -early -view {view1} -max_paths 100 > pd_reports/optimised_cts_reports/timing_post_cts_opt_early.txt
report_timing -late  -view {view1} -max_paths 100 > pd_reports/optimised_cts_reports/timing_post_cts_opt_late.txt

# Track physical area inflation due to potential hold-buffer insertions
report_area -detail                           > pd_reports/optimised_cts_reports/area_post_cts_opt.rpt
report_power -rail_analysis_format VS -outfile pd_reports/optimised_cts_reports/power_post_cts_opt.rpt

# --- 4. SAVE OPTIMIZED CTS SNAPSHOT ---
saveDesign pd_snapshots/alu_cts_opt_05.enc

puts "========================================================"
puts " Post-CTS Optimization completed successfully!          "
puts " Snapshot saved cleanly to pd_snapshots/                "
puts "========================================================"
