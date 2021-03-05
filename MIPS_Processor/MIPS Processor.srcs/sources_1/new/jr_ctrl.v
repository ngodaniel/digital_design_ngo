`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/05/2021 03:04:46 PM
// Design Name: 
// Module Name: jr_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Verilog code for JR Control Unit
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module jr_ctrl(
    input [1:0] ALU_OP,
    input [3:0] FUNCT,
    output JR_CTRL
    );
    assign JR_CTRL = ({ALU_OP,FUNCT} == 6'b001000) ? 1'b1 : 1'b0;
endmodule
