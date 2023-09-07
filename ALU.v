module ALU
#(
    parameter     NB_OP   =    6,  //! Numero de bits de la operacion
    parameter     NB_AB   =    4

)
(
    input            [NB_OP - 1: 0]  i_operation, //! i_operation
    input  signed    [NB_AB - 1: 0]      i_Adata, 
    input  signed    [NB_AB - 1: 0]      i_Bdata,
    output signed    [NB_AB - 1: 0]     o_result
);
wire signed [NB_AB : 0] result;

assign result   = (i_operation == 6'b100000)? (i_Adata  +  i_Bdata):
                  (i_operation == 6'b100010)? (i_Adata  -  i_Bdata):
                                                    {NB_AB+1{1'b0}};

//Aplicacion de saturacion si es necesario.  0111_1111
assign result   = (result >  {{1'b0},{NB_AB{1'b1}}} ) ?   {{1'b0},{NB_AB{1'b1}}} :
                  (result <  {{1'b1},{NB_AB{1'b0}}}) ?    {{1'b0},{NB_AB{1'b1}}} :
                                                                           result;


assign o_result = (i_operation == 6'b100000)?  (result[NB_AB - 1: 0]):   //!ADD    
                  (i_operation == 6'b100010)?  (result[NB_AB - 1: 0]):   //!SUB    
                  (i_operation == 6'b100100)?  (i_Adata  &   i_Bdata):   //!AND     
                  (i_operation == 6'b100101)?  (i_Adata  |   i_Bdata):   //!OR     
                  (i_operation == 6'b100110)?  (i_Adata  ^   i_Bdata):   //!XOR    
                  (i_operation == 6'b100111)? ~(i_Adata  ^   i_Bdata):   //!NOR    
                  (i_operation == 6'b000011)?  (i_Adata  >>  i_Bdata):   //!SRA    
                  (i_operation == 6'b000010)?  (i_Adata >>>  i_Bdata):   //!SRL    
                                                        {NB_AB{1'b0}};   //!Default


                                 

endmodule