#==============================================================
# Cadence Innovus Signoff & GDSII Generation Script
# Target Design            : ALU (Utilisation 0.5)
# Stage                    : Stream Out, Netlist & DEF Export
# Clean Structure          : All final outputs unified under pd_reports/
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR FINAL OUTPUTS ---
# FIXED: Moved completely out of the root directory and structured under pd_reports/
if {![file exists pd_reports/signoff_outputs/GDS]}     { file mkdir pd_reports/signoff_outputs/GDS }
if {![file exists pd_reports/signoff_outputs/netlist]} { file mkdir pd_reports/signoff_outputs/netlist }
if {![file exists pd_reports/signoff_outputs/reports]} { file mkdir pd_reports/signoff_outputs/reports }

# --- 1. RESTORE THE ROUTED DATABASE ---
if {[file exists pd_snapshots/alu_routed_05.enc.dat]} {
    restoreDesign pd_snapshots/alu_routed_05.enc.dat ALU
} else {
    puts "ERROR: Routed snapshot not found! Run routing.tcl first."
    return
}

puts "========================================================"
puts " Starting Final Signoff Verification...                  "
puts "========================================================"

# --- 2. FINAL PHYSICAL VERIFICATION CHECKS ---
# FIXED: Logs routed directly inside the clean pd_reports folder tree
verify_drc > pd_reports/signoff_outputs/reports/signoff_DRC_vio.rpt
verifyConnectivity > pd_reports/signoff_outputs/reports/signoff_verifyConnectivity.rpt

# --- 3. EXPORT FINAL DESIGN ARTIFACTS ---
puts "========================================================"
puts " Streaming Out Final Design Databases...                "
puts "========================================================"

# Saving the final physical layout stream file (GDSII)
# FIXED: GDS file output cleanly targeted inside pd_reports/
streamOut pd_reports/signoff_outputs/GDS/alu_final_05.gds -mapFile streamOut.map -libName DesignLib -units 2000 -mode ALL

# Saving the structural gate-level verilog netlist
# FIXED: Structural verilog backup targeted inside pd_reports/
saveNetlist pd_reports/signoff_outputs/netlist/alu_post_route_netlist.v

# Exporting the physical DEF file capturing floorplan, netlist, and routing geometry
# FIXED: Physical DEF layout structure targeted inside pd_reports/
defOut -floorplan -netlist -routing pd_reports/signoff_outputs/netlist/alu_final.def

# --- 4. SAVE FINAL SESSION CHECKPOINT ---
saveDesign pd_snapshots/alu_completed_signoff_05.enc

puts "========================================================"
puts " Physical Design Flow Completed Successfully!            "
puts " Final GDS: pd_reports/signoff_outputs/GDS/alu_final_05.gds "
puts "========================================================"
