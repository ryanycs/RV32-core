`include "types.svh"

module decoder(
    input  logic [31:0]  inst,
    output logic [4:0]   rs1,
    output logic [4:0]   rs2,
    output logic [4:0]   rd,

    `ifdef Zicsr_EXT
    output logic  [11:0] csr_addr,
    `endif

    output immType_e     imm_type,
    output opcodeType_e  opcode_type
);

// Register-Immediate
localparam OPCODE_OP_IMM = 7'b0010011;
localparam OPCODE_LUI    = 7'b0110111;
localparam OPCODE_AUIPC  = 7'b0010111;

// Register-Register
localparam OPCODE_OP     = 7'b0110011;

// Control Transfer
localparam OPCODE_JAL    = 7'b1101111;
localparam OPCODE_JALR   = 7'b1100111;
localparam OPCODE_BRANCH = 7'b1100011;

// Load/Store
localparam OPCODE_LOAD   = 7'b0000011;
localparam OPCODE_STORE  = 7'b0100011;

// System
localparam OPCODE_SYSTEM = 7'b1110011;

`ifdef F_EXT
// Floating Point Operations
localparam OPCODE_LOAD_FP  = 7'b0000111;
localparam OPCODE_STORE_FP = 7'b0100111;
localparam OPCODE_OP_FP    = 7'b1010011;
`endif

logic [6:0]  funct7;
logic [2:0]  funct3;
logic [6:0]  opcode;

assign funct7  = inst[31:25];
assign rs2     = inst[24:20];
assign rs1     = inst[19:15];
assign funct3  = inst[14:12];
assign rd      = inst[11:7];
assign opcode  = inst[6:0];

`ifdef Zicsr_EXT
assign csr_addr = inst[31:20];
`endif

// imm_type
always_comb begin
    case (opcode)
        OPCODE_OP_IMM, OPCODE_LOAD, OPCODE_JALR:
            imm_type = I_TYPE;

        OPCODE_STORE:
            imm_type = S_TYPE;

        OPCODE_BRANCH:
            imm_type = B_TYPE;

        OPCODE_AUIPC, OPCODE_LUI:
            imm_type = U_TYPE;

        OPCODE_JAL:
            imm_type = J_TYPE;

        default:
            imm_type = I_TYPE;
    endcase
end

always_comb begin
    unique casez ({ opcode, funct3, funct7 })
        { OPCODE_OP_IMM, 3'b000, 7'b??????? }: opcode_type = ADDI;
        { OPCODE_OP_IMM, 3'b001, 7'b0000000 }: opcode_type = SLLI;
        { OPCODE_OP_IMM, 3'b010, 7'b??????? }: opcode_type = SLTI;
        { OPCODE_OP_IMM, 3'b011, 7'b??????? }: opcode_type = SLTIU;
        { OPCODE_OP_IMM, 3'b100, 7'b??????? }: opcode_type = XORI;
        { OPCODE_OP_IMM, 3'b101, 7'b0000000 }: opcode_type = SRLI;
        { OPCODE_OP_IMM, 3'b101, 7'b0100000 }: opcode_type = SRAI;
        { OPCODE_OP_IMM, 3'b110, 7'b??????? }: opcode_type = ORI;
        { OPCODE_OP_IMM, 3'b111, 7'b??????? }: opcode_type = ANDI;

        { OPCODE_LUI   , 3'b???, 7'b??????? }: opcode_type = LUI;

        { OPCODE_AUIPC , 3'b???, 7'b??????? }: opcode_type = AUIPC;

        { OPCODE_OP    , 3'b000, 7'b0000000 }: opcode_type = ADD;
        { OPCODE_OP    , 3'b000, 7'b0100000 }: opcode_type = SUB;
        { OPCODE_OP    , 3'b001, 7'b0000000 }: opcode_type = SLL;
        { OPCODE_OP    , 3'b010, 7'b0000000 }: opcode_type = SLT;
        { OPCODE_OP    , 3'b011, 7'b0000000 }: opcode_type = SLTU;
        { OPCODE_OP    , 3'b100, 7'b0000000 }: opcode_type = XOR;
        { OPCODE_OP    , 3'b101, 7'b0000000 }: opcode_type = SRL;
        { OPCODE_OP    , 3'b101, 7'b0100000 }: opcode_type = SRA;
        { OPCODE_OP    , 3'b110, 7'b0000000 }: opcode_type = OR;
        { OPCODE_OP    , 3'b111, 7'b0000000 }: opcode_type = AND;

        { OPCODE_JAL   , 3'b???, 7'b??????? }: opcode_type = JAL;

        { OPCODE_JALR  , 3'b???, 7'b??????? }: opcode_type = JALR;

        { OPCODE_BRANCH, 3'b000, 7'b??????? }: opcode_type = BEQ;
        { OPCODE_BRANCH, 3'b001, 7'b??????? }: opcode_type = BNE;
        { OPCODE_BRANCH, 3'b100, 7'b??????? }: opcode_type = BLT;
        { OPCODE_BRANCH, 3'b101, 7'b??????? }: opcode_type = BGE;
        { OPCODE_BRANCH, 3'b110, 7'b??????? }: opcode_type = BLTU;
        { OPCODE_BRANCH, 3'b111, 7'b??????? }: opcode_type = BGEU;

        { OPCODE_LOAD  , 3'b000, 7'b??????? }: opcode_type = LB;
        { OPCODE_LOAD  , 3'b001, 7'b??????? }: opcode_type = LH;
        { OPCODE_LOAD  , 3'b010, 7'b??????? }: opcode_type = LW;
        { OPCODE_LOAD  , 3'b100, 7'b??????? }: opcode_type = LBU;
        { OPCODE_LOAD  , 3'b101, 7'b??????? }: opcode_type = LHU;

        { OPCODE_STORE , 3'b000, 7'b??????? }: opcode_type = SB;
        { OPCODE_STORE , 3'b001, 7'b??????? }: opcode_type = SH;
        { OPCODE_STORE , 3'b010, 7'b??????? }: opcode_type = SW;

        `ifdef M_EXT
        { OPCODE_OP    , 3'b000, 7'b0000001 }: opcode_type = MUL;
        { OPCODE_OP    , 3'b001, 7'b0000001 }: opcode_type = MULH;
        { OPCODE_OP    , 3'b010, 7'b0000001 }: opcode_type = MULHSU;
        { OPCODE_OP    , 3'b011, 7'b0000001 }: opcode_type = MULHU;
        `endif

        `ifdef F_EXT
        { OPCODE_OP_FP   , 3'b???, 7'b00000?? }: opcode_type = FADD;
        { OPCODE_OP_FP   , 3'b???, 7'b00001?? }: opcode_type = FSUB;
        { OPCODE_LOAD_FP , 3'b010, 7'b??????? }: opcode_type = FLW;
        { OPCODE_STORE_FP, 3'b010, 7'b??????? }: opcode_type = FSW;
        `endif

        `ifdef Zicsr_EXT
        { OPCODE_SYSTEM, 3'b010, 7'b??????? }: opcode_type = CSRRS;
        `endif

        default:
            opcode_type = NOP;
    endcase
end

endmodule
