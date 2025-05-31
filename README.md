Part 1 Objective: Complete the decoder Verilog starter files to make it run successfully
on the test bench provided on Canvas (viterbi_tx_rx_tb.sv). For part 1, disable error
injection in the channel (in viterbi_tx_rx1.sv) which connects the encoder output to the
decoder input. Complete decoder.sv and its submodules.
Part 1 deliverables:
1) Your working SV code, the Questa/ModelSim transcript, and proof of synthesis (either
Quartus RTL viewer diagram or Mentor Precision netlist text, plus utilization report).
Transcript will show your score / 256 trials.
2) Explain how this encoder works, since it differs somewhat from the Homework 7 unit,
although similar in principle. Use this encoder with the decoder – your Homework 7
encoder will provide decoder input vectors that won’t work with this design.
3) Explain how the decoder works and show that the minimum branch metric = 0 when
no errors are present. How does the decoder determine what sequence of bits was sent to
the encoder?
