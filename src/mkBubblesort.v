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

module mkBubblesort(CLK,
		    RST_N,

		    put_x,
		    EN_put,
		    RDY_put,

		    EN_get,
		    get,
		    RDY_get);
  input  CLK;
  input  RST_N;

  // action method put
  input  [31 : 0] put_x;
  input  EN_put;
  output RDY_put;

  // actionvalue method get
  input  EN_get;
  output [31 : 0] get;
  output RDY_get;

  // signals for module outputs
  wire [31 : 0] get;
  wire RDY_get, RDY_put;

  // register rg_inj
  reg [2 : 0] rg_inj;
  wire [2 : 0] rg_inj$D_IN;
  wire rg_inj$EN;

  // register x0
  reg [31 : 0] x0;
  wire [31 : 0] x0$D_IN;
  wire x0$EN;

  // register x1
  reg [31 : 0] x1;
  wire [31 : 0] x1$D_IN;
  wire x1$EN;

  // register x2
  reg [31 : 0] x2;
  wire [31 : 0] x2$D_IN;
  wire x2$EN;

  // register x3
  reg [31 : 0] x3;
  wire [31 : 0] x3$D_IN;
  wire x3$EN;

  // register x4
  reg [31 : 0] x4;
  reg [31 : 0] x4$D_IN;
  wire x4$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_swap_0_1,
       CAN_FIRE_RL_rl_swap_1_2,
       CAN_FIRE_RL_rl_swap_2_3,
       CAN_FIRE_RL_rl_swap_3_4,
       CAN_FIRE_get,
       CAN_FIRE_put,
       WILL_FIRE_RL_rl_swap_0_1,
       WILL_FIRE_RL_rl_swap_1_2,
       WILL_FIRE_RL_rl_swap_2_3,
       WILL_FIRE_RL_rl_swap_3_4,
       WILL_FIRE_get,
       WILL_FIRE_put;

  // inputs to muxes for submodule ports
  wire [2 : 0] MUX_rg_inj$write_1__VAL_2;
  wire MUX_rg_inj$write_1__SEL_1;

  // remaining internal signals
  wire x0_SLE_x1___d3, x1_SLE_x2___d6, x2_SLE_x3___d9, x3_SLE_x4_1___d12;

  // action method put
  assign RDY_put = rg_inj < 3'd5 && x4 == 32'h7FFFFFFF ;
  assign CAN_FIRE_put = rg_inj < 3'd5 && x4 == 32'h7FFFFFFF ;
  assign WILL_FIRE_put = EN_put ;

  // actionvalue method get
  assign get = x0 ;
  assign RDY_get =
	     rg_inj == 3'd5 && x0_SLE_x1___d3 && x1_SLE_x2___d6 &&
	     x2_SLE_x3___d9 &&
	     x3_SLE_x4_1___d12 ;
  assign CAN_FIRE_get = RDY_get ;
  assign WILL_FIRE_get = EN_get ;

  // rule RL_rl_swap_0_1
  assign CAN_FIRE_RL_rl_swap_0_1 = !x0_SLE_x1___d3 ;
  assign WILL_FIRE_RL_rl_swap_0_1 =
	     CAN_FIRE_RL_rl_swap_0_1 && !WILL_FIRE_RL_rl_swap_1_2 ;

  // rule RL_rl_swap_1_2
  assign CAN_FIRE_RL_rl_swap_1_2 = !x1_SLE_x2___d6 ;
  assign WILL_FIRE_RL_rl_swap_1_2 =
	     CAN_FIRE_RL_rl_swap_1_2 && !WILL_FIRE_RL_rl_swap_2_3 ;

  // rule RL_rl_swap_2_3
  assign CAN_FIRE_RL_rl_swap_2_3 = !x2_SLE_x3___d9 ;
  assign WILL_FIRE_RL_rl_swap_2_3 =
	     CAN_FIRE_RL_rl_swap_2_3 && !WILL_FIRE_RL_rl_swap_3_4 ;

  // rule RL_rl_swap_3_4
  assign CAN_FIRE_RL_rl_swap_3_4 = !x3_SLE_x4_1___d12 ;
  assign WILL_FIRE_RL_rl_swap_3_4 = CAN_FIRE_RL_rl_swap_3_4 ;

  // inputs to muxes for submodule ports
  assign MUX_rg_inj$write_1__SEL_1 = EN_get && x1 == 32'h7FFFFFFF ;
  assign MUX_rg_inj$write_1__VAL_2 = rg_inj + 3'd1 ;

  // register rg_inj
  assign rg_inj$D_IN =
	     MUX_rg_inj$write_1__SEL_1 ? 3'd0 : MUX_rg_inj$write_1__VAL_2 ;
  assign rg_inj$EN = EN_get && x1 == 32'h7FFFFFFF || EN_put ;

  // register x0
  assign x0$D_IN = x1 ;
  assign x0$EN = WILL_FIRE_RL_rl_swap_0_1 || EN_get ;

  // register x1
  assign x1$D_IN = WILL_FIRE_RL_rl_swap_0_1 ? x0 : x2 ;
  assign x1$EN =
	     WILL_FIRE_RL_rl_swap_0_1 || WILL_FIRE_RL_rl_swap_1_2 || EN_get ;

  // register x2
  assign x2$D_IN = WILL_FIRE_RL_rl_swap_1_2 ? x1 : x3 ;
  assign x2$EN =
	     WILL_FIRE_RL_rl_swap_1_2 || WILL_FIRE_RL_rl_swap_2_3 || EN_get ;

  // register x3
  assign x3$D_IN = WILL_FIRE_RL_rl_swap_2_3 ? x2 : x4 ;
  assign x3$EN =
	     WILL_FIRE_RL_rl_swap_2_3 || WILL_FIRE_RL_rl_swap_3_4 || EN_get ;

  // register x4
  always@(EN_put or put_x or WILL_FIRE_RL_rl_swap_3_4 or x3 or EN_get)
  begin
    case (1'b1) // synopsys parallel_case
      EN_put: x4$D_IN = put_x;
      WILL_FIRE_RL_rl_swap_3_4: x4$D_IN = x3;
      EN_get: x4$D_IN = 32'h7FFFFFFF;
      default: x4$D_IN = 32'hAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign x4$EN = EN_put || WILL_FIRE_RL_rl_swap_3_4 || EN_get ;

  // remaining internal signals
  assign x0_SLE_x1___d3 = (x0 ^ 32'h80000000) <= (x1 ^ 32'h80000000) ;
  assign x1_SLE_x2___d6 = (x1 ^ 32'h80000000) <= (x2 ^ 32'h80000000) ;
  assign x2_SLE_x3___d9 = (x2 ^ 32'h80000000) <= (x3 ^ 32'h80000000) ;
  assign x3_SLE_x4_1___d12 = (x3 ^ 32'h80000000) <= (x4 ^ 32'h80000000) ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        rg_inj <= `BSV_ASSIGNMENT_DELAY 3'd0;
	x0 <= `BSV_ASSIGNMENT_DELAY 32'h7FFFFFFF;
	x1 <= `BSV_ASSIGNMENT_DELAY 32'h7FFFFFFF;
	x2 <= `BSV_ASSIGNMENT_DELAY 32'h7FFFFFFF;
	x3 <= `BSV_ASSIGNMENT_DELAY 32'h7FFFFFFF;
	x4 <= `BSV_ASSIGNMENT_DELAY 32'h7FFFFFFF;
      end
    else
      begin
        if (rg_inj$EN) rg_inj <= `BSV_ASSIGNMENT_DELAY rg_inj$D_IN;
	if (x0$EN) x0 <= `BSV_ASSIGNMENT_DELAY x0$D_IN;
	if (x1$EN) x1 <= `BSV_ASSIGNMENT_DELAY x1$D_IN;
	if (x2$EN) x2 <= `BSV_ASSIGNMENT_DELAY x2$D_IN;
	if (x3$EN) x3 <= `BSV_ASSIGNMENT_DELAY x3$D_IN;
	if (x4$EN) x4 <= `BSV_ASSIGNMENT_DELAY x4$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    rg_inj = 3'h2;
    x0 = 32'hAAAAAAAA;
    x1 = 32'hAAAAAAAA;
    x2 = 32'hAAAAAAAA;
    x3 = 32'hAAAAAAAA;
    x4 = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkBubblesort

