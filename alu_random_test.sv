
// alu_random_test.sv
// Lab 8 - Random Test Class
// 
// Test: Creates environment and runs random sequence 500 times to generate
// comprehensive random stimulus for ALU verification


class alu_random_test extends uvm_test;
  
  
  // Component Declarations

  alu_environment env;
  alu_random_sequence seq;
  

  // Factory Registration
 
  `uvm_component_utils(alu_random_test)
  

  // Constructor

  function new(string name = "alu_random_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction : new
  

  // Build Phase - Create Environment

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info(get_type_name(), "Building Random Test", UVM_LOW)
    
    // Create environment
    env = alu_environment::type_id::create("env", this);
    
    `uvm_info(get_type_name(), "Random Test Build Complete", UVM_LOW)
  endfunction : build_phase
  

  // Run Phase - Execute Test
 
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    `uvm_info(get_type_name(), "  Starting Random Test", UVM_LOW)
    `uvm_info(get_type_name(), "  Test: 500 Random Transactions", UVM_LOW)
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    
    // Raise objection to keep simulation running
    phase.raise_objection(this, "Random test started");
    
    // Run 500 random transactions
    repeat(500) begin
      // Create sequence instance
      seq = alu_random_sequence::type_id::create("seq");
      
      // Start sequence on sequencer
      seq.start(env.agent.sequencer);
    end
    
    // Add small delay for final transactions to complete
    #100;
    
    // Drop objection to allow simulation to end
    phase.drop_objection(this, "Random test completed");
    
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    `uvm_info(get_type_name(), "  Random Test Completed", UVM_LOW)
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
  endtask : run_phase
  

  // Report Phase - Test Summary
 
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), "Random Test: All transactions completed", UVM_LOW)
  endfunction : report_phase
  
endclass : alu_random_test