module tb ();
reg Enable;
wire [2:0] led ;

initial 
begin
$display ("Led0\tLed1\tLed2");
$monitor ("%b\t%b\t%b",led[0],led[1],led[2]);
Enable=0;
#5 Enable=1;
end

Wrapper w1 (Enable,led);

endmodule
