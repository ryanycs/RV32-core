module fp_reg_file (
    input  logic         clk,
    input  logic         rst,

    input  logic         reg_wr_en,
    input  logic [4:0]   rd_addr,
    input  logic [63:0]  rd_data,

    input  logic [4:0]   rs1_addr,
    input  logic [4:0]   rs2_addr,

    output logic [63:0]  rs1_data,
    output logic [63:0]  rs2_data
);

endmodule
