module decoder (
    input  logic [9:0] haddr,
    output logic       hsel0,
    output logic       hsel1,
    output logic       hsel2,
    output logic       hsel3
);

always_comb begin
    hsel0 = 1'b0;
    hsel1 = 1'b0;
    hsel2 = 1'b0;
    hsel3 = 1'b0;

    unique case (haddr[9:8])
        2'b00: hsel0 = 1'b1;
        2'b01: hsel1 = 1'b1;
        2'b10: hsel2 = 1'b1;
        2'b11: hsel3 = 1'b1;
        default: ;
    endcase
end

endmodule
