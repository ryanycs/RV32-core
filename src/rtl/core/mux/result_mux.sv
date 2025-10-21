`include "types.svh"

module result_mux(
    input  logic [31:0]  pc_plus_4,
    input  logic [31:0]  alu_result,
    input  logic [31:0]  mem_rd_data,
    `ifdef Zicsr_EXT
    input  logic [31:0]  csr_rd_data,
    `endif

    input  resultSrc_e   result_sel,

    output logic [31:0]  result_out
);

always_comb begin
    case (result_sel)
        RESULT_SRC_PC_PLUS_4:
            result_out = pc_plus_4;

        RESULT_SRC_ALU:
            result_out = alu_result;

        RESULT_SRC_MEM:
            result_out = mem_rd_data;

        `ifdef Zicsr_EXT
        RESULT_SRC_CSR:
            result_out = csr_rd_data;
        `endif

        default:
            result_out = 32'd0;
    endcase
end

endmodule
