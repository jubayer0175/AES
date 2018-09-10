/*This module is the unit of AES encryption
Output has contains two 128 bit registers to store the State and subKey
The registers are initally in reset condition

*/



module Round(

input clk,
input reset,

(* DONT_TOUCH = "true" *)input [0:7]round,
(* DONT_TOUCH = "true" *)input [0:127]data_in,
(* DONT_TOUCH = "true" *)input [0:127]subKey,

(* DONT_TOUCH = "true" *)output reg [0:127]subKeyOut,// piple line register
(* DONT_TOUCH = "true" *)output reg [0:127]data_out //piple line register
    );
    
//world of temorary wires
(* DONT_TOUCH = "true" *)wire [0:127]temDataOut;
(* DONT_TOUCH = "true" *)wire [0:127]tempMixCol;


wire [0:127]singleCycyleDataOut; // initially assign the combinational 
// values to this wires. They will be assigned to the pipeline register later 
//in always to keep the clock syc.
wire [0:127]singleSubkey;

//world of block calls
ByteSub round_byteSub(data_in,temDataOut);
mix_col  round_mixCol(temDataOut,tempMixCol);
keyAdd round_keyAdd(round,tempMixCol,subKey,singleCycyleDataOut,singleSubkey);

// intial flash the pipeline 

initial begin
subKeyOut<=0;
data_out<=0;
end



// sync block
always @(posedge clk,negedge reset) begin

    if (reset) begin
    
    data_out<=0;   
    subKeyOut<=0;
    
    end
    else begin
    data_out<=singleCycyleDataOut;   
    subKeyOut<=singleSubkey;
    
    end     





end




endmodule
