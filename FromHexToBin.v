module FromHexToBin (Bef,Aft);
input Bef ;

output [3:0] Aft;
reg [3:0] Temp ;
assign Aft = Temp;
always @ (Bef)
begin
case(Bef)
1'h0 : Temp=4'b0000;
1'h1 : Temp=4'b0001;
1'h2 : Temp=4'b0010;
1'h3 : Temp=4'b0011;
1'h4 : Temp=4'b0100;
1'h5 : Temp=4'b0101;
1'h6 : Temp=4'b0110;
1'h7 : Temp=4'b0111;
1'h8 : Temp=4'b1000;
1'h9 : Temp=4'b1001;
1'ha : Temp=4'b1010;
1'hb : Temp=4'b1011;
1'hc : Temp=4'b1100;
1'hd : Temp=4'b1101;
1'he : Temp=4'b1110;
1'hf : Temp=4'b1111;
endcase
end



endmodule