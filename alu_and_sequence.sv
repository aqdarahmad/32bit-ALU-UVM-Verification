
// alu_and_sequence.sv
// Lab 5 - AND Sequence
// Tests AND operation (Opcode = 3'b010)


class alu_and_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_and_sequence)
  
  function new(string name = "alu_and_sequence");
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
    
    // Send AND transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b010;  // AND operation
    });
    `uvm_info(get_type_name(), 
              $sformatf("AND: %h & %h", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_and_sequence