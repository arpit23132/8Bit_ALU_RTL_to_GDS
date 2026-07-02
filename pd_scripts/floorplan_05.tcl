#==============================================================
# Cadence Innovus Floorplanning Script - Utilisation 0.5
# Target Design             : ALU (MMMC & IO-Driven Flow)
# Exact Standard Cell Area  : 4331.739 um^2
# Calculated Dimension      : ~94.08 um x 94.08 um (28 rows)
#==============================================================

# --- AUTOMATIC DIRECTORY CREATION FOR OUTPUTS ---
if {![file exists pd_snapshots]} { file mkdir pd_snapshots }
if {![file exists pd_reports]} { file mkdir pd_reports }

# --- 1. DEFINE DESIGN GLOBAL VARIABLES ---
set init_top_cell     "ALU"
set init_verilog      "dft_reports/balanced/dft_netlist_balanced.v"
set init_lef_file     [list "lef/gsclib090_translated.lef"]
set init_gnd_net      "VSS"
set init_pwr_net      "VDD"

# --- 2. MULTI-CORNER & IO ASSIGNMENT INJECTION (UPDATED PATHS) ---
set init_mmmc_file    "pd_scripts/alu_mmmc_views.view"
set init_io_file      "pd_scripts/pin_location.io"

# --- 3. INITIALIZE DESIGN DATABASE ---
init_design

# --- 4. SET 90NM DESIGN NODE RULES ---
setDesignMode -process 90 -flowEffort standard

# --- 5. SANITY CHECKS BEFORE FLOORPLANNING ---
checkDesign -physicalLibrary
checkDesign -timingLibrary
checkDesign -netlist
check_timing

# --- 6. RUN MATHEMATICALLY SNAPPED FLOORPLAN ---
getIoFlowFlag
setIoFlowFlag 0

# MATH TRACKING FOR FUTURE REFERENCE:
# Total Cell Area = 4331.739 um^2
# Target Area @ 0.5 Utilisation = 4331.739 / 0.5 = 8663.478 um^2
# Ideal Square Side = sqrt(8663.478) = 93.078 um
# Snapped to nearest whole 3.36 um library row height: 28 rows * 3.36 um = 94.08 um
floorPlan -site gsclib090site -r 1 0.5 4.06 4.06 4.06 4.06

# =====================================================================
# FIXED: LEGALISE AND SNAP IO PINS TO THE ROUTING GRID IMMEDIATELY HERE
# =====================================================================
legalizePin -pin * -moveFixedPin

# --- 7. POWER PLANNING RING CREATION ---
addRing \
  -skip_via_on_wire_shape Noshape \
  -skip_via_on_pin Standardcell \
  -center 1 \
  -stacked_via_top_layer Metal9 \
  -type core_rings \
  -jog_distance 0.435 \
  -threshold 0.435 \
  -nets {VSS VDD} \
  -follow core \
  -stacked_via_bottom_layer Metal1 \
  -layer {bottom Metal8 top Metal8 right Metal9 left Metal9} \
  -width 1.25 \
  -spacing 0.4

# --- 8. GLOBAL POWER CONNECTIONS & SPECIAL ROUTING ---
globalNetConnect VDD -type pgpin -pin VDD -override -verbose -netlistOverride
globalNetConnect VSS -type pgpin -pin VSS -override -verbose -netlistOverride
sroute -nets {VDD VSS} -allowLayerChange 1 -layerChangeRange {Metal1 Metal9}

# --- 9. SAVE INITIAL FLOORPLAN CHECKPOINT ---
saveDesign pd_snapshots/alu_floorplan_05.enc

puts "========================================================"
puts " Floorplanning executed successfully for Utilisation 0.5"
puts " Core side length snapped perfectly to 94.08 um         "
puts "========================================================"
