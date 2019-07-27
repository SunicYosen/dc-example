#Library Setup
set search_path "$search_path . .. ../.. ../../vsrc ../scripts ../../libs/SMIC18/db ../../libs/SMIC18/sdb ../work"
set target_library   "slow.db"
set symbol_library   "smic18.sdb SP018W_V1p5.sdb"
set link_library     "* $target_library $symbol_library SP018W_V1p5_max.db"

#Saving svf
set_svf ../outputs/state_machine.svf

#Reading Design Files and Specify the current design
source read.tcl
current_design state_machine
link
###YBR ADD uniquify###

###YBR ADD uniquify###
source sm.con

#Saving sdc
write_sdc ../outputs/sm_clk_with_driving.sdc

#Compile
compile

#Clean-up
###YBR ADD -blast_buses###
#[find -hierarchy cell "*"]
remove_unconnected_ports -blast_buses [find -hierarchy cell "*"]
###YBR ADD -blast_buses###

#Report
report_constraint -all_violators > ../reports/violators_clk_with_driving.rpt
report_area > ../reports/area_report_clk_with_driving.rpt
report_timing > ../reports/timing_report_clk_with_driving.rpt

#Saving Designs after Compile
change_names -rule verilog -hier

###YBR
uniquify
write -format verilog -hier -out ../outputs/sm_clk_with_driving.v
write -format ddc -hier -out ../outputs/sm_clk_with_driving.ddc
