`include "types.svh"

module forwarding_unit (
    input  logic [4:0]  rs1_ex,
    input  logic [4:0]  rs2_ex,
    input  logic [4:0]  rd_mem,
    input  logic [4:0]  rd_wb,
    input  logic        reg_wr_en_mem,
    input  logic        reg_wr_en_wb,

    output forwardCtrl_e  forward_a,
    output forwardCtrl_e  forward_b
);

// forward_a
always_comb begin
    if ( (rs1_ex == rd_mem && reg_wr_en_mem) && rs1_ex != 5'd0) begin
        // Forward from MEM stage
        forward_a = FORWARD_FROM_MEM;
    end else if ( (rs1_ex == rd_wb && reg_wr_en_wb) && rs1_ex != 5'd0) begin
        // Forward from WB stage
        forward_a = FORWARD_FROM_WB;
    end else begin
        // No forwarding
        forward_a = FORWARD_NONE;
    end
end

// forward_b
always_comb begin
    if ( (rs2_ex == rd_mem && reg_wr_en_mem) && rs2_ex != 5'd0) begin
        // Forward from MEM stage
        forward_b = FORWARD_FROM_MEM;
    end else if ( (rs2_ex == rd_wb && reg_wr_en_wb) && rs2_ex != 5'd0) begin
        // Forward from WB stage
        forward_b = FORWARD_FROM_WB;
    end else begin
        // No forwarding
        forward_b = FORWARD_NONE;
    end
end

endmodule
