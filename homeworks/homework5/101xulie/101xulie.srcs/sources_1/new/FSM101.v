`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/31 15:58:53
// Design Name: 
// Module Name: FSM101
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


module FSM101(
    input clk,
    input rst,
    input a,
    output z
    );
    
    reg z;
    reg temp_z;
    reg [1:0] currentstate,nextstate;
    parameter S0=2'b00;
    parameter S1=2'b01;
    parameter S2=2'b10;
    
    always@(posedge clk or negedge rst)
        if(!rst)
            currentstate <= S0;
        else
            currentstate <= nextstate;
    
    always@(currentstate or a or rst)
        if(!rst)
            nextstate=S0;
        else
            case(currentstate)
                S0: nextstate = (a==1)? S1:S0;
                S1: nextstate = (a==0)? S2:S1;
                S2: nextstate = (a==1)? S1:S0;
                default: nextstate=S0;
            endcase
            
    always@(rst or currentstate or a)
        if(!rst)
            temp_z=0;
        else
            case(currentstate)
                S0: temp_z = 0;
                S1: temp_z = 0;
                S2: temp_z = (a==1)?1:0;
                default: temp_z = 0;
            endcase
        
     always@(posedge clk or negedge rst)
        if(!rst)
            z <= 0;
        else
            begin
                if((temp_z == 1)&&(nextstate == S1))
                    z <= 1;
                else
                    z <= 0;
            end
endmodule
