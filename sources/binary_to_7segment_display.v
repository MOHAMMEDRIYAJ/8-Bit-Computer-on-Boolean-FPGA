module binary_to_7seg_out (
    input clk,
    input [7:0] bin,
    output reg [7:0] seg,   // includes DP
    output reg [3:0] an
);

    wire [3:0] hundreds, tens, ones;
    wire [6:0] seg_h, seg_t, seg_o;

    bin_to_bcd bcd_convert (
        .bin(bin),
        .hundreds(hundreds),
        .tens(tens),
        .ones(ones)
    );

    bcd_to_7seg s1 (.bcd(ones),     .seg(seg_o));
    bcd_to_7seg s2 (.bcd(tens),     .seg(seg_t));
    bcd_to_7seg s3 (.bcd(hundreds), .seg(seg_h));

    reg [15:0] clk_div = 0;
    always @(posedge clk)
        clk_div <= clk_div + 1;

    wire [1:0] digit = clk_div[15:14];

    always @(*) begin
        case (digit)
            2'b00: begin
                seg = {1'b1, ~seg_o}; // DP off + invert
                an  = 4'b1110;
            end
            2'b01: begin
                seg = {1'b1, ~seg_t};
                an  = 4'b1101;
            end
            2'b10: begin
                seg = {1'b1, ~seg_h};
                an  = 4'b1011;
            end
            2'b11: begin
                seg = 8'b11111111; // all OFF
                an  = 4'b1111;
            end
        endcase
    end

endmodule

module bin_to_bcd (
    input  [7:0] bin,       
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
);
    integer i;
    reg [19:0] bcd;
    always @(*) begin
        bcd = 20'd0;
        bcd[7:0] = bin;
        for (i = 0; i < 8; i = i + 1) begin
            if (bcd[11:8]  >= 5) bcd[11:8]  = bcd[11:8]  + 3; 
            if (bcd[15:12] >= 5) bcd[15:12] = bcd[15:12] + 3; 
            if (bcd[19:16] >= 5) bcd[19:16] = bcd[19:16] + 3; 
            bcd = bcd << 1;  
        end
        hundreds = bcd[19:16];
        tens     = bcd[15:12];
        ones     = bcd[11:8];
    end
endmodule

module bcd_to_7seg (
    input  [3:0] bcd,   
    output reg [6:0] seg 
);
    always @(*) begin
        case (bcd)
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
            default: seg = 7'b1000000; 
        endcase
    end
endmodule

