`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/09/25 14:33:45
// Design Name: 
// Module Name: class_simulation
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


module simMUX41(
    );
    reg a,b,c,d,sel1,sel2;
    wire out;
    MUX41 testmux41(a,b,c,d,sel1,sel2,out);
    initial begin
    
    #5 begin a=1;b=0;c=0;d=0;sel1=0;sel2=0; end
    #5 begin a=0;b=1; end
    #5 begin b=0;c=1; end
    #5 begin c=0;d=1; end
    
    #5 begin a=1;b=0;c=0;d=0;sel1=0;sel2=1; end
    #5 begin a=0;b=1; end
    #5 begin b=0;c=1; end
    #5 begin c=0;d=1; end    
    
    #5 begin a=1;b=0;c=0;d=0;sel1=1;sel2=0; end
    #5 begin a=0;b=1; end
    #5 begin b=0;c=1; end
    #5 begin c=0;d=1; end
    
    #5 begin a=1;b=0;c=0;d=0;sel1=1;sel2=1; end
    #5 begin a=0;b=1; end
    #5 begin b=0;c=1; end
    #5 begin c=0;d=1; end   
    #5 begin a=0;b=0;c=0;d=0; end
    end
endmodule