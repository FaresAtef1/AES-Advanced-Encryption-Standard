module AESDecrypt
#(parameter KeySize=128)
(
input [127:0] CipherText,
input [128*(KeySize/32 + 6+1)-1:0] Words,
output [127:0] PlainText
);
localparam Nr=KeySize/32+6;

wire [127:0] k_sch[Nr:0];

genvar k;
generate 
for (k=0;k<=Nr;k=k+1)begin : generate_block1
assign k_sch[k] = {Words[32+128*k-1-:32],Words[64+128*k-1-:32],Words[96+128*k-1-:32],Words[128+128*k-1-:32]} ;
end
endgenerate

wire [127:0] start [Nr-1:0];
wire [127:0] s_box [Nr-1:0];
wire [127:0] ik_add[Nr-2:0];
wire [127:0] s_row [Nr-1:0];


AddRoundKey A (CipherText,k_sch[Nr],start[0]);

genvar i,j;
generate 
for(i=0;i<Nr-1;i=i+1) begin: generate_block2
InvShiftRows  SR(start[i],s_row[i]);
for(j=0;j<16;j=j+1)begin: generate_block3
InvSubBytes SB(s_row[i][8*(16-j)-1-:8],s_box[i][8*(16-j)-1-:8]);
end
AddRoundKey   Ar(s_box[i],k_sch[Nr-1-i],ik_add[i]);
InvMixColumns MC(ik_add[i],start[i+1]);
end
endgenerate


InvShiftRows  SR(start[Nr-1],s_row[Nr-1]);
genvar t;
generate
for(t=0;t<16;t=t+1)begin: generate_block4
InvSubBytes SR1(s_row[Nr-1][8*(16-t)-1-:8],s_box[Nr-1][8*(16-t)-1-:8]);
end
endgenerate
AddRoundKey Ar1(s_box[Nr-1],k_sch[0],PlainText);


endmodule

