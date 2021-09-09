class counter_driver extends uvm_driver #(counter_transaction);
	`uvm_component_utils(counter_driver)

	virtual counter_vif vif ;
	
//constructor 

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new

//build phase 

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (! uvm_config_db #(virtual counter_vif)::get(this,"*","counter_vif",vif))
			$fatal("failed to get interface");
	endfunction:build_phase

//run phase

	task run_phase(uvm_phase phase);
		
		counter_transaction trn;
		vif.sig_rst_in=1'b0;
		vif.sig_en_ctrl_in=1'b0;
		forever begin
			seq_item_port.get_next_item(trn);
			
			@(posedge vif.sig_clk_in)
			begin

			vif.sig_rst_in=1'b1;
			vif.sig_en_ctrl_in=1'b1;
		
			
			
			vif.sig_set_ctrl_in=trn.t_set_ctrl_in;
			vif.sig_up_ctrl_in=trn.t_up_ctrl_in;
			vif.sig_counter_in=trn.t_counter_in;
			vif.sig_counter_out=trn.t_counter_out;
			vif.sig_ovf_out=trn.t_ovf_out;

			seq_item_port.item_done();
			end		
		end
	endtask:run_phase

endclass:counter_driver

	

