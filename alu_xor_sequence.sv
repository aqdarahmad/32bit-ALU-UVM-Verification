
// alu_xor_sequence.sv
// Lab 5 - XOR Sequence
// Tests XOR operation (Opcode = 3'b100)


class alu_xor_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_xor_sequence)
  
  function new(string name = "alu_xor_sequence");
    super.new(name);
  endfunction
  
  task body();
    alu_sequence_item req;
    
    // Reset the DUT
    req = alu_sequence_item::type_id::create("req");
    req.rst = 1;
    start_item(req);
    `uvm_info(get_type_name(), "Resetting the DUT", UVM_MEDIUM)
    finish_item(req);
    #10;
    
    // Send XOR transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b100;  // XOR operation
    });
    `uvm_info(get_type_name(), 
              $sformatf("XOR: %h ^ %h", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_xor_sequence