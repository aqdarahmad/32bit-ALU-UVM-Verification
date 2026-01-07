
// alu_or_sequence.sv

// Tests OR operation (Opcode = 3'b011)

//
//   
class alu_or_sequence extends uvm_sequence #(alu_sequence_item);
  
  `uvm_object_utils(alu_or_sequence)
  // Constructor
  function new(string name = "alu_or_sequence");
    super.new(name);
  endfunction
  // Main sequence body
  // This sequence resets the DUT and sends an OR operation
  task body();
    alu_sequence_item req;
    
    // Reset the DUT
    req = alu_sequence_item::type_id::create("req");
    req.rst = 1;
    start_item(req);
    `uvm_info(get_type_name(), "Resetting the DUT", UVM_MEDIUM)
    finish_item(req);
    #10;
    
    // Send OR transaction
    req = alu_sequence_item::type_id::create("req");
    start_item(req);
    assert(req.randomize() with { 
      rst == 0;
      Opcode == 3'b011;  // OR operation
    });
    `uvm_info(get_type_name(), 
              $sformatf("OR: %h | %h", req.A, req.B), 
              UVM_MEDIUM)
    finish_item(req);
    #10;
  endtask
  
endclass : alu_or_sequence