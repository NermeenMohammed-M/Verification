

class counter_env extends uvm_component;
	`uvm_component_utils(counter_env)

	
	counter_agent agent;
	counter_scoreboard sb;
//constructor
	function new(string name,uvm_component parent);
		super.new(name,parent);
	endfunction:new

//build phase

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		agent=counter_agent::type_id::create(.name(agent),.parent(this));
		sb=counter_scoreboard::type_id::create(.name(sb),.parent(this));
	endfunction:build_phase

//connect phase

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		
		agent.agent_port.connect(sb.sb_export);

	endfunction:connect_phase


	
endclass:counter_env