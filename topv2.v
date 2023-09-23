`timescale 1ns/100ps
module topv2
#(
    parameter NB_BTN = 3,
    parameter NB_OP  = 6,
    parameter NB_AB  = 6 //!NB_OPERANDOS
)
(
    //input  [NB_AB-1 : 0] i_sw,
    output         [NB_AB-1  : 0]  o_led,
    input          [NB_OP-1  : 0]   i_sw,
    input          [NB_BTN-1 : 0]  i_btn,
    input                          clock,
    input                        i_reset
);


reg signed  [NB_AB-1  : 0]             a_data;
reg signed  [NB_AB-1  : 0]             b_data;
reg signed  [NB_OP-1  : 0]          operation;


always @(posedge clock) begin
    if(i_reset)begin
        a_data    <=   {NB_AB{1'b0}};
        b_data    <=   {NB_AB{1'b0}};
        operation <=   {NB_OP{1'b0}}; 
    end
    else begin
        if(i_btn[0]==1'b1)begin
            a_data <= i_sw[NB_AB-1 : 0];
        end
        if(i_btn[1]==1'b1)begin
            b_data <= i_sw[NB_AB-1 : 0];
        end
        if(i_btn[2]==1'b1)begin
            operation <= i_sw;
        end        
    end
end



ALU
#(
    .NB_OP (NB_OP),  //! Numero de bits de la operacion
    .NB_AB (NB_AB)   //! Numero de bits operadores

)
   u_ALU
    (
        .i_operation(operation      ), //! i_operation
        .i_Adata    (a_data         ), //! i_Adata   
        .i_Bdata    (b_data         ), //! i_Bdata
        .o_result   (o_led          )  //! o_result
    );

endmodule