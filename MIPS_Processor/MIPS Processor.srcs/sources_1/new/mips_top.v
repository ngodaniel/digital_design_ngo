`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Daniel Ngo
// 
// Create Date: 03/05/2021 02:10:46 PM
// Design Name: 
// Module Name: mips_top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: MIPS Processor top level module
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
    wire [1:0] REG_DST, MEM_TO_REG, ALU_OP;
    wire JUMP, BRANCH, MEM_RD, MEM_WR, ALU_SRC, REG_WR;
    wire [2:0] REG_WRITE_DEST;
    wire [15:0] REG_WR_DATA;
    wire [2:0] REG_RD_ADDR1;
    wire [15:0] REG_RD_DATA1;
    wire [2:0] REG_RD_ADDR2;
    wire [15:0] REG_RD_DATA2;
    wire [15:0] SIGN_EXT_IM, RD_DATA2, ZERO_EXT_IM, IMM_EXT;
    wire JR_CONTROL;
    wire [2:0] ALU_CONTROL;
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
    
    //sign extend
    assign SIGN_EXT_IM = {{9{INSTR[6]}},INSTR[6:0]};
    assign ZERO_EXT_IM = {{9{1'b0}},INSTR[6:0]};
    assign IMM_EXT = (SIGN_OR_ZERO == 1'b1) ? SIGN_EXT_IM : ZERO_EXT_IM;
    //JR Control
    jr_ctrl JR_CONTROL_UNIT(.ALU_OP(ALU_OP),.FUNCT(INSTR[3:0]),.JR_CONTROL(JR_CONTROL));
    //ALU Control
    alu_ctrl ALU_CONTROL_UNIT(.ALU_OP(ALU_OP),.FUNCT(INSTR[3:0]),.ALU_CONTROL(ALU_CONTROL));
    //mux alu_src
    assign RD_DATA2 = (ALU_SRC == 1'b1) ? IMM_EXT : REG_RD_DATA2;
    //ALU
    alu ALU_UNIT(.a(REG_RD_DATA1),.b(RD_DATA2),.alu_ctrl(ALU_CONTROL),.result(ALU_OUT),.zero(ZERO_FLAG));
    //immediate shift 1
    assign IM_SHIFT1 = {IMM_EXT[14:0],1'b0};
    //
    assign NO_SIGN_EXT = ~(IM_SHIFT1) + 1'b1;
    //PC BEQ ADD
    assign PC_BEQ = (IM_SHIFT1[15] == 1'b1) ? (PC2 - NO_SIGN_EXT) : (PC2 + IM_SHIFT1);
    //BEQ CONTROL
    assign BEQ_CTRL = BRANCH & ZERO_FLAG;
    //PC_BEQ
    assign PC_4BEQ = (BEQ_CTRL == 1'b1) ? PC_BEQ : PC2;
    //PC_J
    assign PC_J = {PC2[15],JUMP_SHIFT1};
    //PC_4BEQJ
    assign PC_4BEQJ = (JUMP == 1'b1) ? PC_J : PC_4BEQ;
    //PC_JR
    assign PC_JR = REG_RD_DATA1;
    //PC_NEXT
    assign PC_NEXT = (JR_CONTROL == 1'b1) ? PC_JR : PC_4BEQJ;
    //data memory
    data_mem data_memory(.clk(CLK),.mem_access_addr(ALU_OUT),.mem_write_data(REG_RD_DATA2),.mem_write_en(MEM_WR),
    .mem_read(MEM_RD),.mem_read_data(MEM_RD_DATA));
    //write back
    assign REG_WR_DATA = (MEM_TO_REG == 2'b10) ? PC2 : ((MEM_TO_REG == 2'b01) ? MEM_RD_DATA : ALU_OUT);
    //output
    assign PC_OUT = PC_CURRENT;
    assign ALU_RESULT = ALU_OUT;
endmodule
