module code_cov_tb;
  
  logic A, B, C, P, Q, R;
  bit clk;
  logic rst_n;
  logic C_out, P_out, Q_out;
  
  code_cov dut(.*);
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 0;
    rst_n = 0;
    A = 0; B = 0; C = 0; 
    P = 0; Q = 0; R = 0;
    
    #10 rst_n = 1;
    

    for(int i=0; i<64; i++) begin
      #10 {A, B, C, P, Q, R} = i[5:0];
	@(posedge clk); 
    end 
	#5 rst_n = 0;
	@(posedge clk);
	#5 rst_n = 1;
	@(posedge clk);

	repeat(20)
 	{A, B, C, P, Q, R} = $urandom;
	@(posedge clk);
	$finish;
    end
 endmodule 
