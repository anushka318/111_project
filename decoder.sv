module decoder
(
   input             clk,
   input             rst,
   input             enable,
   input [1:0]       d_in,
   output logic      d_out);

// -------- BMC Module Signals --------
// BMC for Branch Metric Computations


   // For N = 0 and for K = 0,1,...7
   wire  [1:0]       bmc0_path_0_bmc;  
   wire  [1:0]       bmc1_path_0_bmc;  
   wire  [1:0]       bmc2_path_0_bmc;  
   wire  [1:0]       bmc3_path_0_bmc;  
   wire  [1:0]       bmc4_path_0_bmc;  
   wire  [1:0]       bmc5_path_0_bmc;  
   wire  [1:0]       bmc6_path_0_bmc;  
   wire  [1:0]       bmc7_path_0_bmc;  

   // For N = 1 and for K = 0,1,...7
   wire  [1:0]       bmc0_path_1_bmc;
   wire  [1:0]       bmc1_path_1_bmc; 
   wire  [1:0]       bmc2_path_1_bmc;
   wire  [1:0]       bmc3_path_1_bmc;
   wire  [1:0]       bmc4_path_1_bmc;
   wire  [1:0]       bmc5_path_1_bmc;
   wire  [1:0]       bmc6_path_1_bmc;
   wire  [1:0]       bmc7_path_1_bmc;


// -------- ACS Module Signals --------
// Add Compare Select Modules for Path Metric Computations

   logic   [7:0]       validity;
   logic   [7:0]       selection;
   logic   [7:0]       path_cost   [8];
   wire    [7:0]       validity_nets;
   wire    [7:0]       selection_nets;

   // For K = 0,1,...7 Selection Signals
   wire              ACS0_selection;  
   wire              ACS1_selection;  
   wire              ACS2_selection;  
   wire              ACS3_selection;  
   wire              ACS4_selection;  
   wire              ACS5_selection;  
   wire              ACS6_selection;  
   wire              ACS7_selection; 

   // For K = 0,1,...7 Validity Signals
   wire              ACS0_valid_o;
   wire              ACS1_valid_o;
   wire              ACS2_valid_o;
   wire              ACS3_valid_o;
   wire              ACS4_valid_o;
   wire              ACS5_valid_o;
   wire              ACS6_valid_o;
   wire              ACS7_valid_o;

   // For K = 0,1,...7 Path Cost Signals
   wire  [7:0]       ACS0_path_cost;
   wire  [7:0]       ACS1_path_cost;
   wire  [7:0]       ACS2_path_cost;
   wire  [7:0]       ACS3_path_cost;
   wire  [7:0]       ACS4_path_cost;
   wire  [7:0]       ACS5_path_cost;
   wire  [7:0]       ACS6_path_cost;   
   wire  [7:0]       ACS7_path_cost;



// -------- Memory Module Signals --------
//Trelis memory write operation, pipeline delay
   logic   [1:0]       mem_bank;
   logic   [1:0]       mem_bank_Q;
   logic   [1:0]       mem_bank_Q2;
   logic               mem_bank_Q3;
   logic               mem_bank_Q4;
   logic               mem_bank_Q5;
   logic   [9:0]       wr_mem_counter;
   logic   [9:0]       rd_mem_counter;

// 4 memory banks -- address pointers 	  (there are 4 of these)
   logic   [9:0]       addr_mem_A;	// A
   logic   [9:0]       addr_mem_B;	// B
   logic   [9:0]       addr_mem_C;	// C
   logic   [9:0]       addr_mem_D;	// D

// write enables
   logic               wr_mem_A;	// A
   logic               wr_mem_B;	// B
   logic               wr_mem_C;	// C
   logic               wr_mem_D;	// D

// data to memories
   logic   [7:0]       d_in_mem_A;	// A
   logic   [7:0]       d_in_mem_B;	// B
   logic   [7:0]       d_in_mem_C;	// C
   logic   [7:0]       d_in_mem_D;	// D

// data from memories
   wire    [7:0]       d_o_mem_A;   // A	
   wire    [7:0]       d_o_mem_B;   // B
   wire    [7:0]       d_o_mem_C;   // C
   wire    [7:0]       d_o_mem_D;   // D
		  
//Trace back module signals
   logic               selection_tbu_0;
   logic               selection_tbu_1;

   logic   [7:0]       d_in_0_tbu_0;
   logic   [7:0]       d_in_1_tbu_0;
   logic   [7:0]       d_in_0_tbu_1;
   logic   [7:0]       d_in_1_tbu_1;

   wire                d_o_tbu_0;
   wire                d_o_tbu_1;

   logic               enable_tbu_0;
   logic               enable_tbu_1;

//Display memory operations 
   wire                wr_disp_mem_0;
   wire                wr_disp_mem_1;

   wire                d_in_disp_mem_0;
   wire                d_in_disp_mem_1;

   logic   [9:0]       wr_mem_counter_disp;
   logic   [9:0]       rd_mem_counter_disp;

   logic   [9:0]       addr_disp_mem_0;
   logic   [9:0]       addr_disp_mem_1;


// ---------------------------------------
// -------- MODULE INSTANTIATIONS --------
// ---------------------------------------


//Branch Metric Computation Modules (8 total)
   bmc0   bmc0_inst( d_in,bmc0_path_0_bmc,bmc0_path_1_bmc);
   bmc1   bmc1_inst( d_in,bmc1_path_0_bmc,bmc1_path_1_bmc);
   bmc2   bmc2_inst( d_in,bmc2_path_0_bmc,bmc2_path_1_bmc);
   bmc3   bmc3_inst( d_in,bmc3_path_0_bmc,bmc3_path_1_bmc);
   bmc4   bmc4_inst( d_in,bmc4_path_0_bmc,bmc4_path_1_bmc);
   bmc5   bmc5_inst( d_in,bmc5_path_0_bmc,bmc5_path_1_bmc);
   bmc6   bmc6_inst( d_in,bmc6_path_0_bmc,bmc6_path_1_bmc);
   bmc7   bmc7_inst( d_in,bmc7_path_0_bmc,bmc7_path_1_bmc);
// Note: bmc is a module that computes the branch metric for each path based on the input data d_in.

//Add Compare Select Modules (8 copies -- note pattern in connections!!)
// i = 0, 1, ... 7        j = 0, 3, 4, 7, 1, 2, 5, 6       k = 1, 2, 5, 6, 0, 3, 4, 7  -- these create lattice butterfly connection pattern
// ACS      ACSi(validity[j],validity[k],bmci_path_i_bmc,bmci_path_1_bmc,path_cost[j],path_cost[k],ACSi_selection,ACSi_valid_o,ACSi_path_cost);
   ACS      ACS0(validity[0],validity[1],bmc0_path_0_bmc,bmc0_path_1_bmc,path_cost[0],path_cost[1],ACS0_selection,ACS0_valid_o,ACS0_path_cost);
   ACS      ACS1(validity[3],validity[2],bmc1_path_0_bmc,bmc1_path_1_bmc,path_cost[3],path_cost[2],ACS1_selection,ACS1_valid_o,ACS1_path_cost);
   ACS      ACS2(validity[4],validity[5],bmc2_path_0_bmc,bmc2_path_1_bmc,path_cost[4],path_cost[5],ACS2_selection,ACS2_valid_o,ACS2_path_cost);
   ACS      ACS3(validity[7],validity[6],bmc3_path_0_bmc,bmc3_path_1_bmc,path_cost[7],path_cost[6],ACS3_selection,ACS3_valid_o,ACS3_path_cost);
   ACS      ACS4(validity[1],validity[0],bmc4_path_0_bmc,bmc4_path_1_bmc,path_cost[1],path_cost[0],ACS4_selection,ACS4_valid_o,ACS4_path_cost);
   ACS      ACS5(validity[2],validity[3],bmc5_path_0_bmc,bmc5_path_1_bmc,path_cost[2],path_cost[3],ACS5_selection,ACS5_valid_o,ACS5_path_cost);
   ACS      ACS6(validity[5],validity[4],bmc6_path_0_bmc,bmc6_path_1_bmc,path_cost[5],path_cost[4],ACS6_selection,ACS6_valid_o,ACS6_path_cost);
   ACS      ACS7(validity[6],validity[7],bmc7_path_0_bmc,bmc7_path_1_bmc,path_cost[6],path_cost[7],ACS7_selection,ACS7_valid_o,ACS7_path_cost);
   
   assign validity_nets    = {ACS7_valid_o, ACS6_valid_o, ACS5_valid_o, ACS4_valid_o, ACS3_valid_o, ACS2_valid_o, ACS1_valid_o, ACS0_valid_o};
   assign selection_nets   = {ACS7_selection, ACS6_selection, ACS5_selection, ACS4_selection, ACS3_selection, ACS2_selection, ACS1_selection, ACS0_selection};
   

   // --- Memory Bank Management Signals --- //
   always @ (posedge clk, negedge rst) begin
      if(!rst)  begin
         validity          <= 8'b1;
         selection         <= 8'b0;
         /* clear all 8 path costs
                  path_cost[i]      <= 8'd0;
         */
         path_cost[0]      <= 8'd0;
         path_cost[1]      <= 8'd0;
         path_cost[2]      <= 8'd0;
         path_cost[3]      <= 8'd0;
         path_cost[4]      <= 8'd0;
         path_cost[5]      <= 8'd0;
         path_cost[6]      <= 8'd0;
         path_cost[7]      <= 8'd0;
      end
      else if(!enable)   begin
         validity          <= 8'b1;
         selection         <= 8'b0;
         /* clear all 8 path costs
                  path_cost[i]      <= 8'd0;
         */        
         path_cost[0]      <= 8'd0;
         path_cost[1]      <= 8'd0;
         path_cost[2]      <= 8'd0;
         path_cost[3]      <= 8'd0;
         path_cost[4]      <= 8'd0;
         path_cost[5]      <= 8'd0;
         path_cost[6]      <= 8'd0;
         path_cost[7]      <= 8'd0;

         if (enable_tbu_0 || enable_tbu_1) begin
            // reset the memory bank
            mem_bank          <= 2'b00;	// A
         end

      else if (&{path_cost[0][7], path_cost[1][7], path_cost[2][7], path_cost[3][7], path_cost[4][7], path_cost[5][7], path_cost[6][7], path_cost[7][7]})  // all MSBs are 1
      // Reduction 7 of all path costs
      begin
         validity          <= validity_nets;
         selection         <= selection_nets;
      
         // path_cost[K]      <= 8'b01111111 & ACSK_path_cost;	 // K = 0, 1, ..., 7
         path_cost[0]   <= 8'b01111111 & ACS0_path_cost;
         path_cost[1]   <= 8'b01111111 & ACS1_path_cost;
         path_cost[2]   <= 8'b01111111 & ACS2_path_cost;
         path_cost[3]   <= 8'b01111111 & ACS3_path_cost;
         path_cost[4]   <= 8'b01111111 & ACS4_path_cost;
         path_cost[5]   <= 8'b01111111 & ACS5_path_cost;
         path_cost[6]   <= 8'b01111111 & ACS6_path_cost;
         path_cost[7]   <= 8'b01111111 & ACS7_path_cost;

      end
      else   begin
         validity          <= validity_nets;
         selection         <= selection_nets;

         // path_cost[K]      <= ACSK_path_cost;	          // K = 0, 1, ..., 7
         path_cost[0]   <= ACS0_path_cost;
         path_cost[1]   <= ACS1_path_cost;
         path_cost[2]   <= ACS2_path_cost;
         path_cost[3]   <= ACS3_path_cost;
         path_cost[4]   <= ACS4_path_cost;
         path_cost[5]   <= ACS5_path_cost;
         path_cost[6]   <= ACS6_path_cost;
         path_cost[7]   <= ACS7_path_cost;

      end
   end


   // --- MEMORY BANK MANAGEMENT --- //
   // if rst (active low) or not enabling (active high), force to 0; else, increment by 1
   
   // --- Write Operation ---- //
   always @ (posedge clk, negedge rst) begin	  // wr_mem_counter   commands
      if(!rst)
         wr_mem_counter <= 10'd0;	// set to min value
      else if(!enable)
         wr_mem_counter <= wr_mem_counter;	// keep same value
      else if(wr_mem_counter == 10'd1023)	// max value
         wr_mem_counter <= 10'd0;	// reset to min value
      else
         wr_mem_counter <= wr_mem_counter + 10'd1;	// increment by 1
   end

   // --- Read Operation ---- //
   always @ (posedge clk, negedge rst) begin
      if(!rst)
         rd_mem_counter <= 10'd1023; // set to max value
      else if(enable)
         rd_mem_counter <= rd_mem_counter - 10'd1 // count down by 1
   end

   always @ (posedge clk, negedge rst)
      if(!rst)
         mem_bank <= 2'b0;
      else begin
         /*if(wr_mem_counter = -1  fill in the guts*/
         if(!enable)
            mem_bank <= 2'b0;	// reset to 0
         else if(wr_mem_counter == 10'd1023)	// max value
            mem_bank <= 2'b0;	// reset to 0
         else if(wr_mem_counter == 10'd0)	// min value
            mem_bank <= 2'b0;	// reset to 0
         else if(mem_bank == 2'b11)	// max value
            mem_bank <= 2'b0;	// reset to 0
         else
               mem_bank <= mem_bank + 2'b1;
      end

   always @ (posedge clk)    begin
      d_in_mem_k  <= selection;		  // k = A, B, C, D
   end

// ---- MEMORY BANK MANAGEMENT ---- //
// * Always write to one
// * Read from two others
// * Keep address at 0 (no writing) for fourth one

   always @ (posedge clk)     	  
      case(mem_bank)
         2'b00: begin       /// write to A, clear C, read from others
            wr_mem_A        <= 1'b1;	// write to A
            wr_mem_B        <= 1'b0;	// read B
            wr_mem_C        <= 1'b0;	// clear C
            wr_mem_D        <= 1'b0;	// read D

            addr_mem_A      <= wr_mem_counter; // write address for A
            addr_mem_B      <= rd_mem_counter; // read address for B
            addr_mem_C      <= 10'd0;          // read address for C
            addr_mem_D      <= rd_mem_counter; // read address for D
         end  

         2'b01: begin       // write to B, clear D, read from others
            wr_mem_A        <= 1'b0;	// read A
            wr_mem_B        <= 1'b1;	// write B
            wr_mem_C        <= 1'b0;	// read C
            wr_mem_D        <= 1'b0;	// clear D

            addr_mem_A      <= rd_mem_counter; // read address for A
            addr_mem_B      <= wr_mem_counter; // write address for B
            addr_mem_C      <= rd_mem_counter; // read address for C
            addr_mem_D      <= 10'd0;          // clear address for D
         end         	 	 

         2'b10: begin      // write to C, clear A, read from others
            wr_mem_A        <= 1'b0;	// clear A
            wr_mem_B        <= 1'b0;	// read B
            wr_mem_C        <= 1'b1;	// write C
            wr_mem_D        <= 1'b0;	// read D

            addr_mem_A      <= 10'd0;          // clear address for A
            addr_mem_B      <= rd_mem_counter; // read address for B
            addr_mem_C      <= wr_mem_counter; // write address for C
            addr_mem_D      <= rd_mem_counter; // read address for D
         end         	 	

         2'b11: begin      // write to D, clear B, read from others
            wr_mem_A        <= 1'b0;	// read A
            wr_mem_B        <= 1'b0;	// clear B
            wr_mem_C        <= 1'b0;	// read C
            wr_mem_D        <= 1'b1;	// write to D

            addr_mem_A      <= rd_mem_counter; // read address for A
            addr_mem_B      <= 10'd0;          // clear address for B
            addr_mem_C      <= rd_mem_counter; // read address for C
            addr_mem_D      <= wr_mem_counter; // write address for D
         end         	 
      endcase
   end
// memory bank management: always write to one, read from two others, keep address at 0 (no writing) for fourth one


//Trelis memory module instantiation

   mem_8x1024   trelis_mem_A	   (
      .clk,
      .wr  (wr_mem_A),
      .addr(addr_mem_A),
      .d_i (d_in_mem_A),
      .d_o (d_o_mem_A)
   );
   mem_8x1024   trelis_mem_B	   (
      .clk,
      .wr  (wr_mem_B),
      .addr(addr_mem_B),
      .d_i (d_in_mem_B),
      .d_o (d_o_mem_B)
   );
   mem_8x1024   trelis_mem_C	   (
      .clk,
      .wr  (wr_mem_C),
      .addr(addr_mem_C),
      .d_i (d_in_mem_C),
      .d_o (d_o_mem_C)
   );
   mem_8x1024   trelis_mem_D	   (
      .clk,
      .wr  (wr_mem_D),
      .addr(addr_mem_D),
      .d_i (d_in_mem_D),
      .d_o (d_o_mem_D)
   );
// Note: trelis_mem_A, trelis_mem_B, trelis_mem_C, and trelis_mem_D are memory modules that store the path metrics for each path.

//Trace back module operation

   always @(posedge clk) begin
      /* create mem_bank, mem_bank_Q1, mem_bank_Q2 pipeline */
      mem_bank_Q   <= mem_bank;	   // pipeline stage 1
      mem_bank_Q2  <= mem_bank_Q;   // pipeline stage 2
   end
// Note: mem_bank_Q, mem_bank_Q2, mem_bank_Q3, mem_bank_Q4, and mem_bank_Q5 are pipelined versions of the memory bank signal.

   always @ (posedge clk, negedge rst)
      if(!rst)
            enable_tbu_0   <= 1'b0;
      else if(mem_bank_Q2==2'b10)
            enable_tbu_0   <= 1'b1;

   always @ (posedge clk, negedge rst)
      if(!rst)
            enable_tbu_1   <= 1'b0;
      else if(mem_bank_Q2==2'b11)
            enable_tbu_1   <= 1'b1;
   
   always @ (posedge clk)
      case(mem_bank_Q2)
         2'b00:	  begin
            d_in_0_tbu_0   <= d_o_mem_D;
            d_in_1_tbu_0   <= d_o_mem_C;
            
            d_in_0_tbu_1   <= d_o_mem_C;
            d_in_1_tbu_1   <= d_o_mem_B;

            selection_tbu_0<= 1'b0;
            selection_tbu_1<= 1'b1;

         end
         2'b01:	   begin
            d_in_0_tbu_0   <= d_o_mem_D;
            d_in_1_tbu_0   <= d_o_mem_C;
            
            d_in_0_tbu_1   <= d_o_mem_A;
            d_in_1_tbu_1   <= d_o_mem_D;
            
            selection_tbu_0<= 1'b1;
            selection_tbu_1<= 1'b0;
         end
         2'b10:	   begin
            d_in_0_tbu_0   <= d_o_mem_B;
            d_in_1_tbu_0   <= d_o_mem_A;
            
            d_in_0_tbu_1   <= d_o_mem_A;
            d_in_1_tbu_1   <= d_o_mem_D;

            selection_tbu_0<= 1'b0;
            selection_tbu_1<= 1'b1;
         end
         2'b11:	  begin
            d_in_0_tbu_0   <= d_o_mem_B;
            d_in_1_tbu_0   <= d_o_mem_A;
            
            d_in_0_tbu_1   <= d_o_mem_C;
            d_in_1_tbu_1   <= d_o_mem_B;

            selection_tbu_0<= 1'b1;
            selection_tbu_1<= 1'b0;
         end
      endcase

//Trace-Back modules instantiation

   tbu tbu_0   (
      .clk,
      .rst,
      .enable(enable_tbu_0),
      .selection(selection_tbu_0),
      .d_in_0(d_in_0_tbu_0),
      .d_in_1(d_in_1_tbu_0),
      .d_o(d_o_tbu_0),
      .wr_en(wr_disp_mem_0)
   );
   tbu tbu_1   (
      .clk,
      .rst,
      .enable(enable_tbu_1),
      .selection(selection_tbu_1),
      .d_in_0(d_in_0_tbu_1),
      .d_in_1(d_in_1_tbu_1),
      .d_o(d_o_tbu_1),
      .wr_en(wr_disp_mem_1)
   );

   
//Display Memory modules Instantioation
//   d_in_disp_mem_K   =  d_o_tbu_K;  K=0,1
assign d_in_disp_mem_0 = d_o_tbu_0; // input to display memory 0
assign d_in_disp_mem_1 = d_o_tbu_1; // input to display memory 1

  mem_disp   mem_1x10	  (
      .clk              ,
      .wr(wr_disp_mem_0),
      .addr(addr_disp_mem_0),
      .d_i(d_in_disp_mem_0),
      .d_o(d_o_disp_mem_0)
   );
   mem_disp   disp_mem_1	  (
      .clk              ,
      .wr(wr_disp_mem_1),
      .addr(addr_disp_mem_1),
      .d_i(d_in_disp_mem_1),
      .d_o(d_o_disp_mem_1)
   );

// Display memory module operation
   always @ (posedge clk)
      mem_bank_Q3 <= mem_bank_Q2[0];

   always @ (posedge clk)
      if(!rst)
         wr_mem_counter_disp  <=  10'd0 + 10'd2;
      else if(!enable)
         wr_mem_counter_disp  <= 10'd0 + 10'd2; //same
      else
         wr_mem_counter_disp <= wrr_mem_counter_disp - 10'd1;
//       decrement wr_mem_counter_disp    

   always @ (posedge clk)
      if(!rst)
         rd_mem_counter_disp  <= 10'd1023 - 10'd2 //max value - 2
      else if(!enable)
         rd_mem_counter_disp  <= 10'd1023 - 10'd2//same
      else         // increment    rd_mem_counter_disp  
         rd_mem_counter_disp <= rd_mem_counter_disp + 1'd1; // increment by 1   
   
   always @ (posedge clk)
      if (!mem_bank_Q3)
         begin
            addr_disp_mem_0   <= rd_mem_counter_disp; 
            addr_disp_mem_1   <= wr_mem_counter_disp;
         end
     //  else:	 swap rd and wr 
         else
         begin
            addr_disp_mem_0   <= wr_mem_counter_disp; 
            addr_disp_mem_1   <= rd_mem_counter_disp;
         end
      

   always @ (posedge clk) 	 
      if(!rst)
         d_out <= 1'b0;	// reset to 0
      else if(!enable)
         d_out <= d_out;	// keep same value
      else if(mem_bank_Q3)	// if mem_bank_Q3 is 1, then use d_o_tbu_1
         d_out <= d_o_tbu_1;
      else			// else use d_o_tbu_0
         d_out <= d_o_tbu_0;

/* pipeline mem_bank_Q3 to Q4 to Q5
 also  d_out = d_o_disp_mem_i 
    i = mem_bank_Q5 
*/

   always @ (posedge clk) begin
      mem_bank_Q4 <= mem_bank_Q3; // pipeline stage 4
      mem_bank_Q5 <= mem_bank_Q4; // pipeline stage 5
   end

   assign d_out = (mem_bank_Q5) ? d_o_tbu_1 : d_o_tbu_0; // output from trace back module

endmodule
