	


class counter_config extends uvm_object;
	`uvm_object_utils(counter_config)//add it in factory

	function new(string name = "");
		super.new(name);//super because we extended from parent have fun new()
	endfunction: new

endclass: counter_config
