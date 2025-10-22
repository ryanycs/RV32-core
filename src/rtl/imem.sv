`include "define.svh"

module imem(
    input  logic [31:0] addr,    // Address
    output logic [31:0] rd_data  // Data output
);

logic [31:0] mem [511:0][31:0];

logic [8:0] row_addr;
logic [4:0] col_addr;

assign row_addr = (addr >> 2) / 32;
assign col_addr = (addr >> 2) % 32;

always_comb begin
    rd_data = mem[row_addr][col_addr];
end

endmodule
