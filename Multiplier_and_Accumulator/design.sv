parameter WIDTH = 8;

module ece593w26_mul(input logic clk, rst,
                     input logic [(WIDTH-1):0]w, x,
                     logic [$clog2(WIDTH-1):0] count,
                     output logic [(2*WIDTH):0]f);
  
  
  typedef enum logic [1:0] {SHIFT, ADD, SUB} state_t;
                     
  state_t current_state, next_state;
  
  always_ff @(posedge clk) begin
    if(rst) begin
      current_state <= SHIFT;
      
      a <= 1'b0;
      q_1 <= 1'b0;
      q = x;
      
    end
  end 
  
  always_comb begin
    
    case(current_state) 
      
      SHIFT: begin
      
        if(({q[0], q_1} == 00) || ({q[0], q_1} == 11)) begin
          {a, q, q_1} <= {a, q, q_1} >>> 1;
      		count = count-1;
      		end
        
      end

      ADD: begin
        
        if({q[0], q_1} == 01) begin
          a = a + w;
          count = count - 1;
        end
        
      end
      
      SUB: begin
        
        if({q[0], q_1} == 10) begin
          a = a - w;
          count = count - 1;
          
        end 
           
       end
           
       default: next_state = SHIFT;
       end
   endcase
endmodule 
