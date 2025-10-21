module mux2 (
    input  logic [31:0]  in0,
    input  logic [31:0]  in1,
    input  logic         sel,
    output logic [31:0]  out
);

always_comb begin
    if (sel)
        out = in1;
    else
        out = in0;
end

endmodule
