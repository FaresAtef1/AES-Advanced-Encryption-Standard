module RotWord (input [31:0] RowBef, output [31:0] RowAft);
assign RowAft = {RowBef[23:0],RowBef[31:24]};
endmodule
