module clk_div_100mhz_to_6hz (
    input  wire clk_100mhz,   // 100 MHz clock
    input  wire rst,
    output reg  en_6hz         // 1-cycle enable pulse @ 6 Hz
);

    localparam integer COUNT_MAX = 16666666; // 100e6 / 6

    reg [24:0] count;

    always @(posedge clk_100mhz) begin
        if (rst) begin
            count <= 25'd0;
            en_6hz <= 1'b0;
        end else if (count == COUNT_MAX - 1) begin
            count <= 25'd0;
            en_6hz <= 1'b1;    // pulse for 1 cycle
        end else begin
            count <= count + 1'b1;
            en_6hz <= 1'b0;
        end
    end
endmodule
