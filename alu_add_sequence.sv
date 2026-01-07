
// alu_add_sequence.sv
// Lab 5 - Addition Sequence
// Tests ADD operation (Opcode = 3'b000)


class alu_add_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_add_sequence)
  
  function new(string name = "alu_add_sequence");
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
    
    // Send ADD transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b000;  // ADD operation
    });
    `uvm_info(get_type_name(), 
              $sformatf("ADD: %0d + %0d", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_add_sequence