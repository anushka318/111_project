module ACS		                        // add-compare-select
(  input       path_0_valid,
   input       path_1_valid,
   input [1:0] path_0_bmc,	            // branch metric computation
   input [1:0] path_1_bmc,				
   input [7:0] path_0_pmc,				// path metric computation
   input [7:0] path_1_pmc,

   output logic        selection,
   output logic        valid_o,
   output logic [7:0] path_cost);  

   wire  [7:0] path_cost_0;			   // branch metric + path metric
   wire  [7:0] path_cost_1;

/* Fill in the guts per ACS instructions
*/
//For each trellis state, adds the branch metric to the path metric, compares possible paths, and selects the best (minimum cost) path.  
 assign path_cost0 = path_0_pmc + path_0_bmc;
 assign path_cost1 = path_1_pmc + path_1_bmc;
 assign selection = (!path_0_valid && path_1_valid) ? 1'b1:
                    (path_0_valid && !path_1_valid) ? 1'b0:
                    (path_cost_0 > path_cost_1) ? 1'b1: 1'b0;
assign valid_o = path_0_valid || path_1_valid;
assign path_cost = (selection == 1'b1) ? path_cost_1 : (selection == 1'b0) ? path_cost_0 : 1'b0;
endmodule
