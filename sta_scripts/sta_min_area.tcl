#==============================================================
# Cadence Tempus STA Script - Netlist A (Min Area Case)
# Target Constraint         : Constraint C (8ns Period)
#==============================================================

#--------------------------------------------------------------
# Create Output Directories
#--------------------------------------------------------------
# Create the report directories only if they do not already exist.
# This prevents file generation errors when Tempus attempts to
# write timing reports into non-existent folders.
if {![file exists sta_reports]} {
    file mkdir sta_reports
}
if {![file exists sta_reports/min_area]} {
    file mkdir sta_reports/min_area
}

# Stores the destination path used by all report commands below.
set report_dir "sta_reports/min_area"

#--------------------------------------------------------------
# Read Timing Library and Synthesized Netlist
#--------------------------------------------------------------
# Load the Liberty timing library containing cell delay,
# timing arc, slew, capacitance, and power models used for
# static timing analysis.
read_lib lib/slow.lib

# Read the synthesized gate-level Verilog netlist generated
# during synthesis. This netlist consists of standard cells
# mapped from the RTL description.
read_verilog synthesis_outputs/min_area_case/synthesized_netlist_min_area.v

# Specify the top-level design module on which STA will be performed.
set_top_module ALU

#--------------------------------------------------------------
# Read Timing Constraints
#--------------------------------------------------------------
# Import the Synopsys Design Constraints (SDC) file.
# The SDC defines the operating environment for STA, including
# clock definitions, input/output delays, timing exceptions,
# clock uncertainty, and other design constraints.
read_sdc synthesis_constraints/design_balanced.sdc

#--------------------------------------------------------------
# Generate GBA (Graph-Based Analysis) Timing Reports
#--------------------------------------------------------------
# Graph-Based Analysis computes arrival and required times using
# conservative graph traversal. It is computationally efficient
# and is typically used as the default timing analysis method.
#
# Generate the worst setup timing paths.
report_timing > $report_dir/gba_setup_min_area.rpt

# Generate the worst hold timing paths using early-mode analysis.
report_timing -early > $report_dir/gba_hold_min_area.rpt

#--------------------------------------------------------------
# Generate PBA (Path-Based Analysis) Timing Reports
#--------------------------------------------------------------
# Path-Based Analysis performs detailed timing computation on
# complete timing paths instead of independent graph segments.
# Since reconvergent paths are analyzed together, PBA generally
# reports less pessimistic and more accurate slack values than GBA.
#
# -retime path_slew_propagation enables accurate slew propagation
# along the selected timing path.
#
# -max_path 50 limits the report to the 50 worst timing paths.
#
# -nworst 50 requests timing information for the 50 worst paths.
#
# -path_type full_clock reports the complete timing path,
# including the launch clock path, data path, and capture clock path.

# Generate setup timing report using Path-Based Analysis.
report_timing -retime path_slew_propagation \
   -max_path 50 -nworst 50 -path_type full_clock > $report_dir/pba_setup_min_area.rpt

# Generate hold timing report using Path-Based Analysis.
report_timing -retime path_slew_propagation -early \
   -max_path 50 -nworst 50 -path_type full_clock > $report_dir/pba_hold_min_area.rpt

#--------------------------------------------------------------
# Generate Design Quality and Timing Audit Reports
#--------------------------------------------------------------

# Performs consistency checks on the timing database and reports
# missing clocks, unconstrained paths, invalid timing definitions,
# or any other issues that could affect STA accuracy.
check_timing > $report_dir/check_timing_min_area.rpt

# Reports all clocks present in the design, including their
# periods, waveforms, generated clocks, uncertainties,
# and propagation information.
report_clocks > $report_dir/clocks_min_area.rpt

# Lists all timing constraints that are currently violated,
# including setup and hold violations with their slack values.
report_constraints -all_violators > $report_dir/violations_min_area.rpt

# Reports the parasitic information (wire resistance and
# capacitance) annotated onto the design. If no extracted
# parasitics are available, this report indicates the current
# parasitic status used during timing analysis.
report_annotated_parasitics > $report_dir/parasitics_min_area.rpt

# Exit Tempus after all reports have been successfully generated.
exit
