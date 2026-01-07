
// alu_regression_test.sv
// Lab 8 - Regression Test Class (Exercise Solution)
// 
// Test: Comprehensive regression that runs ALL sequences from Lab 5
// This ensures complete coverage of all ALU operations and edge cases


class alu_regression_test extends uvm_test;
  

  // Component Declarations
  alu_environment env;
  
  // All sequence types
  alu_random_sequence           random_seq;
  alu_add_sequence              add_seq;
  alu_sub_sequence              sub_seq;
  alu_and_sequence              and_seq;
  alu_or_sequence               or_seq;
  alu_xor_sequence              xor_seq;
  alu_undefined_opcode_sequence undef_seq;
  alu_overflow_sequence         overflow_seq;
  alu_underflow_sequence        underflow_seq;
  

  // Factory Registration

  `uvm_component_utils(alu_regression_test)
  

  // Constructor

  function new(string name = "alu_regression_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  

  // Build Phase - Create Environment

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info(get_type_name(), "Building Regression Test", UVM_LOW)
    
    // Create environment
    env = alu_environment::type_id::create("env", this);
    
    `uvm_info(get_type_name(), "Regression Test Build Complete", UVM_LOW)
  endfunction : build_phase
  

  // Run Phase - Execute All Sequences
 
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "=========================================================", UVM_LOW)
    `uvm_info(get_type_name(), "=     ALU COMPREHENSIVE REGRESSION TEST                 =", UVM_LOW)
    `uvm_info(get_type_name(), "=  Running all sequences from Lab 5                     =", UVM_LOW)
    `uvm_info(get_type_name(), "=========================================================", UVM_LOW)
    
    // Raise objection
    phase.raise_objection(this, "Regression test started");
    

    // Test 1: Random Sequence (100 iterations)

    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 1/9: Random Sequence (100 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(100) begin
      random_seq = alu_random_sequence::type_id::create("random_seq");
      random_seq.start(env.agent.sequencer);
    end
    
 
    // Test 2: ADD Sequence (50 iterations)

    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 2/9: ADD Sequence (50 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(50) begin
      add_seq = alu_add_sequence::type_id::create("add_seq");
      add_seq.start(env.agent.sequencer);
    end
    
  
    // Test 3: SUB Sequence (50 iterations)

    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 3/9: SUB Sequence (50 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(50) begin
      sub_seq = alu_sub_sequence::type_id::create("sub_seq");
      sub_seq.start(env.agent.sequencer);
    end
    

    // Test 4: AND Sequence (30 iterations)
  
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 4/9: AND Sequence (30 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(30) begin
      and_seq = alu_and_sequence::type_id::create("and_seq");
      and_seq.start(env.agent.sequencer);
    end
    
 
    // Test 5: OR Sequence (30 iterations)

    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 5/9: OR Sequence (30 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(30) begin
      or_seq = alu_or_sequence::type_id::create("or_seq");
      or_seq.start(env.agent.sequencer);
    end
    

    // Test 6: XOR Sequence (30 iterations)

    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 6/9: XOR Sequence (30 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(30) begin
      xor_seq = alu_xor_sequence::type_id::create("xor_seq");
      xor_seq.start(env.agent.sequencer);
    end
    

    // Test 7: Undefined Opcode Sequence (20 iterations)

    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 7/9: Undefined Opcode (20 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(20) begin
      undef_seq = alu_undefined_opcode_sequence::type_id::create("undef_seq");
      undef_seq.start(env.agent.sequencer);
    end
    

    // Test 8: Overflow Sequence (10 iterations)
 
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 8/9: Overflow Sequence (10 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(10) begin
      overflow_seq = alu_overflow_sequence::type_id::create("overflow_seq");
      overflow_seq.start(env.agent.sequencer);
    end
    

    // Test 9: Underflow Sequence (10 iterations)
  
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    `uvm_info(get_type_name(), "Test 9/9: Underflow Sequence (10 trans)", UVM_LOW)
    `uvm_info(get_type_name(), "----------------------------------------", UVM_LOW)
    repeat(10) begin
      underflow_seq = alu_underflow_sequence::type_id::create("underflow_seq");
      underflow_seq.start(env.agent.sequencer);
    end
    
    // Small delay for final transactions
    #100;
    
    // Drop objection
    phase.drop_objection(this, "Regression test completed");
    
    `uvm_info(get_type_name(), "==========================================================", UVM_LOW)
    `uvm_info(get_type_name(), "=     REGRESSION TEST COMPLETED                         =", UVM_LOW)
    `uvm_info(get_type_name(), "=  Total Transactions: 360                              =", UVM_LOW)
    `uvm_info(get_type_name(), "==========================================================", UVM_LOW)
  endtask : run_phase
  

  // Report Phase
 
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), "Regression Test: All sequences executed successfully", UVM_LOW)
  endfunction : report_phase
  
endclass : alu_regression_test



