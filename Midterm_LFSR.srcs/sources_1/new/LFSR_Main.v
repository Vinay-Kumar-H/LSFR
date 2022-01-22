`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2021 12:01:57 PM
// Design Name: 
// Module Name: LFSR_Main
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


module LFSR_Main(
    input wire clk,
    input wire rst,
    input wire get_random,
    input wire load_seed,
    input wire [0:7]data_in,
    output reg [0:7]d_out
);
    //Temp variable to store default value of seed when reset
    wire [0:31]seed_in_default;

    //Seed input value intialized to default
    reg [0:31]seed_in=32'h02468ACD;

    //temp output of LFSR which will be stored back to seed_in fed back to LFSR
    wire [0:31]seed_out_temp;

    //state registers
    reg [1:0]state=0;
    reg [1:0]next_state;

    //counter for output state
    reg [1:0]cnt=2'd3;

    //counter for input
    reg [1:0]cnt_in=2'd3;
    wire [0:7]d_out1;

    //temp data for 
    wire [0:31]seed_in_temp;

    LFSR_Default L_D(.rst(rst),.seed_in(seed_in_default));
    LFSR_Logic L_L(.clk(clk),.rst(rst),.get_random(get_random),.state(next_state),.seed_in(seed_in),.seed_out(seed_out_temp));
    LFSR_Output L_O(.clk(clk),.rst(rst),.cnt(cnt),.seed_out(seed_in),.d_out(d_out1));
    LFSR_Input L_I(.clk(clk),.rst(rst),.cnt(cnt_in),.data_in(data_in),.seed_tmp(seed_in),.seed_in(seed_in_temp));
    //clock synched state change
    always@(posedge clk)
    begin
        state<=next_state;
    end

    //counter for output state
    always @(posedge clk)
    begin
        if(next_state==2'b10)
            begin
                if(cnt==2'd0)
                    begin
                        cnt=2'd3;
                    end
                else
                    begin
                        cnt<=cnt-2'd1;
                    end
            end
        else
            begin
                cnt=2'd3;
            end

    end

    //counter for output state
    always @(posedge clk)
    begin
        if(state==2'b11)
            begin
                if(cnt_in==2'd0)
                    begin
                        cnt_in=2'd3;
                    end
                else
                    begin
                        cnt_in<=cnt_in-2'd1;
                    end
            end
        else
            begin
                cnt_in=2'd3;
            end

    end

    //Next state logic
    always @(rst,get_random,load_seed,cnt,cnt_in,state)
    begin
        if(!rst)
            begin
                next_state<=2'd0;
            end
        else if(rst)
        begin
            case(state)
                2'd0:
                begin
                    if(!load_seed)
                        begin
                            if(get_random)
                                begin
                                    next_state<=2'd2;
                                end
                            else if(!get_random)
                            begin
                                next_state<=2'd1;
                            end
                        end
                    else
                        begin
                            next_state<=2'd3;
                        end
                end
                2'd1:
                begin
                    if(!load_seed)
                        begin
                            if(get_random)
                                begin
                                    next_state<=2'd2;
                                end
                            else if(!get_random)
                            begin
                                next_state<=2'd1;
                            end
                        end
                    else if(load_seed)
                        begin
                            next_state<=2'd3;
                        end
                end
                2'd2:
                begin
                    if(!load_seed)
                        begin
                            if(!get_random)
                            begin
                                if(cnt==2'd3)
                                    begin
                                        next_state<=2'd1;
                                    end
                                else
                                    begin
                                        next_state<=2'd2;
                                    end

                            end
                        end
                    else if(load_seed)
                        begin
                            if(cnt==2'd3)
                                begin
                                    next_state<=2'd3;
                                end
                            else
                                begin
                                    next_state<=2'd2;
                                end
                        end

                end

                2'd3:
                begin
                    if(!load_seed)
                    begin
                        if(cnt_in==2'd3)
                            begin
                                if(!get_random)
                                    begin
                                        next_state<=2'd1;
                                    end
                                else if(get_random)
                                    begin
                                        next_state<=2'd2;
                                    end
                            end
                        else if(load_seed)
                            begin
                                next_state<=2'd3;
                            end
                    end
                end
                default:
                begin
                    next_state<=state;
                end
            endcase
        end
    end

    //output Logic
    always @(seed_out_temp,seed_in_temp,d_out1,state)
    begin
        case(state)
            2'd0:
            begin
                if(!rst)
                begin
                    seed_in<=seed_in_default;
                    d_out<=8'h00;
                end
            end
            2'd1:
            begin
                seed_in<=seed_out_temp;
                d_out<=8'h00;
            end
            2'd2:
            begin
                d_out<=d_out1;
            end
            2'd3:
            begin
                seed_in<=seed_in_temp;
                d_out<=8'h00;
            end
            default:
            d_out<=8'hXX;
        endcase
    end

endmodule
