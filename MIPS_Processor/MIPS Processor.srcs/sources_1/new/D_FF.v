`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/03/2021 11:44:41 PM
// Design Name: 
// Module Name: D_FF
// Project Name: MIPS Processor
// Target Devices: 
// Tool Versions: 
// Description: d flip-flop apart of the ALU component of the MIPS processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module D_FF(
    input d,
    input rst_n,
    input clk,
    input init_value,
    output q
    );
    reg q;
    
    always @(posedge clk or negedge rst_n)
        if (~rst_n)
            q <= init_value;    //set to zero on reset
        else
            q <= d;             
endmodule
