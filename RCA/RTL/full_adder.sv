//--------------------------------------------------------------------
// Design : Full Adder
//--------------------------------------------------------------------

module full_adder(
  input  a_i, // A Input
  input  b_i, // B Input
  input  c_i, // Carry Input
  output s_o, // Sum Output
  output c_o  // Carry Output
);
  
  // Sum
  assign s_o = a_i ^ b_i ^ c_i;
  // Carry
  assign c_o = (a_i & b_i) | (b_i & c_i) | (a_i & c_i);
  
endmodule
