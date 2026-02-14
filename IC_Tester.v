module IC_Tester(pass,gpio_pins,number,clk);

	output reg pass;
	inout [13:0]gpio_pins;
	input clk;
	input [3:0]number;
	wire [3:0]corr_out;
	reg comp_out;
	wire [1:0]sequence;
	
	Output_Gen out(corr_out,number);
	IC_input in(sequence,gpio_pins,number,clk);
	IC_tester_display LCD(clk,pass,RS,EN,DATA);
	
	always @(posedge clk)
	begin
		case(sequence)
			/*2'b00 : comp_out = corr_out[3];
			2'b01 : comp_out = corr_out[2];
			2'b10 : comp_out = corr_out[1];
			2'b11 : comp_out = corr_out[0];*/
			2'b00 : comp_out = corr_out[0];
			2'b01 : comp_out = corr_out[1];
			2'b10 : comp_out = corr_out[2];
			2'b11 : comp_out = corr_out[3];
			
		endcase 
		
		if (number < 4'b0101)
		begin
			pass <= (gpio_pins[2] ^~ comp_out) & (gpio_pins[5] ^~ comp_out) & (gpio_pins[7] ^~ comp_out) & (gpio_pins[10] ^~ comp_out);
		end
		
		else if (number == 4'b0101)
		begin
			pass <= (gpio_pins[0] ^~ comp_out) & (gpio_pins[3] ^~ comp_out) & (gpio_pins[9] ^~ comp_out) & (gpio_pins[12] ^~ comp_out);
		end
			
		else if (number == 4'b0110)
		begin
			pass <= (gpio_pins[1] ^~ comp_out) & (gpio_pins[3] ^~ comp_out) & (gpio_pins[5] ^~ comp_out) & (gpio_pins[7] ^~ comp_out) & (gpio_pins[9] ^~ comp_out) & (gpio_pins[11] ^~ comp_out);
		end
		
		else
			pass <= 0;
			
	end
endmodule 

