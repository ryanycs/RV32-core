`include "types.svh"

module branch_comp (
    input  logic [31:0]  a,
    input  logic [31:0]  b,
    input  branchCtrl_e  branch_ctrl,
    output logic         branch_taken
);

always_comb begin
    case (branch_ctrl)
        BRANCH_EQ:
            branch_taken = (a == b);

        BRANCH_NE:
            branch_taken = (a != b);

        BRANCH_LT:
            branch_taken = ($signed(a) < $signed(b));

        BRANCH_GE:
            branch_taken = ($signed(a) >= $signed(b));

        BRANCH_LTU:
            branch_taken = (a < b);

        BRANCH_GEU:
            branch_taken = (a >= b);

        default:
            branch_taken = 1'b0;
    endcase
end

endmodule
