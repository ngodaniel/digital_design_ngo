`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/05/2021 01:27:09 PM
// Design Name: 
// Module Name: ctrl_unit
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


module ctrl_unit(
    input [2:0] OPCODE,
    input RST,
    output reg [1:0] REG_DST, MEM_TO_REG,ALU_OP,
    output reg JUMP, BRANCH, MEM_RD, MEM_WR, ALU_SRC, REG_WR, SIGN_OR_ZERO
    );
    always @(*) begin
        if(RST == 1'b1) begin
            REG_DST = 2'b00;
            MEM_TO_REG = 2'b00;
            ALU_OP = 1'b0;         //false
            JUMP = 1'b0;           //false
            MEM_RD = 1'b0;         //false
            MEM_WR = 1'b0;         //false
            ALU_SRC = 1'b0;        //false  
            REG_WR = 1'b0;         //false
            SIGN_OR_ZERO = 1'b1;   //false
    end
    else begin
        case(OPCODE)
        3'b000: begin //add
                REG_DST = 2'b01;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b00;
                JUMP = 1'b0;            //false
                BRANCH = 1'b0;          //false
                MEM_RD = 1'b0;          //false
                MEM_WR = 1'b0;          //false
                ALU_SRC = 1'b0;         //false
                REG_WR = 1'b1;          //true
                SIGN_OR_ZERO = 1'b1;    //true
                end
        3'b001: begin //SLI
                REG_DST = 2'b00;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b10;
                JUMP = 1'b0;            //false
                BRANCH = 1'b0;          //false
                MEM_RD = 1'b0;          //false
                MEM_WR = 1'b0;          //false
                ALU_SRC = 1'b1;         //true
                REG_WR = 1'b1;          //true 
                SIGN_OR_ZERO = 1'b0;    //false 
            end
        3'b010: begin  //j
                REG_DST = 2'b00;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b00;
                JUMP = 1'b1;            //true
                BRANCH = 1'b0;          //false
                MEM_RD = 1'b0;          //false
                MEM_WR = 1'b0;          //false
                ALU_SRC = 1'b0;         //false 
                REG_WR = 1'b0;          //false 
                SIGN_OR_ZERO = 1'b1;    //true
                end
        3'b001: begin //jal
                REG_DST = 2'b10;
                MEM_TO_REG = 2'b10;
                ALU_OP = 2'b00;
                JUMP = 1'b1;            //true 
                BRANCH = 1'b0;          //false
                MEM_RD = 1'b0;          //false
                MEM_WR = 1'b0;          //false
                ALU_SRC = 1'b0;         //false
                REG_WR = 1'b1;          //true
                SIGN_OR_ZERO = 1'b1;    //true 
                end
        3'b100: begin //lw
                REG_DST = 2'b00;
                MEM_TO_REG = 2'b01;
                ALU_OP = 2'b11;
                JUMP = 1'b0;
                BRANCH = 1'b0;
                MEM_RD = 1'b1;
                MEM_WR = 1'b0;
                ALU_SRC = 1'b1;
                REG_WR = 1'b1;
                SIGN_OR_ZERO = 1'b1;
                end
       3'b101: begin //sw
                REG_DST = 2'b00;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b11;
                JUMP = 1'b0;
                BRANCH = 1'b0;
                MEM_RD = 1'b0;
                MEM_WR = 1'b1;
                ALU_SRC = 1'b1;
                REG_WR = 1'b0;
                SIGN_OR_ZERO = 1'b1;
                end
        3'b110: begin //beg
                REG_DST = 2'b00;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b01;
                JUMP = 1'b0;
                BRANCH = 1'b1;
                MEM_RD = 1'b0;
                MEM_WR = 1'b0;
                ALU_SRC = 1'b0;
                REG_WR = 1'b0;
                SIGN_OR_ZERO = 1'b1;
                end
        3'b111: begin //addi
                REG_DST = 2'b00;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b11;
                JUMP = 1'b0;
                BRANCH = 1'b0;
                MEM_RD = 1'b0;
                MEM_WR = 1'b0;
                ALU_SRC = 1'b1;
                REG_WR = 1'b1;
                SIGN_OR_ZERO = 1'b1;
                end
        default: begin
                REG_DST = 2'b01;
                MEM_TO_REG = 2'b00;
                ALU_OP = 2'b00;
                JUMP = 1'b0;
                BRANCH = 1'b0;
                MEM_RD = 1'b0;
                MEM_WR = 1'b0;
                ALU_SRC = 1'b0;
                REG_WR = 1'b1;
                SIGN_OR_ZERO = 1'b1;
                end
        endcase
        end
    end
endmodule
