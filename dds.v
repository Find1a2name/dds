module dds(clkin,clk_dvd,out,ke,ku,kd,kr,kl,sel1,sel2,sel3,sel4,sel5,sel6,led);
input clkin;
output reg [7:0] out;//真正的输出
Reg [15:0] aout; //用于调幅的中间寄存器
wire [7:0] wout; //连在外置数据的线

output clk_dvd = 1;
reg [4:0] cnt = 0;
reg clk_dvd = 1;
reg [8:0] keycnt = 0;
reg [9:0] address = 0;
reg [19:0] Win;
reg [2:0] tt = 0 ;          //改了
reg t = 1;
reg ttt = 1;
reg [19:0] a;
reg b = 0;
reg [9:0] c,d;
reg apl = 1;
reg [6:0] = 7'd10;



//shumaguan
input ke,ku,kd,kl,kr;

reg [31:0]cnt0=0;
reg clk_dvd0;
output reg sel1,sel2,sel3,sel4,sel5,sel6;
reg [2:0] sel= 1;
reg [23:0]data = 24'h000000;
reg [23:0]datad = 24'h000000;
reg [23:0]dataa = 24'hAAAA00;
reg [4:0] js;
reg [3:0]num;
output reg [7:0]led;
reg [1:0]state=0;
reg [31:0] fd = 0;
reg [31:0] fd1 = 0;
reg [31:0] fd2 = 0;
reg [31:0] fd3 = 0;reg [31:0] fd4 = 0;reg [31:0] fd5 = 0;
reg [2:0] sell = 1;
reg [30:0] ds1;
reg wwait = 1;reg wwait1 = 1,wwait2 = 1,wwait3 = 1,wwait4 = 1,wwait5 = 1;



always@(posedge clkin)
begin
	if	(cnt0==100000)
	begin
		clk_dvd0=~clk_dvd0;
		cnt0 = 0;
	end
	else
	cnt0 <= cnt0+1;
end
//选择哪个亮
always @(posedge clk_dvd0)
begin
	if(sel==3'h6)
		sel <= 1;
	else
	begin
		sel <= sel+1;
	end
	
case(sel)
	3'd1:	begin sel1<=0;sel2<=1;sel3<=1;sel4<=1;sel5<=1;sel6<=1;end
	3'd2:	begin sel2<=0;sel1<=1;sel3<=1;sel4<=1;sel5<=1;sel6<=1;end
	3'd3:	begin sel3<=0;sel2<=1;sel1<=1;sel4<=1;sel5<=1;sel6<=1;end
	3'd4:	begin sel4<=0;sel2<=1;sel3<=1;sel1<=1;sel5<=1;sel6<=1;end
	3'd5:	begin sel5<=0;sel2<=1;sel3<=1;sel4<=1;sel1<=1;sel6<=1;end
	3'd6:	begin sel6<=0;sel2<=1;sel3<=1;sel4<=1;sel5<=1;sel1<=1;end
endcase
end

always @(sel)
begin

	case(sel)
	3'h1: num = datad[23:20];
	3'h2: num = datad[19:16];
	3'h3: num = datad[15:12];
	3'h4: num = datad[11:8];
	3'h5: num = datad[7:4];
	3'h6: num = datad[3:0];
	endcase

end

always @(posedge clk_dvd0)
begin

case(num)
	4'h0: led = 8'hC0;
	4'h1: led = 8'hF9;
	4'h2: led = 8'hA4;
	4'h3: led = 8'hB0;
	4'h4: led = 8'h99;
	4'h5: led = 8'h92;
	4'h6: led = 8'h82;
	4'h7: led = 8'hF8;
	4'h8: led = 8'h80;
	4'h9: led = 8'h90;
	4'hA: led = 8'hFF;
	4'hB: led = 8'h86;
	4'hC: led = 8'hAB;
	4'hD: led = 8'hA1;
endcase
end








//aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa

abc u1(.address(address),.clock(clk_dvd),.q(rout));
//
always @(posedge clkin)
begin
	if (cnt <= 250)                 //GA改了
		cnt <= cnt+1;
	else
	begin
		cnt <= 0;
		clk_dvd = ~clk_dvd;//1秒钟刷十万次，100Hz的一个周期有1000个点；
	end
	
end




always @(negedge clkin)


begin

 
if (apl == 1) //调频
begin
datad = data;			
	if ((ku==0) || (fd1>0))
	begin
		if((fd1<1000000))
			fd1 <= fd1+1;
		else
		begin
			if(ku==0)
			
			wwait1 <= 0;
			else
			begin
				if(wwait1==0)
				begin
					case(sell)
					1:begin if(data[23:20] == 9) data[23:20]<=0; else data[23:20]<=data[23:20]+4'b1; end
					2:begin if(data[19:16] == 4) data[19:16]<=0; else data[19:16]<=data[19:16]+4'b1; end
					3:begin if(data[15:12] == 9) data[15:12]<=0; else data[15:12]<=data[15:12]+4'b1; end
					4:begin if(data[11:8] == 9)  data[11:8]<=0;  else data[11:8]<=data[11:8]+4'b1;   end
					5:begin if(data[7:4] == 9)   data[7:4]<=0;   else data[7:4]<=data[7:4]+4'b1;     end
					6:begin if(data[3:0] == 9)   data[3:0]<=0;   else data[3:0]<=data[3:0]+4'b1;     end
					endcase
					wwait1 <= 1;
					fd1 <= 0;
					t = 0;
				end
			end
		end
	end
	
	if ((kd==0) || (fd2>0))
	begin
		if (fd2<1000000)
			fd2 <= fd2+1;
		else
		begin
			if(kd == 0)
				wwait2 <= 0;
			else
			begin
				if(wwait2==0)
				begin
				case(sell)
				1:begin if(data[23:20] == 0) data[23:20]<=9; else data[23:20]<=data[23:20]-4'b1; end
				2:begin if(data[19:16] == 0) data[19:16]<=4; else data[19:16]<=data[19:16]-4'b1; end
				3:begin if(data[15:12] == 0) data[15:12]<=9; else data[15:12]<=data[15:12]-4'b1; end
				4:begin if(data[11:8] == 0)  data[11:8]<=9;  else data[11:8]<=data[11:8]-4'b1;   end
				5:begin if(data[7:4] == 0)   data[7:4]<=9;   else data[7:4]<=data[7:4]-4'b1;     end
				6:begin if(data[3:0] == 0)   data[3:0]<=9;   else data[3:0]<=data[3:0]-4'b1;     end
				endcase
				wwait2 <= 1;
				fd2 <= 0;
				t = 0;
				end
			end
		end
	end

	if ((kr==0) || (fd3>0))
	begin
		if(fd3<1000000)
			fd3 <= fd3+1;
		else
		begin
			if(kr==0)
			wwait3 <= 0;
			else
				if(wwait3 == 0)
					begin
					if (sell==6)
					begin
						sell <= 1;
						//t = 0;  移位不需要重新输入显示值
					end
					else
					begin
						sell<=sell+1'b1;
						//t = 0;  移位不需要重新输入显示值
					end
					fd3 <= 0;
					wwait3 <= 1;
				end
		end
	end

	if ((kl==0) || (fd4>0))
	begin
		if(fd4<1000000)
			fd4 <= fd4+1;
		else
		begin
			if(kl==0)
				wwait4 <= 0;
			else
				if(wwait4 == 0)
				begin
					if (sell==1)
					begin
						sell <= 6;
					//t = 0;
					end
					
					else
					begin
						sell<=sell-1'b1;
						//t = 0;
					end
					fd4 <= 0;
					wwait4 <= 1;
				end
		end
	end

	if ((ke==0) || (fd5>0))
	begin
		if(fd5<1000000)
			fd5 <= fd5+1;
		else
		begin
			if(ke==0)
				wwait5 <= 0;
			else
				if(wwait5==0)
				begin
					wwait5 <= 1;
					fd5 <= 0;	
					apl = 0;							
				end
		end
	end
end


if(apl == 0)  // 调幅
begin
datad = dataa;
	if ((ke==0) || (fd5>0))
	begin
		if(fd5<1000000)
			fd5 <= fd50+1;
		else
		begin
			if(ke==0)
				wwait5 <= 0;
			else
				if(wwait5==0)
				begin
					wwait5 <= 1;
					fd5 <= 0;	
					apl == 1;							
				end
		end
	end

	if ((ku==0) || (fd1>0))
	begin
		if((fd1<1000000))
			fd1 <= fd1+1;
		else
		begin
			if(ku==0)
			
			wwait1 <= 0;
			else
			begin
				if(wwait1==0)
				begin
					
					
					if (data[11:8]==0)
					begin
						if (dataa[3:0] == 9) 
						begin
							
							dataa[3:0]<=0;
							ap <= ap+1;
							if (dataa[7:4]<9)
							begin
								dataa[7:4] <= dataa[7:4]+1;
							
							end
							else
							begin
								dataa[7:4] <= 0;
					 			dataa[11:8]<= 1;
							end
						end
					end
					else
					begin
						dataa[3:0] <= 0;
						dataa[7:4] <= 1;
						dataa[11:8]<= 0;
						ap = 10 ; 
					end
						
						else
							dataa[3:0]<=dataa[3:0]+1;
							ap = ap+1;//如何乘到out上
						
					wwait1 <= 1;
					fd1 <= 0;
					
				end
			end
		end
	end




end


//调幅代码
	aout = ap*wout;
	out = aout[15:8];


//调整频率的代码
	if (t == 0)
	begin
		Win = 0;
		Win = Win+data[23:20]*100000;
		Win = Win+data[19:16]*10000;
		Win = Win+data[15:12]*1000;
		Win = Win+data[11:8]*100;
		Win = Win+data[7:4]*10;
		Win = Win+data[3:0];
		t = 1;
		ttt = 0;
		
	end


	if(ttt == 0 )
	begin
		
		ttt = 1;
		tt <= 1'd1;
		a <= Win;  //-7'd100;		//改了
		address <= 0;
	end

	if(tt == 1 && ttt == 1)
	begin
		if (a >= 100)
		begin
			a <= a-100;
			b <= b+1;
		end
		else
		begin
			c <= a;
			d <= a;
			tt <= 2;
			
		end
	end

	if(tt == 2)
	begin
		if (keycnt <= 500)
			keycnt = keycnt + 1;
		else
		begin
			keycnt = 0;
			if ((address+b+1)<=999)
			begin
				if( (c+d)<100 )
				begin
					if((c<=50) && ((c+d)>50))
						address <= address+b+1;
					else
						address <= address+b;

					c <= c+d;
				end
				else
				begin
					if((c<=50))
						address <= address+b+1; 	
					else
						address <= address+b;
	
					c <= c+d-100;
					
				end
			end
			else
			begin
				if((address+b)<=999)
				begin
					if((c+d)<100)
					begin
						if((c<=50) && ((c+d>50)))
						begin
							address <= address+b-999;
							
						end
						else 
							address <= address+b;
						c <= c+d;
					end
					else
					begin
						if((c<=50) && ((c+d)>50))
							address <= address+b-999;
						else
							address <= address+b;
				
						c <= c-100+d;
					end
				end
				else
				begin
					if((c+d)<100)
					begin
						if((c<=50) && ((c+d>50)))
							address <= address+b-999;
						else
							address <= address+b-1000;
						c <= c+d;
	
					end
					else
					begin
						if((c<=50) && ((c+d)>50))
							address <= address+b-999;
						else
							address <= address+b-1000;
					
						c <= c+d-100;
					end
				end
				
			end
		end
	end	













end


	

	
	
	
	
	

endmodule 
