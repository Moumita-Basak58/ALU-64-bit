set_db init_lib_search_path /home/nielit/Project_Moumita/RTLtoGDSII_5_0/counter_design_database_45nm/lib
set_db init_hdl_search_path /home/nielit/Project_Moumita/RTLtoGDSII_5_0/counter_design_database_45nm/rtl
read_libs /home/nielit/Project_Moumita/RTLtoGDSII_5_0/counter_design_database_45nm/lib/slow_vdd1v0_basicCells.lib
read_hdl /home/nielit/Project_Moumita/RTLtoGDSII_5_0/counter_design_database_45nm/rtl/project.v
elaborate
read_sdc /home/nielit/Project_Moumita/RTLtoGDSII_5_0/counter_design_database_45nm/constraints/projectsConstraints.sdc

set_db dft_scan_style muxed_scan 
set_db dft_prefix dft_
define_shift_enable -name SE -active high -create_port SE
check_dft_rules

set_db syn_generic_effort medium
syn_generic
set_db syn_map_effort medium
syn_map
set_db syn_opt_effort medium
syn_opt

check_dft_rules 
set_db design:project .dft_min_number_of_scan_chains 1 
define_scan_chain -name top_chain -sdi scan_in -sdo scan_out -create_ports  

connect_scan_chains -auto_create_chains 
syn_opt -incr

report_scan_chains 
write_dft_atpg -library /home/nielit/Project_Moumita/RTLtoGDSII_5_0/counter_design_database_45nm/lib/slow_vdd1v0_basiccells.v
write_hdl > outputs/project_netlist_dft.v
write_sdc > outputs/project_sdc_dft.sdc
write_sdf -nonegchecks -edges check_edge -timescale ns -recrem split  -setuphold split > outputs/dft_delays.sdf
write_scandef > outputs/project_scanDEF.scandef

