# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "C_I_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_I_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_I_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_I_HIGHADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_N_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_N_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_N_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_N_HIGHADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_S_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_S_HIGHADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_D_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_D_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_D_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_D_HIGHADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_P_DATA_WIDTH" -parent ${Page_0} -widget comboBox
  ipgui::add_param $IPINST -name "C_P_ADDR_WIDTH" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_P_BASEADDR" -parent ${Page_0}
  ipgui::add_param $IPINST -name "C_P_HIGHADDR" -parent ${Page_0}


}

proc update_PARAM_VALUE.C_I_DATA_WIDTH { PARAM_VALUE.C_I_DATA_WIDTH } {
	# Procedure called to update C_I_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_I_DATA_WIDTH { PARAM_VALUE.C_I_DATA_WIDTH } {
	# Procedure called to validate C_I_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_I_ADDR_WIDTH { PARAM_VALUE.C_I_ADDR_WIDTH } {
	# Procedure called to update C_I_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_I_ADDR_WIDTH { PARAM_VALUE.C_I_ADDR_WIDTH } {
	# Procedure called to validate C_I_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_I_BASEADDR { PARAM_VALUE.C_I_BASEADDR } {
	# Procedure called to update C_I_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_I_BASEADDR { PARAM_VALUE.C_I_BASEADDR } {
	# Procedure called to validate C_I_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_I_HIGHADDR { PARAM_VALUE.C_I_HIGHADDR } {
	# Procedure called to update C_I_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_I_HIGHADDR { PARAM_VALUE.C_I_HIGHADDR } {
	# Procedure called to validate C_I_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_N_DATA_WIDTH { PARAM_VALUE.C_N_DATA_WIDTH } {
	# Procedure called to update C_N_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_N_DATA_WIDTH { PARAM_VALUE.C_N_DATA_WIDTH } {
	# Procedure called to validate C_N_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_N_ADDR_WIDTH { PARAM_VALUE.C_N_ADDR_WIDTH } {
	# Procedure called to update C_N_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_N_ADDR_WIDTH { PARAM_VALUE.C_N_ADDR_WIDTH } {
	# Procedure called to validate C_N_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_N_BASEADDR { PARAM_VALUE.C_N_BASEADDR } {
	# Procedure called to update C_N_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_N_BASEADDR { PARAM_VALUE.C_N_BASEADDR } {
	# Procedure called to validate C_N_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_N_HIGHADDR { PARAM_VALUE.C_N_HIGHADDR } {
	# Procedure called to update C_N_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_N_HIGHADDR { PARAM_VALUE.C_N_HIGHADDR } {
	# Procedure called to validate C_N_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_S_DATA_WIDTH { PARAM_VALUE.C_S_DATA_WIDTH } {
	# Procedure called to update C_S_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_DATA_WIDTH { PARAM_VALUE.C_S_DATA_WIDTH } {
	# Procedure called to validate C_S_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_ADDR_WIDTH { PARAM_VALUE.C_S_ADDR_WIDTH } {
	# Procedure called to update C_S_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_ADDR_WIDTH { PARAM_VALUE.C_S_ADDR_WIDTH } {
	# Procedure called to validate C_S_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_S_BASEADDR { PARAM_VALUE.C_S_BASEADDR } {
	# Procedure called to update C_S_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_BASEADDR { PARAM_VALUE.C_S_BASEADDR } {
	# Procedure called to validate C_S_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_S_HIGHADDR { PARAM_VALUE.C_S_HIGHADDR } {
	# Procedure called to update C_S_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_S_HIGHADDR { PARAM_VALUE.C_S_HIGHADDR } {
	# Procedure called to validate C_S_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_D_DATA_WIDTH { PARAM_VALUE.C_D_DATA_WIDTH } {
	# Procedure called to update C_D_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D_DATA_WIDTH { PARAM_VALUE.C_D_DATA_WIDTH } {
	# Procedure called to validate C_D_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_D_ADDR_WIDTH { PARAM_VALUE.C_D_ADDR_WIDTH } {
	# Procedure called to update C_D_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D_ADDR_WIDTH { PARAM_VALUE.C_D_ADDR_WIDTH } {
	# Procedure called to validate C_D_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_D_BASEADDR { PARAM_VALUE.C_D_BASEADDR } {
	# Procedure called to update C_D_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D_BASEADDR { PARAM_VALUE.C_D_BASEADDR } {
	# Procedure called to validate C_D_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_D_HIGHADDR { PARAM_VALUE.C_D_HIGHADDR } {
	# Procedure called to update C_D_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_D_HIGHADDR { PARAM_VALUE.C_D_HIGHADDR } {
	# Procedure called to validate C_D_HIGHADDR
	return true
}

proc update_PARAM_VALUE.C_P_DATA_WIDTH { PARAM_VALUE.C_P_DATA_WIDTH } {
	# Procedure called to update C_P_DATA_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_P_DATA_WIDTH { PARAM_VALUE.C_P_DATA_WIDTH } {
	# Procedure called to validate C_P_DATA_WIDTH
	return true
}

proc update_PARAM_VALUE.C_P_ADDR_WIDTH { PARAM_VALUE.C_P_ADDR_WIDTH } {
	# Procedure called to update C_P_ADDR_WIDTH when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_P_ADDR_WIDTH { PARAM_VALUE.C_P_ADDR_WIDTH } {
	# Procedure called to validate C_P_ADDR_WIDTH
	return true
}

proc update_PARAM_VALUE.C_P_BASEADDR { PARAM_VALUE.C_P_BASEADDR } {
	# Procedure called to update C_P_BASEADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_P_BASEADDR { PARAM_VALUE.C_P_BASEADDR } {
	# Procedure called to validate C_P_BASEADDR
	return true
}

proc update_PARAM_VALUE.C_P_HIGHADDR { PARAM_VALUE.C_P_HIGHADDR } {
	# Procedure called to update C_P_HIGHADDR when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.C_P_HIGHADDR { PARAM_VALUE.C_P_HIGHADDR } {
	# Procedure called to validate C_P_HIGHADDR
	return true
}


proc update_MODELPARAM_VALUE.C_I_DATA_WIDTH { MODELPARAM_VALUE.C_I_DATA_WIDTH PARAM_VALUE.C_I_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_I_DATA_WIDTH}] ${MODELPARAM_VALUE.C_I_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_I_ADDR_WIDTH { MODELPARAM_VALUE.C_I_ADDR_WIDTH PARAM_VALUE.C_I_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_I_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_I_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_N_DATA_WIDTH { MODELPARAM_VALUE.C_N_DATA_WIDTH PARAM_VALUE.C_N_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_N_DATA_WIDTH}] ${MODELPARAM_VALUE.C_N_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_N_ADDR_WIDTH { MODELPARAM_VALUE.C_N_ADDR_WIDTH PARAM_VALUE.C_N_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_N_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_N_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_DATA_WIDTH { MODELPARAM_VALUE.C_S_DATA_WIDTH PARAM_VALUE.C_S_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_DATA_WIDTH}] ${MODELPARAM_VALUE.C_S_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_S_ADDR_WIDTH { MODELPARAM_VALUE.C_S_ADDR_WIDTH PARAM_VALUE.C_S_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_S_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_S_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_D_DATA_WIDTH { MODELPARAM_VALUE.C_D_DATA_WIDTH PARAM_VALUE.C_D_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_D_DATA_WIDTH}] ${MODELPARAM_VALUE.C_D_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_D_ADDR_WIDTH { MODELPARAM_VALUE.C_D_ADDR_WIDTH PARAM_VALUE.C_D_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_D_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_D_ADDR_WIDTH}
}

proc update_MODELPARAM_VALUE.C_P_DATA_WIDTH { MODELPARAM_VALUE.C_P_DATA_WIDTH PARAM_VALUE.C_P_DATA_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_P_DATA_WIDTH}] ${MODELPARAM_VALUE.C_P_DATA_WIDTH}
}

proc update_MODELPARAM_VALUE.C_P_ADDR_WIDTH { MODELPARAM_VALUE.C_P_ADDR_WIDTH PARAM_VALUE.C_P_ADDR_WIDTH } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.C_P_ADDR_WIDTH}] ${MODELPARAM_VALUE.C_P_ADDR_WIDTH}
}

