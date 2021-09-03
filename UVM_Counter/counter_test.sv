

class counter_test extends uvm_test;
	`uvm_component_utils(counter_test)//add to factory


	
	counter_env env;// env handle 

	
//constructor
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
		counter_sequence seq;
		
		phase.raise_objection(.obj(this));//raise obj to know that the run task start(start generation stimulus) (sync.) "like event in oop"

		seq=counter_sequence::type_id::create(.name("seq"));//seq is dynamic no parent
		assert(seq.randomize());
		seq.start(env.agent.seqr);//start seq with seqr

		phase.drop_objection(.obj(this));//drop obj to know that the run task end
	endtask:run_phase


	
	

endclass:counter_test

