`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/04/2021 04:58:34 PM
// Design Name: 
// Module Name: alu
// Project Name: MIPS Processor
// Target Devices: 
// Tool Versions: 
// Description: ALU module for MIPS processor
// accepts 2 inputs a and b, then add, subtract, and, or depending on alu_ctrl
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu(
    a, b, alu_ctrl, result, zero
    );
    input [15:0] a, b;
    input [2:0] alu_ctrl;
    output reg [15:0] result;
    output zero;
    
    always @(*) begin
        case(alu_ctrl)
        3'b000: result = a + b; //add
        3'b001: result = a - b; //subtract
        3'b010: result = a & b; //and
        3'b011: result = a | b; //or
        3'b100: begin
            if (a<b) result = 16'd1;
            else result = 16'd0;
        end
        default: result = a + b; //add
        endcase
    end
    assign zero = (result==16'd0) ? 1'b1 : 1'b0;
endmodule
