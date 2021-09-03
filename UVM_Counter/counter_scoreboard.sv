

class counter_scoreboard extends uvm_scoreboard;
	`uvm_component_utils(counter_scoreboard)

	uvm_analysis_export #(counter_transaction) sb_export;//export from the port(agent)
	//uvm_analysis_export#(counter_sequence) monitor_port; //export from the port(monitor)

	
	counter_transaction seq_before;
	counter_transaction seq_after;

	

	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new


	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		sb_export=new("sb_export",this);
		//monitor_port=new("monitor_port",this);

	endfunction:build_phase

	
	virtual task run_phase(uvm_phase phase);

	@(posedge seq_before.t_clk_in)
	begin
		if(~ seq_before.t_rst_in)
			begin
				seq_before.t_counter_out=8'b0;
				seq_before.t_ovf_out=1'b0;
			end

		else if(seq_before.t_en_ctrl_in)
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
		else
			begin
			if(seq_before.t_set_ctrl_in)
				seq_before.t_counter_out=seq_before.t_counter_in;
			end
	end

 	endtask:run_phase
	


	virtual function void compare();
		
		if((seq_before.t_ovf_out==seq_after.t_ovf_out) & (seq_before.t_counter_out==seq_after.t_counter_out)) begin
			`uvm_info("compare", {"Test: OK!"}, UVM_LOW); end
		else begin
			`uvm_info("compare", {"Test: Fail!"}, UVM_LOW); end
		
		 
	endfunction:compare
		


endclass:counter_scoreboard
