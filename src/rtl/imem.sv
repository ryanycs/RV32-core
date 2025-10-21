`include "define.svh"

module imem(
    input  logic [31:0] addr,    // Address
    output logic [31:0] rd_data  // Data output
);

logic [31:0] mem [0:IMEM_SIZE/4-1];

always_comb begin
    rd_data = mem[addr >> 2];
end

endmodule
