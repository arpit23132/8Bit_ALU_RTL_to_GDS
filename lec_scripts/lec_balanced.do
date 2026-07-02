//==============================================================
// Cadence Conformal LEC Script
// Evaluation Case   : Balanced Case (Golden RTL vs. Netlist)
// Project             : 8-bit ALU
//==============================================================

// CREATE OUTPUT DIRECTORIES IF THEY DO NOT EXIST
// Using Tcl interpreter blocks inside Conformal to handle directory structure
tcl if {![file exists lec_outputs]} { file mkdir lec_outputs }
tcl if {![file exists lec_outputs/balanced]} { file mkdir lec_outputs/balanced }

// Setup logging environment now that the path is guaranteed
set log file lec_outputs/balanced/lec_balanced.log -replace

//--------------------------------------------------------------
// Read Technology Library
//--------------------------------------------------------------
// Loads foundational standard-cell models into both design containers
read library lib/slow.v -verilog -both

//--------------------------------------------------------------
// Read Design Files
//--------------------------------------------------------------
// Reads the original high-level Golden Verilog RTL implementation
read design rtl/ALU.v -verilog -golden

// Reads the structural Revised Post-Synthesis netlist containing foundry cells
read design synthesis_outputs/balanced_case/synthesized_netlist_balanced.v -verilog -revised

//--------------------------------------------------------------
// Mapping and Formal Comparison Execution
//--------------------------------------------------------------
// Switches the tool from Setup mode into Logic Equivalence Checking (LEC) mode
set system mode lec

// Automatically identifies and binds corresponding key points (DFFs, Ports) between designs
add compared point -all

// Invokes the math engines to exhaustively prove structural equivalence
compare

//--------------------------------------------------------------
// Generate Verification Reports
//--------------------------------------------------------------
// Outputs verbal compilation statistics and structural gate messages
report messages -compare -verb

// Details internal logic cones or pin errors if non-equivalence is encountered
report compare data -noneq

// Summarizes the final evaluation verdict (EQUIVALENT or NON-EQUIVALENT)
report verification

//--------------------------------------------------------------
// Export Verification Database & Exit
//--------------------------------------------------------------
// Archives the formal session state into a dedicated verification information directory
set verification information lec_outputs/balanced/Equivalence_checking_balanced
write verification information

// Gracefully exits the Conformal engine
exit
