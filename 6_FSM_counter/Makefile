all: build

build: 
	xvlog ./tb_fsm_counter.v ./fsm_counter.v
	xelab tb_fsm_counter -debug wave -s tb_fsm_counter   
	xsim tb_fsm_counter -gui -wdb simulate_xsim_tb &

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
