`include "types.svh"

module csr(
    input  logic         clk,
    input  logic         rst,
    input  logic         csr_instret_inc,
    input  logic [11:0]  csr_addr,
    output logic [31:0]  csr_rd_data
);

// CSR Registers
logic [63:0] instret;
logic [63:0] cycle;

// cycle
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        cycle   <= 32'd0;
    end else begin
        cycle <= cycle + 32'd1;
    end
end

// instret
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        instret <= 32'd0;
    end else begin
        if (csr_instret_inc) begin
            instret <= instret + 32'd1;
        end
    end
end

always_comb begin
    case (csr_addr)
        CSR_CYCLE:
            csr_rd_data = cycle[31:0];

        CSR_CYCLEH:
            csr_rd_data = cycle[63:32];

        CSR_INSTRET:
            csr_rd_data = instret[31:0];

        CSR_INSTRETH:
            csr_rd_data = instret[63:32];

        default:
            csr_rd_data = 32'd0;
    endcase
end

endmodule
