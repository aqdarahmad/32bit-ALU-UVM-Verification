
// alu_overflow_sequence.sv
// Lab 5 - Overflow Sequence
// Tests overflow condition: 2147483647 + 1 (signed 32-bit max + 1)


class alu_overflow_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_overflow_sequence)
  
  function new(string name = "alu_overflow_sequence");
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
    
    // Send overflow transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b000;      // ADD operation
      A == 2147483647;       // Max positive signed 32-bit
      B == 1;                // Adding 1 causes overflow
    });
    `uvm_info(get_type_name(), 
              $sformatf("OVERFLOW TEST: %0d + %0d", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_overflow_sequence