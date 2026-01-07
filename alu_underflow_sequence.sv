
// alu_underflow_sequence.sv
// Lab 5 - Underflow Sequence
// Tests underflow condition: -2147483648 - 1 (signed 32-bit min - 1)


class alu_underflow_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_underflow_sequence)
  
  function new(string name = "alu_underflow_sequence");
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
    
    // Send underflow transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b001;      // SUB operation
      A == -2147483648;      // Min negative signed 32-bit
      B == 1;                // Subtracting 1 causes underflow
    });
    `uvm_info(get_type_name(), 
              $sformatf("UNDERFLOW TEST: %0d - %0d", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_underflow_sequence