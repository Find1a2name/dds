module dds(clkin,out);
input clkin;
output wire [7:0] out;

reg [4:0] cnt = 0;
reg clk_dvd = 1;

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
