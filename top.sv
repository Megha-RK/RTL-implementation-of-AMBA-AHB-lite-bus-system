module ahb_top (
    input logic hclk,
    input  logic hresetn,
    input  logic start,
    input  logic rw,
    input  logic [9:0]  addr,
    input  logic [31:0] wdata,
    output logic [31:0] rdata,
    output logic done
);
logic [9:0]  haddr;
logic [31:0] hwdata;
logic [31:0] hrdata;
logic hwrite;
logic [1:0]  htrans;
logic hready;
logic hsel0;
logic hsel1;
logic hsel2;
logic hsel3;
logic [31:0] hrdata0;
logic [31:0] hrdata1;
logic [31:0] hrdata2;
logic [31:0] hrdata3;
logic hready0;
logic hready1;
logic hready2;
logic hready3;
ahb_manager manager (
    .hclk (hclk),
    .hresetn (hresetn),
    .start (start),
    .rw (rw),
    .addr (addr),
    .wdata (wdata),
    .hrdata (hrdata),
    .hready (hready),
    .haddr(haddr),
    .hwdata (hwdata),
    .hwrite (hwrite),
    .htrans (htrans),
    .rdata (rdata),
    .done (done)
);
decoder dec (
    .haddr (haddr),
    .hsel0 (hsel0),
    .hsel1 (hsel1),
    .hsel2 (hsel2),
    .hsel3 (hsel3)
);
slave0 s0 (
    .hclk (hclk),
    .hresetn (hresetn),
    .hsel (hsel0),
    .hwrite(hwrite),
    .haddr (haddr),
    .hwdata(hwdata),
    .hrdata (hrdata0),
    .hready (hready0)
);
slave1 s1 (
    .hclk (hclk),
    .hresetn (hresetn),
    .hsel (hsel1),
    .hwrite (hwrite),
    .haddr (haddr),
    .hwdata (hwdata),
    .hrdata (hrdata1),
    .hready (hready1)
);
slave2 s2 (
    .hclk (hclk),
    .hresetn (hresetn),
    .hsel (hsel2),
    .hwrite (hwrite),
    .haddr (haddr),
    .hwdata (hwdata),
    .hrdata (hrdata2),
    .hready (hready2)
);

slave3 s3 (
    .hclk (hclk),
    .hresetn (hresetn),
    .hsel (hsel3),
    .hwrite (hwrite),
    .haddr (haddr),
    .hwdata (hwdata),
    .hrdata (hrdata3),
    .hready (hready3)
);
hrdata_mux mux (
    .hsel0 (hsel0),
    .hsel1 (hsel1),
    .hsel2 (hsel2),
    .hsel3 (hsel3),
    .hrdata0(hrdata0),
    .hrdata1(hrdata1),
    .hrdata2(hrdata2),
    .hrdata3(hrdata3),
    .hrdata (hrdata)
);
always_comb begin
    unique case (1'b1)
        hsel0: hready = hready0;
        hsel1: hready = hready1;
        hsel2: hready = hready2;
        hsel3: hready = hready3;
        default: hready = 1'b1;
    endcase
end
endmodule
