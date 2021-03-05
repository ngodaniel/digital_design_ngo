`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/04/2021 05:59:01 PM
// Design Name: 
// Module Name: instruc_mem
// Project Name: MIPS Processor
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


module instruc_mem(
    input [15:0] pc,
    output wire [15:0] instruc
    );
    wire [3:0] rom_addr = pc[4:1];
    reg [15:0] rom[15:0];
    initial begin
        rom[0] = 16'b1000000110000000;  
        rom[1] = 16'b0010110010110010;  
        rom[2] = 16'b1101110001100111;  
        rom[3] = 16'b1101110111011001;  
        rom[4] = 16'b1111110110110001;  
        rom[5] = 16'b1100000001111011; 
        rom[6] = 16'b0000000000000000;  
        rom[7] = 16'b0000000000000000;  
        rom[8] = 16'b0000000000000000;  
        rom[9] = 16'b0000000000000000;  
        rom[10] = 16'b0000000000000000;  
        rom[11] = 16'b0000000000000000;  
        rom[12] = 16'b0000000000000000;  
        rom[13] = 16'b0000000000000000;  
        rom[14] = 16'b0000000000000000;  
        rom[15] = 16'b0000000000000000;
    end
    assign instruction = (pc[15:0] < 32) ? rom[rom_addr[3:0]] : 16'd0;
endmodule
