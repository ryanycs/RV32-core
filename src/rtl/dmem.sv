module dmem(
    input  logic        clk,
    input  logic        wr_en,     // 0: read, 1: write
    input  logic [31:0] bit_wr_en, // Set 1'b1 for which bits to write
    input  logic [31:0] addr,      // Address
    input  logic [31:0] wr_data,   // Data input
    output logic [31:0] rd_data    // Data output
);

logic [31:0] mem [0:DMEM_SIZE/4-1];

always_comb begin
    rd_data = mem[addr >> 2];
end

always_ff @(posedge clk) begin
    if (wr_en) begin
        mem[addr >> 2] <= wr_data & bit_wr_en
                          | mem[addr >> 2] & ~bit_wr_en;
    end
end

endmodule
