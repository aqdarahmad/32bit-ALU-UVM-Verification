// alu_and_sequence.sv
// Tests AND operation (Opcode = 3'b010)

class alu_and_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_and_sequence)
  
  function new(string name = "alu_and_sequence");
    super.new(name);
  endfunction

  // Main sequence body
  task body();
    alu_sequence_item req;

    // Create AND transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst    == 0;
      Opcode == 3'b010; 
    }) else
      `uvm_fatal(get_type_name(), "Randomization failed");

    `uvm_info(
      get_type_name(), 
      $sformatf("AND operation: A=%0h, B=%0h", req.A, req.B), 
      UVM_MEDIUM
    )
    finish_item(req);
  endtask
  
endclass : alu_and_sequence
