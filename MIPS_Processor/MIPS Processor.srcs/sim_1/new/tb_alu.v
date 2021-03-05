`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 05:14:28 PM
// Design Name: 
// Module Name: tb_alu
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


module tb_alu(

    );
    reg [15:0] a, b;
    reg [2:0] alu_ctrl;
    wire [15:0] result;
    wire zero;
    
    alu UUT(.a(a),.b(b),.alu_ctrl(alu_ctrl),.result(result),.zero(zero));
    
    initial
    $monitorb("a: %d | b: %d | results: %d",a,b,result);
    initial begin
    a = 16'd15; b = 16'd15; alu_ctrl = 3'b0001;
    #50
    $finish;
    end
endmodule
