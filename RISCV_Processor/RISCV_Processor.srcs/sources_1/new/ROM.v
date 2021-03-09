`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/08/2021 12:03:46 PM
// Design Name: 
// Module Name: ROM
// Project Name: RISCV Processor
// Target Devices: 
// Tool Versions: 
// Description: the 32x23 ROM module which will hold the instructions
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module ROM(
    DATA, ROM_CS, ROM_OE, ADDR
    );
    input ROM_CS, ROM_OE;
    input [4:0] ADDR;
    output reg [31:0] DATA;
    
    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 5;
    parameter ROM_DEPTH = 32;
    reg [DATA_WIDTH-1:0] MEM [ROM_DEPTH-1:0];
    
    always @(ROM_CS or ROM_OE) begin: MEM_READ
        if (ROM_CS && ROM_OE) DATA = MEM[ADDR];
        else DATA = DATA;
    end    
endmodule
