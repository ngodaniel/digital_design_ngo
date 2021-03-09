`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/08/2021 10:55:11 AM
// Design Name: 
// Module Name: PC
// Project Name: RISC_V Processor
// Target Devices: 
// Tool Versions: 
// Description: this is the program counter that specifies the memory location in ROM and RAM
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module PC(
    CNT, LOAD_EN, PC_EN, ADDR, CLK, RST
    );
    parameter SIZE =1;
    input LOAD_EN, PC_EN, CLK, RST;
    input [SIZE-1:0] ADDR;
    output reg [SIZE-1:0] CNT;
    
    always @(posedge CLK or negedge RST) begin
        if(!RST) CNT <= 5'b0;
        else begin
            if(PC_EN) begin
                if(LOAD_EN) begin
                    if(CNT==7) CNT <= ADDR;
                    else begin
                        if(CNT >= 60) CNT <= 5'b0;
                        else CNT <= CNT +1;
                    end
                end
                else begin
                    if (CNT >= 60) CNT <= 5'b0;
                    else CNT <= CNT+1;
                end
            end
            else CNT <= CNT;
        end
    end
endmodule
