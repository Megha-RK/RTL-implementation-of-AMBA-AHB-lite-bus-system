module slave0 (
    input wire hclk,
    input wire hresetn,
    input wire hsel,
    input wire hwrite,
    input wire [9:0] haddr,
    input wire [31:0] hwdata,
    output reg [31:0] hrdata,
    output wire hready
);
reg [31:0] mem [0:255];
assign hready = 1'b1;
always @(posedge hclk) begin
    if (hsel && hwrite)
        mem[haddr] <= hwdata;
end
always @(*) begin
    if (hsel && !hwrite)
        hrdata = mem[haddr];
    else
        hrdata = 32'd0;
end
endmodule
