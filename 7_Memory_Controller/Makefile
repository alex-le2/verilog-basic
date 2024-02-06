all: build

build: 
	xvlog ./tb_bram_controller.v ./bram_controller.v ./true_dpbram.v
	xelab tb_bram_controller -debug wave -s tb_bram_controller   
	xsim tb_bram_controller -gui -wdb simulate_xsim_tb &

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
