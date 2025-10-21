`include "types.svh"

module control_unit(
    input  opcodeType_e  opcode_type,

    output logic         reg_wr_en,
    output logic         mem_wr_en,
    output logic         jump,
    output logic         branch,
    output branchCtrl_e  branch_ctrl,
    output aluCtrl_e     alu_ctrl,
    output aluSrc1_e     alu_src1,
    output aluSrc2_e     alu_src2,
    output lsuCtrl_e     lsu_ctrl,
    output resultSrc_e   result_src

    `ifdef Zicsr_EXT
    ,
    output logic         csr_instret_inc
    `endif
);

always_comb begin
    reg_wr_en   = 1'b0;
    mem_wr_en   = 1'b0;
    jump        = 1'b0;
    branch      = 1'b0;
    branch_ctrl = BRANCH_NOP;
    alu_ctrl    = ALU_NOP;
    alu_src1    = ALU_SRC1_RS1;
    alu_src2    = ALU_SRC2_RS2;
    lsu_ctrl    = LSU_NOP;
    result_src  = RESULT_SRC_ALU;
    `ifdef Zicsr_EXT
    csr_instret_inc = 1'b1;
    `endif

    case (opcode_type)
        ADDI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        SLLI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SLL;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        SLTI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SLT;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        SLTIU: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SLTU;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        XORI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_XOR;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        SRLI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SRL;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        SRAI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SRA;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        ORI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_OR;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        ANDI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_AND;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        LUI: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_LUI;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        AUIPC: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_ALU;
        end

        ADD: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        SUB: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SUB;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        SLL: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SLL;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        SLT: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SLT;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        SLTU: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SLTU;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        XOR: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_XOR;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        SRL: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SRL;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        SRA: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_SRA;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        OR: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_OR;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        AND: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_AND;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_RS2;
            result_src  = RESULT_SRC_ALU;
        end

        JAL: begin
            reg_wr_en   = 1'b1;
            jump        = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_PC_PLUS_4;
        end

        JALR: begin
            reg_wr_en   = 1'b1;
            jump        = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            result_src  = RESULT_SRC_PC_PLUS_4;
        end

        BEQ: begin
            branch      = 1'b1;
            branch_ctrl = BRANCH_EQ;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
        end

        BNE: begin
            branch      = 1'b1;
            branch_ctrl = BRANCH_NE;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
        end

        BLT: begin
            branch      = 1'b1;
            branch_ctrl = BRANCH_LT;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
        end

        BGE: begin
            branch      = 1'b1;
            branch_ctrl = BRANCH_GE;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
        end

        BLTU: begin
            branch      = 1'b1;
            branch_ctrl = BRANCH_LTU;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
        end

        BGEU: begin
            branch      = 1'b1;
            branch_ctrl = BRANCH_GEU;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_PC;
            alu_src2    = ALU_SRC2_IMM;
        end

        LB: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_LB;
            result_src  = RESULT_SRC_MEM;
        end

        LH: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_LH;
            result_src  = RESULT_SRC_MEM;
        end

        LW: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_LW;
            result_src  = RESULT_SRC_MEM;
        end

        LBU: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_LBU;
            result_src  = RESULT_SRC_MEM;
        end

        LHU: begin
            reg_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_LHU;
            result_src  = RESULT_SRC_MEM;
        end

        SB: begin
            mem_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_SB;
        end

        SH: begin
            mem_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_SH;
        end

        SW: begin
            mem_wr_en   = 1'b1;
            alu_ctrl    = ALU_ADD;
            alu_src1    = ALU_SRC1_RS1;
            alu_src2    = ALU_SRC2_IMM;
            lsu_ctrl    = LSU_SW;
        end

        `ifdef M_EXT
        `endif

        `ifdef Zicsr_EXT
        CSRRS: begin
            reg_wr_en   = 1'b1;
            result_src  = RESULT_SRC_CSR;
        end


        default: begin
            csr_instret_inc = 1'b0;
        end
        `endif
    endcase
end

endmodule
