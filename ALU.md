
# Entity: ALU 
- **File**: ALU.v
- **Title:**  Unidad Aritmetica Logica
- **Author:**  Gerard Brian - Rodriguez Emanuel
- **Date:**  08-09-2023

## Diagram
![Diagram](ALU.svg "Diagram")
## Description

This module implements an Arithmetic Logic Unit (ALU) that performs arithmetic and logical operations on two signed inputs of NB_AB bits each, based on the operation code i_operation of NB_OP bits. The output o_result is also a signed number of NB_AB bits.

## Generics

| Generic name | Type | Value | Description                     |
| ------------ | ---- | ----- | ------------------------------- |
| NB_OP        |      | 6     | Number of bits of the operation |
| NB_AB        |      | 8     | Number of bits of the operands  |

## Ports

| Port name   | Direction | Type                   | Description             |
| ----------- | --------- | ---------------------- | ----------------------- |
| i_operation | input     | [NB_OP - 1: 0]         | Operation code          |
| i_Adata     | input     | signed  [NB_AB - 1: 0] | First operand           |
| i_Bdata     | input     | signed  [NB_AB - 1: 0] | Second operand          |
| o_result    | output    | signed  [NB_AB - 1: 0] | Result of the operation |

## Signals

| Name        | Type                     | Description |
| ----------- | ------------------------ | ----------- |
| temp_result | reg signed [NB_AB - 1:0] |             |

## Processes
- unnamed: ( @(*) )
  - **Type:** always
