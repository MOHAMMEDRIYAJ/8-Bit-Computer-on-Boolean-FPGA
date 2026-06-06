module RAM(
    input clk,
    input reset,
    input ram_in_en,
    input [3:0] ram_in_addr,
    input [7:0] bus_in,
    output [7:0] bus_out,
    input start,
    input [7:0]a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15, 
    input load_btn
    
);
    reg [7:0] memory [15:0];
    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < 16; i = i + 1)
                memory[i] <= 8'b00000000;
        end 
        else if (ram_in_en) begin
            memory[ram_in_addr] <= bus_in;
        end
        else if(~start && load_btn) begin
            memory[0] <=  a0;   
            memory[1] <=  a1;
            memory[2] <=  a2;
            memory[3] <=  a3;
            memory[4] <=  a4;
            memory[5] <=  a5;
            memory[6] <=  a6;
            memory[7] <=  a7;
            memory[8] <=  a8;
            memory[9] <=  a9;
            memory[10] <=  a10;
            memory[11] <=  a11;
            memory[12] <=  a12;
            memory[13] <=  a13;      
            memory[14] <=  a14;
            memory[15] <=  a15;
        end
    end
    assign bus_out = memory[ram_in_addr];
endmodule