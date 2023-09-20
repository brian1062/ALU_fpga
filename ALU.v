//! @title Unidad Aritmetica Logica
//! @author 
//! @date 08-09-2023

//! -Implementacion de una Unidad
//!  Aritmetica logica
`timescale 1ns/100ps
module ALU
#(
    parameter     NB_OP   =    6,  //! Numero de bits de la operacion
    parameter     NB_AB   =    8   //! Numero de bits operadores

)
(
    input            [NB_OP - 1: 0]  i_operation, //! i_operation
    input    signed  [NB_AB - 1: 0]      i_Adata, //! i_Adata   
    input    signed  [NB_AB - 1: 0]      i_Bdata, //! i_Bdata
    output   signed  [NB_AB - 1: 0]     o_result  //! o_result
);

reg signed [NB_AB - 1:0] temp_result;

always @(*) begin
    case (i_operation)
    6'b100000: temp_result =    i_Adata  +   i_Bdata ;
    6'b100010: temp_result =    i_Adata  -   i_Bdata ; 
    6'b100100: temp_result =    i_Adata  &   i_Bdata ;
    6'b100101: temp_result =    i_Adata  |   i_Bdata ;
    6'b100110: temp_result =    i_Adata  ^   i_Bdata ;
    6'b100111: temp_result =  ~(i_Adata  ^   i_Bdata);
    6'b000011: temp_result =    i_Adata >>>  i_Bdata ;
    6'b000010: temp_result =    i_Adata  >>  i_Bdata ;
    default  : temp_result =           {NB_AB{1'b0}} ;
    endcase
end

assign o_result = temp_result;

endmodule