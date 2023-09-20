`timescale 1ns/100ps
module tb_alu();

reg                        clock;
reg                        reset;
reg signed [7:0] i_aData;
reg signed [7:0] i_bData;
reg signed [5:0] i_operation;
wire signed [7:0] o_result;

initial begin
    clock         = 1'b0       ;
    reset         = 1'b0       ;
    #100 i_aData  = 8'b00001111  ;
    #100 i_bData  = 8'b00000001  ;
    #100 i_operation = 6'b000011;
    #110 i_aData  = 8'b10001111  ;
    #110 i_bData  = 8'b00000001  ;
    #110 i_operation = 6'b000011;

    #100000 $finish            ;
end


always #5 clock = ~clock;

ALU
#(
    .NB_OP  (6),  //! Numero de bits de la operacion
    .NB_AB  (8)   //! Numero de bits operadores

)
u_ALU
(
    .i_operation(i_operation), //! i_operation
    .i_Adata    (i_aData), //! i_Adata   
    .i_Bdata    (i_bData), //! i_Bdata
    .o_result   (o_result)  //! o_result
);

endmodule