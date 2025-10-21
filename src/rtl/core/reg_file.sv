`include "define.svh"
`include "types.svh"

module reg_file (
    input  logic  clk,
    input  logic  rst,

    input  logic [4:0]   rs1,
    input  logic [4:0]   rs2,
    output logic [31:0]  rs1_data,
    output logic [31:0]  rs2_data,

    input  logic         wr_en,
    input  logic [4:0]   wr_addr,
    input  logic [31:0]  wr_data
);

logic [31:0] reg_file [31:1];

// rs1_data
always_comb begin
    if (rs1 == 5'd0) begin
        rs1_data = 32'd0;
    end else begin
        rs1_data = (rs1 == wr_addr && wr_en) ? wr_data : reg_file[rs1];
    end
end

// rs2_data
always_comb begin
    if (rs2 == 5'd0) begin
        rs2_data = 32'd0;
    end else begin
        rs2_data = (rs2 == wr_addr && wr_en) ? wr_data : reg_file[rs2];
    end
end

// Write to register file
always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        for (int i = 1; i < 32; i = i + 1) begin
            reg_file[i] <= 32'd0;
        end
        reg_file[2] <= SP_START_ADDR;
    end else if (wr_en) begin
        reg_file[wr_addr] <= wr_data;
    end
end

endmodule
