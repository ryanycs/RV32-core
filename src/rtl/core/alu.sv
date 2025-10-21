`include "types.svh"

module alu(
    input  logic [31:0]  a,
    input  logic [31:0]  b,
    input  aluCtrl_e     alu_ctrl,
    output logic [31:0]  alu_result
);

always_comb begin
    case (alu_ctrl)
        ALU_ADD:
            alu_result = a + b;

        ALU_SUB:
            alu_result = a - b;

        ALU_AND:
            alu_result = a & b;

        ALU_OR:
            alu_result = a | b;

        ALU_XOR:
            alu_result = a ^ b;

        ALU_SLL:
            alu_result = a << b[4:0];

        ALU_SRL:
            alu_result = a >> b[4:0];

        ALU_SRA:
            alu_result = a >>> b[4:0];

        ALU_SLT:
            alu_result = $signed(b) < $signed(b) ? 32'd1 : 32'd0;

        ALU_SLTU:
            alu_result = a < b ? 32'd1 : 32'd0;

        ALU_LUI:
            alu_result = b;

        default:
            alu_result = 32'd0;
    endcase
end

endmodule
