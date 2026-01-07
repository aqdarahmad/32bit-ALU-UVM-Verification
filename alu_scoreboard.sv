
// alu_scoreboard.sv
// UVM Scoreboard for ALU DUT
// Contains reference model and checks DUT output against expected results



class alu_scoreboard extends uvm_scoreboard;
  

  // Factory Registration

  `uvm_component_utils(alu_scoreboard)
  

  // Analysis Port (receives transactions from monitor)
  
  uvm_analysis_imp#(alu_sequence_item, alu_scoreboard) exp;
  
 
  // Queue to store incoming packets
  
  alu_sequence_item packetQueue[$];
  
  
  // Reference packet for expected results
 
  alu_sequence_item refPacket;
  
 
  // Statistics Counters
  
  int pass_count = 0;
  int fail_count = 0;
 
  
  // Constructor
  
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  
  // Build Phase - Create analysis port and reference packet
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    exp = new("exp", this);
    refPacket = alu_sequence_item::type_id::create("refPacket");
  endfunction : build_phase
  

  // Write Function - Called by monitor's analysis port
 
  function void write(alu_sequence_item req);
    packetQueue.push_back(req);
  endfunction : write
  
 
  // Run Phase - Process packets and check results
 
  task run_phase(uvm_phase phase);
    alu_sequence_item packet;
    
    forever begin
      // Wait for packets in queue
      wait(packetQueue.size() > 0);
      
      // Get packet from queue
      packet = packetQueue.pop_front();
      
      // Calculate expected result using reference model
      alu_rf(packet.A, packet.B, packet.Opcode, 
             refPacket.Result, refPacket.Error);
      
      // Copy inputs to reference packet for comparison
      refPacket.A = packet.A;
      refPacket.B = packet.B;
      refPacket.Opcode = packet.Opcode;
      
      // Compare actual vs expected
      if(is_equal(refPacket, packet)) begin
        pass_count++;
        `uvm_info("PASS", "====== :: MATCH :: ======", UVM_LOW)
        `uvm_info("ACTUAL", $sformatf("A=%0d, B=%0d, Op=%b, Result=%0d, Error=%b", 
                  packet.A, packet.B, packet.Opcode, packet.Result, packet.Error), UVM_LOW)
        `uvm_info("EXPECTED", $sformatf("A=%0d, B=%0d, Op=%b, Result=%0d, Error=%b", 
                  refPacket.A, refPacket.B, refPacket.Opcode, refPacket.Result, refPacket.Error), UVM_LOW)
      end
      else begin
        fail_count++;
        `uvm_error("FAIL", "====== :: MISMATCH :: ======")
        `uvm_info("ACTUAL", $sformatf("A=%0d, B=%0d, Op=%b, Result=%0d, Error=%b", 
                  packet.A, packet.B, packet.Opcode, packet.Result, packet.Error), UVM_LOW)
        `uvm_info("EXPECTED", $sformatf("A=%0d, B=%0d, Op=%b, Result=%0d, Error=%b", 
                  refPacket.A, refPacket.B, refPacket.Opcode, refPacket.Result, refPacket.Error), UVM_LOW)
      end
    end
  endtask : run_phase
  
  
  // Report Phase - Print final statistics
  
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    `uvm_info(get_type_name(), "       SCOREBOARD FINAL REPORT", UVM_LOW)
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("Total Transactions: %0d", pass_count + fail_count), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("PASSED: %0d", pass_count), UVM_LOW)
    `uvm_info(get_type_name(), $sformatf("FAILED: %0d", fail_count), UVM_LOW)
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
  endfunction : report_phase
  
  
  // Comparison Function - Compare two packets
  
  function bit is_equal(alu_sequence_item reference, alu_sequence_item packet);
    if(reference.A === packet.A &&
       reference.B === packet.B &&
       reference.Opcode === packet.Opcode &&
       reference.Result === packet.Result &&
       reference.Error === packet.Error)
      return 1;
    else
      return 0;
  endfunction : is_equal
  
  
  // ALU Reference Model - Golden Model for Expected Results
  
  static task alu_rf(input logic signed [31:0] A,
                     input logic [31:0] B,
                     input logic [2:0] Opcode,
                     output logic [31:0] Result,
                     output logic Error);
    
    // Initialize Error flag
    Error = 0;
    
    case (Opcode)
  
      // ADD Operation (Opcode = 000)
    
      3'b000: begin
        Result = A + B;
        // Check for overflow
        // Overflow occurs when:
        // - Two positive numbers add to negative (pos + pos = neg)
        // - Two negative numbers add to positive (neg + neg = pos)
        if ((A > 0 && B > 0 && Result < 0) || (A < 0 && B < 0 && Result > 0))
          Error = 1;
      end
      
  
      // SUB Operation (Opcode = 001)
   
      3'b001: begin
        Result = A - B;
        // Check for underflow
        // Underflow occurs when:
        // - Negative - Positive results in value > original negative
        // - Positive - Negative results in value < original positive
        if ((A < 0 && B > 0 && Result > A) || (A > 0 && B < 0 && Result < A))
          Error = 1;
      end
      
   
      // AND Operation (Opcode = 010)
   
      3'b010: begin
        Result = A & B;
      end
      
   
      // OR Operation (Opcode = 011)
   
      3'b011: begin
        Result = A | B;
      end
      
   
      // XOR Operation (Opcode = 100)
    
      3'b100: begin
        Result = A ^ B;
      end
      
   
      // Undefined Opcode (101, 110, 111)
     
      default: begin
        Result = 0;
        Error = 1'b1;  // Set error flag for invalid opcode
      end
    endcase
  endtask : alu_rf
  
endclass : alu_scoreboard