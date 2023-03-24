module AESMultiply
( 
input [7:0] A,
input [7:0] B,
output [7:0] C
);

reg [7:0] x;
reg  [7:0] y;
reg  [7:0] p;
reg carry;


integer i;

always@*
begin 
x=A;
y=B;
p=0;
    for(i=0;i<8;i=i+1)         
	 begin
        if(y[0] & 1'b1)
            p =p^x;
        carry = x[7] & 1'b1;
        x = x<<1;
        if(carry==1)
            x=x^8'h1b;
        y = y>>1;
    end
end
 assign C=p;



endmodule 
