parameter WIDTH = 8;
module fullAdder(input logic a, b, cin,
                  output logic s, cout);
  
  assign sum = a ^ b ^ cin;
  assign cout = (a&b) | (b&cin) | (cin&a);
endmodule 

module adder16(input logic [(2*WIDTH)-1:0] a, b,
               input logic cin,
               output logic [(2*WIDTH)-1:0]sum,
               output logic cout);
  
  logic [(2*WIDTH)-1:0] c;
  
  genvar i;
  generate 
    for(i=0; i<(2*WIDTH);i=i+1) begin : FA_LOOP
      if(i == 0) begin
        fullAdder fa(.a(a[i]), .b(b[i]), .cin(cin), .sum(sum[i]), .cout(cout[i]));
      end 
      else begin 
        full_adder fa(.a(a[i]), .b(b[i]), .cin(c[i-1]), .sum(sum[i]), .cout(c[i]));
      end
    end
  endgenerate
  
  assign cout = c[(2*WIDTH-1)];
endmodule 
