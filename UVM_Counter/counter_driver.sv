class counter_driver extends uvm_driver #(counter_transaction);
	`uvm_component_utils(counter_driver)

	virtual counter_vif vif ;
	
//constructor 

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new

//build phase 

	function void build_phase(phase);
		super.build_phase(phase);
		if (! uvm_config_db #(virtual counter_vif)::get(null,"","vif",vif))
			$fatal("faild to get interface");
	endfunction:build_phase

//run phase

	task run_phase(phase);
		
		counter_transaction seq;
		forever begin

			seq_item_port.get_next_item(seq);
		
			vif.sig_clk_in=seq.t_clk_in;
			vif.sig_rst_in=seq.t_rst_in;
			vif.sig_en_ctrl_in=seq.t_en_ctrl_in;
			vif.sig_set_ctrl_in=seq.t_set_ctrl_in;
			vif.sig_up_ctrl_in=seq.t_up_ctrl_in;
			vif.sig_counter_in=seq.t_counter_in;
			vif.sig_counter_out=seq.t_counter_out;
			vif.sig_ovf_out=seq.t_ovf_out;

			seq_item_port.item_done();
		
		end
	endtask:run_phase

endclass:counter_driver

	

