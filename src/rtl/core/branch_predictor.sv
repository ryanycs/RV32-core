module branch_predictor(
    input  logic clk,
    input  logic rst,

    input  logic [31:0] pc_if,
    input  logic        branch_taken_ex,
    input  logic [31:0] branch_pc_ex,
    input  logic [31:0] branch_target_ex,
    output logic        predict_taken,
    output logic [31:0] predict_target
);

endmodule
