#==============================================================
# Cadence Innovus Clock Tree DRV Repair & Refinement Script
# Target Design            : ALU (Utilisation 0.5)
# Stage                    : Max Transition, Capacitance & Skew Repair
# Output Directories       : Synchronized to pd_reports/cts_repair_reports/ & pd_snapshots/
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR REPAIR REPORTS ---
if {![file exists pd_reports/cts_repair_reports]} { file mkdir pd_reports/cts_repair_reports }

# --- 1. RESTORE THE OPTIMIZED CTS DATABASE ---
# FIXED: Pointing cleanly to the flat pd_snapshots/ directory
if {[file exists pd_snapshots/alu_cts_opt_05.enc.dat]} {
    restoreDesign pd_snapshots/alu_cts_opt_05.enc.dat ALU
} else {
    puts "ERROR: Optimized CTS snapshot not found! Run cts_opt.tcl first."
    return
}

puts "========================================================"
puts " Starting Clock Tree DRV Repair & Refinement...         "
puts "========================================================"

# --- 2. EXECUTE ADVANCED CLOCK TREE DRC & SKEW REPAIR ---
# Enabling transition, capacitance, skew, and placement refinement via rebuffering
ccopt_pro \
  -enable_drv_fixing true \
  -enable_drv_fixing_by_rebuffering true \
  -enable_refine_place true \
  -enable_routing_eco true \
  -enable_skew_fixing true \
  -enable_skew_fixing_by_rebuffering true \
  -enable_timing_update true

# --- 3. GENERATE POST-REPAIR DESIGN REPORTS ---
puts "========================================================"
puts " Generating Post-Repair Verification Reports...         "
puts "========================================================"

# Final pre-route structural timing evaluations
report_timing -early -view {view1} -max_paths 100 > pd_reports/cts_repair_reports/timing_post_repair_early.txt
report_timing -late  -view {view1} -max_paths 100 > pd_reports/cts_repair_reports/timing_post_repair_late.txt

# Track physical area distribution after clock tree sizing
report_area -detail > pd_reports/cts_repair_reports/area_post_repair.rpt

# --- 4. SAVE REPAIRED CTS DESIGN SNAPSHOT ---
saveDesign pd_snapshots/alu_cts_repaired_05.enc

puts "========================================================"
puts " Clock Tree DRV Repair executed successfully!           "
puts " Snapshot saved cleanly to pd_snapshots/                "
puts "========================================================"
