//==============================================================================
// testbench.sv
// Complete UVM ALU Testbench - ALL LABS (1-9)
// 
// FINAL VERSION: Full end-to-end verification with DUT
//==============================================================================
`include "uvm_macros.svh"
import uvm_pkg::*;

//==============================================================================
// Lab 1: Transaction and Sequencer
//==============================================================================
`include "alu_sequence_item.sv"
`include "alu_sequencer.sv"

//==============================================================================
// Lab 2: Interface
//==============================================================================
`include "alu_interface.sv"

//==============================================================================
// Lab 3: Driver and Monitor
//==============================================================================
`include "alu_driver.sv"
`include "alu_monitor.sv"

//==============================================================================
// Lab 4: Agent
//==============================================================================
`include "alu_agent.sv"

//==============================================================================
// Lab 5: Sequences
//==============================================================================
`include "alu_random_sequence.sv"
`include "alu_add_sequence.sv"
`include "alu_sub_sequence.sv"
`include "alu_and_sequence.sv"
`include "alu_or_sequence.sv"
`include "alu_xor_sequence.sv"
`include "alu_undefined_opcode_sequence.sv"
`include "alu_overflow_sequence.sv"
`include "alu_underflow_sequence.sv"

//==============================================================================
// Lab 6: Scoreboard
//==============================================================================
`include "alu_scoreboard.sv"

//==============================================================================
// Lab 6.5: Subscriber (Coverage Collector)
//==============================================================================
`include "alu_subscriber.sv"

//==============================================================================
// Lab 7: Environment
//==============================================================================
`include "alu_environment.sv"

//==============================================================================
// Lab 8: Tests
//==============================================================================
`include "alu_random_test.sv"
`include "alu_regression_test.sv"

//==============================================================================
// Top Module
//==============================================================================
module top;
  
  //----------------------------------------------------------------------------
  // Clock and Reset Signals
  //----------------------------------------------------------------------------
  logic clk;
  logic rst;
  
  //----------------------------------------------------------------------------
  // Clock Generation (100MHz - 10ns period)
  //----------------------------------------------------------------------------
  initial begin
    clk = 0;
    forever #5 clk = ~clk;  // Toggle every 5ns
  end
  
  //----------------------------------------------------------------------------
  // Reset Generation
  //----------------------------------------------------------------------------
  initial begin
    rst = 1;           // Assert reset
    #20;               // Hold for 20ns (2 clock cycles)
    rst = 0;           // Deassert reset
  end
  
  //----------------------------------------------------------------------------
  // Interface Instantiation
  //----------------------------------------------------------------------------
  alu_interface alu_if(clk, rst);
  
  //----------------------------------------------------------------------------
  // DUT Instantiation (Lab 9 - NEW!)
  //----------------------------------------------------------------------------
  alu dut (
    .clk(clk),
    .rst(rst),
    .A(alu_if.A),
    .B(alu_if.B),
    .Opcode(alu_if.Opcode),
    .Result(alu_if.Result),
    .Error(alu_if.Error)
  );
  
  //----------------------------------------------------------------------------
  // UVM Test Execution
  //----------------------------------------------------------------------------
  initial begin
    // Store virtual interface in config_db
    uvm_config_db#(virtual alu_interface)::set(null, "*", "vif", alu_if);
    
    // Display startup banner
    display_startup_banner();
    
    // Run the UVM test
    // To select test, use: +UVM_TESTNAME=alu_random_test or alu_regression_test
    // Default: alu_regression_test
    run_test("alu_regression_test");
  end
  
  //----------------------------------------------------------------------------
  // Waveform Dump (VCD format for EDA Playground)
  //----------------------------------------------------------------------------
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, top);
  end
  
  //----------------------------------------------------------------------------
  // Helper Function - Startup Banner
  //----------------------------------------------------------------------------
  function void display_startup_banner();
    $display("\n");
    $display("===================================================================");
    $display("+       UVM ALU Verification Environment v1.0 - COMPLETE       +");
    $display("===================================================================");
    $display("+  ALL LABS COMPLETE (1-9)                                     +");
    $display("+                                                               +");
    $display("+  TRUE Sequence Item & Sequencer         (Lab 1)                +");
    $display("+  TRUE Interface with Clocking Blocks    (Lab 2)                +");
    $display("+  TRUE Driver & Monitor                  (Lab 3)                +");
    $display("+  TRUE Agent                             (Lab 4)                +");
    $display("+  TRUE Sequences (9 types)               (Lab 5)                +");
    $display("+  TRUE Scoreboard with Reference Model   (Lab 6)                +");
    $display("+  TRUE Subscriber for Coverage           (Lab 6.5)              +");
    $display("+  TRUE Environment                       (Lab 7)                +");
    $display("+  TRUE Test Classes                      (Lab 8)                +");
    $display("+  TRUE DUT (ALU Design)                  (Lab 9)                +");
    $display("============================================================");
    $display("+  DUT: 32-bit ALU                                             +");
    $display("+  Operations: ADD, SUB, AND, OR, XOR                          +");
    $display("+  Features: Overflow/Underflow Detection                      +");
    $display("+  Clock: 100MHz (10ns period)                                 +");
    $display("+  Reset: Active high, 20ns duration                           +");
    $display("============================================================");
    $display("+  Available Tests:                                            +");
    $display("+  1. alu_random_test      - 500 random transactions           +");
    $display("+  2. alu_regression_test  - Comprehensive (all sequences)     +");
    $display("============================================================");
    $display("+  To select test: +UVM_TESTNAME=<test_name>                   +");
    $display("============================================================");
    $display("\n");
  endfunction
  
endmodule