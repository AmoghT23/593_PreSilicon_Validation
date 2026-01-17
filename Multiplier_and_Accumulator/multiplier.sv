// Parameter of the WIDTH of the Multiplier
parameter WIDTH = 8;

// Module with all input/output signals
module ece593w26_mul(input logic clk, rst,
                     input logic [(WIDTH-1):0] w, x,
                     output logic [(2*WIDTH):0] f);

  // Enumeration for the FSM (flowchart of the Wallace Tree Multiplier)
  typedef enum logic [1:0] {SHIFT, ADD, SUB} state_t;

  state_t current_state, next_state;

  //To hold the intermediate results
  logic [(WIDTH-1):0] a, q, q_1;
  logic [$clog2(WIDTH):0] count;

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      
      current_state <= SHIFT;  
      count <= WIDTH;          
      a <= 0;                  
      q_1 <= 0;                
      q <= x;                  
    end else begin
      current_state <= next_state;

      //Case statement for FSM(flowchart)
      case(current_state)
        
        SHIFT: begin
          if (count == 0) begin
            next_state <= ADD;  
          end 
          else if ({q[0], q_1} == 2'b00 || {q[0], q_1} == 2'b11) begin
            {a, q, q_1} <= {a, q, q_1} >>> 1;  
            count <= count - 1; 
            next_state <= SHIFT;  
          end 
          else begin
            next_state <= SHIFT;  
          end
        end

        ADD: begin
          if ({q[0], q_1} == 2'b01) begin
            a <= a + w;  
            count <= count - 1;  
            next_state <= SHIFT;  
          end
        end

        SUB: begin
          if ({q[0], q_1} == 2'b10) begin
            a <= a - w; 
            count <= count - 1;
            next_state <= SHIFT; 
          end
        end
		
        //Default condition 
        default: begin
          next_state <= SHIFT; 
        end
      endcase
    end
  end

	assign f = {a, q};

endmodule
