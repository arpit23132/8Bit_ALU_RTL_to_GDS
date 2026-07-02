#==============================================================
# Cadence Genus Synthesis Script
# Optimization Case   : Balanced Target (design_balanced.sdc)
# Project             : 8-bit ALU
#==============================================================

# CREATE OUTPUT DIRECTORIES IF THEY DO NOT EXIST
# Checks for the master 'synthesis_outputs' folder and the nested 
# 'balanced_case' sub-folder to prevent tool crashes during file generation.
if {![file exists synthesis_outputs]} {
    file mkdir synthesis_outputs
}
if {![file exists synthesis_outputs/balanced_case]} {
    file mkdir synthesis_outputs/balanced_case
}

#--------------------------------------------------------------
# Specify search paths
#--------------------------------------------------------------
# lib_search_path points Genus to directories containing technology libraries (.lib)
set_db lib_search_path ./lib

# hdl_search_path points Genus to directories containing original Verilog/VHDL files
set_db hdl_search_path ./rtl

#--------------------------------------------------------------
# Load technology library
#--------------------------------------------------------------
# Maps generic RTL logic into specific standard cells defined in this foundry target library
set_db library slow.lib

#--------------------------------------------------------------
# Read RTL source
#--------------------------------------------------------------
# Parses the high-level Verilog code and checks for syntax/structural errors
read_hdl ALU.v

#--------------------------------------------------------------
# Elaborate RTL (Explicitly specifying the top module)
#--------------------------------------------------------------
# Builds a generic gate-level architecture and resolves hierarchy for the top 'ALU' module
elaborate ALU

#--------------------------------------------------------------
# Read timing constraints
#--------------------------------------------------------------
# Inputs the Synopsys Design Constraints (SDC) file targeting balanced area-delay requirements
read_sdc ./synthesis_constraints/design_balanced.sdc

#--------------------------------------------------------------
# Perform synthesis (RTL to Generic, then Generic to Mapped)
#--------------------------------------------------------------
# syn_generic optimizes RTL and translates it into technology-independent generic gates
syn_generic

# syn_map maps those generic gates onto the specific technology standard cells from slow.lib
syn_map

#--------------------------------------------------------------
# Generate SDF file
#--------------------------------------------------------------
# write_sdf outputs the Standard Delay Format (SDF) file 
# (Contains the delays of gates and interconnections, used for accurate gate-level timing simulation.)
write_sdf \
-timescale ns \
-nonegchecks \
-recrem split \
-edges check_edge \
> synthesis_outputs/balanced_case/delays_balanced.sdf

#--------------------------------------------------------------
# Write synthesized Verilog netlist
#--------------------------------------------------------------
# Generates the post-synthesis structural Verilog file
# (Consists purely of interconnected foundry standard cells; used as input for Physical Design/Innovus)
write_hdl > synthesis_outputs/balanced_case/synthesized_netlist_balanced.v

#--------------------------------------------------------------
# Export SDC for Physical Design (Innovus)
#--------------------------------------------------------------
# Writes out updated constraints reflecting post-synthesis clock definitions and paths 
# (Crucial for driving timing closure during placement and routing in Innovus)
write_sdc > synthesis_outputs/balanced_case/design_post_synthesis_balanced.sdc

#--------------------------------------------------------------
# Save synthesis script/database
#--------------------------------------------------------------
# Exports a reconstructed execution script tracking the complete tool state and constraints applied
write_script > synthesis_outputs/balanced_case/synthesis_script_balanced.tcl

#--------------------------------------------------------------
# Generate Reports
#--------------------------------------------------------------
# report timing analyzes setup/hold slacks and highlights the critical timing paths
report timing > synthesis_outputs/balanced_case/timing_report_balanced.rep

# report power calculates estimated static (leakage) and dynamic switching power consumption
report power  > synthesis_outputs/balanced_case/power_report_balanced.rep

# report gates breakdowns standard cell types utilized, cell count, and total instances
report gates  > synthesis_outputs/balanced_case/cell_report_balanced.rep

# report area computes the total silicon area footprint (combinational + sequential + net area)
report area   > synthesis_outputs/balanced_case/area_report_balanced.rep

#--------------------------------------------------------------
# Open Genus GUI (Optional)
#--------------------------------------------------------------
# Launches the graphical user interface to visually inspect schematic logic and slack histograms
gui_show
