// Code your design here
module project(
   input[63:0] a,b,//input a,b
   input [4:0] sel,//select line
   output reg [127:0] c//output
);
always @(*) begin
   case(sel)
     //Arithmetic operation
      5'b00000: c[64:0]=a+b;//add
      5'b00001: c[63:0]=a-b;//subtract
      5'b00010: c=a*b;//multiply
      5'b00011: c[63:0]=(b!=0)?a/b:0;//divide
      5'b00100: c[63:0]=a%b;//modulo
     //Logical Operation
     5'b00101: c[63:0]=a|b;//or
     5'b00110: c[63:0]=a&b;//and
     5'b00111: c[63:0]=~a;//invert a
     5'b01000: c[63:0]=~b;//invert b
     5'b01001: c[63:0]=a^b;//xor   
     5'b01010: c[63:0]=~(a^b);//xnor
     5'b01011: c[63:0]=~(a&b);//nand
     5'b01100: c[63:0]=~(a|b);//nor
     //Rotate operation
     5'b01101: c[63:0] = {a[62:0], a[63]}; // Rotate left a by 1
        5'b01110: c[63:0] = {a[0], a[63:1]};  // Rotate right a by 1
        5'b01111: c[63:0] = {b[62:0], b[63]}; // Rotate left b by 1
        5'b10000: c[63:0] = {b[0], b[63:1]};  // Rotate right b by 1

    //shift operation
     5'b10001: c[63:0]=a<<1;//logical left a by 1 position
     5'b10010: c[63:0]=a>>1;//logical right a by 1 position
     5'b10011: c[63:0]=b<<1;//logical left b by 1 position
     5'b10100: c[63:0]=b>>1;//logical right b by 1 position
     //comparison operation
     5'b10101: c[63:0]=(a>b)?64'd1:64'd0;//greater than
     5'b10110: c[63:0]=(a==b)?64'd1:64'd0;//equal to
    
   default: c=64'b0;//default case
   endcase
end
endmodule


