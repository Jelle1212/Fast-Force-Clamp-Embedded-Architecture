# Runtime Tcl commands to interact with - pid_parameters_v1_0

# Sourcing design address info tcl
set bd_path [get_property DIRECTORY [current_project]]/[current_project].srcs/[current_fileset]/bd
source ${bd_path}/pid_parameters_v1_0_include.tcl

# jtag axi master interface hardware name, change as per your design.
set jtag_axi_master hw_axi_1
set ec 0

# hw test script
# Delete all previous axis transactions
if { [llength [get_hw_axi_txns -quiet]] } {
	delete_hw_axi_txn [get_hw_axi_txns -quiet]
}


# Test all lite slaves.
set wdata_1 abcd1234

# Test: P
# Create a write transaction at p_addr address
create_hw_axi_txn w_p_addr [get_hw_axis $jtag_axi_master] -type write -address $p_addr -data $wdata_1
# Create a read transaction at p_addr address
create_hw_axi_txn r_p_addr [get_hw_axis $jtag_axi_master] -type read -address $p_addr
# Initiate transactions
run_hw_axi r_p_addr
run_hw_axi w_p_addr
run_hw_axi r_p_addr
set rdata_tmp [get_property DATA [get_hw_axi_txn r_p_addr]]
# Compare read data
if { $rdata_tmp == $wdata_1 } {
	puts "Data comparison test pass for - P"
} else {
	puts "Data comparison test fail for - P, expected-$wdata_1 actual-$rdata_tmp"
	inc ec
}

# Test: I
# Create a write transaction at i_addr address
create_hw_axi_txn w_i_addr [get_hw_axis $jtag_axi_master] -type write -address $i_addr -data $wdata_1
# Create a read transaction at i_addr address
create_hw_axi_txn r_i_addr [get_hw_axis $jtag_axi_master] -type read -address $i_addr
# Initiate transactions
run_hw_axi r_i_addr
run_hw_axi w_i_addr
run_hw_axi r_i_addr
set rdata_tmp [get_property DATA [get_hw_axi_txn r_i_addr]]
# Compare read data
if { $rdata_tmp == $wdata_1 } {
	puts "Data comparison test pass for - I"
} else {
	puts "Data comparison test fail for - I, expected-$wdata_1 actual-$rdata_tmp"
	inc ec
}

# Test: D
# Create a write transaction at d_addr address
create_hw_axi_txn w_d_addr [get_hw_axis $jtag_axi_master] -type write -address $d_addr -data $wdata_1
# Create a read transaction at d_addr address
create_hw_axi_txn r_d_addr [get_hw_axis $jtag_axi_master] -type read -address $d_addr
# Initiate transactions
run_hw_axi r_d_addr
run_hw_axi w_d_addr
run_hw_axi r_d_addr
set rdata_tmp [get_property DATA [get_hw_axi_txn r_d_addr]]
# Compare read data
if { $rdata_tmp == $wdata_1 } {
	puts "Data comparison test pass for - D"
} else {
	puts "Data comparison test fail for - D, expected-$wdata_1 actual-$rdata_tmp"
	inc ec
}

# Test: N
# Create a write transaction at n_addr address
create_hw_axi_txn w_n_addr [get_hw_axis $jtag_axi_master] -type write -address $n_addr -data $wdata_1
# Create a read transaction at n_addr address
create_hw_axi_txn r_n_addr [get_hw_axis $jtag_axi_master] -type read -address $n_addr
# Initiate transactions
run_hw_axi r_n_addr
run_hw_axi w_n_addr
run_hw_axi r_n_addr
set rdata_tmp [get_property DATA [get_hw_axi_txn r_n_addr]]
# Compare read data
if { $rdata_tmp == $wdata_1 } {
	puts "Data comparison test pass for - N"
} else {
	puts "Data comparison test fail for - N, expected-$wdata_1 actual-$rdata_tmp"
	inc ec
}

# Test: S
# Create a write transaction at s_addr address
create_hw_axi_txn w_s_addr [get_hw_axis $jtag_axi_master] -type write -address $s_addr -data $wdata_1
# Create a read transaction at s_addr address
create_hw_axi_txn r_s_addr [get_hw_axis $jtag_axi_master] -type read -address $s_addr
# Initiate transactions
run_hw_axi r_s_addr
run_hw_axi w_s_addr
run_hw_axi r_s_addr
set rdata_tmp [get_property DATA [get_hw_axi_txn r_s_addr]]
# Compare read data
if { $rdata_tmp == $wdata_1 } {
	puts "Data comparison test pass for - S"
} else {
	puts "Data comparison test fail for - S, expected-$wdata_1 actual-$rdata_tmp"
	inc ec
}

# Check error flag
if { $ec == 0 } {
	 puts "PTGEN_TEST: PASSED!" 
} else {
	 puts "PTGEN_TEST: FAILED!" 
}

