module IC_input(sequence,gpio_reg,number,clk);
	
	output reg [13:0]gpio_reg;
	output reg [1:0]sequence;
	input [3:0]number;
	input clk;
	initial gpio_reg[13:0] = 14'b0;
	initial sequence[1:0] = 2'b11;
	
	always @(posedge clk)
	begin
	
		if (number < 4'b0101)
		begin
			gpio_reg[1:0] <= gpio_reg[1:0] + 2'b01;
			gpio_reg[4:3] <= gpio_reg[4:3] + 2'b01;
			gpio_reg[9:8] <= gpio_reg[9:8] + 2'b01;
			gpio_reg[12:11] <= gpio_reg[12:11] + 2'b01;
			gpio_reg[2] <= 1'bz;
			gpio_reg[5] <= 1'bz;
			gpio_reg[7] <= 1'bz;
			gpio_reg[10] <= 1'bz;
			sequence <= sequence + 2'b01;
		end
		
		else if (number == 4'b0101)
		begin
			gpio_reg[2:1] <= gpio_reg[2:1] + 2'b01;
			gpio_reg[5:4] <= gpio_reg[5:4] + 2'b01;
			gpio_reg[8:7] <= gpio_reg[8:7] + 2'b01;
			gpio_reg[11:10] <= gpio_reg[11:10] + 2'b01;
			gpio_reg[0] <= 1'bz;
			gpio_reg[3] <= 1'bz;
			gpio_reg[9] <= 1'bz;
			gpio_reg[12] <= 1'bz;
			sequence <= sequence + 2'b01;
		end
		
		else if (number == 4'b0110)
		begin
			gpio_reg[0] <= gpio_reg[0] + 1'b1;
			gpio_reg[2] <= gpio_reg[2] + 1'b1;
			gpio_reg[4] <= gpio_reg[4] + 1'b1;
			gpio_reg[8] <= gpio_reg[8] + 1'b1;
			gpio_reg[10] <= gpio_reg[10] + 1'b1;
			gpio_reg[12] <= gpio_reg[12] + 1'b1;
			gpio_reg[1] <= 1'bz;
			gpio_reg[3] <= 1'bz;
			gpio_reg[5] <= 1'bz;
			gpio_reg[7] <= 1'bz;
			gpio_reg[9] <= 1'bz;
			gpio_reg[11] <= 1'bz;
			sequence[0] <= sequence[0] + 1'b1;
		end
		
		else
			gpio_reg[13:0] = 14'b0;

	end
endmodule
		
	
		
			
			
	
	

	
