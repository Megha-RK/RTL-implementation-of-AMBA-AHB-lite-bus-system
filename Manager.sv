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
} state_t;

state_t state, next_state;

always_ff @(posedge hclk or negedge hresetn) begin
if (!hresetn)
state <= IDLE;
else
state <= next_state;
end

always_comb begin
next_state = state;

case (state)
IDLE: begin
if (start && rw)
next_state = WR_ADDR;
else if (start && !rw)
next_state = RD_ADDR;
end

WR_ADDR:
next_state = WR_WAIT;

WR_WAIT: begin
if (hready)
next_state = DONE;
end

RD_ADDR:
next_state = RD_WAIT;

RD_WAIT: begin
if (hready)
next_state = DONE;
end

DONE:
next_state = IDLE;

default:
next_state = IDLE;
endcase
end

always_ff @(posedge hclk or negedge hresetn) begin
if (!hresetn) begin
haddr <= '0;
hwdata <= '0;
hwrite <= 1'b0;
htrans <= 2'b00;
rdata <= '0;
done <= 1'b0;
end
else begin
done <= 1'b0;

case (state)
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
