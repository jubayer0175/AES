`timescale 1ns / 1ps


module AES(

input clk,
input rst,
input en,
input [127:0]Din,
input Din_valid,
output [127:0]Dout,
output  Dout_valid

);

(* DONT_TOUCH = "true" *) reg [8:0] shift;

AES_128 AES_ (clk,en,rst,Din,128'h000102030405060708090A0B0C0D0E0F,Dout);

assign Dout_valid = shift[8];

always @(posedge clk, posedge rst) begin
	if (rst) begin
		shift <= 9'b000000000;
	end
	else begin
		shift <= shift << 1;
		shift[0] <= Din_valid;
	end
end

endmodule
