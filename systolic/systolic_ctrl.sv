module systolic_ctrl
   #(parameter dim=32) 
(input clk,rst
 output ctrl
);

//states
    enum logic [1:0] {start  = 2'b00,
                      counter  = 2'b01,
                      finish = 2'b10} next_state, current_state;


int cnt;//counter

always @(posedge clk,negedge rst) begin
    
        if(!nrst)//reset mode -ve edge
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
        start:
            ctrl=1;
            cnt=1;
            next_state=counter
        counter:begin
            cnt=cnt+1;
            if(cnt==dim)
                next_state=finish;
            else
               next_state=counter;
            end
        finish:
            ctrl=0;
     
        default:
            next_state=start;

end

    
endmodule
