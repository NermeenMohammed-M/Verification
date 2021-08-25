


class counter_test extends uvm_test;
	`uvm_component_utils(counter_test)//add to factory

//constructor
	
	counter_env env;// env handle 
	function new(string name , uvm_component parent);
		super.new(name,parent);
	endfunction:new

//build phase
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env=counter_env::type_id::create(.name("env"),.parent(this));//create env using factory (instead new()) with name env and parent (this class)
	endfunction:build_phase
	

	
//run phase
	
	task run_phase(uvm_phase phase);
		counter_sequencer seqr;
		
		phase.raise_objection(.obj(this));//raise obj to now that the run task start (sync.)
		seqr=counter_sequence::type_id::create(.name("seq"));//seq is dynamic no parent
		assert(seqr.randomize());

		seqr.start(env.agent.seqr);//start seq with seqr

		phase.drop_objection(.obj(this));
	endtask:run_phase


	
	

endclass:counter_test

