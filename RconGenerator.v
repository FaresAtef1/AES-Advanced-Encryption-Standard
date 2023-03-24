module RconGenerator (input[5:0] i , input [3:0]Nk , output [31:0] Rcon);

reg [31:0] RconTemp ;
assign Rcon = RconTemp ;

always @ (i)
begin
case(i/Nk)
4'd1 : RconTemp=32'h01000000;
4'd2 : RconTemp=32'h02000000;
4'd3 : RconTemp=32'h04000000;
4'd4 : RconTemp=32'h08000000;
4'd5 : RconTemp=32'h10000000;
4'd6 : RconTemp=32'h20000000;
4'd7 : RconTemp=32'h40000000;
4'd8 : RconTemp=32'h80000000;
4'd9 : RconTemp=32'h1b000000;
4'd10 :RconTemp=32'h36000000;

endcase
end

endmodule
