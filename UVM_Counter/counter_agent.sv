	

class counter_agent extends uvm_agent;
	`uvm_component_utils(counter_agent)
	
	uvm_analysis_port#(counter_transaction) agent_port;//Provides a way for any object to send data to a set of subscribers (observers)
	//uvm_analysis_port#(data) port_name;
	//we need to create the port in build phase
	
	counter_sequencer seqr;
	counter_monitor monitor;
	counter_driver driver;
//constructor

	function new(string name, uvm_component parent);
		super.new(name,parent);
	endfunction:new

//build phase (top to bottom)

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		

	agent_port= new(.name("agent_port"),.parent(this));//create agent_port()
	

	seqr=counter_sequencer::type_id::create(.name("seqr"),.parent(this));
	monitor=counter_sequencer::type_id::create(.name("monitor"),.parent(this)) ;
	driver=counter_driver::type_id::create(.name("driver"),.parent(this));

	endfunction:build_phase


//connect phase (bottom to top)
//The UVM calls the connect_phase() method in all UVM components after it has finished calling all the copies of build_phase().

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driver.seq_item_port.connect(seqr.seq_item_export);
		monitor.monitor_port.connect(agent_port);
	endfunction:connect_phase

endclass
	
