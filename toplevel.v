module toplevel 
#(
    //parameter NB_SW  = 4,
    parameter NB_BTN = 3,
    parameter NB_LED = 6,
    parameter NB_OP  = 6
)
(
    output [NB_LED-1 : 0] o_led,
    input  [NB_OP-1  : 0]  i_sw,
    input  [NB_BTN-1 : 0] i_btn,
    input                 clock,
    input               i_reset
);

reg  [NB_OP-1:0 ]                     op_A;
reg  [NB_OP-1:0 ]                     op_B;
reg  [NB_OP-1:0 ]                operation;

wire [NB_OP-1:0 ]            wire_A_to_alu;
wire [NB_OP-1:0 ]            wire_B_to_alu;
wire [NB_OP-1:0 ]    wire_operation_to_alu;

always @(posedge clock) begin
    if(i_reset)begin
        op_A      <= {NB_OP{1'b0}};
        op_B      <= {NB_OP{1'b0}};
        operation <= {NB_OP{1'b0}};
    end
    if(i_btn[0])begin
        op_A <= i_sw;
    end
    else if (i_btn[1]) begin
        op_B <= i_sw;
    end
    else if (i_btn[3]) begin
        operation <= i_sw;
    end
end
     
assign  wire_A_to_alu         =      op_A;
assign  wire_B_to_alu         =      op_B;
assign  wire_operation_to_alu = operation;

ALU
#(
    .NB_OP(NB_OP),  //! Numero de bits de la operacion
    .NB_AB(NB_OP)

)
  u_ALU
(
    .i_operation(wire_operation_to_alu), //! i_operation
    .i_Adata    (wire_A_to_alu), 
    .i_Bdata    (wire_B_to_alu),
    .o_result   (o_led)
);


endmodule