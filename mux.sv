module hrdata_mux (
    input  logic hsel0,
    input  logic hsel1,
    input  logic hsel2,
    input  logic hsel3,
    input  logic [31:0] hrdata0,
    input  logic [31:0] hrdata1,
    input  logic [31:0] hrdata2,
    input  logic [31:0] hrdata3,
    output logic [31:0] hrdata
);
always_comb begin
    unique case (1'b1)
        hsel0:  hrdata = hrdata0;
        hsel1:  hrdata = hrdata1;
        hsel2:  hrdata = hrdata2;
        hsel3:  hrdata = hrdata3;
        default: hrdata = 32'd0;
    endcase
end
endmodule
