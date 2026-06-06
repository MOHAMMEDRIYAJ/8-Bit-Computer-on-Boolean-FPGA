module RAM_load(clk,prog_load,sw_data,addr_data,a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15);
    input clk;
    input [2:0] prog_load;
    input [3:0] sw_data;
    input [7:0] addr_data;
    output reg [7:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
    
    reg [7:0] memory [0:15];
    
    always @(posedge clk) begin 
        memory[sw_data] <= addr_data;
    end
    
    localparam FIBO = 3'b000;      // FIBONACCI SERIES 
    localparam MUL = 3'b001;       // MULTIPLICATION OF TWO NUMBERS
    localparam DIV = 3'b010;       // DIVISION OF TWO NUMBERS
    localparam MAX_NO = 3'b011;    // MAXIMUM OF TWO NUMBERS
    localparam PASSWORD = 3'b100;  // PASSWORD CHECKER
    localparam SUM_N = 3'b101;     // SUM OF N NUMBERS
    localparam TRAFFIC = 3'b110;   // TRAFFIC LIGHT CONTROLLER WITH BIT MASKING
    localparam MANUAL = 3'b111;    // MANUAL PROGRAMMING
        
    
    
    always @(posedge clk) begin
        case(prog_load)
          FIBO:begin  
            a0 <= 8'b0101_0000;  // LDI 0 
            a1 <= 8'b0100_1110;  // STA 14
            a2 <= 8'b1110_0000;  // OUT
            a3 <= 8'b0101_0001;  // LDI 1
            a4 <= 8'b0100_1101;  // STA 13
            a5 <= 8'b0001_1101;  // LDA 13
            a6 <= 8'b0010_1110;  // ADD 14
            a7 <= 8'b0111_1111;  // JC 15
            a8 <= 8'b1110_0000;  // OUT
            a9 <= 8'b0100_1101;  // STA 13
            a10 <= 8'b0011_1110;  // SUB 14
            a11 <= 8'b0100_1110;  // STA 14
            a12 <= 8'b0110_0101;  // JMP 5
            a13 <= 8'b0000_0000;
            a14 <= 8'b0000_0000;
            a15 <= 8'b0110_0000;  // JMP 0
          end
          MUL:begin
            a0 <= 8'b1101_1110;  // INP 14
            a1 <= 8'b1101_1111;  // INP 15
            a2 <= 8'b0001_1101;  // LDA 13
            a3 <= 8'b0010_1110;  // ADD 14
            a4 <= 8'b0100_1101;  // STA 13
            a5 <= 8'b1110_0000;  // OUT
            a6 <= 8'b0001_1111;  // LDA 15
            a7 <= 8'b1010_0001;  // SUI 1
            a8 <= 8'b0100_1111;  // STA 15
            a9 <= 8'b1000_1100;  // JZ 12
            a10 <= 8'b0111_1100;  // JC 12
            a11 <= 8'b0110_0010;  // JMP 2
            a12 <= 8'b1111_0000;  // HLT
            a13 <= 8'b0000_0000;
            a14 <= 8'b0000_0000;  // <= INPUT 1
            a15 <= 8'b0000_0000;  // <= INPUT 2
          end
          DIV:begin
            a0 <= 8'b1101_1110;  // INP 14
            a1 <= 8'b1101_1111;  // INP 15
            a2 <= 8'b0001_1110;  // LDA 14
            a3 <= 8'b0011_1111;  // SUB 15
            a4 <= 8'b0100_1110;  // STA 14
            a5 <= 8'b0111_1011;  // JC 11
            a6 <= 8'b0001_1101;  // LDA 13
            a7 <= 8'b1001_0001;  // ADI 1
            a8 <= 8'b0100_1101;  // STA 13
            a9 <= 8'b1110_0000;  // OUT
            a10 <= 8'b0110_0010;  // JMP 2
            a11 <= 8'b1111_0000;  // HLT
            a12 <= 8'b0000_0000;
            a13 <= 8'b0000_0000;
            a14 <= 8'b0000_0000;  // <= INPUT 1
            a15 <= 8'b0000_0000;  // <= INPUT 2
        end
        MAX_NO:begin
            a0 <= 8'b1101_1110;  // INP 14
            a1 <= 8'b1101_1111;  // INP 15
            a2 <= 8'b0011_1110;  // SUB 14
            a3 <= 8'b0111_0111;  // JC 7
            a4 <= 8'b0001_1111;  // LDA 15
            a5 <= 8'b1110_0000;  // OUT
            a6 <= 8'b1111_0000;  // HLT
            a7 <= 8'b0001_1110;  // LDA 14
            a8 <= 8'b0110_0101;  // JMP 5
            a9 <= 8'b0000_0000;
            a10 <= 8'b0000_0000;
            a11 <= 8'b0000_0000;
            a12 <= 8'b0000_0000;
            a13 <= 8'b0000_0000;
            a14 <= 8'b0000_0000;  // <= INPUT 1
            a15 <= 8'b0000_0000;  // <= INPUT 2
        end
        PASSWORD:begin
            a0 <= 8'b1101_1111;  // INP 15
            a1 <= 8'b1011_1110;  // XRA 14
            a2 <= 8'b1000_1010;  // JZ 10
            a3 <= 8'b0001_1001;  // LDA 9
            a4 <= 8'b1001_0001;  // ADI 1
            a5 <= 8'b0100_1001;  // STA 9
            a6 <= 8'b1011_1101;  // XRA 13
            a7 <= 8'b1000_1100;  // JZ 12
            a8 <= 8'b0110_0000;  // JMP 0
            a9 <= 8'b0000_0000;  
            a10 <= 8'b0101_0001;  // LDI 1
            a11 <= 8'b1110_0000;  // OUT
            a12 <= 8'b1111_0000;  // HLT
            a13 <= 8'b0000_0011;  // ATTEMPTS = 3
            a14 <= 8'b0010_0111;  // PASSWORD => 27 <= BCD
            a15 <= 8'b0000_0000;  // <= INPUT 1
        end
        SUM_N:begin
            a0 <= 8'b1101_1111;  // INP 15
            a1 <= 8'b0001_1110;  // LDA 14
            a2 <= 8'b0010_1111;  // ADD 15
            a3 <= 8'b0100_1110;  // STA 14
            a4 <= 8'b0001_1111;  // LDA 15
            a5 <= 8'b1010_0001;  // SUI 1
            a6 <= 8'b0100_1111;  // STA 15
            a7 <= 8'b1000_1001;  // JZ 9
            a8 <= 8'b0110_0001;  // JMP 1
            a9 <= 8'b0001_1110;  // LDA 14
            a10 <= 8'b1110_0000;  // OUT
            a11 <= 8'b1111_0000;  // HLT
            a12 <= 8'b0000_0000;
            a13 <= 8'b0000_0000;
            a14 <= 8'b0000_0000;
            a15 <= 8'b0000_0000;  // <= INPUT 1
        end
        TRAFFIC:begin
            a0 <= 8'b0001_1111;  // LDA 15
            a1 <= 8'b1100_1100;  // ANA 12
            a2 <= 8'b1110_0000;  // OUT
            a3 <= 8'b0001_1101;  // LDA 13
            a4 <= 8'b1110_0000;  // OUT
            a5 <= 8'b0001_1111;  // LDA 15
            a6 <= 8'b1100_1110;  // ANA 14
            a7 <= 8'b1110_0000;  // OUT
            a8 <= 8'b0001_1101;  // LDA 13
            a9 <= 8'b1110_0000;  // OUT
            a10 <= 8'b0110_0000;  // JMP 0
            a11 <= 8'b0000_0000;
            a12 <= 8'b0110_0100;  // DATA : 0110_0100 => 100 <= BCD
            a13 <= 8'b0000_1010;  // DATA : 0000_1010 => 010 <= BCD
            a14 <= 8'b0000_0001;  // DATA : 0000_0001 => 001 <= BCD
            a15 <= 8'b1111_1111;  // DATA : 1111_1111
        end
        MANUAL:begin
            a0 <= memory[0];
            a1 <= memory[1];
            a2 <= memory[2];
            a3 <= memory[3];
            a4 <= memory[4];
            a5 <= memory[5];
            a6 <= memory[6];
            a7 <= memory[7];
            a8 <= memory[8];
            a9 <= memory[9];
            a10 <= memory[10];
            a11 <= memory[11];
            a12 <= memory[12];
            a13 <= memory[13];
            a14 <= memory[14];
            a15 <= memory[15];
        end
      endcase
    end
endmodule
