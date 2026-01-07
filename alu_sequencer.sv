//==============================================================================
// alu_sequencer.sv
// Sequencer - Traffic controller that receives sequence items from sequences,
// delivers them one by one to the driver, and manages the flow and ordering
// of transactions.
//==============================================================================

class alu_sequencer extends uvm_sequencer #(alu_sequence_item); 
  
  // UVM factory registration 
  `uvm_component_utils(alu_sequencer)
  
  // Constructor 
  function new(string name = "alu_sequencer", uvm_component parent = null);
    super.new(name, parent); 
  endfunction : new 
  
endclass : alu_sequencer