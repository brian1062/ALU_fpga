`timescale 1ns/100ps
module tb_toplevel();

reg                        clock;
reg                        reset;
reg    [5:0]                i_sw;
reg    [2:0]               i_btn;
wire   [5:0]               o_led;


initial begin
    clock         = 1'b0       ;
    reset         = 1'b0       ;
    i_sw          = 6'b000000  ;
    i_btn         = 3'b000     ;
    #100 @(posedge clock) reset    = 1'b1       ;
    #110 reset    = 1'b0       ;
    #110 i_sw     = 6'b000100  ;
    #110 i_btn    = 3'b001     ;
    #115 i_btn    = 3'b000     ;
    #120 i_sw     = 6'b001111  ;
    #120 i_btn    = 3'b010     ;
    #125 i_btn    = 3'b000     ;
    #130 i_sw     = 6'b100000  ;
    #125 i_btn    = 3'b100     ;
    #130 i_btn    = 3'b000     ;
    #130 reset    = 1'b1       ;
    #135 reset    = 1'b0       ;
    #135 i_sw     = 6'b000011  ; //SRA
    #135 @(posedge clock) i_btn    = 3'b010     ;
    #140 @(posedge clock) i_btn    = 3'b000     ;
    #145 i_sw     = 6'b101011  ;
    #150 @(posedge clock )i_btn    = 3'b001     ;
    #155 @(posedge clock) i_btn    = 3'b000     ;
    #160 i_sw     = 6'b000011  ;
    #165 @(posedge clock) i_btn    = 3'b100     ;
    #170 @(posedge clock) i_btn    = 3'b000     ;
    #100000 $finish            ;
end

//assign wire_sw = i_sw;

always #5 clock = ~clock;

topv2
#(
  .NB_BTN(3),
  .NB_OP (6),
  .NB_AB (6) //!NB_OPERANDOS
)
  u_topv2
  (
    .o_led  (o_led  ),
    .i_sw   (i_sw),
    .i_btn  (i_btn  ),
    .clock  (clock  ),
    .i_reset(reset  )
  );

endmodule