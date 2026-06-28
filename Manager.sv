module ahb_manager (
input  logic hclk,
input  logic hresetn,
input  logic start,
input  logic rw,
input  logic [9:0] addr,
input  logic [31:0] wdata,
input  logic [31:0] hrdata,
input  logic hready,
output logic [9:0] haddr,
output logic [31:0] hwdata,
output logic hwrite,
output logic [1:0]  htrans,
output logic [31:0] rdata,
output logic done
);
typedef enum logic [2:0] {
IDLE,
WR_ADDR,
WR_WAIT,
RD_ADDR,
RD_WAIT,
DONE
} m_state;
m_state cs, ns;

always_ff @(posedge hclk or negedge hresetn) begin
if (!hresetn)
cs <= IDLE;
else
cs <= ns;
end

always_comb begin
ns = cs;

  case (cs)
IDLE: begin
if (start && rw)
ns = WR_ADDR;
else if (start && !rw)
ns = RD_ADDR;
end

WR_ADDR:
ns = WR_WAIT;

WR_WAIT: begin
if (hready)
ns = DONE;
end

RD_ADDR:
ns = RD_WAIT;

RD_WAIT: begin
if (hready)
ns = DONE;
end

DONE:
ns = IDLE;

default:
ns = IDLE;
endcase
end

always_ff @(posedge hclk or negedge hresetn) begin
if (!hresetn) begin
haddr <= 1'b0;
hwdata <= 1'b0;
hwrite <= 1'b0;
htrans <= 2'b00;
rdata <= 1'b0;
done <= 1'b0;
end
else begin
done <= 1'b0;

  case (cs)
IDLE: begin
htrans <= 2'b00;
hwrite <= 1'b0;
end

WR_ADDR: begin
haddr <= addr;
hwdata <= wdata;
hwrite <= 1'b1;
htrans <= 2'b10;
end

WR_WAIT:
htrans <= 2'b10;

RD_ADDR: begin
haddr <= addr;
hwrite <= 1'b0;
htrans <= 2'b10;
end

RD_WAIT: begin
if (hready)
rdata <= hrdata;
end

DONE: begin
done <= 1'b1;
htrans <= 2'b00;
end
endcase
end
end
endmodule
