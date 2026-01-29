module code_cov (
input logic A, B, C, P, Q, R,
input bit clk,
input logic rst_n,
output logic C_out, P_out, Q_out
);

  typedef enum logic [1:0] {AND, OR, NAND} state;
  state current_state, next_state;
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) 
      current_state <= AND;
    else 
      current_state <= next_state;
  end
  
  always_comb begin
     C_out = 0; P_out = 0; Q_out = 0;
  next_state = current_state;

    case(current_state)
      AND : begin
        C_out = (A && B);
        next_state = OR;
      end
      OR : begin
        P_out = (C || P);
	if(A)
	next_state = AND;
	else
	next_state = NAND;
      end
      NAND : begin
        Q_out = ~(Q && R); 
        next_state = AND;
      end
      default: next_state = AND;
      endcase
    end
      
endmodule
