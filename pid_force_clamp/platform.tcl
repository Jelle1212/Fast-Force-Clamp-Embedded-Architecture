# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct C:\Users\JelleKomen\Documents\software\pid_force_clamp\platform.tcl
# 
# OR launch xsct and run below command.
# source C:\Users\JelleKomen\Documents\software\pid_force_clamp\platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {pid_force_clamp}\
-hw {C:\Users\JelleKomen\Documents\software\pid_force_clamp.xsa}\
-out {C:/Users/JelleKomen/Documents/software}

platform write
domain create -name {standalone_ps7_cortexa9_0} -display-name {standalone_ps7_cortexa9_0} -os {standalone} -proc {ps7_cortexa9_0} -runtime {cpp} -arch {32-bit} -support-app {hello_world}
platform generate -domains 
platform active {pid_force_clamp}
domain active {zynq_fsbl}
domain active {standalone_ps7_cortexa9_0}
platform generate -quick
platform generate
platform clean
platform generate
platform config -updatehw {C:/Users/JelleKomen/Documents/software/pid_force_clamp.xsa}
platform generate -domains 
platform clean
platform generate
platform config -updatehw {C:/Users/JelleKomen/Documents/software/pid_force_clamp.xsa}
platform clean
platform generate
platform config -updatehw {C:/Users/JelleKomen/Documents/software/pid_force_clamp.xsa}
platform generate -domains 
platform config -updatehw {C:/Users/JelleKomen/Documents/software/pid_force_clamp.xsa}
platform generate -domains 
