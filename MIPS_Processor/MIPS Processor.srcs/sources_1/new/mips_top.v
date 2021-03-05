`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/05/2021 02:10:46 PM
// Design Name: 
// Module Name: mips_top
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


module mips_top(
    input CLK, RST,
    output [15:0] PC_OUT, ALU_RESULT
    );
    reg [15:0] PC_CURRENT;
    wire signed [15:0] PC_NEXT, PC2;
    wire [15:0] INSTR;
    wire [1:0] REG_DsT, MEM_TO_REG, ALU_OP;
    wire JUMP, BRANCH, MEM_RD, MEM_WR, ALU_SRC, REG_WR;
    wire [2:0] REG_WRITE_DEST;
    wire [15:0] REG_WR_DATA;
    wire [2:0] REG_RD_ADDR1;
    wire [15:0] REG_RD_DATA1;
    wire [2:0] REG_RD_ADDR2;
    wire [15:0] REG_RD_DATA2;
    wire [15:0] SIGN_EXT_IM, RD_DATA2, ZERO_EXT_IM, IMM_EXT;
    wire JR_CTRL;
    wire [2:0] ALU_CTRL;
    wire [15:0] ALU_OUT;
    wire ZERO_FLAG;
    wire signed [15:0] IM_SHIFT1, PC_J, PC_BEQ, PC_4BEQ, PC_4BEQJ, PC_JR;
    wire BEQ_CTRL;
    wire [14:0] JUMP_SHIFT1;
    wire[15:0] MEM_RD_DATA;
    wire [15:0] NO_SIGN_EXT;
    wire SIGN_OR_ZERO;
    
    //PC
    always @(posedge CLK or posedge RST) begin
        if(RST) PC_CURRENT <= 16'd0;
        else PC_CURRENT <= PC_NEXT;
    end
    
    //PC + 2
    assign PC2 = PC_CURRENT + 16'd2;
    instruc_mem instruction_memory(.pc(PC_CURRENT),.instruc(INSTR));
    
    //jump shift left 1
    assign JUMP_SHIFT1 = {INSTR[13:0],1'b0};
    
    //control unit
    ctrl_unit control_unit(.RST(RST),.OPCODE(INSTR[15:13]),.REG_DST(REG_DST),.MEM_TO_REG(MEM_TO_REG),.ALU_OP(ALU_OP),.JUMP(JUMP),
    .BRANCH(BRANCH),.MEM_RD(MEM_RD),.MEM_WR(MEM_WR),.ALU_SRC(ALU_SRC),.REG_WR(REG_WR),.SIGN_OF_ZERO(SIGN_OF_ZERO));
    
    //mux regdest
    assign REG_WR_DEST = (REG_DST == 2'b10) ? 3'b111 : ((REG_DST == 2'b01) ? INSTR[6:4] : INSTR[9:7]);
    
    //reg file
    assign REG_RD_ADDR1 = INSTR[12:10];
    assign REG_RRD_ADDR2 = INSTR[9:7];
    register_file reg_file(.clk(CLK),.rst(RST),.reg_write_en(REG_WR),.reg_write_dest(REG_WR_DEST),
    .reg_write_data(REG_WR_DATA),.reg_read_addr_1(READ_RD_ADDR1),.red_read_data_1(REG_READ_DATA1),
    .reg_read_addr_2(READ_RD_ADDR2),.reg_read_data_2(REG_RD_DATA2));
endmodule
