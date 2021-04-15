`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/15/2021 04:08:51 PM
// Design Name: 
// Module Name: MIR
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


module MIR(
    ROM_DATA, OPCODE, I_bit, ADDR, DATA, IR_EN
    );
    
    input IR_EN;
    input [31:0] DATA;
    output reg [3:0] OPCODE;
    output reg I_bit;
    output reg [6:0] ADDR;
    output reg [7:0] ROM_DATA;
    
    always @(DATA) begin
        if(IR_EN) begin
            OPCODE=DATA[31:28];
            I_bit=DATA[27];
            ADDR=DATA[26:20];
            ROM_DATA=DATA[7:0];    
        end
        else begin
            OPCODE=OPCODE;
            I_bit=I_bit;
            ADDR=ADDR;
            ROM_DATA=ROM_DATA;
        end
    end
endmodule
