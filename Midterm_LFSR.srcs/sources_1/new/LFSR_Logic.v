`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2021 11:07:48 AM
// Design Name: 
// Module Name: LFSR_Logic
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


module LFSR_Logic(
    input wire clk,
    input wire rst,
    input wire get_random,
    input wire[1:0]state,
    input wire [0:31]seed_in,
    output reg [0:31]seed_out
);
    reg [0:31]out;
    always @(posedge clk)
    if(rst & !get_random & state==2'b01)
        begin
            seed_out<={(seed_in[3]^seed_in[4]^seed_in[14]^seed_in[18]^seed_in[20]^seed_in[25]^seed_in[31]),seed_in[0:30]};
        end
    else
        begin
            seed_out<=seed_in;
        end
endmodule
