`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2021 11:28:53 AM
// Design Name: 
// Module Name: LFSR_Default
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


module LFSR_Default(
    input wire rst,
    output reg [0:31]seed_in,
    output reg [0:7]d_out
);
    always @(rst)
    begin
        if(!rst)
        begin
            seed_in<=32'h02468ACD;
            d_out<=8'h00;
        end
    end
endmodule