

class counter_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(counter_scoreboard)

	uvm_analysis_imp#(counter_transaction,counter_scoreboard) sb_export;//export from the port(agent) (output from mointor -the dut output-)
		//uvm_tlm_analysis_fifo #(counter_transaction) fifo;

	virtual counter_vif vif;
	counter_transaction seq_before;//predictor
	counter_transaction seq_after;//from monitor

	

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb_export=new("sb_export",this);
		if (! uvm_config_db #(virtual counter_vif)::get(this,"*","counter_vif",vif))
			$fatal("faild to get interface");
		//monitor_port=new("monitor_port",this);

		//fifo= new("fifo", this);

	endfunction:build_phase


	virtual function void write(counter_transaction data);
		`uvm_info("write",$sformatf("data received=0x%0h",data),UVM_MEDIUM)
	endfunction


/*
	function void connect_phase(uvm_phase phase);
		sb_export.connect(fifo.analysis_export);
		
	endfunction: connect_phase
*/

	
	virtual task run_phase(uvm_phase phase);
	
	//fifo.get(seq_after);
	 seq_before= counter_transaction::type_id::create(.name("seq_before"));

	@(posedge vif.sig_clk_in)
	begin
		if(~ vif.sig_rst_in)
			begin
				seq_before.t_counter_out=8'b0;
				seq_before.t_ovf_out=1'b0;
			end

		else if(vif.sig_en_ctrl_in)
	 		begin
		
			if(seq_before.t_up_ctrl_in)
				seq_before.t_counter_out=seq_before.t_counter_out+1;
			else
				seq_before.t_counter_out=seq_before.t_counter_out-1;
	
			if(seq_before.t_counter_out==8'hff)
				seq_before.t_ovf_out=1'b1;
			else
				seq_before.t_ovf_out=1'b0;
			end
		else if(seq_before.t_set_ctrl_in)
			
			seq_before.t_counter_out=seq_before.t_counter_in;
			
	end
	
	 compare();

 	endtask:run_phase
	


	virtual function void compare();
		
		if((seq_before.t_ovf_out==vif.sig_ovf_out) && (seq_before.t_counter_out==vif.sig_counter_out)) begin
			`uvm_info("compare", {"Test: OK!"}, UVM_LOW); end
		else begin
			`uvm_info("compare", {"Test: Fail!"}, UVM_LOW); end
		
		 
	endfunction:compare
		


endclass:counter_scoreboard
