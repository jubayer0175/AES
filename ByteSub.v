
module ByteSub(
(* DONT_TOUCH = "true" *) input [0:127] A,
(* DONT_TOUCH = "true" *) output [0:127] B
);




 wire [0:7]t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,t10,t11,t12,t13,t14,t15;
 
Sbox SB0(A[0:7],t0);
Sbox SB1(A[8:15],t1);
Sbox SB2(A[16:23],t2);
Sbox SB3(A[24:31],t3);
Sbox SB4(A[32:39],t4);
Sbox SB5(A[40:47],t5);
Sbox SB6(A[48:55],t6);
Sbox SB7(A[56:63],t7);
Sbox SB8(A[64:71],t8);
Sbox SB9(A[72:79],t9);
Sbox SB10(A[80:87],t10);
Sbox SB11(A[88:95],t11);
Sbox SB12(A[96:103],t12);
Sbox SB13(A[104:111],t13);
Sbox SB14(A[112:119],t14);
Sbox SB15(A[120:127],t15);

 


assign B[0:7]=t0;//t0
assign B[8:15]=t5;//t5
assign B[16:23]=t10;//t10
assign B[24:31]=t15;//t15
assign B[32:39]=t4;//t4
assign B[40:47]=t9;//t9
assign B[48:55]=t14;//t14
(* DONT_TOUCH = "true" *) assign B[56:63]=t3;//t3
(* DONT_TOUCH = "true" *) assign B[64:71]=t8;//t8
(* DONT_TOUCH = "true" *) assign B[72:79]=t13;//t13
(* DONT_TOUCH = "true" *) assign B[80:87]=t2;//t2
(* DONT_TOUCH = "true" *) assign B[88:95]=t7;//t7
(* DONT_TOUCH = "true" *) assign B[96:103]=t12;//t12
(* DONT_TOUCH = "true" *) assign B[104:111]=t1;//t1
(* DONT_TOUCH = "true" *) assign B[112:119]=t6;//t6
(* DONT_TOUCH = "true" *) assign B[120:127]=t11;//t11






endmodule
