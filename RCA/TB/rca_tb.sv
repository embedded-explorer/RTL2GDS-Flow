//--------------------------------------------------------------------
// Design : TB for Ripple Carry Adder with registered sum and carry
//--------------------------------------------------------------------

`timescale 1ns/100ps

module rca_tb();

  parameter N = 4;
  
  logic         clk_i;
  logic         rst_i;
  logic [N-1:0] a_i  ;
  logic [N-1:0] b_i  ;
  logic         c_i  ;
  logic [N-1:0] s_o  ;
  logic         c_o  ;
  
  // Post Synthesis Simulation
  `ifdef POST_SYN_SIM
    logic scan_en = 0;
    logic scan_in = 0;
    logic scan_out;
    rca rca(
      .clk_i    (clk_i    ),
	  .rst_i    (rst_i    ),
      .a_i      (a_i      ),
      .b_i      (b_i      ),
      .c_i      (c_i      ),
      .s_o      (s_o      ),
      .c_o      (c_o      ),
      .SE       (scan_en  ), 
      .scan_in  (scan_in  ),
      .scan_out (scan_out )
    );
    
    initial begin
      $sdf_annotate("../SYN/outputs/delays.sdf",rca_tb.rca,,"post_syn_sim.log","MAXIMUM");
    end
  `else
    rca #(
      .N   (N  )
    )rca(
      .clk_i (clk_i),
	  .rst_i (rst_i),
      .a_i   (a_i  ),
      .b_i   (b_i  ),
      .c_i   (c_i  ),
      .s_o   (s_o  ),
      .c_o   (c_o  )
    );
  `endif
  
  // Clock Generation
  initial begin
    clk_i = 0;
	forever #2.5 clk_i = ~clk_i;
  end
  
  initial begin
    // Initialize Inputs
	rst_i = 1'b0;
	a_i   = 'h0;
	b_i   = 'h0;
	c_i   = 1'b0;
	
	// Apply Reset
	@(posedge clk_i);
	rst_i <= 1'b1;
	repeat(4) @(posedge clk_i);
	rst_i <= 1'b0;
	
	// Apply Stimulus Randomly
    repeat(20)begin
	  {a_i, b_i, c_i} <= {$random%512};
	  @(posedge clk_i);
	end
	@(posedge clk_i);
	#20 $finish;
  end

endmodule
