/* For our constraint length = 3, there will be 2**3 = 8
of these, but unlike ACS, not all are identical. 
*/
											   
module bmc4				  // branch metric computation
(
   input    [1:0] rx_pair,
   output   [1:0] path_0_bmc,
   output   [1:0] path_1_bmc);

  /*
  These modules are identical except as noted here:
tmp00 = rx_pair[0]; tmp01 = rx_pair[1]
exception: for bmc 1,2,5, and 6, invert rx_pair[1] in the above expression
tmp10 = !tmp00 tmp 11 = !tmp01
path_0_bmc[1] = tmp00 & tmp01
path_0_bmc[0] = tmp00 ^ tmp01
same for path_1_bmc with tmp10 and tmp11
*/
logic tmp00, tmp01, tmp10, tmp11;
assign tmp00 = rx_pair[0];
assign tmp01 = rx_pair[1]; // Invert for bmc 1,2,5,6
assign tmp10 = !tmp00;
assign tmp11 = !tmp01;

assign path_0_bmc[1] = tmp00 & tmp01;
assign path_0_bmc[0] = tmp00 ^ tmp01;
assign path_1_bmc[1] = tmp10 & tmp11;
assign path_1_bmc[0] = tmp10 ^ tmp11;
endmodule
