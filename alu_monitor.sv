//Lab3 
//Monitor : watch DUT signals and captures what is happening , and sends these observations to scoreboared for checking ,it never drives signals only reads

class alu_monitor extends uvm_monitor;
  
  // Virtual interface to observe DUT
  virtual alu_interface vif;
  
  // Analysis port to send observations to scoreboard
  uvm_analysis_port#(alu_sequence_item) port;
  
  // Sequence item to store sampled data
  alu_sequence_item item;
  
  // Register with factory
  `uvm_component_utils(alu_monitor)
  
  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase - create analysis port and get virtual interface
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    port = new("monitor_port", this);
    if(!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level")
  endfunction
  
  // Run phase - continuously monitor signals
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    `uvm_info("MONITOR_CLASS", "Inside Run Phase!", UVM_HIGH)
    
    forever begin
      // Create new item for this observation
      item = alu_sequence_item::type_id::create("item");
      
      // Wait for reset to be deasserted
      wait(!vif.rst);
      
      // Sample inputs at posedge clk
      @(posedge vif.clk);
      item.A = vif.A;
      item.B = vif.B;
      item.Opcode = vif.Opcode;
      
      // Sample outputs at next posedge clk
      @(posedge vif.clk);
      item.Result = vif.Result;
      item.Error = vif.Error;
      
      // Send observed transaction to scoreboard via analysis port
      port.write(item);
    end
  endtask
  
endclass