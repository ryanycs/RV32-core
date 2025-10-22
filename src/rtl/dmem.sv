module dmem(
    input  logic        clk,
    input  logic        wr_en,     // 0: read, 1: write
    input  logic [31:0] bit_wr_en, // Set 1'b1 for which bits to write
    input  logic [31:0] addr,      // Address
    input  logic [31:0] wr_data,   // Data input
    output logic [31:0] rd_data    // Data output
);

logic [31:0] mem [511:0][31:0];

logic [8:0] row_addr;
logic [4:0] col_addr;

assign row_addr = (addr >> 2) / 32;
assign col_addr = (addr >> 2) % 32;

always_comb begin
    rd_data = mem[row_addr][col_addr];
end

always @(posedge clk) begin
    if (wr_en) begin
        mem[row_addr][col_addr] <= wr_data & bit_wr_en
                                   | mem[row_addr][col_addr] & ~bit_wr_en;
    end
end

endmodule
