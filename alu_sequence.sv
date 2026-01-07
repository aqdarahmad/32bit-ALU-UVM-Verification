`ifndef ALU_SEQUENCE_SV
`define ALU_SEQUENCE_SV

`include "uvm_macros.svh"
import uvm_pkg::*;
class alu_sequence extends uvm_sequence #(alu_sequence_item);

  `uvm_object_utils(alu_sequence)

  function new(string name="alu_sequence");
    super.new(name);
  endfunction

  virtual task body();
    // Create new transaction
    alu_sequence_item req = alu_sequence_item::type_id::create("req");

    // Apply reset
    req.rst = 1;
    start_item(req);
    `uvm_info(get_type_name(), "Reset the DUT", UVM_NONE)
    finish_item(req);
    #10;

    // Randomize transaction
    void'(req.randomize() with { rst == 0; });
    start_item(req);
    finish_item(req);
    #10;
  endtask

endclass
`endif
