module InvMixColumns(PrevState,NextState);
input [127:0] PrevState ;
output wire [127:0] NextState;
wire [7:0] s0 [3:0];
wire [7:0] s1 [3:0];
wire [7:0] s2 [3:0];
wire [7:0] s3 [3:0];
wire [7:0] p0 [3:0];
wire [7:0] p1 [3:0];
wire [7:0] p2 [3:0];
wire [7:0] p3 [3:0];
wire [7:0] t0 [3:0];
wire [7:0] t1 [3:0];
wire [7:0] t2 [3:0];
wire [7:0] t3 [3:0];
wire [7:0] f0 [3:0];
wire [7:0] f1 [3:0];
wire [7:0] f2 [3:0];
wire [7:0] f3 [3:0];

genvar i;
generate 
for(i=0;i<4;i=i+1) begin : generate_block
AESMultiply a1(8'h0e,PrevState[127-(32*i)-:8],s0[i]);
AESMultiply a2(8'h0b,PrevState[119-(32*i)-:8],s1[i]);
AESMultiply a3(8'h0d,PrevState[111-(32*i)-:8],s2[i]);
AESMultiply a4(8'h09,PrevState[103-(32*i)-:8],s3[i]);

assign NextState[127-(32*i)-:8]=s0[i]^s1[i]^s2[i]^s3[i];

AESMultiply a5(8'h09,PrevState[127-(32*i)-:8],p0[i]);
AESMultiply a6(8'h0e,PrevState[119-(32*i)-:8],p1[i]);
AESMultiply a17(8'h0b,PrevState[111-(32*i)-:8],p2[i]);
AESMultiply a18(8'h0d,PrevState[103-(32*i)-:8],p3[i]);

assign NextState[119-(32*i)-:8]=p0[i]^p1[i]^p2[i]^p3[i];

AESMultiply a41(8'h0d,PrevState[127-(32*i)-:8],t0[i]);
AESMultiply a14(8'h09,PrevState[119-(32*i)-:8],t1[i]);
AESMultiply a19(8'h0e,PrevState[111-(32*i)-:8],t2[i]);
AESMultiply a188(8'h0b,PrevState[103-(32*i)-:8],t3[i]);

assign NextState[111-(32*i)-:8]=t0[i]^t1[i]^t2[i]^t3[i];

AESMultiply a551(8'h0b,PrevState[127-(32*i)-:8],f0[i]);
AESMultiply a518(8'h0d,PrevState[119-(32*i)-:8],f1[i]);
AESMultiply a51(8'h09,PrevState[111-(32*i)-:8],f2[i]);
AESMultiply a31(8'h0e,PrevState[103-(32*i)-:8],f3[i]);

assign NextState[103-(32*i)-:8]=f0[i]^f1[i]^f2[i]^f3[i];






end
endgenerate
 



endmodule 