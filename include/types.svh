`ifndef TYPES_SVH
`define TYPES_SVH

typedef enum logic [2:0] {
    I_TYPE,
    S_TYPE,
    B_TYPE,
    U_TYPE,
    J_TYPE
} immType_e;


typedef enum logic [5:0] {
    // R-Type (10 ops)
    ADD, SUB,
    AND, OR, XOR,
    SLL, SRL, SRA,
    SLT, SLTU,

    // I-Type (15 ops)
    ADDI,
    ANDI, ORI, XORI,
    SLLI, SRLI, SRAI, SLTI, SLTIU,
    JALR,
    LW, LH, LHU, LB, LBU,

    // S-Type (3 ops)
    SW, SB, SH,

    // U-Type (2 ops)
    AUIPC, LUI,

    // J-Type (1 op)
    JAL,

    // B-Type (6 ops)
    BEQ, BNE, BLT, BGE, BLTU, BGEU,

`ifdef M_EXT
    MUL, MULH, MULHSU, MULHU,
`endif

`ifdef F_EXT
    FLW, FSW,
    FADD, FSUB,
`endif

`ifdef Zicsr_EXT
    CSRRS,
`endif

    NOP // Note: This is not a real opcode, just a placeholder
} opcodeType_e;


typedef enum logic [4:0] {
    ALU_NOP,
    ALU_ADD,
    ALU_SUB,
    ALU_AND,
    ALU_OR,
    ALU_XOR,
    ALU_SLL,
    ALU_SRL,
    ALU_SRA,
    ALU_SLT,
    ALU_SLTU,
    ALU_LUI
} aluCtrl_e;


typedef enum logic {
    ALU_SRC1_PC,
    ALU_SRC1_RS1
} aluSrc1_e;


typedef enum logic {
    ALU_SRC2_RS2,
    ALU_SRC2_IMM
} aluSrc2_e;


typedef enum logic [2:0] {
    BRANCH_NOP,
    BRANCH_EQ,
    BRANCH_NE,
    BRANCH_LT,
    BRANCH_GE,
    BRANCH_LTU,
    BRANCH_GEU
} branchCtrl_e;


typedef enum logic [1:0] {
    FORWARD_NONE,
    FORWARD_FROM_WB,
    FORWARD_FROM_MEM
} forwardCtrl_e;


typedef enum logic [3:0] {
    LSU_NOP,
    LSU_LB,
    LSU_LH,
    LSU_LW,
    LSU_LBU,
    LSU_LHU,
    LSU_SB,
    LSU_SH,
    LSU_SW
} lsuCtrl_e;


typedef enum logic {
    PC_SRC_PC_PLUS_4,
    PC_SRC_ALU_RESULT
} pcSrc_e;


typedef enum logic [1:0] {
    RESULT_SRC_ALU,
    RESULT_SRC_MEM,
    RESULT_SRC_PC_PLUS_4

    `ifdef Zicsr_EXT
    ,
    RESULT_SRC_CSR
    `endif
} resultSrc_e;


`ifdef Zicsr_EXT
typedef enum logic [11:0] {
    CSR_CYCLE    = 12'hC00,
    CSR_CYCLEH   = 12'hC80,
    CSR_INSTRET  = 12'hC02,
    CSR_INSTRETH = 12'hC82
} csrAddr_e;
`endif

`endif
