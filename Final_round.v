


module Final_round(
input clk, 
input reset,
input [0:7]round,
input [0:127]data_in,
input [0:127]subKey,
output reg [0:127]  data_out
    );
    
    
(* DONT_TOUCH = "true" *)wire [0:127]temDataOut;   

wire [0:127]singleCycyleDataOut;
     
ByteSub round_byteSub_final(data_in,temDataOut);    
KeyAddFinal round_keyAdd_final(round,temDataOut,subKey,singleCycyleDataOut);    

initial  data_out<=0;
 // initial flash 
 
 always @ (posedge clk, negedge reset) begin
 
if (reset)
data_out<=0;
else
data_out<=singleCycyleDataOut;
end
 
  
endmodule
