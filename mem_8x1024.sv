/*make the data path K bits wide for mem_Kx1024
   K=8 for module mem, K=1 for module mem_disp */ 
module mem_8x1024 (
   input              clk,
   input              wr,       
   input      [9:0]   addr,     
   input      [7:0]   d_i,      
   output logic [7:0] d_o       
);

   logic [7:0] mem [0:1023];

   always_ff @(posedge clk) begin
      if (wr) begin
         mem[addr] <= d_i;      // synchronous write
      end
      d_o <= mem[addr];         // synchronous read (like DFF on output)
   end

endmodule
