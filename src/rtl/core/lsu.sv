module lsu(
    input  lsuCtrl_e     lsu_ctrl,
    input  logic [31:0]  addr,
    input  logic         wr_en,
    input  logic [31:0]  wr_data,
    input  logic [31:0]  rd_data,

    output logic         mem_wr_en,
    output logic [31:0]  mem_bit_wr_en,
    output logic [31:0]  mem_addr,
    output logic [31:0]  mem_wr_data,

    output logic [31:0]  mem_rd_data
);

assign mem_wr_en   = wr_en;
assign mem_addr    = addr;
assign mem_wr_data = wr_data;

always_comb begin
    mem_rd_data   = rd_data;
    mem_bit_wr_en = 32'h00000000;

    case (lsu_ctrl)
        LSU_LB: begin
            mem_rd_data = { { 24{mem_rd_data[7]}}, mem_rd_data[7:0] };
        end

        LSU_LH: begin
            mem_rd_data = { { 16{mem_rd_data[15]}}, mem_rd_data[15:0] };
        end

        LSU_LW: begin
            mem_rd_data = rd_data;
        end

        LSU_LBU: begin
            mem_rd_data = { 24'h000000, mem_rd_data[7:0] };
        end

        LSU_LHU: begin
            mem_rd_data = { 16'h0000, mem_rd_data[15:0] };
        end

        LSU_SB: begin
            mem_bit_wr_en = 32'h000000FF;
        end

        LSU_SH: begin
            mem_bit_wr_en = 32'h0000FFFF;
        end

        LSU_SW: begin
            mem_bit_wr_en = 32'hFFFFFFFF;
        end
    endcase
end

endmodule
