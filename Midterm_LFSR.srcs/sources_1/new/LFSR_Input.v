`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 03:10:49 AM
// Design Name: 
// Module Name: LFSR_Input
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


module LFSR_Input(
    input wire clk,
    input wire rst,
    input wire [0:7]data_in,
    input wire [1:0]cnt,
    input wire [0:31]seed_tmp,
    output reg [0:31]seed_in
);
   
    always @(posedge clk)
    begin
        if(rst)
        begin
            if(cnt==2'b00)begin
               seed_in<={data_in[0:7],seed_tmp[8:31]};
            end
            else if(cnt==2'b01)begin
                seed_in<={seed_tmp[0:7],data_in[0:7],seed_tmp[16:31]};
            end
            else if(cnt==2'b10)begin
                seed_in<={seed_tmp[0:15],data_in[0:7],seed_tmp[24:31]};
            end
            else if(cnt==2'b11)begin
                seed_in<={seed_tmp[0:23],data_in[0:7]};
            end
        end
    end
endmodule
