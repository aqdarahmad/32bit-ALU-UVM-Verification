//interface is a bridge between the testbecnh and the DUT , instead of connecting individual wires one by one , we group all related signals together in an interface 

//Clocking blocks in interface : 1)driver clocking block : it drives the signals on negedge clk so the data is ready before the DUT smaples it on the posedge 		2)monitor cb : samples the signals on the posedge : to observer what the DUT outputs after processing 


//Modports: it defines who can access which signals : 1)driver modport: can only write to A , B , opcode 	2)monitor modport : can only read all signals .

interface alu_interface(input logic clk , rst) ;
  
  //inputs and outputs 
  logic signed [31:0] A; 
  logic signed [31:0] B;
  logic [2:0] Opcode;
  logic [31:0] Result;
  logic Error ; 
  
  //Driver CB 
  clocking cb_drv @(negedge clk);
    default input #1 output #0;
    output A;
    output B;
    output Opcode;
  endclocking
  
  //Monitor CB
  clocking cb_mon @(posedge clk);
    default input #0 output #1;
    input A; 
    input B;
    input Opcode; 
    input Result;
    input Error;
  endclocking
  
  //Modport for driver 
  modport drv (clocking cb_drv , input clk);
    
  //Modport for monitor 
    modport mon (clocking cb_mon , input clk);
      
      endinterface
    