


// alu_agent.sv
// UVM Agent for ALU DUT
// Contains Driver, Sequencer, and Monitor components
class alu_agent extends uvm_agent;
  

  // Component Declarations
 
  alu_driver    driver;
  alu_sequencer sequencer;
  alu_monitor   monitor;
  

  // Factory Registration

  `uvm_component_utils(alu_agent)
  

  // Constructor

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
 
  // Build Phase - Create Components
 
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Check if agent is in ACTIVE mode
    if(get_is_active() == UVM_ACTIVE) begin
      // Create sequencer and driver (only in active mode)
      sequencer = alu_sequencer::type_id::create("alu_sequencer", this);
      driver    = alu_driver::type_id::create("alu_driver", this);
    end
    
    // Always create monitor (both active and passive modes)
    monitor = alu_monitor::type_id::create("alu_monitor", this);
  endfunction : build_phase
  

  // Connect Phase - Wire Components Together
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
  // 
  // Connect driver to sequencer if in ACTIVE mode
    if(get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction : connect_phase
  
endclass : alu_agent