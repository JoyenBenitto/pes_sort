`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkPes_Sort(CLK,
		  RST_N);
  input  CLK;
  input  RST_N;

  // register lfsr_r
  reg [7 : 0] lfsr_r;
  wire [7 : 0] lfsr_r$D_IN;
  wire lfsr_r$EN;

  // register rg_j1
  reg [31 : 0] rg_j1;
  wire [31 : 0] rg_j1$D_IN;
  wire rg_j1$EN;

  // register rg_j2
  reg [31 : 0] rg_j2;
  wire [31 : 0] rg_j2$D_IN;
  wire rg_j2$EN;

  // ports of submodule sorter
  wire [31 : 0] sorter$get, sorter$put_x;
  wire sorter$EN_get, sorter$EN_put, sorter$RDY_get, sorter$RDY_put;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_drain_outputs,
       CAN_FIRE_RL_rl_feed_inputs,
       WILL_FIRE_RL_rl_drain_outputs,
       WILL_FIRE_RL_rl_feed_inputs;

  // declarations used by system tasks
  // synopsys translate_off
  reg [31 : 0] v__h384;
  reg [31 : 0] v__h493;
  reg [31 : 0] v__h378;
  reg [31 : 0] v__h487;
  // synopsys translate_on

  // remaining internal signals
  wire [31 : 0] v__h194;

  // submodule sorter
  mkBubblesort sorter(.CLK(CLK),
		      .RST_N(RST_N),
		      .put_x(sorter$put_x),
		      .EN_put(sorter$EN_put),
		      .EN_get(sorter$EN_get),
		      .RDY_put(sorter$RDY_put),
		      .get(sorter$get),
		      .RDY_get(sorter$RDY_get));

  // rule RL_rl_feed_inputs
  assign CAN_FIRE_RL_rl_feed_inputs =
	     sorter$RDY_put && (rg_j1 ^ 32'h80000000) < 32'h80000005 ;
  assign WILL_FIRE_RL_rl_feed_inputs = CAN_FIRE_RL_rl_feed_inputs ;

  // rule RL_rl_drain_outputs
  assign CAN_FIRE_RL_rl_drain_outputs =
	     sorter$RDY_get && (rg_j2 ^ 32'h80000000) < 32'h80000005 ;
  assign WILL_FIRE_RL_rl_drain_outputs = CAN_FIRE_RL_rl_drain_outputs ;

  // register lfsr_r
  assign lfsr_r$D_IN =
	     lfsr_r[0] ?
	       { 1'd1, lfsr_r[7:5], ~lfsr_r[4:2], lfsr_r[1] } :
	       { 1'd0, lfsr_r[7:1] } ;
  assign lfsr_r$EN = CAN_FIRE_RL_rl_feed_inputs ;

  // register rg_j1
  assign rg_j1$D_IN = rg_j1 + 32'd1 ;
  assign rg_j1$EN = CAN_FIRE_RL_rl_feed_inputs ;

  // register rg_j2
  assign rg_j2$D_IN = rg_j2 + 32'd1 ;
  assign rg_j2$EN = CAN_FIRE_RL_rl_drain_outputs ;

  // submodule sorter
  assign sorter$put_x = v__h194 ;
  assign sorter$EN_put = CAN_FIRE_RL_rl_feed_inputs ;
  assign sorter$EN_get = CAN_FIRE_RL_rl_drain_outputs ;

  // remaining internal signals
  assign v__h194 = { 24'd0, lfsr_r } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        lfsr_r <= `BSV_ASSIGNMENT_DELAY 8'd1;
	rg_j1 <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_j2 <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (lfsr_r$EN) lfsr_r <= `BSV_ASSIGNMENT_DELAY lfsr_r$D_IN;
	if (rg_j1$EN) rg_j1 <= `BSV_ASSIGNMENT_DELAY rg_j1$D_IN;
	if (rg_j2$EN) rg_j2 <= `BSV_ASSIGNMENT_DELAY rg_j2$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    lfsr_r = 8'hAA;
    rg_j1 = 32'hAAAAAAAA;
    rg_j2 = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_feed_inputs)
	begin
	  v__h384 = $stime;
	  #0;
	end
    v__h378 = v__h384 / 32'd10;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_feed_inputs)
	$display("%0d: x_%0d = %0d",
		 v__h378,
		 $signed(rg_j1),
		 $signed(v__h194));
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_drain_outputs)
	begin
	  v__h493 = $stime;
	  #0;
	end
    v__h487 = v__h493 / 32'd10;
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_drain_outputs)
	$display("                                %0d: y_%0d = %0d",
		 v__h487,
		 $signed(rg_j2),
		 $signed(sorter$get));
    if (RST_N != `BSV_RESET_VALUE)
      if (WILL_FIRE_RL_rl_drain_outputs && rg_j2 == 32'd4) $finish(32'd1);
  end
  // synopsys translate_on
endmodule  // mkPes_Sort

