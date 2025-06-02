module tbu
(
   input       clk,
   input       rst,
   input       enable,
   input       selection,
   input [7:0] d_in_0,
   input [7:0] d_in_1,
   output logic  d_o,
   output logic  wr_en);

   logic         d_o_reg;
   logic         wr_en_reg;
   
   logic   [2:0] pstate;
   logic   [2:0] nstate;

   logic         selection_buf;

   always @(posedge clk)    begin
      selection_buf  <= selection;
      wr_en          <= wr_en_reg;
      d_o            <= d_o_reg;
   end
   always @(posedge clk, negedge rst) begin
     if (!rst) begin
        pstate <= 3'b000;
        d_o_reg <= 1'b0;
        wr_en_reg <= 1'b0;
     end else if (enable) begin
        pstate <= nstate;
        wr_en_reg <= selection;
        d_o_reg <= selection? d_in_1[pstate] : 0;
     end
   end
   //pstate goes from 0 to 7
   //nstate goes from 0 to 7
   always @(*) begin
      case (pstate)
         3'b000: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[0] == 1'b0) ? 'd0 : 'd1):
                                               ((d_in_1[0] == 1'b0) ? 'd0 : 'd1);
            end else begin
               nstate = 3'b000;
            end
         end
         3'b001: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[1] == 1'b0) ? 'd3 : 'd2):
                                               ((d_in_1[1] == 1'b0) ? 'd3 : 'd2);            
            end else begin
               nstate = 3'b000;
            end
         end
         3'b010: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[2] == 1'b0) ? 'd4 : 'd5):
                                               ((d_in_1[2] == 1'b0) ? 'd4 : 'd5);       
            end else begin
               nstate = 3'b000;
            end
         end
         3'b011: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[3] == 1'b0) ? 'd7 : 'd6):
                                               ((d_in_1[3] == 1'b0) ? 'd7 : 'd6);       
            end else begin
               nstate = 3'b000;
            end
         end
         3'b100: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[4] == 1'b0) ? 'd1 : 'd0):
                                               ((d_in_1[4] == 1'b0) ? 'd1 : 'd0);       
            end else begin
               nstate = 3'b000;
            end
         end
         3'b101: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[5] == 1'b0) ? 'd2 : 'd3):
                                               ((d_in_1[5] == 1'b0) ? 'd2 : 'd3);       
            end else begin
               nstate = 3'b000;
            end
         end
         3'b110: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[6] == 1'b0) ? 'd5 : 'd4):
                                               ((d_in_1[6] == 1'b0) ? 'd5 : 'd4);       
            end else begin
               nstate = 3'b000;
            end
         end
         3'b111: begin
            if (enable) begin
               nstate = (selection_buf == 0) ? ((d_in_0[7] == 1'b0) ? 'd6 : 'd7):
                                               ((d_in_1[7] == 1'b0) ? 'd6 : 'd7);       
            end else begin
               nstate = 3'b000;
            end
         end
         default: begin
            nstate = 3'b000; // default case to handle unexpected states
         end
      endcase
   end
endmodule