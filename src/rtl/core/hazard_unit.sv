`include "types.svh"

module hazard_unit (
    input logic [4:0]  rs1_id,
    input logic [4:0]  rs2_id,
    input logic [4:0]  rd_ex,
    input resultSrc_e  result_src_ex,
    input pcSrc_e      pc_sel,

    output logic  stall_pc,
    output logic  stall_if_id,
    output logic  flush_if_id,
    output logic  flush_id_ex
);

logic lw_stall;

// Load hazard
assign lw_stall    = (result_src_ex == RESULT_SRC_MEM)
                     && ( (rs1_id == rd_ex) || (rs2_id == rd_ex) );
assign stall_pc    = ~lw_stall; // 0 to stall
assign stall_if_id = ~lw_stall;

// Branch taken or load introduces a bubble
assign flush_if_id = (pc_sel == PC_SRC_ALU_RESULT);
assign flush_id_ex = lw_stall || (pc_sel == PC_SRC_ALU_RESULT);

endmodule
