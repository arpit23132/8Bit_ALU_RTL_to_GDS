#==============================================================
# Cadence Innovus Global & Detailed Routing Script
# Target Design            : ALU (Utilisation 0.5)
# Stage                    : Physical Interconnect Wire Routing
# Clean Structure          : All reports unified under pd_reports/
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR ROUTING ---
# FIXED: Moved completely out of the root directory and structured under pd_reports/
if {![file exists pd_reports/post_route_reports/timing]} { file mkdir pd_reports/post_route_reports/timing }
if {![file exists pd_reports/post_route_reports/area]}   { file mkdir pd_reports/post_route_reports/area }

# --- 1. RESTORE THE REPAIRED CTS DATABASE ---
if {[file exists pd_snapshots/alu_cts_repaired_05.enc.dat]} {
    restoreDesign pd_snapshots/alu_cts_repaired_05.enc.dat ALU
} else {
    puts "ERROR: Repaired CTS snapshot not found! Run cts_repair.tcl first."
    return
}

puts "========================================================"
puts " Starting Global and Detailed Routing...                "
puts "========================================================"

# --- 2. EXACT NANOROUTE ENGINE MODE CONFIGURATIONS ---
setNanoRouteMode -quiet -timingEngine {}
setNanoRouteMode -quiet -routeWithSiPostRouteFix 0
setNanoRouteMode -quiet -drouteStartIteration default
setNanoRouteMode -quiet -routeTopRoutingLayer default
setNanoRouteMode -quiet -routeBottomRoutingLayer default
setNanoRouteMode -quiet -drouteEndIteration default
setNanoRouteMode -quiet -routeWithTimingDriven false
setNanoRouteMode -quiet -routeWithSiDriven false

# --- 3. RUN PHYSICAL INTERCONNECT ROUTING ---
routeDesign -globalDetail

# --- 4. GENERATE CLEAN REPORTS UNDER PD_REPORTS ---
puts "========================================================"
puts " Generating Post-Routing Verification Reports...       "
puts "========================================================"

# Early/Hold timing analysis under actual distributed metal network delays
report_timing -early -view {view1} -max_paths 100 > pd_reports/post_route_reports/timing/timing_post_PnR_early.txt

# Late/Setup timing analysis
report_timing -late  -max_paths 100 > pd_reports/post_route_reports/timing/timing_post_PnR_late.txt

# Physical gate area and utilization breakdown
report_area -detail > pd_reports/post_route_reports/area/area_post_pnr4.rpt

# Core power analysis
report_power -rail_analysis_format VS -outfile pd_reports/post_route_reports/routeafteranalysis.rpt

# --- 5. SAVE ROUTED DESIGN SNAPSHOT ---
saveDesign pd_snapshots/alu_routed_05.enc

puts "========================================================"
puts " Routing executed successfully!                          "
puts " Snapshot saved cleanly to pd_snapshots/alu_routed_05.enc"
puts "========================================================"
