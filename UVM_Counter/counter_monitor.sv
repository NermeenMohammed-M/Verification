class counter_monitor extends uvm_component;

	`uvm_component_utils(counter_monitor)

	virtual counter_vif vif;
	uvm_analysis_port#(counter_sequence) monitor_port;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (! uvm_config_db #(virtual counter_vif)::get(null,"","vif",vif))
			$fatal("faild to get interface");
		monitor_port= new(.name("monitor_port"),.parent(this));
	
	endfunction:build_phase



	task run_phase(uvm_phase phase);
		
		counter_transaction seq;
		forever begin
			
			seq = counter_sequence::type_id::create(.name("seq"));

			
		
			seq.t_clk_in=vif.sig_clk_in;
			seq.t_rst_in=vif.sig_rst_in;
			seq.t_en_ctrl_in=vif.sig_en_ctrl_in;
			seq.t_set_ctrl_in=vif.sig_set_ctrl_in;
			seq.t_up_ctrl_in=vif.sig_up_ctrl_in;
			seq.t_counter_in=vif.sig_counter_in;
			seq.t_counter_out=vif.sig_counter_out;
			seq.t_ovf_out=vif.sig_ovf_out;

			monitor_port.write(seq);

			
		
		end
	endtask:run_phase

endclass 