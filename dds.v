module dds(clkin,out,ke,ku,kd,kl,kr,sel1,sel2,sel3,sel4,sel5,sel6);
input clkin;
output wire [7:0] out;

//数码管部分参数 cnt0，clkin_dvd0;
input ke,ku,kd,kl,kr;
output clk_dvd;
reg [31:0]cnt0 = 0;
reg clk_dvd;
reg rst_n = 1'b1;
output reg sel1,sel2,sel3,sel4,sel5,sel6;
reg [2:0] sel= 1;
reg [23:0]data = 24'h523456;
reg [23:0] dat;reg [23:0] t = 24'hAAAAAA;reg [4:0] js;
	
reg [3:0]num;	//数码管显示数the num the led display
output reg [7:0]led;//数码管LED八级

reg [1:0]state=0;
	
reg [31:0] fd;reg [31:0] fd1;reg [31:0] fd2;reg [31:0] fd3;reg [31:0] fd4;reg [31:0] fd5;//防抖计数器，牺牲了很大的内存，...
	//...有一种好的改进方法是每隔20ms传输一次数据，或者直接在回跳的抖动时间内也重新置零；
reg [2:0] sell = 1;
reg [30:0] ds1;
reg wwait = 1;reg wwait1,wwait2,wwait3,wwait4,wwait5;
	
	
	
	
//sin部分；
reg [4:0] cnt = 0;
reg clk_dvd0 = 1;

reg [9:0] address = 0;


abc u1(.address(address),.clock(clk_dvd),.q(out));

always @(posedge clkin)
begin
	if (cnt <= 25)
		cnt <= cnt+1;
	else
	begin
		cnt <= 0;
		clk_dvd = ~clk_dvd;//1秒钟刷一百万次，1kHz的一个周期有1000个点；
	end
end

always @(posedge clk_dvd)
begin
	
	if (address<=10'd999)
	begin
		address <= address+1;
	end
	
	else
	begin
		address <= 0;
		
	end
end


endmodule 
