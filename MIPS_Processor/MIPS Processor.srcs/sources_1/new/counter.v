`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/03/2021 11:53:05 PM
// Design Name: Daniel Ngo
// Module Name: counter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: counter apart of the ALU component of the MIPS processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter(
    input enable,
    input clk,
    input rst_n,
    output reg[3:0] counter
    );
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) counter <= 4'b0000;
        else if (enable) counter <= counter + 4'b0001;
    end
endmodule
