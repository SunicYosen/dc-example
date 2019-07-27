module state_tv();

reg clk;
reg reset;
reg compare_result;

wire [3:0] new_state;
wire error;
wire hold;

initial
begin
  $vcdpluson;
  clk = 0;
  reset = 1;
  compare_result = 1;
  #10
  reset = 0;
  #1000 $finish;
end

always #2 clk = ~clk;

state_machine state_machine(.clk(clk),
                            .reset(reset),
                            .compare_result(compare_result),
                            .new_state(new_state),
                            .hold(hold),
                            .error(error));

endmodule