
// alu.sv (design.sv)
// Lab 9 - ALU Design (DUT - Device Under Test)
// 
// 32-bit ALU with the following operations:
// - ADD (000): Addition with overflow detection
// - SUB (001): Subtraction with underflow detection
// - AND (010): Bitwise AND
// - OR  (011): Bitwise OR
// - XOR (100): Bitwise XOR
// - Undefined (101-111): Set Error flag


module alu(
  input  logic        clk,
  input  logic        rst,
  input  logic [31:0] A,
  input  logic [31:0] B,
  input  logic [2:0]  Opcode,
  output logic [31:0] Result,
  output logic        Error
);


  // Internal Signals
  
  logic [31:0] result_next;
  logic        error_next;
  

  // Combinational Logic - ALU Operations

  always_comb begin
    // Default values
    result_next = 32'h0;
    error_next  = 1'b0;
    
    if (!rst) begin  // Only operate when not in reset
      case (Opcode)

        // ADD Operation (Opcode = 000)
  
        3'b000: begin
          result_next = A + B;
          
          // Overflow Detection for signed addition
          // Overflow when: pos + pos = neg  OR  neg + neg = pos
          if ((A[31] == 0 && B[31] == 0 && result_next[31] == 1) ||
              (A[31] == 1 && B[31] == 1 && result_next[31] == 0)) begin
            error_next = 1'b1;
          end
        end
        

        // SUB Operation (Opcode = 001)

        3'b001: begin
          result_next = A - B;
          
          // Underflow Detection for signed subtraction
          // Underflow when: neg - pos results in value > original
          //             OR: pos - neg results in value < original
          if ((A[31] == 1 && B[31] == 0 && result_next > A) ||
              (A[31] == 0 && B[31] == 1 && result_next < A)) begin
            error_next = 1'b1;
          end
        end
        
  
        // AND Operation (Opcode = 010)

        3'b010: begin
          result_next = A & B;
        end
        
  
        // OR Operation (Opcode = 011)
   
        3'b011: begin
          result_next = A | B;
        end
        
   
        // XOR Operation (Opcode = 100)
      
        3'b100: begin
          result_next = A ^ B;
        end
        
    
        // Undefined Opcodes (101, 110, 111)
  
        default: begin
          result_next = 32'h0;
          error_next  = 1'b1;
        end
      endcase
    end
  end
  

  // Sequential Logic - Registered Outputs

  always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
      Result <= 32'h0;
      Error  <= 1'b0;
    end
    else begin
      Result <= result_next;
      Error  <= error_next;
    end
  end

endmodule : alu