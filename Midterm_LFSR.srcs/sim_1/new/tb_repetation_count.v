`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/28/2021 01:44:00 PM
// Design Name: 
// Module Name: tb_repetation_count
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


module tb_repetation_count(
);
    reg clk;
    reg rst=1;
    reg get_random=0;
    reg[1:0]state=2'b01;
    reg [0:31]seed_in=32'h02468ACD;
    wire [0:31]seed_out;
    reg [0:31]output_reg=0;
    integer i=0;

    LFSR_Logic uut(.clk(clk),.rst(rst),.get_random(get_random),.state(state),.seed_in(seed_in),.seed_out(seed_out));

    always
    begin
        clk=0;
        #10
        clk=1;
        #10;
    end

    always
    begin
        #20
        if(seed_out==32'h02468ACD)
            begin
                $display("Sequence repeating");
                $finish;
            end
        else
            begin
                seed_in<=seed_out;
                i=i+1;
            end
    end
endmodule
