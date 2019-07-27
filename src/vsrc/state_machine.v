module  state_machine(input          clk,
                      input          reset,
                      input          compare_result,
                      output  [3:0]  new_state,
                      output         hold,
                      output         error);

reg [3:0] state;
reg error_state;

always @(posedge clk)
begin
  if(reset)
  begin
    state <= 4'b1111;
    error_state <= 1'b1;
  end
        
  else if (compare_result)
  begin
    case (state)
      4'b1111: state <= 4'b1111;
      4'b1100: state <= 4'b0011;
      4'b1000: state <= 4'b0100;
      4'b0100: state <= 4'b0011;
      4'b0011: state <= 4'b1111;
      4'b0010: state <= 4'b0001;
      4'b0001: state <= 4'b1111; 
      default: state <= 4'b1111;
    endcase
  end
        
  else
  begin
    case (state)
      4'b1111: state <= 4'b1100;
      4'b1100: state <= 4'b1000;
      4'b1000: error_state <= 1'b1;
      4'b0100: error_state <= 1'b1;
      4'b0011: state <= 4'b0010;
      4'b0010: error_state <= 1'b1;
      4'b0001: error_state <= 1'b1; 
      default: error_state <= 1'b1;
    endcase
  end     
end

assign new_state = state;
assign error = error_state;
assign hold  = !state[0];

endmodule