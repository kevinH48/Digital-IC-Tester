module IC_tester_display(clk,pass,RS,EN,DATA);
    input clk;
    input pass;
    output reg RS;         
    output reg EN;                 
    output reg [7:0] DATA;


parameter INIT = 0, CHECK_IC = 1, WRITE_GOOD = 2, WRITE_BAD = 3, IDLE = 4;
reg [2:0] state = INIT;

parameter FUNCTION_SET = 8'h38;  // 8-bit, 2 line, 5x8 dots
parameter DISPLAY_ON = 8'h0C;
parameter CLEAR_DISPLAY = 8'h01;

reg [7:0] good_text [0:6];
reg [7:0] bad_text [0:5];

integer i = 0;

initial begin
    good_text[0] = "o";
    good_text[1] = "n";
    good_text[2] = "e";
    good_text[3] = "G";
    good_text[4] = "o";
    good_text[5] = "o";
    good_text[6] = "d";

    bad_text[0] = "o";
    bad_text[1] = "n";
    bad_text[2] = "e";
    bad_text[3] = "B";
    bad_text[4] = "a";
    bad_text[5] = "d";
end

always @(posedge clk) begin
    case (state)
        INIT: begin
            DATA <= FUNCTION_SET;
            RS <= 0; 
            EN <= 1;
            state <= CHECK_IC;
        end
        
        CHECK_IC: begin
            if (pass) state <= WRITE_GOOD;
            else state <= WRITE_BAD;
        end
        
        WRITE_GOOD: begin
            if (i < 7) begin
                DATA <= good_text[i];
                RS <= 1; 
                EN <= 1;
                i <= i + 1;
            end else begin
                i <= 0;
                state <= IDLE;
            end
        end
        
        WRITE_BAD: begin
            if (i < 6) begin
                DATA <= bad_text[i];
                RS <= 1; 
                EN <= 1;
                i <= i + 1;
            end else begin
                i <= 0;
                state <= IDLE;
            end
        end
        
        IDLE: begin
            EN <= 0; 
            RS <= 0;
            DATA <= 8'b00000000;
        end
    endcase
end
endmodule
	