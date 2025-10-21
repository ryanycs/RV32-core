`include "types.svh"

module imm_gen(
    input  logic [31:0]  inst,
    input  immType_e     imm_type,
    output logic [31:0]  imm
);

always_comb begin
    case (imm_type)
        I_TYPE:
            imm = { { 21{inst[31]}}, inst[30:20] };

        S_TYPE:
            imm = { { 21{inst[31]}}, inst[30:25], inst[11:7] };

        B_TYPE:
            imm = { { 20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0 };

        U_TYPE:
            imm = { inst[31:12], 12'b0 };

        J_TYPE:
            imm = { { 12{inst[31]}}, inst[19:12], inst[20], inst[30:25], inst[24:21], 1'b0 };

        default:
            imm = 32'b0;
    endcase
end

endmodule
