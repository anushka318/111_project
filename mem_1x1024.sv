/*make the data path K bits wide for mem_Kx1024
   K=8 for module mem, K=1 for module mem_disp */ 
module mem_1x1024					(
   input                  clk,
   input                  wr,	 // write enable
   input      [9:0]       addr,     
   input            d_i,      
   output logic     d_o  );
   logic                  mem   [1024];

   logic  mem [0:1023];

   always_ff @(posedge clk) begin
      if (wr) begin
         mem[addr] <= d_i;      // synchronous write
      end
      d_o <= mem[addr];         // synchronous read (like DFF on output)
   end

endmodule
