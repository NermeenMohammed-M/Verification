module systolic_ctrl
   #(parameter row=4) 
   (input clk,rst,
    output ctrl
    );

//states
    enum logic [1:0] {start  = 2'b00,
                      counter  = 2'b01,
                      finish = 2'b10} next_state, current_state;


    int cnt;//counter
    reg out;
    assign ctrl=out;

    always @(posedge clk,negedge rst) begin
    
        if(!rst)//reset mode -ve edge
          begin
            current_state <= start; 
            cnt=0;

          end
        else
          begin
            current_state <= next_state;//go to next state
          end
      
    end

    always@(posedge clk) begin
        case(current_state)
            start:begin
                out=1'b1;
                cnt=1;
                next_state=counter;
            end
            counter:begin
                cnt=cnt+1;
	    //check counter
                if(cnt==row)
                    next_state=finish;
                else
                   next_state=counter;
                end
            finish:begin
                out=1'b0;
	        cnt=0;
     	    end
            default:
                next_state=start;

       endcase
    end

//initial
//$monitor("clk=%b  rst=%b counter=%d  ctrl=%b",clk,rst,cnt,ctrl);
    
endmodule



module ctrl_test;
reg clk,rst;
wire ctrl;



systolic_ctrl ins(.clk(clk),.rst(rst),.ctrl(ctrl));


initial clk=0;

always
#5 clk=~clk;

initial
begin
#10
rst=0;

#10
rst=1;

end

//initial
//$monitor("clk=%b  rst=%b ctrl=%b",clk,rst,ctrl);
endmodule
