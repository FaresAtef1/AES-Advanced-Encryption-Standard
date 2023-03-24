module MixColumns (PrevState,NextState);
input [127:0] PrevState ;
output wire [127:0] NextState;
wire [7:0] AA [3:0];
wire [7:0] AB [3:0];
wire [7:0] AC [3:0];
wire [7:0] AD [3:0];
wire [7:0] AE [3:0];
wire [7:0] AF [3:0];
wire [7:0] AG [3:0];
wire [7:0] AH [3:0];

genvar i ;
generate
for(i=0;i<4;i=i+1) begin : generate_block

AESMultiply A1 (8'h02 , PrevState [127-(32*i)-:8] , AA[i]);
AESMultiply A2 (8'h03 , PrevState [119-(32*i)-:8] , AB[i]);

assign NextState[127-(32*i)-:8] = AA[i] ^ AB[i] ^ PrevState [111-(32*i)-:8] ^ PrevState [103-(32*i)-:8] ;

AESMultiply A3 (8'h02 , PrevState [119-(32*i)-:8] , AC[i]);
AESMultiply A4 (8'h03 , PrevState [111-(32*i)-:8] , AD[i]);

assign NextState[119-(32*i)-:8] = PrevState [127-(32*i)-:8] ^ AC[i] ^ AD[i] ^ PrevState [103-(32*i)-:8] ;

AESMultiply A5 (8'h02 , PrevState [111-(32*i)-:8] , AE[i]);
AESMultiply A6 (8'h03 , PrevState [103-(32*i)-:8] , AF[i]);

assign NextState[111-(32*i)-:8] = PrevState [127-(32*i)-:8] ^ PrevState [119-(32*i)-:8] ^ AE[i] ^ AF[i] ;

AESMultiply A7 (8'h03 , PrevState [127-(32*i)-:8] , AG[i]);
AESMultiply A8 (8'h02 , PrevState [103-(32*i)-:8] , AH[i]);

assign NextState[103-(32*i)-:8] = AG[i] ^ PrevState [119-(32*i)-:8] ^ PrevState [111-(32*i)-:8] ^ AH[i] ;

end
endgenerate

endmodule