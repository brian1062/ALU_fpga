//! @title TopLevel
//! @author Gerard Brian - Rodriguez Emanuel
//! @date 08-09-2023

//! This module represents the top-level module of the design, which instantiates an ALU module and connects it to the inputs and outputs of the design. 
//! The module has three inputs: i_sw, i_btn, clock, and i_reset, and one output: o_led. 
//! The module also has three parameters: NB_BTN, NB_OP, and NB_AB, which determine the number of bits of the buttons, operations, and operands, respectively. 
//! The module reads the inputs and updates the operands and operation based on the button pressed. 
//! The updated operands and operation are then passed to the ALU module, which performs the operation and outputs the result to o_led.
`timescale 1ns/100ps
module topv2
#(
    parameter NB_BTN = 3,
    parameter NB_OP  = 6,
    parameter NB_AB  = 6 
)
(
    output         [NB_AB-1  : 0]  o_led,    //! Output of the operation
    input          [NB_OP-1  : 0]   i_sw,    //! Input for the operation
    input          [NB_BTN-1 : 0]  i_btn,    //! Input for the buttons
    input                          clock,    //! Input for the clock
    input                        i_reset     //! Input for the reset signal
);


reg signed  [NB_AB-1  : 0]             a_data;  //! First operand
reg signed  [NB_AB-1  : 0]             b_data;  //! Second operand
reg signed  [NB_OP-1  : 0]          operation;  //! Operation code


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
    .NB_OP (NB_OP),  //! Number of bits of the operation
    .NB_AB (NB_AB)   //! Number of bits of the operands

)
   u_ALU
    (
        .i_operation(operation      ), //! Operation code
        .i_Adata    (a_data         ), //! First operand   
        .i_Bdata    (b_data         ), //! Second operand
        .o_result   (o_led          )  //! Result of the operation
    );

endmodule