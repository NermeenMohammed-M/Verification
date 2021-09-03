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
		if (! uvm_config_db #(virtual counter_vif)::get(null,"*","vif",vif))
			$fatal("faild to get interface");
	endfunction:build_phase

//run phase

	task run_phase(uvm_phase phase);
		
		counter_transaction trn;
		forever begin

			seq_item_port.get_next_item(trn);
		
			vif.sig_clk_in=trn.t_clk_in;
			vif.sig_rst_in=trn.t_rst_in;
			vif.sig_en_ctrl_in=trn.t_en_ctrl_in;
			vif.sig_set_ctrl_in=trn.t_set_ctrl_in;
			vif.sig_up_ctrl_in=trn.t_up_ctrl_in;
			vif.sig_counter_in=trn.t_counter_in;
			vif.sig_counter_out=trn.t_counter_out;
			vif.sig_ovf_out=trn.t_ovf_out;

			seq_item_port.item_done();
		
		end
	endtask:run_phase

endclass:counter_driver

	

