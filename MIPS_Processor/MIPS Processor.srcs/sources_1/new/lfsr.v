`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/04/2021 03:04:04 PM
// Design Name: 
// Module Name: lfsr
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: linear feedback shift register for the ALU of the MIPS processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module lfsr(
    input clk,
    input rst_n,
    input [4:0] s_initial,
    output [4:0] Sout
    );
    
    wire [4:0] s_reg;
    wire d_xor;
    
    D_FF s0(.q(s_reg[0]), .d(s_reg[4]), .rst_n(rst_n), .clk(clk), .init_value(s_initial[0]));
    D_FF s1(.q(s_reg[1]), .d(s_reg[0]), .rst_n(rst_n), .clk(clk), .init_value(s_initial[1]));
    xor xor_u(d_xor, s_reg[1], s_reg[4]);
    D_FF s2(.q(s_reg[2]), .d(d_xor), .rst_n(rst_n), .clk(clk), .init_value(s_initial[2]));
    D_FF s3(.q(s_reg[3]), .d(s_reg[2]), .rst_n(rst_n), .clk(clk), .init_value(s_initial[3]));
    D_FF s4(.q(s_reg[4]), .d(s_reg[3]), .rst_n(rst_n), .clk(clk), .init_value(s_initial[4]));
    assign Sout = s_reg;
endmodule
