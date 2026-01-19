module sync_fifo(input clk,rst,
                 input wr_en,rd_en,
                 input [7:0] data_in,
                 output full,empty,
                 output reg [7:0] data_out);
parameter depth = 8;
reg [7:0] mem [0:depth-1];                 
reg [2:0] wr_p;
reg [2:0] rd_p; 
reg [3:0] count;
assign full = (count == depth);
assign empty = (count == 0);
always@(posedge clk or negedge rst )begin 
if(!rst)begin
wr_p <= 0;
end else begin
if(wr_en == 1 )begin
mem[wr_p] <= data_in;
wr_p <= wr_p + 1;
end
end
end     
always@(posedge clk or negedge rst )begin 
if(!rst)begin
rd_p <= 0;
end else begin
if(rd_en == 1 )begin
data_out <= mem[rd_p];
rd_p <= rd_p + 1;
end
end
end     
always@(posedge clk or negedge rst )begin 
if(!rst)begin
count <= 0;
end else begin
case({wr_en,rd_en})
2'b10 :count <= count + 1;
2'b01 :count <= count - 1; 
2'b11 :count <= count; 
2'b00 :count <= count; 
default : count <= count; 
endcase
end
end               
endmodule
