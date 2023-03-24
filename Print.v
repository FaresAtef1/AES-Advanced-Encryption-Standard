module Print (Counter,State);
input Counter ;
input [127:0]State;

always@(State)
case(Counter)

2'b00 : $display("round[ 0].input\t%h",State);
2'b01 : $display("round[ 0].k_sch\t%h",State);
2'b10 : $display("round[ 1].start\t%h",State);
2'b11 : $display("round[ 1].s_box\t%h",State);

endcase

endmodule