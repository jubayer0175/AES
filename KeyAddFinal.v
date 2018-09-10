



module KeyAddFinal(
input [0:7]round,
input [0:127]dataIn,
input [0:127]subKey,
output [0:127]dataOut
    );


wire [0:127]nextSubKey;

assign dataOut=dataIn ^ nextSubKey;// done key addition part
subKey SbKey(round,subKey,nextSubKey);    
endmodule

