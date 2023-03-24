module AddRoundKey (input [127:0] StateBef,Key,output  [127:0] StateAft);

assign StateAft= StateBef^Key;

endmodule