module if_id(
    input  logic  clk,
    input  logic  rst,
    input  logic  clear,
    input  logic  en,

    input  logic [31:0]  pc_in,
    input  logic [31:0]  pc_plus_4_in,
    input  logic [31:0]  inst_in,

    output logic [31:0]  pc_out,
    output logic [31:0]  pc_plus_4_out,
    output logic [31:0]  inst_out
);

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        pc_out        <= 32'd0;
        pc_plus_4_out <= 32'd0;
        inst_out      <= 32'd0;
    end else if (clear) begin
        pc_out        <= 32'd0;
        pc_plus_4_out <= 32'd0;
        inst_out      <= 32'd0;
    end else if (en) begin
        pc_out        <= pc_in;
        pc_plus_4_out <= pc_plus_4_in;
        inst_out      <= inst_in;
    end
end

endmodule
