
// alu_undefined_opcode_sequence.sv
// Lab 5 - Undefined Opcode Sequence
// Tests undefined opcodes (3'b101, 3'b110, 3'b111)


class alu_undefined_opcode_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_undefined_opcode_sequence)
  
  function new(string name = "alu_undefined_opcode_sequence");
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
    
    // Send undefined opcode transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode inside {3'b101, 3'b110, 3'b111};  // Undefined opcodes
    });
    `uvm_info(get_type_name(), 
              $sformatf("UNDEFINED OPCODE: %b", req.Opcode), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_undefined_opcode_sequence