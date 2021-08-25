module Counter_8bit 
#(parameter width=8)

(input wire clk_in,
input wire rst_in,
input wire en_ctrl_in,
input wire set_ctrl_in,
input wire up_ctrl_in,
input wire[width-1:0] counter_in,
output reg [width-1:0]counter_out,
output reg ovf_out
);

initial 
begin
counter_out=8'b0;
end



always @(posedge clk_in or negedge rst_in)
begin

	if(~ rst_in)
		begin
			counter_out=8'b0;
			ovf_out=1'b0;
		end

	else if(en_ctrl_in)
	 begin
		
		if(up_ctrl_in)
			counter_out=counter_out+1;
		else
			counter_out=counter_out-1;

		if(counter_out==8'hff)
			ovf_out=1'b1;
		else
			ovf_out=1'b0;
	end
	else if(set_ctrl_in)
	begin
		
		counter_out=counter_in;
	end
end


endmodule


module counter_test;
 reg clk_in;
 reg rst_in;
 reg en_ctrl_in;
 reg set_ctrl_in;
 reg up_ctrl_in;
 reg[7:0] counter_in;
 wire [7:0]counter_out;
 wire ovf_out;


Counter_8bit inst1(.clk_in(clk_in) , .rst_in(rst_in) , .en_ctrl_in(en_ctrl_in) , .set_ctrl_in(set_ctrl_in) , .up_ctrl_in(up_ctrl_in) , .counter_in(counter_in) , .counter_out(counter_out) , .ovf_out(ovf_out));

initial clk_in = 0;
always #10 clk_in = ~clk_in;


initial
begin
#20
rst_in=1'b1;
en_ctrl_in=1'b1;
up_ctrl_in=1'b1;






$monitor("%b %b %b %b %b %b",clk_in,en_ctrl_in,up_ctrl_in,rst_in,counter_out,ovf_out);

end
endmodule
