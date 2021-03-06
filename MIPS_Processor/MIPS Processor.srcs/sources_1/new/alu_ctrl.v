`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/04/2021 09:21:23 PM
// Design Name: 
// Module Name: alu_ctrl
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_ctrl(
    input [1:0] ALU_OP,
    input [3:0] FUNCT,
    output reg [2:0] ALU_CONTROL
    );
    wire [5:0] ALU_CTRL_IN;
    assign ALU_CTRL_IN = {ALU_OP, FUNCT};
    always @(ALU_CTRL_IN)
        casex(ALU_CTRL_IN)
            6'b11xxxx: ALU_CONTROL = 3'b000;
            6'b10xxxx: ALU_CONTROL = 3'b100;
            6'b01xxxx: ALU_CONTROL = 3'b001;
            6'b000000: ALU_CONTROL = 3'b000;
            6'b000001: ALU_CONTROL = 3'b001;
            6'b000010: ALU_CONTROL = 3'b010;
            6'b000011: ALU_CONTROL = 3'b011;
            6'b000100: ALU_CONTROL = 3'b100;
            default: ALU_CONTROL = 3'b000;
        endcase
endmodule
