`timescale 1ns / 1ps

module g(
(* DONT_TOUCH = "true" *)input [0:7]rc,// this indicates the round
(* DONT_TOUCH = "true" *)input [0:31] V,
(* DONT_TOUCH = "true" *)output [0:31]V_Ged
    );
   
 wire [0:7]temp0, temp1,temp2,temp3;

 wire [0:7]tempy;  
   // shift them
   
  assign temp0=V[8:15];
  assign temp1=V[16:23];
  assign temp2=V[24:31];
  assign temp3=V[0:7];
  
   assign V_Ged[0:7]= tempy ^ rc;
  
  
    Sbox S0(temp0, tempy); // xor vale goes to 
    Sbox S1(temp1,V_Ged[8:15]);
    Sbox S2(temp2,V_Ged[16:23]);
    Sbox S3(temp3,V_Ged[24:31]); 
  
  //Sbox query, here i think a centralized ROM acess could save some time


  
  

endmodule
