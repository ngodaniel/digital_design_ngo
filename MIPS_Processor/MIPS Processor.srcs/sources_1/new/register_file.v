`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/04/2021 05:43:07 PM
// Design Name: 
// Module Name: register_file
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 16-bit wide 8-bit deep R/W register
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module register_file(
    input clk,
    input rst,
    //write port
    input reg_write_en,
    input [2:0] reg_write_dest,
    input [15:0] reg_write_data,
    //read port 1
    input [2:0] reg_read_addr_1,
    output [15:0] reg_read_data_1,
    //read port 2
    input [2:0] reg_read_addr_2,
    output [15:0] reg_read_data_2
    );
    reg [15:0] reg_array [7:0];
    always @(posedge clk or posedge rst) begin
        if(rst) begin
            reg_array[0] <= 16'b0;
            reg_array[1] <= 16'b0;
            reg_array[2] <= 16'b0;
            reg_array[3] <= 16'b0;
            reg_array[4] <= 16'b0;
            reg_array[5] <= 16'b0;
            reg_array[6] <= 16'b0;
            reg_array[7] <= 16'b0;
        end
        else begin
            if(reg_write_en) reg_array[reg_write_dest] <= reg_write_data;
        end
    end
    assign reg_read_data_1 = (reg_read_addr_1 == 0) ? 16'b0 : reg_array[reg_read_addr_1];
    assign reg_read_data_2 = (reg_read_addr_2 == 0) ? 16'b0 : reg_array[reg_read_addr_2];
endmodule
