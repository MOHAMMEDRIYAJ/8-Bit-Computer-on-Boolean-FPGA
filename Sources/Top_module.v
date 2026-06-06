module cpu_top (
    input clk_in,
    input reset,
    input start,
    input clk_ctrl,
    input [2:0] prog_load,
    input [3:0] sw_data,
    input [7:0] enter_data,
    input load_btn,
    input inp_loaded,
    output inp_req,
    output [18:0] sig_out,

    output [7:0] seg_out,
    output [7:0] seg_pc,
    output [3:0] anode1_pins,
    output [3:0] anode0_pins
);

    // ============================
    // Interconnect wires
    // ============================
    //reg [7:0] sw_data;
    reg [7:0] inp_data,ram_data;
    wire [3:0] ram_addr;
    wire [7:0] ram_data_in;
    wire [7:0] ram_data_out;
    wire ram_in_en;
    wire inp_sig;
    wire [3:0] pc_disp;
    wire [7:0] out_display;
    
    assign inp_req = inp_sig;
    
    always @(posedge clk_in) begin
        if(inp_sig) begin
            inp_data <= enter_data;
            ram_data <= ram_data;
        end    
        else begin
            ram_data <= enter_data;
            inp_data <= inp_data;
        end
    end
    
    // 100 Mhz to 6hz
    wire clk_6hz;
    clk_div_100mhz_to_6hz Clk_div(
        .clk_100mhz(clk_in),
        .rst(reset),
        .en_6hz(clk_6hz)
        );
        
    // 100 Mhz to 1hz
    wire clk_1hz;
    clk_div_100mhz_to_1hz(
        .clk(clk_in),
        .reset(reset),
        .c_out(clk_1hz)
        );
        
    //  Clk muxing
    wire clk;
    assign clk = (clk_ctrl) ? clk_1hz : clk_6hz;
    
    // ============================
    // Instantiate CPU core
    // ============================

    cpu_core CPU (
        .clk(clk),
        .reset(reset),
        .start(start),
        .pc_disp(pc_disp),
        .out_display(out_display),
        .inp_req(inp_sig),   
        .inp_loaded(inp_loaded), // inp by me 
        .inp_data(inp_data),   //inp reg data
        .ram_data_in(ram_data_in),
        .ram_data_out(ram_data_out),
        .ram_addr(ram_addr),
        .ram_in_en(ram_in_en),
        .sig_out(sig_out)
    );
    
    // ===========================
    // RAM LOADING
    // ===========================
    wire [7:0] a0,a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11,a12,a13,a14,a15;
    RAM_load Program_Loader(
            .clk(clk_in),
            .prog_load(prog_load),
            .sw_data(sw_data),
            .addr_data(ram_data),
            .a0(a0),
            .a1(a1),
            .a2(a2),
            .a3(a3),
            .a4(a4),
            .a5(a5),
            .a6(a6),
            .a7(a7),
            .a8(a8),
            .a9(a9),
            .a10(a10),
            .a11(a11),
            .a12(a12),
            .a13(a13),
            .a14(a14),
            .a15(a15) );            
            
    
    // ============================
    // Instantiate RAM (external)
    // ============================

    RAM RAM_inst (
            .clk(clk),
            .reset(reset),
            .ram_in_en(ram_in_en),
            .ram_in_addr(ram_addr),
            .bus_in(ram_data_out),
            .bus_out(ram_data_in),
    
            .start(start),
            .a0(a0),
            .a1(a1),
            .a2(a2),
            .a3(a3),
            .a4(a4),
            .a5(a5),
            .a6(a6),
            .a7(a7),
            .a8(a8),
            .a9(a9),
            .a10(a10),
            .a11(a11),
            .a12(a12),
            .a13(a13),
            .a14(a14),
            .a15(a15),
            .load_btn(load_btn)
        );
    
    // ============================
    // Instantiate external display
    // ============================

    binary_to_7seg_out outDisplay(
        .clk(clk_in),
        .bin(out_display),
        .seg(seg_out),
        .an(anode0_pins)
    );
    
    binary_to_7seg_pc pcDisplay(
        .clk(clk_in),
        .pcbin(pc_disp),
        .seg(seg_pc),
        .an(anode1_pins)
    );

endmodule
