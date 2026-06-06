`timescale 1ns / 1ps

module binary_to_7seg_pc(
    input clk,
    input [3:0] pcbin,
    output reg [7:0] seg,   // includes DP
    output reg [3:0] an
);
    wire [6:0] seg_p;
    bin_to_7seg s1 (.bin(pcbin),.seg(seg_p));
    
    reg [15:0] clk_div = 0;
    always @(posedge clk)
        clk_div <= clk_div + 1;

    wire [1:0] digit = clk_div[15:14];

    always @(*) begin
        case (digit)
            2'b00: begin
                seg = {1'b1, ~seg_p};
                an  = 4'b1110;
            end
            2'b01: begin
                seg = 8'b11111111; // all OFF
                an  = 4'b111;
            end
            2'b10: begin
                seg = 8'b11111111; // all OFF
                an  = 4'b1111;
            end
            2'b11: begin
                seg = 8'b11111111; // all OFF
                an  = 4'b1111;
            end
        endcase
    end

endmodule

module bin_to_7seg (
    input  [3:0] bin,   
    output reg [6:0] seg 
);
    always @(*) begin
        case (bin)
            4'b0000: seg = 7'b0111111; 
            4'b0001: seg = 7'b0000110; 
            4'b0010: seg = 7'b1011011;
            4'b0011: seg = 7'b1001111; 
            4'b0100: seg = 7'b1100110; 
            4'b0101: seg = 7'b1101101; 
            4'b0110: seg = 7'b1111101; 
            4'b0111: seg = 7'b0000111; 
            4'b1000: seg = 7'b1111111; 
            4'b1001: seg = 7'b1101111;
            4'b1010: seg = 7'b1110111;
            4'b1011: seg = 7'b1111100;
            4'b1100: seg = 7'b0111001;
            4'b1101: seg = 7'b1011110;
            4'b1110: seg = 7'b1111001;
            4'b1111: seg = 7'b1110001;
            default: seg = 7'b0111111; 
        endcase
    end
endmodule