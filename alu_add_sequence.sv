
// alu_add_sequence.sv
// Sequence to test ALU ADD operation
// Tests ADD operation (Opcode = 3'b000)

// Import UVM package
class alu_add_sequence extends uvm_sequence #(alu_sequence_item);
      // Register the sequence with UVM factory
  `uvm_object_utils(alu_add_sequence)
  
  function new(string name = "alu_add_sequence");
    super.new(name);
  endfunction
  
  // Main sequence body
  // This sequence resets the DUT and sends an ADD operation
  task body();
    alu_sequence_item req;
    
    // Reset the DUT
    req = alu_sequence_item::type_id::create("req");
    req.rst = 1;
    start_item(req);
    `uvm_info(get_type_name(), "Resetting the DUT", UVM_MEDIUM)
    finish_item(req);
    #10;
    
    // Send ADD transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b000;  
    });
    // Log the ADD operation
    `uvm_info(get_type_name(), 
              $sformatf("ADD: %0d + %0d", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_add_sequence