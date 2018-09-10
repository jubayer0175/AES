`timescale 1ns / 1ps

module keyAdd(

input [0:7]round,
input [0:127]dataIn,
input [0:127]subKey,

output [0:127]dataOut,
output [0:127]nextSubKey
    );
    
assign dataOut=dataIn ^ nextSubKey;// done key addition part

// this part has nothing to do with current round. it merely generates next \
//round sub key
subKey SbKey(round,subKey,nextSubKey);    
endmodule
