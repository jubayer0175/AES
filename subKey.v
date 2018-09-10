`timescale 1ns / 1ps

module subKey(
(* DONT_TOUCH = "true" *)input [0:7]Rc,
(* DONT_TOUCH = "true" *)input [0:127]W,
(* DONT_TOUCH = "true" *)output [0:127]W_out
    );
    
 
wire [0:31]gOut;    
    
 g G(Rc,W[96:127],gOut);
 
 assign W_out[0:31]=    W[0:31] ^ gOut[0:31];
 assign W_out[32:63]=   W_out[0:31] ^ W[32:63];
 assign W_out[64:95]=   W_out[31:63] ^ W[64:95];
 assign W_out[96:127]=  W_out[64:95] ^ W[96:127];

endmodule
