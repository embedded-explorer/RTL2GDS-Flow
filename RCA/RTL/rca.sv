//--------------------------------------------------------------------
// Design : Ripple Carry Adder with registered sum and carry
//--------------------------------------------------------------------

module rca#(
  parameter N = 4
)(
  input          clk_i, // Clcok
  input          rst_i, // Synchronous Active High Reset
  input  [N-1:0] a_i  , // 4-Bit A Input
  input  [N-1:0] b_i  , // 4-Bit B Input
  input          c_i  , // Carry Input
  output [N-1:0] s_o  , // Registered Sum Output
  output         c_o    // Registered Carry Output
);
  
  logic [N-1:0] s; // Internal Sum
  logic [N  :0] c; // Internal Carry
  
  genvar i;
  
  assign c[0] = c_i;
  // Instntiate Chain of Full Adders
  generate
    for(i=0; i<N; i=i+1)begin
	  full_adder fa(
        .a_i (a_i[i]),
        .b_i (b_i[i]),
        .c_i (c[i]  ),
        .s_o (s[i]  ),
        .c_o (c[i+1]) 
      );
	end
  endgenerate
  
  // Register Sum Output
  generate
    for(i=0; i<N; i=i+1)begin
	  d_ff reg_s(
        .clk_i (clk_i ),
        .rst_i (rst_i ),
        .d_i   (s[i]  ),
        .q_o   (s_o[i])
      );
	end
  endgenerate
  
  // Register Carry Output
  d_ff reg_c(
    .clk_i (clk_i ),
    .rst_i (rst_i ),
    .d_i   (c[N]  ),
    .q_o   (c_o   )
  );
  
endmodule
