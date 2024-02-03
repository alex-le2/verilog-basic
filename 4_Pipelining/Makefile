all: build

build: 
	xvlog ./tb_exp_cal_8.v ./exp_cal_8.v
	xelab tb_exp_cal_8 -debug wave -s tb_exp_cal_8   
	xsim tb_exp_cal_8 -gui -wdb simulate_xsim_tb &

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
