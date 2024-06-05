onerror {quit -f}
vlib work
vlog -work work lab1-fpAdd.vo
vlog -work work lab1.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.lab1-fpAdd_vlg_vec_tst
vcd file -direction lab1.msim.vcd
vcd add -internal lab1-fpAdd_vlg_vec_tst/*
vcd add -internal lab1-fpAdd_vlg_vec_tst/i1/*
add wave /*
run -all
