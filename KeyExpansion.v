module KeyExpansion #(parameter KeySize = 128) (input [KeySize-1:0] Key , output [128*(KeySize/32 + 6+1)-1:0] W );

localparam Nr = KeySize/32 + 6 ;
localparam Nk = KeySize/32  ;

wire [31:0] Temp [4*(Nr+1)-Nk-1:0];
wire [31:0] RotWordOut[((4*(Nr+1)-1)/Nk)-1:0];
wire [31:0] SubByteOut[4*(Nr+1)-Nk:0];
wire [31:0] Rcon[((4*(Nr+1)-1)/Nk)-1:0];
wire [128*(Nr+1)-1:0] WTemp ;
wire [31:0] Temp1 [4*(Nr+1)-Nk-1:0];   

assign W = WTemp;

genvar i ;
genvar j ;
genvar k ;

generate 

for (k=0;k<Nk;k=k+1)begin : generate_block3
assign WTemp[32*(k+1)-1-:32] = Key[32*(Nk-k)-1-:32];
end

for (i=Nk;i<4*(Nr+1);i=i+1) begin : generate_block

assign Temp[i-Nk]=WTemp [i*32-1 -:32]; 
   
if(i%Nk==0)
begin
RconGenerator a322 (i,Nk , Rcon[(i-Nk)/Nk]);
RotWord A1 (Temp[i-Nk][31:0],RotWordOut[(i-Nk)/Nk]) ;
for(j=0;j<4;j=j+1) begin : generate_block1
SubByte A2 (RotWordOut[(i-Nk)/Nk] [8*(j+1)-1-:8],SubByteOut[i-Nk][8*(j+1)-1-:8]);
end
assign Temp1[i-Nk]= SubByteOut[i-Nk] ^ Rcon[(i-Nk)/Nk] ;
end

else if (Nk>6 && i%Nk == 3'd4 )
begin

for(j=0;j<4;j=j+1) begin : generate_block1
SubByte A211 (Temp[i-Nk] [8*(j+1)-1-:8],SubByteOut[i-Nk][8*(j+1)-1-:8]);
end
assign Temp1[i-Nk] = SubByteOut[i-Nk];

end

else
begin
assign Temp1[i-Nk] = Temp[i-Nk] ;
end

assign WTemp[32*(i+1)-1-:32] =  WTemp [32*(i-Nk+1)-1-:32] ^ Temp1[i-Nk] ;

end
endgenerate

endmodule
