#==============================================================
# Cadence Innovus Standard Cell Placement Script
# Target Design            : ALU (Utilisation 0.5)
# Exact Standard Cell Area : 4331.739 um^2
# Output Directories       : Synchronized to pd_reports/placement_reports/ & pd_snapshots/
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR REPORTS ---
if {![file exists pd_reports/placement_reports]} { file mkdir pd_reports/placement_reports }

# --- 1. RESTORE THE FLOORPLAN & POWER DATABASE ---
if {[file exists pd_snapshots/alu_floorplan_05.enc.dat]} {
    restoreDesign pd_snapshots/alu_floorplan_05.enc.dat ALU
} else {
    puts "ERROR: Floorplan snapshot not found! Run floorplan_05.tcl first."
    return
}

puts "========================================================"
puts " Starting Timing-Driven Standard Cell Placement...      "
puts "========================================================"

# --- 2. DEFINE DFT SCAN CHAINS BEFORE PLACEMENT ---
# Defining the structural paths of the scan chains to prevent placement QoR degradation
specifyScanChain scan1 -start DFT_sdi_1 -stop DFT_sdo_1
specifyScanChain scan2 -start DFT_sdi_2 -stop DFT_sdo_2

# --- 3. RUN LEGAL PLACEMENT ---
setPlaceMode -fp false
placeDesign

# --- 4. PARASITIC EXTRACTION & TIMING DESIGN SIGNALS ---
# Extracting virtual RC parasitics right after placement
extractRC
rcOut -spef pd_reports/placement_reports/alu_placement.spef

# Writing out the ideal-clock SDF for placement timing verification
write_sdf -ideal_clock_network pd_reports/placement_reports/physical_design_alu_placed.sdf

# --- 5. GENERATE CLEAN PLACEMENT DESIGN REPORTS ---
puts "========================================================"
puts " Generating Post-Placement Reports in placement_reports/... "
puts "========================================================"

# Physical, structural and connectivity verifications
verify_drc         > pd_reports/placement_reports/placement_DRC_vio.rpt
verifyConnectivity > pd_reports/placement_reports/placement_connectivity.rpt
reportRoute        > pd_reports/placement_reports/placement_reportRoute.rpt
reportWire         > pd_reports/placement_reports/placement_reportWire.rpt
summaryReport -outdir pd_reports/placement_reports/summaryReport

# Pre-CTS timing evaluation based on virtual trial routing
report_timing -early -view view1 -max_paths 100 > pd_reports/placement_reports/timing_post_placement_early.txt
report_timing -late  -view view1 -max_paths 100 > pd_reports/placement_reports/timing_post_placement_late.txt

# Area, power, and gate counting logs
report_area -detail                             > pd_reports/placement_reports/area_post_placement.rpt
reportGateCount -level 5 -limit 100 -outfile     pd_reports/placement_reports/gate_count_post_placement.rpt
report_power -rail_analysis_format VS -outfile  pd_reports/placement_reports/power_post_placement.rpt

# --- 6. SAVE PLACEMENT SNAPSHOT CHECKPOINT ---
saveDesign pd_snapshots/alu_placement_05.enc

puts "========================================================"
puts " Placement executed successfully for Utilisation 0.5    "
puts " Snapshot saved cleanly to pd_snapshots/                "
puts "========================================================"
