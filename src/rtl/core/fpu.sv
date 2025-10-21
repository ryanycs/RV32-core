`include "types.svh"

module fpu(
    input  logic  clk,
    input  logic  rst,

    input  logic [31:0]  a,
    input  logic [31:0]  b,
    input  logic [2:0]   fpu_ctrl,
    output logic [31:0]  fpu_result
);

endmodule
