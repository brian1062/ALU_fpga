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
    $display("----------------------Suma------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b + B: %b, Result: %b", $time, a_data, i_sw, o_led);
        if (o_led !== a_data + i_sw) begin
            $display("Suma incorrecta! Esperado: %b, Obtenido: %b", a_data + i_sw, o_led);
        end
    end
    #10;
    i_sw                      = 6'b100010  ;   //RESTA
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------Resta------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b - B: %b, Result: %b", $time, a_data, i_sw, o_led);

        if (o_led !== a_data - i_sw) begin
            $display("Resta incorrecta! Esperado: %b, Obtenido: %b", a_data - i_sw, o_led);
        end
    end
    #10;
    i_sw                      = 6'b100100  ;   //AND
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------AND------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b AND B: %b, Result: %b", $time, a_data, i_sw, o_led);

        if (o_led !== (a_data & i_sw)) begin
            $display("AND incorrecta! Esperado: %b, Obtenido: %b", a_data & i_sw, o_led);
        end
    end
    #10;
    i_sw                      = 6'b100101  ;   //OR
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------OR------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b OR B: %b, Result: %b", $time, a_data, i_sw, o_led);
        
        if (o_led !== (a_data | i_sw)) begin
            $display("OR incorrecta! Esperado: %b, Obtenido: %b", a_data | i_sw, o_led);
        end
    end
    i_sw                      = 6'b100110  ;   //XOR
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------XOR------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b XOR, B: %b, Result: %b", $time, a_data, i_sw, o_led);
        
        if (o_led !== (a_data ^ i_sw)) begin
            $display("XOR incorrecta! Esperado: %b, Obtenido: %b", a_data ^ i_sw, o_led);
        end
    end
    #10;
    i_sw                      = 6'b100111  ;   //NOR
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------NOR------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b NOR, B: %b, Result: %b", $time, a_data, i_sw, o_led);
        
        if (o_led !== (~(a_data ^ i_sw))) begin
            $display("NOR incorrecta! Esperado: %b, Obtenido: %b", ~(a_data ^ i_sw), o_led);
        end
    end
    #10;
    i_sw                      = 6'b000011  ;   //SRA
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------SRA------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b SRA, B: %b, Result: %b", $time, a_data, i_sw, o_led);
    end
    #10;
    i_sw                      = 6'b000010  ;   //SRL
    #10;
    i_btn                     = 3'b100     ;
    #10;
    $display("----------------------SRL------------------------------");
    repeat (50) begin
        generate_random_input();
        $display("Time: %0t, A: %b SRL, B: %b, Result: %b", $time, a_data, i_sw, o_led);
        
        if (o_led !== a_data >> i_sw) begin
            $display("SRL incorrecta! Esperado: %b, Obtenido: %b", a_data >> i_sw, o_led);
        end
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