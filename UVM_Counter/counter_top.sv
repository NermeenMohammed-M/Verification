`include "counter_vif.sv"
import counter_pkg::*;
//`include "counter.v"
import uvm_pkg::*;
`include "uvm_macros.svh" 


module counter_top;
	
	

	//Interface declaration
	 counter_vif vif();


	//Connects the Interface to the DUT
	Counter_8bit dut(vif.sig_clk_in,
			vif.sig_rst_in,
			vif.sig_en_ctrl_in,
			vif.sig_set_ctrl_in,
			vif.sig_up_ctrl_in,
			vif.sig_counter_in,
			vif.sig_counter_out,
			vif.sig_ovf_out);

	initial begin

		//"uvm_config_db" store global info across the testbench in an organized way.
		//set(null,*,name_of_data,value)
		//first two parameter make the data available entire testbench
		uvm_config_db #(virtual counter_vif)::set(null,"*","counter_vif",vif);
		
		run_test("counter_test");//start the test (fun. in uvm)
		/*
		The run_test() task reads the +UVM_TESTNAME parameter from the simulation's
		command line and instantiates an object of that class name. We can avoid using
		+UVM_TESTNAME by passing run_test() a string that contains the test name, but of
		course this defeats the whole idea of being able to launch many tests with one
		compile.
		*/
		end

	//Variable initialization
	initial begin
		vif.sig_clk_in <= 1'b1;
	end

	//Clock generation
	always
		#5 vif.sig_clk_in = ~vif.sig_clk_in;
endmodule
