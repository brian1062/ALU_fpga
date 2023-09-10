`timescale 1ns/100ps
module tb_toplevel();

reg               clock;
reg               reset;
reg   [5:0]        i_sw;
wire  [5:0]       wire_sw;
reg   [2:0]       i_btn;
//wire  [3:0]     wire_led;
wire  [3:0]       o_led;


initial begin
    clock         = 1'b0       ;
    reset         = 1'b0       ;
    i_sw          = 6'b000000  ;
    i_btn         = 3'b000     ;
    #100 reset    = 1'b1       ;
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
    #100000 $finish            ;
end

assign wire_sw = i_sw;

always #5 clock = ~clock;

topv2
#(
  .NB_BTN(3),
  .NB_OP (6),
  .NB_AB (4) //!NB_OPERANDOS
)
  u_topv2
  (
    .o_led  (o_led  ),
    .i_sw   (wire_sw),
    .i_btn  (i_btn  ),
    .clock  (clock  ),
    .i_reset(reset  )
  );

endmodule