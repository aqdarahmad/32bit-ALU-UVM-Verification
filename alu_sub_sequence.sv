
// alu_sub_sequence.sv
// Lab 5 - Subtraction Sequence
// Tests SUB operation (Opcode = 3'b001)


class alu_sub_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_sub_sequence)
  
  function new(string name = "alu_sub_sequence");
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
    
    // Send SUB transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b001;  // SUB operation
    });
    `uvm_info(get_type_name(), 
              $sformatf("SUB: %0d - %0d", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_sub_sequence