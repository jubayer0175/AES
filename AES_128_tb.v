`timescale 1ns / 1ps

module AES_128_tb();

reg [0:127]Din;
reg [0:127]Key;
reg clk;
reg enable;
reg reset;
wire [0:127]Dout;
reg Din_valid;
wire Dout_valid;

// result can be verified here
//http://extranet.cryptomathic.com/aescalc
initial begin 

//#0   Din<=128'h00112233445566778899aabbccddeef;
#8   Key<=128'h000102030405060708090A0B0C0D0E0F;

end



 AES  sf(clk,reset, enable,Din,Din_valid,Dout,Dout_valid);




//instances;
initial begin
#0 clk <= 0;
#0 enable<=0;
#0 Din <=0;
#0 Key <=0;
#0 reset<=1;
#0 Din_valid<=0;

#5 enable <= 1;
#5 reset <=0;// the device should start working

end


always #10 clk =~clk;


initial begin
// test website
////http://extranet.cryptomathic.com/aescalc
#8 Din <=128'h00112233445566778899AABBCCDDFFF0;//Dout: 1D3E80EAD35822D3C7694761104A8F87
//#30 Din <=128'h00112233445566778899AABBCCDDFFF1;//Dout:2763C32E7652D34ECFB6EBDB46EBC7C2
//#30 Din<=128'h00112233445566778899AABBCCDDFFF2;

end

initial begin

#10 Din_valid<=1;
#20 Din_valid<=0;

end






endmodule
