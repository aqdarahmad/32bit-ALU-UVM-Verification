

// alu_environment.sv
// UVM Environment for ALU DUT
// Contains Agent, Scoreboard, and Subscriber components
class alu_environment extends uvm_env;
  

  // Component Declarations

  alu_agent      agent;
  alu_scoreboard scoreboard;
  alu_subscriber subscriber;  
  

  // Factory Registration

  `uvm_component_utils(alu_environment)
  
 
  // Constructor
 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  
  
  // Build Phase - Create Components
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    `uvm_info(get_type_name(), "Building Environment Components", UVM_HIGH)
    
    // Create agent (contains driver, monitor, sequencer)
    agent = alu_agent::type_id::create("agent", this);
    
    // Create scoreboard (reference model + checker)
    scoreboard = alu_scoreboard::type_id::create("scoreboard", this);
    
    // Create subscriber (coverage collector)
    subscriber = alu_subscriber::type_id::create("subscriber", this);
    
    `uvm_info(get_type_name(), "Environment Build Complete", UVM_HIGH)
  endfunction : build_phase
  

  // Connect Phase - Wire Components Together
  
  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    `uvm_info(get_type_name(), "Connecting Environment Components", UVM_HIGH)
    
    // Connect monitor to scoreboard (for checking)
    agent.monitor.port.connect(scoreboard.exp);
    
    // Connect monitor to subscriber (for coverage)
    agent.monitor.port.connect(subscriber.analysis_export);
    
    `uvm_info(get_type_name(), "Environment Connections Complete", UVM_HIGH)
  endfunction : connect_phase
  
  
  // Report Phase - Display Environment Summary
 
  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    `uvm_info(get_type_name(), "    ENVIRONMENT CONFIGURATION", UVM_LOW)
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
    `uvm_info(get_type_name(), "Agent Type: ALU Agent (Active Mode)", UVM_LOW)
    `uvm_info(get_type_name(), "Scoreboard: Enabled with Reference Model", UVM_LOW)
    `uvm_info(get_type_name(), "Subscriber: Enabled for Coverage Collection", UVM_LOW)
    `uvm_info(get_type_name(), "Monitor -> Scoreboard: Connected", UVM_LOW)
    `uvm_info(get_type_name(), "Monitor -> Subscriber: Connected", UVM_LOW)
    `uvm_info(get_type_name(), "========================================", UVM_LOW)
  endfunction : report_phase
  
endclass : alu_environment