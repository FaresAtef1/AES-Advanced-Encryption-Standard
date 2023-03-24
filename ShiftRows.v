module ShiftRows
(
input [0:127] PrevState,
output[0:127] NextState
);
reg [0:127] NextStateReg;
assign NextState=NextStateReg;
integer i;
always@*
begin
NextStateReg[7-:8]=PrevState[7-:8];
NextStateReg[39-:8]=PrevState[39-:8];
NextStateReg[71-:8]=PrevState[71-:8];
NextStateReg[103-:8]=PrevState[103-:8];
for(i=1;i<4;i=i+1)
begin
case(shift(i,4))
2'd1:begin
NextStateReg[8*i+7-:8]=PrevState[8*(i+4)+7-:8];
NextStateReg[8*(i+4)+7-:8]=PrevState[8*(i+8)+7-:8];
NextStateReg[8*(i+8)+7-:8]=PrevState[8*(i+12)+7-:8];
NextStateReg[8*(i+12)+7-:8]=PrevState[8*i+7-:8];
end
2'd2:begin
NextStateReg[8*i+7-:8]=PrevState[8*(i+8)+7-:8];
NextStateReg[8*(i+4)+7-:8]=PrevState[8*(i+12)+7-:8];
NextStateReg[8*(i+8)+7-:8]=PrevState[8*i+7-:8];
NextStateReg[8*(i+12)+7-:8]=PrevState[8*(i+4)+7-:8];
end
2'd3:begin
NextStateReg[8*i+7-:8]=PrevState[8*(i+12)+7-:8];
NextStateReg[8*(i+4)+7-:8]=PrevState[8*i+7-:8];
NextStateReg[8*(i+8)+7-:8]=PrevState[8*(i+4)+7-:8];
NextStateReg[8*(i+12)+7-:8]=PrevState[8*(i+8)+7-:8];
end
endcase
end 
end

function [1:0] shift;
input [1:0] r,Nb;
 
case(r)
2'b01 : shift=2'b01;
2'b10 : shift=2'b10;
2'b11 : shift=2'b11;
default : shift=2'b00;
endcase
endfunction

endmodule