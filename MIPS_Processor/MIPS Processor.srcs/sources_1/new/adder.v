`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer: Daniel Ngo
// 
// Create Date: 03/03/2021 11:20:03 PM
// Design Name: 
// Module Name: adder
// Project Name: MIPS Processor
// Target Devices: 
// Tool Versions: 
// Description: full adder apart of the ALU component of the MIPS processor
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


    module adder(
    input a,
    input b,
    input cin,
    output cout,
    output sum
    );
    
    //sum = a xor b xor cin
    xor #(50) (sum,a,b,cin);
    
    //carry out = a*b+cin*(a+B)
    and #(50) and1(c1,a,b);
    or #(50) or1(c2,a,b);
    or #(50) or2(cout,c1,c3);
  
endmodule
