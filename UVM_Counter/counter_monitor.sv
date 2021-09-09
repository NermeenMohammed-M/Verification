class counter_monitor extends uvm_component;

	`uvm_component_utils(counter_monitor)

	virtual counter_vif vif;
	uvm_analysis_port#(counter_transaction) monitor_port;

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		if (! uvm_config_db #(virtual counter_vif)::get(this,"*","counter_vif",vif))
			$fatal("faild to get interface");

		monitor_port= new(.name("monitor_port"),.parent(this));
	
	endfunction:build_phase



	task run_phase(uvm_phase phase);
		
		counter_transaction trn;
		forever begin
			@(posedge vif.sig_clk_in)
			begin
			trn = counter_transaction::type_id::create(.name("trn"));

			
		
			
			//trn.t_rst_in=vif.sig_rst_in;
			//trn.t_en_ctrl_in=vif.sig_en_ctrl_in;
			//trn.t_set_ctrl_in=vif.sig_set_ctrl_in;
			trn.t_up_ctrl_in=vif.sig_up_ctrl_in;
			trn.t_counter_in=vif.sig_counter_in;
			trn.t_counter_out=vif.sig_counter_out;
			trn.t_ovf_out=vif.sig_ovf_out;

			monitor_port.write(trn);//the dut output

			end
		
		end
	endtask:run_phase

endclass 