`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2021 12:09:53 PM
// Design Name: 
// Module Name: test_bench
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


module test_bench(
);
    reg clk;
    reg rst;
    reg get_random;
    reg load_seed=0;
    wire [0:7]d_out;
    integer i=0;
    reg [0:31]output_default=0;
    reg[0:7]data_in=0;
    LFSR_Main uut(.clk(clk),.rst(rst),.get_random(get_random),.load_seed(load_seed),.data_in(0),.d_out(d_out));
    //Clock geeration
    always begin:clk_generation
        clk<=0;
        #50;
        clk<=1;
        #50;
    end
    always begin
        //reset test
        rst<=0;
        #100;
        rst<=1;
        #20000;
    end
    always begin: test_cases
        //check the value of seed after reset
        #100;
        get_random<=1;
        for(i=0;i<5;i=i+1)
            begin
                if(i==1)
                    begin
                        output_default[24:31]<=d_out;
                    end
                else if(i==2)
                    begin
                        output_default[16:23]<=d_out;
                    end
                else if(i==3)
                    begin
                        output_default[8:15]<=d_out;
                    end
                else if(i==4)
                begin
                    output_default[0:7]<=d_out;
                end
                #100;
            end
        if(output_default==32'h02468ACD)
            begin
                $display("Default value is set as expected");
                output_default<=0;
            end
        else
            begin
                $display("Default value is not set as expected");
                output_default<=0;
            end
            //check the value of seed after reset

            /*cheking if output is produced when get_random=0 and output is still not completed 
            and also when the get_random becomes '1' before all the output is produce it should again continue to output the data*/
        get_random<=0;
        #100;
        get_random<=1;
        #600;
        get_random<=0;
        #100;
        /*cheking if output is produced when get_random=0 and output is still not completed 
            and also when the get_random becomes '1' before all the output is produce it should again continue to output the data*/

        //Checking for LFSR function
        get_random<=1;
        for(i=0;i<5;i=i+1)
            begin
                if(i==1)
                    begin
                        output_default[24:31]<=d_out;
                    end
                else if(i==2)
                    begin
                        output_default[16:23]<=d_out;
                    end
                else if(i==3)
                    begin
                        output_default[8:15]<=d_out;
                    end
                else if(i==4)
                begin
                    output_default[0:7]<=d_out;
                end
                #100;
            end
        if(output_default==32'h1234566)
            begin
                $display("Ouput is LFSR of default value");
                output_default<=0;
            end
        else
            begin
                $display("Ouput is not LFSR of default value");
                output_default<=0;
            end
            //Checking for LFSR function
            
            //checking for Data load
            get_random<=0;
            #300;
            load_seed<=1;
            #50;
            for(i=0;i<5;i=i+1)
            begin
            if(i==1)
                    begin
                        data_in<=8'h32;
                    end
                else if(i==2)
                    begin
                        data_in<=8'h45;
                    end
                else if(i==3)
                    begin
                        data_in<=8'h87;
                    end
                else if(i==4)
                begin
                    data_in<=8'h77;
                end
                #100;
            end
            load_seed<=0;
            #100;
            get_random<=1;
        for(i=0;i<5;i=i+1)
            begin
                if(i==1)
                    begin
                        output_default[24:31]<=d_out;
                    end
                else if(i==2)
                    begin
                        output_default[16:23]<=d_out;
                    end
                else if(i==3)
                    begin
                        output_default[8:15]<=d_out;
                    end
                else if(i==4)
                begin
                    output_default[0:7]<=d_out;
                end
                #100;
            end
        if(output_default==32'h32458777)
            begin
                $display("seed value is set as expected");
                output_default<=0;
            end
        else
            begin
                $display("seed value is not set as expected");
                output_default<=0;
            end
            //checking for data load
    end
endmodule