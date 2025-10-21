`timescale 1ns/1ps
`include "top.sv"
`define CYCLE      20.0
`define MAX_CYCLES 1000

module tb;

logic clk = 0;
logic rst = 1;
int   cycle_count = 0;

always #(`CYCLE/2) clk = ~clk;

initial begin
    #(`CYCLE * 1.5 + 1);
    rst = 0;
end

top u_top(
    .clk(clk),
    .rst(rst)
);

initial begin
    $readmemh("tests/prog/prog1.hex", u_top.u_imem.mem);
end

// Cycle counter and timeout
always @(posedge clk) begin
    cycle_count <= cycle_count + 1;

    if (cycle_count >= `MAX_CYCLES) begin
        // Dump RV32 registers
        $display("\n\n=== Register Dump ===");
        for (int i = 1; i < 32; i++) begin
            $display("x%-2d: 0x%08x", i, u_top.u_core.u_reg_file.reg_file[i]);
        end

        $display("Testbench Timeout: Exceeded %0d cycles", `MAX_CYCLES);
        $finish;
    end
end

`ifdef FSDB
initial begin
    $fsdbDumpfile("output/test_core.fsdb");
    $fsdbDumpvars(0, tb);
    $fsdbDumpMDA();
    $fsdbDumpSVA();
end
`else
initial begin
    $dumpfile("output/test_core.vcd");
    $dumpvars(0, tb);
end
`endif

endmodule
