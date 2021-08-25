`include "counter_vif.sv"
`include "counter_pkg.sv"
`include "counter.v"


module counter_top;
	import uvm_pkg::*;
	`include "uvm_macros.svh" 

	//Interface declaration
	 counter_vif vif();


	//Connects the Interface to the DUT
	counter dut(vif.sig_clk_in,
			vif.sig_rst_in,
			vif.sig_en_ctrl_in,
			vif.sig_set_ctrl_in,
			vif.sig_up_ctrl_in,
			vif.sig_counter_in,
			vif.sig_counter_out,
			vif.sig_ovf_out);

	initial begin
		uvm_config_db#(virtual counter_vif)::set(null,"","counter_vif",vif);
		
		run_test();
		end

	//Variable initialization
	initial begin
		vif.sig_clk_in <= 1'b1;
	end

	//Clock generation
	always
		#5 vif.sig_clk_in = ~vif.sig_clk_in;
endmodule
