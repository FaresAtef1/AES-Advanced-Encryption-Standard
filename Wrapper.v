module Wrapper (input Enable , output [2:0] Led);  

reg [127:0] PLAINTEXT;
reg [127:0] Key1 ;
reg [191:0] Key2 ;
reg [255:0] Key3 ;
wire [127:0] CipherText [2:0];  
wire [127:0] DeCipheredText [2:0];

localparam WordsSize128 =128*(128/32 + 6+1);
localparam WordsSize192 =128*(192/32 + 6+1);
localparam WordsSize256 =128*(256/32 + 6+1);

wire [WordsSize128-1:0] Words128 ;
wire [WordsSize192-1:0] Words192 ;
wire [WordsSize256-1:0] Words256 ;

reg [2:0] LedTemp ;
assign Led= LedTemp;

always @*
begin
LedTemp=0;
if (Enable==1)
begin
Key1=128'h000102030405060708090a0b0c0d0e0f;
Key2 =192'h000102030405060708090a0b0c0d0e0f1011121314151617 ;
Key3 =256'h000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f ;
PLAINTEXT =128'h00112233445566778899aabbccddeeff;


if (DeCipheredText[0]==PLAINTEXT)
LedTemp[0] =1'b1;

if (DeCipheredText[1]==PLAINTEXT)
LedTemp[1] =1'b1;

if (DeCipheredText[2]==PLAINTEXT)
LedTemp[2] =1'b1;
end
end
KeyExpansion #(128) KE1 (Key1,Words128);
AES #(128) AESE1 (PLAINTEXT,Words128,CipherText[0]);
AESDecrypt#(128) AESEDec1 (CipherText[0],Words128,DeCipheredText[0]);

KeyExpansion #(192) KE2 (Key2,Words192);
AES #(192) AESE2 (PLAINTEXT,Words192,CipherText[1]);
AESDecrypt#(192) AESEDec2 (CipherText[1],Words192,DeCipheredText[1]);

KeyExpansion #(256) KE3 (Key3,Words256);
AES #(256) AESE3 (PLAINTEXT,Words256,CipherText[2]);
AESDecrypt#(256) AESEDec3 (CipherText[2],Words256,DeCipheredText[2]);

endmodule
