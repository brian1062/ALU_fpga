`timescale 1ns/100ps
module tb_toprandom();

parameter NB_BTN = 3;
parameter NB_AB  = 6;

reg                        clock;
reg                        reset;
reg    [NB_BTN-1:0]        i_btn;
reg    [NB_AB -1:0]         i_sw;
wire   [NB_AB -1:0]        o_led;
reg    [NB_AB -1:0]       a_data;


initial begin
    clock                          = 1'b0       ;
    reset                          = 1'b0       ;
    i_btn                          = 3'b000     ;
    #10  @(posedge clock) reset    = 1'b1       ;
    #10  @(posedge clock) reset    = 1'b0       ;
    #10;
    i_sw                      = 6'b100000  ;   //SUMA
    #10;
    i_btn                     = 3'b100     ;   
    #10;
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b, B: %b, Result: %b", $time, a_data, i_sw, o_led);
    end
    #10;
    i_sw                      = 6'b100010  ;   //RESTA
    #10;
    i_btn                     = 3'b100     ;
    #10;
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b, B: %b, Result: %b", $time, a_data, i_sw, o_led);

    end
    #10;
    $finish;
end


always #5 clock = ~clock;


task automatic generate_random_input();
begin
    i_sw = $random % (2 ** NB_AB);
    i_btn = 3'b001;
    a_data = i_sw;
    #10;
    i_btn = 3'b000;
    #10;
     i_sw = $random % (2 ** NB_AB);
     i_btn = 3'b010;
     #10;
     i_btn = 3'b000;
     #10;


end
endtask



topv2
#(
  .NB_BTN(NB_BTN),
  .NB_OP (NB_AB ),
  .NB_AB (NB_AB ) //!NB_OPERANDOS
)
  u_topv2
  (
    .o_led  (o_led  ),
    .i_sw   (i_sw   ),
    .i_btn  (i_btn  ),
    .clock  (clock  ),
    .i_reset(reset  )
  );

endmodule