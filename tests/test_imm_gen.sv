`timescale 1ns/1ps
`include "imm_gen.sv"
`include "decoder.sv"
// `include "core.sv"

module tb;

logic        [31:0] inst;
logic        [4:0]  rs1;
logic        [4:0]  rs2;
logic        [4:0]  rd;

immType_e           imm_type;
opcodeType_e        opcode_type;

logic signed [31:0] imm;

decoder decoder(
    .inst,
    .rs1,
    .rs2,
    .rd,
    .imm_type,
    .opcode_type
);

imm_gen immGen(
    .inst,
    .imm_type,
    .imm
);

initial begin
    // Test I_TYPE
    inst = 32'hfff48413; // addi x8, x9, -1
    #10;
    $display("%8s rd: %2d rs1: %2d rs2: %2d imm: %0d", opcode_type.name(), rd, rs1, rs2, imm_out);

    // Test S_TYPE
    inst = 32'h4c84a923; // sw x8, 1234(x9)
    #10;
    $display("%8s rd: %2d rs1: %2d rs2: %2d imm: %0d", opcode_type.name(), rd, rs1, rs2, imm_out);

    // Test B_TYPE
    inst = 32'h06940d63; // beq x8, x9, 122
    #10;
    $display("%8s rd: %2d rs1: %2d rs2: %2d imm: %0d", opcode_type.name(), rd, rs1, rs2, imm_out);

    // Test U_TYPE
    inst = 32'h10000437; // lui x8, 65536
    #10;
    $display("%8s rd: %2d rs1: %2d rs2: %2d imm: 0x%08x", opcode_type.name(), rd, rs1, rs2, imm_out);

    // Test J_TYPE
    inst = 32'h000100ef; // jal x1, 65536
    #10;
    $display("%8s rd: %2d rs1: %2d rs2: %2d imm: %0d", opcode_type.name(), rd, rs1, rs2, imm_out);

    $finish;
end

initial begin
    $dumpfile("output/test_imm_gen.vcd");
    $dumpvars(0, tb);
end

endmodule
