`include "define.svh"
`include "types.svh"

module program_counter (
    input  logic  clk,
    input  logic  rst,
    input  logic  en,

    input  logic [31:0]  pc_in,
    output logic [31:0]  pc_out
);

logic [31:0] pc_reg;

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        pc_reg <= PC_START_ADDR;
    end else if (en) begin
        pc_reg <= pc_in;
    end
end

assign pc_out = pc_reg;

endmodule
