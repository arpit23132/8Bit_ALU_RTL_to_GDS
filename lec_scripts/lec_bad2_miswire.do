tcl if {![file exists lec_outputs]} { file mkdir lec_outputs }
tcl if {![file exists lec_outputs/bad_cases]} { file mkdir lec_outputs/bad_cases }

set log file lec_outputs/bad_cases/lec_bad2_miswire.log -replace

read library lib/slow.v -verilog -both

read design rtl/ALU.v -verilog -golden
read design lec_bad_netlists/bad2_miswire.v -verilog -revised

set system mode lec
add compared point -all
compare

report messages -compare -verb
report compare data -noneq
report verification

set verification information lec_outputs/bad_cases/Equivalence_checking_bad2
write verification information
exit
