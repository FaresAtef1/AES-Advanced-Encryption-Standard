module AES #(parameter KeySize = 128)  (input [127:0] PLAINTEXT ,input [128*(KeySize/32 + 6+1)-1:0] Words,output [127:0] CipherText);

localparam Nr = KeySize/32 + 6 ;

wire [127:0] Start [Nr-1:0] ;
wire [127:0] s_box [Nr-1:0] ;
wire [127:0] s_row [Nr-1:0] ;
wire [127:0] m_col [Nr-2:0] ;
wire [127:0] k_sch [Nr:0] ;

genvar k;
genvar i;
genvar j;
genvar l;

generate 
for (k=0;k<=Nr;k=k+1)begin : generate_block
assign k_sch[k] = {Words[32+128*k-1-:32],Words[64+128*k-1-:32],Words[96+128*k-1-:32],Words[128+128*k-1-:32]} ;
end

AddRoundKey ARK1 (PLAINTEXT,k_sch[0],Start[0]);

for (i=0;i<Nr-1;i=i+1)begin : generate_block1

for(j=0;j<16;j=j+1) begin : generate_block2
SubByte A2 (Start[i] [8*(j+1)-1-:8],s_box[i][8*(j+1)-1-:8]);
end

ShiftRows SR1 (s_box[i],s_row[i]);
MixColumns MC1 (s_row[i],m_col[i]);
AddRoundKey ARK2 (m_col[i],k_sch[i+1],Start[i+1]);

end

for(l=0;l<16;l=l+1) begin : generate_block3
SubByte A2 (Start[Nr-1] [8*(l+1)-1-:8],s_box[Nr-1][8*(l+1)-1-:8]);
end

ShiftRows SR2 (s_box[Nr-1],s_row[Nr-1]);
AddRoundKey ARK3 (s_row[Nr-1],k_sch[Nr],CipherText);

endgenerate

endmodule
