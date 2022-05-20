

proc generate {drv_handle} {
	xdefine_include_file $drv_handle "xparameters.h" "pid_parameters" "NUM_INSTANCES" "DEVICE_ID"  "C_P_BASEADDR" "C_P_HIGHADDR" "C_I_BASEADDR" "C_I_HIGHADDR" "C_D_BASEADDR" "C_D_HIGHADDR" "C_N_BASEADDR" "C_N_HIGHADDR" "C_S_BASEADDR" "C_S_HIGHADDR"
}
