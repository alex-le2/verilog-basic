all: build

build: 
	xvlog ./tb_fsm_test.v ./fsm_test.v
	xelab tb_fsm_test -debug wave -s tb_fsm_test   
	xsim tb_fsm_test -gui -wdb simulate_xsim_tb &

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
