all: build

build: 
	xvlog ./tb_counter_2024.v ./counter_2024.v
	xelab tb_counter_2024 -debug wave -s tb_counter_2024   
	xsim tb_counter_2024 -gui -wdb simulate_xsim_tb &

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
