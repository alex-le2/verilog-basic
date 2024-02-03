all: build

build: 
	xvlog ./tb_combi.v ./combi_1.v ./combi_2.v
	xelab tb_combi -debug wave -s tb_combi   
	xsim tb_combi -gui -wdb simulate_xsim_tb &

clean:
	rm -rf *xe* *xs* *.wdb *trace* *xv* *we* .hbs .Xil
