`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 09:41:10 PM
// Design Name: 
// Module Name: tb_alu_ctrl
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


module tb_alu_ctrl(

    );
    reg [1:0] ALU_OP;
    reg [3:0] FUNC;
    wire [2:0] ALU_CTRL;
    
    alu_ctrl UUT(.ALU_OP(ALU_OP),.FUNC(FUNC),.ALU_CTRL(ALU_CTRL));
    initial
    $monitorb("ALU_OP: %b | FUNC: %b | ALU_CTRL: %b",ALU_OP,FUNC,ALU_CTRL);
    initial begin
    ALU_OP = 2'b00; FUNC = 4'b0000;
    #5 FUNC = 4'b0001;
    #5 FUNC = 4'b0010;
    #5 FUNC = 4'b0011;
    #5 FUNC = 4'b0100;
    #5 FUNC = 4'b0101;
    #5 FUNC = 4'b0110;
    #5 FUNC = 4'b0111;
    #5 FUNC = 4'b1000;
    #5 FUNC = 4'b1001;
    #5 FUNC = 4'b1010;
    #5 FUNC = 4'b1011;
    #5 FUNC = 4'b1100;
    #5 FUNC = 4'b1101;
    #5 FUNC = 4'b1110;
    #5 FUNC = 4'b1111;
    #50
    $finish;
    end
    
endmodule
