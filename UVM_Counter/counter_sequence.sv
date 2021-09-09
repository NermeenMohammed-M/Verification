class counter_transaction extends uvm_sequence_item ;



	//bit t_clk_in;
	//bit t_rst_in;
	//rand bit t_en_ctrl_in;
	rand bit t_set_ctrl_in;
	rand bit t_up_ctrl_in;
	rand bit[7:0] t_counter_in;
	
	bit[7:0]t_counter_out;
	bit t_ovf_out;



	`uvm_object_utils(counter_transaction)

//constructor

	function new(string name= "");
		super.new(name);
	endfunction:new

/*
`uvm_object_utils_begin(counter_transaction)
	`uvm_field_int()
`uvm_object_utils_end

*/
endclass:counter_transaction




class counter_sequence extends uvm_sequence#(counter_transaction);

	`uvm_object_utils(counter_sequence)
	
	function new(string name = "");
		super.new(name);
	endfunction: new

	

	task body();
		counter_transaction trn;
		
		//repeat(10) 
		begin
		trn =counter_transaction::type_id::create(.name("trn"));

		start_item(trn);
		assert(trn.randomize());
		
		finish_item(trn);
		end
	endtask: body


endclass:counter_sequence


