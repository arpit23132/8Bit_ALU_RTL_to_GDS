tcl if {![file exists lec_outputs]} { file mkdir lec_outputs }
tcl if {![file exists lec_outputs/bad_cases]} { file mkdir lec_outputs/bad_cases }

set log file lec_outputs/bad_cases/lec_bad3_wrong_cell.log -replace

read library lib/slow.v -verilog -both

read design rtl/ALU.v -verilog -golden
read design lec_bad_netlists/bad3_wrong_cell.v -verilog -revised

set system mode lec
add compared point -all
compare

report messages -compare -verb
report compare data -noneq
report verification

set verification information lec_outputs/bad_cases/Equivalence_checking_bad3
write verification information
exit
