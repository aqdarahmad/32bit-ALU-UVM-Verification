
// alu_driver.sv
// Lab 3 - Driver Component
// 
// Driver: Converts transactions from sequencer into actual signal changes 
// on the interface (acts as a translator from sequencer to interface)


class alu_driver extends uvm_driver#(alu_sequence_item);
  
  // Virtual interface to connect to the DUT 
  virtual alu_interface vif;
  
  // Sequence item handle 
  alu_sequence_item item;
  
  // Register with factory 
  `uvm_component_utils(alu_driver)
  
  // Constructor 
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction
  
  // Build phase - getting virtual interface from config_db
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual alu_interface)::get(this, "", "vif", vif))

      `uvm_fatal(get_type_name(), "Not set at top level")
  endfunction
  
  // Run phase - continuously get and drive transactions
  task run_phase(uvm_phase phase);
    forever begin
      // Get next transaction from sequencer
      seq_item_port.get_next_item(item);
      
      // Drive it to the DUT
      drive(item);
      
      // Log what we drove
      `uvm_info(get_type_name(), 
                $sformatf("Driver: signals driven to DUT are: A=%0d, B=%0d, Opcode=%h", 
                          item.A, item.B, item.Opcode), 
                UVM_HIGH)
      
      // Tell sequencer we're done with this item
      seq_item_port.item_done();
    end
  endtask
  
  // Drive task - apply signals to interface
  task drive(alu_sequence_item req);
    @(vif.cb_drv);
    vif.cb_drv.A <= req.A;
    vif.cb_drv.B <= req.B;
    vif.cb_drv.Opcode <= req.Opcode;
  endtask
  
endclass : alu_driver