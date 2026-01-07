
// alu_random_sequence.sv
// Lab 5 - Random Sequence
// Fully randomized stimulus for comprehensive testing


class alu_random_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_random_sequence)
  
  function new(string name = "alu_random_sequence");
    super.new(name);
  endfunction
  
  task body();
    alu_sequence_item req;
    
    // Reset the DUT first
    req = alu_sequence_item::type_id::create("req");
    req.rst = 1;
    start_item(req);
    `uvm_info(get_type_name(), "Resetting the DUT", UVM_MEDIUM)
    finish_item(req);
    #10;
    
    // Send random transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { rst == 0; });
    `uvm_info(get_type_name(), 
              $sformatf("Random: A=%0d, B=%0d, Opcode=%b", req.A, req.B, req.Opcode), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_random_sequence