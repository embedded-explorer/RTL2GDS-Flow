
//input ports
add mapped point clk_i clk_i -type PI PI
add mapped point rst_i rst_i -type PI PI
add mapped point a_i[3] a_i[3] -type PI PI
add mapped point a_i[2] a_i[2] -type PI PI
add mapped point a_i[1] a_i[1] -type PI PI
add mapped point a_i[0] a_i[0] -type PI PI
add mapped point b_i[3] b_i[3] -type PI PI
add mapped point b_i[2] b_i[2] -type PI PI
add mapped point b_i[1] b_i[1] -type PI PI
add mapped point b_i[0] b_i[0] -type PI PI
add mapped point c_i c_i -type PI PI

//output ports
add mapped point s_o[3] s_o[3] -type PO PO
add mapped point s_o[2] s_o[2] -type PO PO
add mapped point s_o[1] s_o[1] -type PO PO
add mapped point s_o[0] s_o[0] -type PO PO
add mapped point c_o c_o -type PO PO

//inout ports




//Sequential Pins
add mapped point genblk2[3].reg_s/q_o/q genblk2[3].reg_s_q_o_reg/Q  -type DFF DFF
add mapped point reg_c/q_o/q reg_c_q_o_reg/Q  -type DFF DFF
add mapped point genblk2[2].reg_s/q_o/q genblk2[2].reg_s_q_o_reg/Q  -type DFF DFF
add mapped point genblk2[1].reg_s/q_o/q genblk2[1].reg_s_q_o_reg/Q  -type DFF DFF
add mapped point genblk2[0].reg_s/q_o/q genblk2[0].reg_s_q_o_reg/Q  -type DFF DFF



//Black Boxes



//Empty Modules as Blackboxes
