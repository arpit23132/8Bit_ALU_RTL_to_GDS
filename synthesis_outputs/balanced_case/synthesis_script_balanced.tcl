######################################################################

# Created by Genus(TM) Synthesis Solution 19.13-s073_1 on Mon Jun 29 02:44:57 IST 2026

# This file contains the RC script for design:ALU

######################################################################

set_db -quiet init_lib_search_path ./lib
set_db -quiet design_mode_process no_value
set_db -quiet phys_assume_met_fill 0.0
set_db -quiet map_placed_for_hum false
set_db -quiet phys_use_invs_extraction true
set_db -quiet phys_route_time_out 120.0
set_db -quiet capacitance_per_unit_length_mmmc {}
set_db -quiet resistance_per_unit_length_mmmc {}
set_db -quiet runtime_by_stage {{PBS_Generic-Start 0 15 0.0 6.0} {to_generic 1 17 1 7} {first_condense 2 19 3 11} {PBS_Generic_Opt-Post 4 19 3.2292620000000003 9.229262} {{PBS_Generic-Postgen HBO Optimizations} 0 20 0.0 9.229262} {PBS_TechMap-Start 0 20 0.0 10.229262} {{PBS_TechMap-Premap HBO Optimizations} 0 20 0.0 10.229262} {second_condense 2 22 3 15} {reify 5 27 10 26} {global_incr_map 1 28 0 26} {{PBS_Techmap-Global Mapping} 8 28 7.462650000000002 17.691912000000002} {{PBS_TechMap-Datapath Postmap Operations} 1 29 0.9869190000000003 18.678831000000002} {{PBS_TechMap-Postmap HBO Optimizations} 0 29 -0.013071000000003608 18.66576} {{PBS_TechMap-Postmap Clock Gating} 0 29 0.0 18.66576} {{PBS_TechMap-Postmap Cleanup} 0 29 -0.012155999999997391 18.653604} {PBS_Techmap-Post_MBCI 0 29 0.0 18.653604}}
set_db -quiet tinfo_tstamp_file .rs_arpit23132.tstamp
set_db -quiet metric_enable true
set_db -quiet flow_metrics_snapshot_uuid b35e3496-28a0-404c-b874-54ca9482a4e9
set_db -quiet phys_use_segment_parasitics true
set_db -quiet probabilistic_extraction true
set_db -quiet ple_correlation_factors {1.9000 2.0000}
set_db -quiet maximum_interval_of_vias inf
set_db -quiet layer_aware_buffer true
set_db -quiet interconnect_mode wireload
set_db -quiet wireload_mode enclosed
set_db -quiet wireload_selection none
set_db -quiet operating_condition:default_emulate_libset_max/slow/slow .tree_type balanced_tree
set_db -quiet operating_condition:default_emulate_libset_max/slow/_nominal_ .tree_type balanced_tree
# BEGIN MSV SECTION
# END MSV SECTION
define_clock -name clk -domain domain_1 -period 8000.0 -divide_period 1 -rise 0 -divide_rise 1 -fall 1 -divide_fall 2 -remove -design design:ALU port:ALU/clk
set_db -quiet clock:ALU/clk .slew {400.0 400.0 400.0 400.0}
set_db -quiet clock:ALU/clk .clock_setup_uncertainty {400.0 400.0}
define_cost_group -design design:ALU -name clk
external_delay -accumulate -input {0.0 no_value 0.0 no_value} -clock clock:ALU/clk -name create_clock_delay_domain_1_clk_R_0 port:ALU/clk
set_db -quiet external_delay:ALU/create_clock_delay_domain_1_clk_R_0 .clock_network_latency_included true
external_delay -accumulate -input {no_value 0.0 no_value 0.0} -clock clock:ALU/clk -edge_fall -name create_clock_delay_domain_1_clk_F_0 port:ALU/clk
set_db -quiet external_delay:ALU/create_clock_delay_domain_1_clk_F_0 .clock_network_latency_included true
path_group -paths [specify_paths -to clock:ALU/clk]  -name clk -group cost_group:ALU/clk -user_priority -1047552
# BEGIN DFT SECTION
set_db -quiet dft_scan_style muxed_scan
set_db -quiet dft_scanbit_waveform_analysis false
identify_multibit_cell_abstract_scan_segments -design design:ALU
# END DFT SECTION
set_db -quiet design:ALU .seq_reason_deleted_internal {}
set_db -quiet design:ALU .qos_by_stage {{to_generic {wns -11111111} {tns -111111111} {vep -111111111} {area 12340} {cell_count 1454} {utilization  0.00} {runtime 1 17 1 7} }{first_condense {wns -11111111} {tns -111111111} {vep -111111111} {area 12260} {cell_count 1521} {utilization  0.00} {runtime 2 19 3 11} }{second_condense {wns -11111111} {tns -111111111} {vep -111111111} {area 12164} {cell_count 1508} {utilization  0.00} {runtime 2 22 3 15} }{reify {wns 1294} {tns 0} {vep 0} {area 4283} {cell_count 649} {utilization  0.00} {runtime 5 27 10 26} }{global_incr_map {wns 486} {tns 0} {vep 0} {area 4204} {cell_count 637} {utilization  0.00} {runtime 1 28 0 26} }}
set_db -quiet design:ALU .seq_mbci_coverage 0.0
set_db -quiet design:ALU .hdl_filelist {{default -v2001 {SYNTHESIS} {rtl/ALU.v} {./rtl} {}}}
set_db -quiet design:ALU .hdl_user_name ALU
set_db -quiet design:ALU .verification_directory fv/ALU
set_db -quiet design:ALU .lp_clock_gating_max_flops inf
set_db -quiet {port:ALU/in1[7]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[7]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[7]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[7]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[7]} .original_name {in1[7]}
set_db -quiet {port:ALU/in1[6]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[6]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[6]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[6]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[6]} .original_name {in1[6]}
set_db -quiet {port:ALU/in1[5]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[5]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[5]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[5]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[5]} .original_name {in1[5]}
set_db -quiet {port:ALU/in1[4]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[4]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[4]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[4]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[4]} .original_name {in1[4]}
set_db -quiet {port:ALU/in1[3]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[3]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[3]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[3]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[3]} .original_name {in1[3]}
set_db -quiet {port:ALU/in1[2]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[2]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[2]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[2]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[2]} .original_name {in1[2]}
set_db -quiet {port:ALU/in1[1]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[1]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[1]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[1]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[1]} .original_name {in1[1]}
set_db -quiet {port:ALU/in1[0]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in1[0]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in1[0]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in1[0]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in1[0]} .original_name {in1[0]}
set_db -quiet {port:ALU/in2[7]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[7]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[7]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[7]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[7]} .original_name {in2[7]}
set_db -quiet {port:ALU/in2[6]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[6]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[6]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[6]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[6]} .original_name {in2[6]}
set_db -quiet {port:ALU/in2[5]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[5]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[5]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[5]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[5]} .original_name {in2[5]}
set_db -quiet {port:ALU/in2[4]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[4]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[4]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[4]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[4]} .original_name {in2[4]}
set_db -quiet {port:ALU/in2[3]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[3]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[3]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[3]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[3]} .original_name {in2[3]}
set_db -quiet {port:ALU/in2[2]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[2]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[2]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[2]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[2]} .original_name {in2[2]}
set_db -quiet {port:ALU/in2[1]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[1]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[1]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[1]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[1]} .original_name {in2[1]}
set_db -quiet {port:ALU/in2[0]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/in2[0]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/in2[0]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/in2[0]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/in2[0]} .original_name {in2[0]}
set_db -quiet port:ALU/clk .original_name clk
set_db -quiet port:ALU/rst .original_name rst
set_db -quiet {port:ALU/sel[3]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/sel[3]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/sel[3]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/sel[3]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/sel[3]} .original_name {sel[3]}
set_db -quiet {port:ALU/sel[2]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/sel[2]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/sel[2]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/sel[2]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/sel[2]} .original_name {sel[2]}
set_db -quiet {port:ALU/sel[1]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/sel[1]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/sel[1]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/sel[1]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/sel[1]} .original_name {sel[1]}
set_db -quiet {port:ALU/sel[0]} .input_slew_max_rise 200.0
set_db -quiet {port:ALU/sel[0]} .input_slew_max_fall 200.0
set_db -quiet {port:ALU/sel[0]} .input_slew_min_rise 200.0
set_db -quiet {port:ALU/sel[0]} .input_slew_min_fall 200.0
set_db -quiet {port:ALU/sel[0]} .original_name {sel[0]}
set_db -quiet {port:ALU/out1[7]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[7]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[7]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[7]} .original_name {out1[7]}
set_db -quiet {port:ALU/out1[7]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[6]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[6]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[6]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[6]} .original_name {out1[6]}
set_db -quiet {port:ALU/out1[6]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[5]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[5]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[5]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[5]} .original_name {out1[5]}
set_db -quiet {port:ALU/out1[5]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[4]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[4]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[4]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[4]} .original_name {out1[4]}
set_db -quiet {port:ALU/out1[4]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[3]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[3]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[3]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[3]} .original_name {out1[3]}
set_db -quiet {port:ALU/out1[3]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[2]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[2]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[2]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[2]} .original_name {out1[2]}
set_db -quiet {port:ALU/out1[2]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[1]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[1]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[1]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[1]} .original_name {out1[1]}
set_db -quiet {port:ALU/out1[1]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out1[0]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out1[0]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out1[0]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out1[0]} .original_name {out1[0]}
set_db -quiet {port:ALU/out1[0]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[7]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[7]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[7]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[7]} .original_name {out2[7]}
set_db -quiet {port:ALU/out2[7]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[6]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[6]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[6]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[6]} .original_name {out2[6]}
set_db -quiet {port:ALU/out2[6]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[5]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[5]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[5]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[5]} .original_name {out2[5]}
set_db -quiet {port:ALU/out2[5]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[4]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[4]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[4]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[4]} .original_name {out2[4]}
set_db -quiet {port:ALU/out2[4]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[3]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[3]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[3]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[3]} .original_name {out2[3]}
set_db -quiet {port:ALU/out2[3]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[2]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[2]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[2]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[2]} .original_name {out2[2]}
set_db -quiet {port:ALU/out2[2]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[1]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[1]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[1]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[1]} .original_name {out2[1]}
set_db -quiet {port:ALU/out2[1]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {port:ALU/out2[0]} .external_pin_cap_min 1000.0
set_db -quiet {port:ALU/out2[0]} .external_capacitance_max {1000.0 1000.0}
set_db -quiet {port:ALU/out2[0]} .external_capacitance_min 1000.0
set_db -quiet {port:ALU/out2[0]} .original_name {out2[0]}
set_db -quiet {port:ALU/out2[0]} .external_pin_cap {1000.0 1000.0}
set_db -quiet {inst:ALU/X_reg[0]} .original_name {{X[0]}}
set_db -quiet {inst:ALU/X_reg[0]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[0]} .single_bit_orig_name {X[0]}
set_db -quiet {inst:ALU/X_reg[0]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[0]/Q} .original_name {X[0]/q}
set_db -quiet {inst:ALU/X_reg[1]} .original_name {{X[1]}}
set_db -quiet {inst:ALU/X_reg[1]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[1]} .single_bit_orig_name {X[1]}
set_db -quiet {inst:ALU/X_reg[1]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[1]/Q} .original_name {X[1]/q}
set_db -quiet {inst:ALU/X_reg[2]} .original_name {{X[2]}}
set_db -quiet {inst:ALU/X_reg[2]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[2]} .single_bit_orig_name {X[2]}
set_db -quiet {inst:ALU/X_reg[2]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[2]/Q} .original_name {X[2]/q}
set_db -quiet {inst:ALU/X_reg[3]} .original_name {{X[3]}}
set_db -quiet {inst:ALU/X_reg[3]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[3]} .single_bit_orig_name {X[3]}
set_db -quiet {inst:ALU/X_reg[3]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[3]/Q} .original_name {X[3]/q}
set_db -quiet {inst:ALU/X_reg[4]} .original_name {{X[4]}}
set_db -quiet {inst:ALU/X_reg[4]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[4]} .single_bit_orig_name {X[4]}
set_db -quiet {inst:ALU/X_reg[4]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[4]/Q} .original_name {X[4]/q}
set_db -quiet {inst:ALU/X_reg[5]} .original_name {{X[5]}}
set_db -quiet {inst:ALU/X_reg[5]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[5]} .single_bit_orig_name {X[5]}
set_db -quiet {inst:ALU/X_reg[5]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[5]/Q} .original_name {X[5]/q}
set_db -quiet {inst:ALU/X_reg[6]} .original_name {{X[6]}}
set_db -quiet {inst:ALU/X_reg[6]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[6]} .single_bit_orig_name {X[6]}
set_db -quiet {inst:ALU/X_reg[6]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[6]/Q} .original_name {X[6]/q}
set_db -quiet {inst:ALU/X_reg[7]} .original_name {{X[7]}}
set_db -quiet {inst:ALU/X_reg[7]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/X_reg[7]} .single_bit_orig_name {X[7]}
set_db -quiet {inst:ALU/X_reg[7]} .gint_phase_inversion false
set_db -quiet {pin:ALU/X_reg[7]/Q} .original_name {X[7]/q}
set_db -quiet {inst:ALU/Y_reg[0]} .original_name {{Y[0]}}
set_db -quiet {inst:ALU/Y_reg[0]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[0]} .single_bit_orig_name {Y[0]}
set_db -quiet {inst:ALU/Y_reg[0]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[0]/Q} .original_name {Y[0]/q}
set_db -quiet {inst:ALU/Y_reg[1]} .original_name {{Y[1]}}
set_db -quiet {inst:ALU/Y_reg[1]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[1]} .single_bit_orig_name {Y[1]}
set_db -quiet {inst:ALU/Y_reg[1]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[1]/Q} .original_name {Y[1]/q}
set_db -quiet {inst:ALU/Y_reg[2]} .original_name {{Y[2]}}
set_db -quiet {inst:ALU/Y_reg[2]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[2]} .single_bit_orig_name {Y[2]}
set_db -quiet {inst:ALU/Y_reg[2]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[2]/Q} .original_name {Y[2]/q}
set_db -quiet {inst:ALU/Y_reg[3]} .original_name {{Y[3]}}
set_db -quiet {inst:ALU/Y_reg[3]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[3]} .single_bit_orig_name {Y[3]}
set_db -quiet {inst:ALU/Y_reg[3]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[3]/Q} .original_name {Y[3]/q}
set_db -quiet {inst:ALU/Y_reg[4]} .original_name {{Y[4]}}
set_db -quiet {inst:ALU/Y_reg[4]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[4]} .single_bit_orig_name {Y[4]}
set_db -quiet {inst:ALU/Y_reg[4]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[4]/Q} .original_name {Y[4]/q}
set_db -quiet {inst:ALU/Y_reg[5]} .original_name {{Y[5]}}
set_db -quiet {inst:ALU/Y_reg[5]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[5]} .single_bit_orig_name {Y[5]}
set_db -quiet {inst:ALU/Y_reg[5]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[5]/Q} .original_name {Y[5]/q}
set_db -quiet {inst:ALU/Y_reg[6]} .original_name {{Y[6]}}
set_db -quiet {inst:ALU/Y_reg[6]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[6]} .single_bit_orig_name {Y[6]}
set_db -quiet {inst:ALU/Y_reg[6]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[6]/Q} .original_name {Y[6]/q}
set_db -quiet {inst:ALU/Y_reg[7]} .original_name {{Y[7]}}
set_db -quiet {inst:ALU/Y_reg[7]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/Y_reg[7]} .single_bit_orig_name {Y[7]}
set_db -quiet {inst:ALU/Y_reg[7]} .gint_phase_inversion false
set_db -quiet {pin:ALU/Y_reg[7]/Q} .original_name {Y[7]/q}
set_db -quiet {inst:ALU/out1_reg[0]} .original_name {{out1[0]}}
set_db -quiet {inst:ALU/out1_reg[0]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[0]} .single_bit_orig_name {out1[0]}
set_db -quiet {inst:ALU/out1_reg[0]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[0]/Q} .original_name {out1[0]/q}
set_db -quiet {inst:ALU/out1_reg[1]} .original_name {{out1[1]}}
set_db -quiet {inst:ALU/out1_reg[1]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[1]} .single_bit_orig_name {out1[1]}
set_db -quiet {inst:ALU/out1_reg[1]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[1]/Q} .original_name {out1[1]/q}
set_db -quiet {inst:ALU/out1_reg[2]} .original_name {{out1[2]}}
set_db -quiet {inst:ALU/out1_reg[2]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[2]} .single_bit_orig_name {out1[2]}
set_db -quiet {inst:ALU/out1_reg[2]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[2]/Q} .original_name {out1[2]/q}
set_db -quiet {inst:ALU/out1_reg[3]} .original_name {{out1[3]}}
set_db -quiet {inst:ALU/out1_reg[3]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[3]} .single_bit_orig_name {out1[3]}
set_db -quiet {inst:ALU/out1_reg[3]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[3]/Q} .original_name {out1[3]/q}
set_db -quiet {inst:ALU/out1_reg[4]} .original_name {{out1[4]}}
set_db -quiet {inst:ALU/out1_reg[4]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[4]} .single_bit_orig_name {out1[4]}
set_db -quiet {inst:ALU/out1_reg[4]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[4]/Q} .original_name {out1[4]/q}
set_db -quiet {inst:ALU/out1_reg[5]} .original_name {{out1[5]}}
set_db -quiet {inst:ALU/out1_reg[5]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[5]} .single_bit_orig_name {out1[5]}
set_db -quiet {inst:ALU/out1_reg[5]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[5]/Q} .original_name {out1[5]/q}
set_db -quiet {inst:ALU/out1_reg[6]} .original_name {{out1[6]}}
set_db -quiet {inst:ALU/out1_reg[6]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[6]} .single_bit_orig_name {out1[6]}
set_db -quiet {inst:ALU/out1_reg[6]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[6]/Q} .original_name {out1[6]/q}
set_db -quiet {inst:ALU/out1_reg[7]} .original_name {{out1[7]}}
set_db -quiet {inst:ALU/out1_reg[7]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out1_reg[7]} .single_bit_orig_name {out1[7]}
set_db -quiet {inst:ALU/out1_reg[7]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out1_reg[7]/Q} .original_name {out1[7]/q}
set_db -quiet {inst:ALU/out2_reg[0]} .original_name {{out2[0]}}
set_db -quiet {inst:ALU/out2_reg[0]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[0]} .single_bit_orig_name {out2[0]}
set_db -quiet {inst:ALU/out2_reg[0]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[0]/Q} .original_name {out2[0]/q}
set_db -quiet {inst:ALU/out2_reg[1]} .original_name {{out2[1]}}
set_db -quiet {inst:ALU/out2_reg[1]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[1]} .single_bit_orig_name {out2[1]}
set_db -quiet {inst:ALU/out2_reg[1]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[1]/Q} .original_name {out2[1]/q}
set_db -quiet {inst:ALU/out2_reg[2]} .original_name {{out2[2]}}
set_db -quiet {inst:ALU/out2_reg[2]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[2]} .single_bit_orig_name {out2[2]}
set_db -quiet {inst:ALU/out2_reg[2]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[2]/Q} .original_name {out2[2]/q}
set_db -quiet {inst:ALU/out2_reg[3]} .original_name {{out2[3]}}
set_db -quiet {inst:ALU/out2_reg[3]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[3]} .single_bit_orig_name {out2[3]}
set_db -quiet {inst:ALU/out2_reg[3]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[3]/Q} .original_name {out2[3]/q}
set_db -quiet {inst:ALU/out2_reg[4]} .original_name {{out2[4]}}
set_db -quiet {inst:ALU/out2_reg[4]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[4]} .single_bit_orig_name {out2[4]}
set_db -quiet {inst:ALU/out2_reg[4]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[4]/Q} .original_name {out2[4]/q}
set_db -quiet {inst:ALU/out2_reg[5]} .original_name {{out2[5]}}
set_db -quiet {inst:ALU/out2_reg[5]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[5]} .single_bit_orig_name {out2[5]}
set_db -quiet {inst:ALU/out2_reg[5]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[5]/Q} .original_name {out2[5]/q}
set_db -quiet {inst:ALU/out2_reg[6]} .original_name {{out2[6]}}
set_db -quiet {inst:ALU/out2_reg[6]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[6]} .single_bit_orig_name {out2[6]}
set_db -quiet {inst:ALU/out2_reg[6]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[6]/Q} .original_name {out2[6]/q}
set_db -quiet {inst:ALU/out2_reg[7]} .original_name {{out2[7]}}
set_db -quiet {inst:ALU/out2_reg[7]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/out2_reg[7]} .single_bit_orig_name {out2[7]}
set_db -quiet {inst:ALU/out2_reg[7]} .gint_phase_inversion false
set_db -quiet {pin:ALU/out2_reg[7]/Q} .original_name {out2[7]/q}
set_db -quiet {inst:ALU/sel_ff_reg[0]} .original_name {{sel_ff[0]}}
set_db -quiet {inst:ALU/sel_ff_reg[0]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/sel_ff_reg[0]} .single_bit_orig_name {sel_ff[0]}
set_db -quiet {inst:ALU/sel_ff_reg[0]} .gint_phase_inversion false
set_db -quiet {pin:ALU/sel_ff_reg[0]/Q} .original_name {sel_ff[0]/q}
set_db -quiet {inst:ALU/sel_ff_reg[1]} .original_name {{sel_ff[1]}}
set_db -quiet {inst:ALU/sel_ff_reg[1]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/sel_ff_reg[1]} .single_bit_orig_name {sel_ff[1]}
set_db -quiet {inst:ALU/sel_ff_reg[1]} .gint_phase_inversion false
set_db -quiet {pin:ALU/sel_ff_reg[1]/Q} .original_name {sel_ff[1]/q}
set_db -quiet {inst:ALU/sel_ff_reg[2]} .original_name {{sel_ff[2]}}
set_db -quiet {inst:ALU/sel_ff_reg[2]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/sel_ff_reg[2]} .single_bit_orig_name {sel_ff[2]}
set_db -quiet {inst:ALU/sel_ff_reg[2]} .gint_phase_inversion false
set_db -quiet {pin:ALU/sel_ff_reg[2]/Q} .original_name {sel_ff[2]/q}
set_db -quiet {inst:ALU/sel_ff_reg[3]} .original_name {{sel_ff[3]}}
set_db -quiet {inst:ALU/sel_ff_reg[3]} .orig_hdl_instantiated false
set_db -quiet {inst:ALU/sel_ff_reg[3]} .single_bit_orig_name {sel_ff[3]}
set_db -quiet {inst:ALU/sel_ff_reg[3]} .gint_phase_inversion false
set_db -quiet {pin:ALU/sel_ff_reg[3]/Q} .original_name {sel_ff[3]/q}
# BEGIN PMBIST SECTION
# END PMBIST SECTION
set_db -quiet source_verbose true
#############################################################
#####   FLOW WRITE   ########################################
##
## Written by Genus(TM) Synthesis Solution version 19.13-s073_1
## flowkit v19.10-s013_1
## Written on 02:44:57 29-Jun 2026
#############################################################
#####   Flow Definitions   ##################################

#############################################################
#####   Step Definitions   ##################################


#############################################################
#####   Attribute Definitions   #############################

if {[is_attribute flow_edit_end_steps -obj_type root]} {set_db flow_edit_end_steps {}}
if {[is_attribute flow_edit_start_steps -obj_type root]} {set_db flow_edit_start_steps {}}
if {[is_attribute flow_footer_tcl -obj_type root]} {set_db flow_footer_tcl {}}
if {[is_attribute flow_header_tcl -obj_type root]} {set_db flow_header_tcl {}}
if {[is_attribute flow_metadata -obj_type root]} {set_db flow_metadata {}}
if {[is_attribute flow_setup_config -obj_type root]} {set_db flow_setup_config {HUDDLE {!!map {}}}}
if {[is_attribute flow_step_begin_tcl -obj_type root]} {set_db flow_step_begin_tcl {}}
if {[is_attribute flow_step_check_tcl -obj_type root]} {set_db flow_step_check_tcl {}}
if {[is_attribute flow_step_end_tcl -obj_type root]} {set_db flow_step_end_tcl {}}
if {[is_attribute flow_step_order -obj_type root]} {set_db flow_step_order {}}
if {[is_attribute flow_summary_tcl -obj_type root]} {set_db flow_summary_tcl {}}
if {[is_attribute flow_template_feature_definition -obj_type root]} {set_db flow_template_feature_definition {}}
if {[is_attribute flow_template_type -obj_type root]} {set_db flow_template_type {}}
if {[is_attribute flow_template_version -obj_type root]} {set_db flow_template_version {}}
if {[is_attribute flow_user_templates -obj_type root]} {set_db flow_user_templates {}}


#############################################################
#####   Flow History   ######################################

if {[is_attribute flow_branch -obj_type root]} {set_db flow_branch {}}
if {[is_attribute flow_caller_data -obj_type root]} {set_db flow_caller_data {}}
if {[is_attribute flow_current -obj_type root]} {set_db flow_current {}}
if {[is_attribute flow_hier_path -obj_type root]} {set_db flow_hier_path {}}
if {[is_attribute flow_db_directory -obj_type root]} {set_db flow_db_directory dbs}
if {[is_attribute flow_exit_when_done -obj_type root]} {set_db flow_exit_when_done false}
if {[is_attribute flow_history -obj_type root]} {set_db flow_history {}}
if {[is_attribute flow_log_directory -obj_type root]} {set_db flow_log_directory logs}
if {[is_attribute flow_mail_on_error -obj_type root]} {set_db flow_mail_on_error false}
if {[is_attribute flow_mail_to -obj_type root]} {set_db flow_mail_to {}}
if {[is_attribute flow_metrics_file -obj_type root]} {set_db flow_metrics_file {}}
if {[is_attribute flow_metrics_snapshot_parent_uuid -obj_type root]} {set_db flow_metrics_snapshot_parent_uuid {}}
if {[is_attribute flow_metrics_snapshot_uuid -obj_type root]} {set_db flow_metrics_snapshot_uuid b35e3496-28a0-404c-b874-54ca9482a4e9}
if {[is_attribute flow_overwrite_db -obj_type root]} {set_db flow_overwrite_db false}
if {[is_attribute flow_report_directory -obj_type root]} {set_db flow_report_directory reports}
if {[is_attribute flow_run_tag -obj_type root]} {set_db flow_run_tag {}}
if {[is_attribute flow_schedule -obj_type root]} {set_db flow_schedule {}}
if {[is_attribute flow_script -obj_type root]} {set_db flow_script {}}
if {[is_attribute flow_starting_db -obj_type root]} {set_db flow_starting_db {}}
if {[is_attribute flow_status_file -obj_type root]} {set_db flow_status_file {}}
if {[is_attribute flow_step_canonical_current -obj_type root]} {set_db flow_step_canonical_current {}}
if {[is_attribute flow_step_current -obj_type root]} {set_db flow_step_current {}}
if {[is_attribute flow_step_last -obj_type root]} {set_db flow_step_last {}}
if {[is_attribute flow_step_last_msg -obj_type root]} {set_db flow_step_last_msg {}}
if {[is_attribute flow_step_last_status -obj_type root]} {set_db flow_step_last_status not_run}
if {[is_attribute flow_step_next -obj_type root]} {set_db flow_step_next {}}
if {[is_attribute flow_working_directory -obj_type root]} {set_db flow_working_directory .}

#############################################################
#####   User Defined Attributes   ###########################

