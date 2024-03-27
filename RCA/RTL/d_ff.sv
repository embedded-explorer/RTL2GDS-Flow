//--------------------------------------------------------------------
// Design : D Flip Flop with synchronous reset
//--------------------------------------------------------------------

module d_ff(
  input        clk_i, // Clcok
  input        rst_i, // Synchronous Active High Reset
  input        d_i  , // Input
  output logic q_o    // Output
);
  
  always@(posedge clk_i)begin
    if(rst_i)begin
	  q_o <= 1'b0;
	end else begin
	  q_o <= d_i;
	end
  end
  
endmodule
