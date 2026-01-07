#Suggested probe command:
#########################
indago_probe -log
indago_probe -wave -wave_probe_args="[scope -tops] -all -depth all"
indago_probe -start_time=10000000000fs -sv_flow -sv_files="*uvm_root.svh*"

# Visited files:
# uvm_root.svh - 3 times

