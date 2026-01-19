module tb_sync_fifo;
reg clk,rst;
reg wr_en,rd_en;
reg data_in;
wire full,empty;
wire data_out;
sync_fifo uut(.clk(clk),
              .rst(rst),
              .wr_en(wr_en),
              .rd_en(rd_en),
              .data_in(data_in),
              .full(full),
              .empty(empty),
              .data_out(data_out));
initial clk = 1'b1;
always #5 clk = ~clk;
integer i;
initial begin
rst = 1;
wr_en = 0;
rd_en = 0;
data_in = 8'b0;
#10 rst = 0;
#10 rst = 1;
wr_en = 1;
rd_en = 0; 
for(i=0; i<8 ; i=i+1)begin
data_in = i;
#10;
end
wr_en = 0;
rd_en = 1; 
for(i=0; i<8 ; i=i+1)begin
#10;
end 
wr_en = 1;
rd_en = 0; 
for(i=0; i<8 ; i=i+1)begin
data_in = i;
#10;
end
#10;
#10;
#10;  
end             
endmodule
