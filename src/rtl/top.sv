`include "core/core.sv"
`include "imem.sv"
`include "dmem.sv"

module top(
    input logic clk,
    input logic rst
);

logic [31:0] imem_addr;
logic [31:0] imem_rd_data;
logic [31:0] dmem_addr;
logic [31:0] dmem_wr_data;
logic        dmem_wr_en;
logic [31:0] dmem_bit_wr_en;
logic [31:0] dmem_rd_data;

core u_core(
    .clk            (clk),
    .rst            (rst),
    .imem_rd_data   (imem_rd_data),
    .dmem_rd_data   (dmem_rd_data),
    .imem_addr      (imem_addr),
    .dmem_wr_en     (dmem_wr_en),
    .dmem_bit_wr_en (dmem_bit_wr_en),
    .dmem_addr      (dmem_addr),
    .dmem_wr_data   (dmem_wr_data)
);

imem u_imem(
    .addr    (imem_addr),
    .rd_data (imem_rd_data)
);

dmem u_dmem(
    .clk       (clk),
    .wr_en     (dmem_wr_en),
    .bit_wr_en (dmem_bit_wr_en),
    .addr      (dmem_addr),
    .wr_data   (dmem_wr_data),
    .rd_data   (dmem_rd_data)
);

endmodule
