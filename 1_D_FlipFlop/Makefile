all: build

build: 
	xvlog ./tb_d_ff.v ./d_ff.v 
	xelab tb_d_ff -debug wave -s tb_d_ff   
	xsim tb_d_ff -gui -wdb simulate_xsim_tb

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
