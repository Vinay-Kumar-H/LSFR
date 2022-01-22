`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2021 11:39:50 AM
// Design Name: 
// Module Name: LFSR_Output
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


module LFSR_Output(
    input wire clk,
    input wire rst,
    input wire [1:0]cnt,
    input wire [0:31]seed_out,
    output reg [0:7]d_out
);
    always @(posedge clk)
    begin
        if(rst)
        begin
            if(cnt==2'b00)begin
                d_out[0:7]<=seed_out[0:7];
            end
            else if(cnt==2'b01)begin
                d_out[0:7]<=seed_out[8:15];
            end
            else if(cnt==2'b10)begin
                d_out[0:7]<=seed_out[16:23];
            end
            else if(cnt==2'b11)begin
                d_out[0:7]<=seed_out[24:31];
            end
        end
    end
endmodule
