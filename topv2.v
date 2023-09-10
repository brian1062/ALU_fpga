module topv2
#(
    parameter NB_BTN = 3,
    parameter NB_OP  = 6,
    parameter NB_AB  = 4 //!NB_OPERANDOS
)
(
    //input  [NB_AB-1 : 0] i_sw,
    output  [NB_AB-1  : 0]  o_led,
    input   [NB_OP-1  : 0]   i_sw,
    input   [NB_BTN-1 : 0]  i_btn,
    input                   clock,
    input                 i_reset
);

reg [NB_AB-1  : 0]              a_data;
reg [NB_AB-1  : 0]              b_data;
reg [NB_OP-1  : 0]           operation;

wire [NB_AB-1  : 0]        wire_a_data;
wire [NB_AB-1  : 0]        wire_b_data;
wire [NB_OP-1  : 0]     wire_operation;

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
        else if(i_btn[1]==1'b1)begin
            b_data <= i_sw[NB_AB-1 : 0];
        end
        else if(i_btn[2]==1'b1)begin
            operation <= i_sw;
        end        
    end
end

assign wire_a_data    =    a_data;
assign wire_b_data    =    b_data;
assign wire_operation = operation;

ALU
#(
    .NB_OP (NB_OP),  //! Numero de bits de la operacion
    .NB_AB (NB_AB)   //! Numero de bits operadores

)
   u_ALU
    (
        .i_operation(wire_operation ), //! i_operation
        .i_Adata    (wire_a_data    ), //! i_Adata   
        .i_Bdata    (wire_b_data    ), //! i_Bdata
        .o_result   (o_led          )  //! o_result
    );

endmodule