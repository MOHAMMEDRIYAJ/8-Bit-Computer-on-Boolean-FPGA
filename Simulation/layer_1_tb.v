module tb_cpu_top();
	reg clk,reset,start,load_btn,inp_loaded;
	reg [2:0] prog_load;
	reg [3:0] sw_data;
	reg [7:0] enter_data;
	wire inp_req;
	wire [18:0] sig_out;
	wire [7:0] bin_display;
	wire [3:0] pc_out;
	
	cpu_top dut(clk,reset,start,prog_load,sw_data,enter_data,load_btn,inp_loaded,inp_req,sig_out,bin_display,pc_out);
	
	initial clk = 0;
	always #5 clk = ~clk;
	
	task initialize;
	begin
		{reset,start,prog_load,sw_data,load_btn,inp_loaded,enter_data} = 0;
	end
	endtask 
	
	task Reset;
	begin	
		@(negedge clk) reset = 1;
		@(negedge clk) reset = 0;
	end
	endtask 
	
	task Layer(input [2:0] layer);
	begin 
		@(negedge clk) prog_load = layer;
	end
	endtask
	
	task Manual_Address (input [3:0] addr);
	begin	
		@(negedge clk) sw_data = addr;
	end
	endtask
	
	task Manual(input [7:0] data);
	begin	
		@(negedge clk) enter_data = data;
	end
	endtask 
	
	task Input_data (input [7:0] inp_data);
	begin	
		@(negedge clk) enter_data = inp_data;
	end
	endtask
	
	task Start;
	begin
		@(negedge clk) start = 1;
		@(negedge clk) start = 0;
	end
	endtask
	
	task Input_load;
	begin
		@(negedge clk) inp_loaded = 1;
		@(negedge clk) inp_loaded = 0;
	end
	endtask
	
	task Layer_load;
	begin
		@(negedge clk) load_btn = 1;
		@(negedge clk) load_btn = 0;
	end
	endtask
	
	initial begin 
		$monitor("Time=%0t | Reset=%b | Layer=%b | Layer_Load=%b | Start=%b | Output=%b | Halt=%b",$time , reset,prog_load,load_btn,start,bin_display,sig_out[14]);
		initialize;
		Reset;
		Layer(3'b000);
		Layer_load;
		Start;
		#1000;$finish;
	end
		
endmodule