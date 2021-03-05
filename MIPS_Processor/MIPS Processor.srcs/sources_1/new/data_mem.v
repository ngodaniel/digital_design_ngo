`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/04/2021 06:11:51 PM
// Design Name: 
// Module Name: data_mem
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


module data_mem(
    input clk,
    input [15:0] mem_access_addr,   //address input, shared by read and write port
    input [15:0] mem_write_data,    //write port
    input mem_write_en,             
    input mem_read,
    output [15:0] mem_read_data     //read port
    );
    
    integer i;
    reg [15:0] ram [255:0];
    wire [7:0] ram_addr = mem_access_addr[8:1];
endmodule
