`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/11 17:19:54
// Design Name: 
// Module Name: v_vga
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module v_vga(
	input clk_vga,
	input [11:0]colour,
	output Hsync,
	output Vsync,
	output [3:0]vgaRed,
	output [3:0]vgaGreen,
	output [3:0]vgaBlue,
	output reg [15:0]addr,
	output reg enb
    );
	parameter ta = 80, tb = 160, tc = 800, td = 16, te = 1056, to = 3, tp = 21, tq = 600, tr = 1, ts = 625;
	reg [10:0]x_counter = 0;
	reg [10:0]y_counter = 0;
	reg [11:0]colour1 = 0;
	always@(negedge clk_vga) begin
		if(x_counter == te - 1) begin
			x_counter = 0;
			if(y_counter == ts - 1) begin
				y_counter = 0;
			end
			else begin
				y_counter = y_counter + 1;
			end
		end
		else begin
			x_counter = x_counter + 1;
			if((y_counter >= (to + tp)) && (y_counter < (to + tp + 200))) begin
				if((x_counter >= (ta + tb - 2)) && (x_counter < (ta + tb + 300))) begin
					if(x_counter >= (ta + tb + 298)) begin
						addr = addr;
					end
					else begin
						addr = addr + 1;
					end
					enb = 1;
					if(x_counter >= (ta + tb)) begin
						colour1 = colour;
					end
					else begin
						colour1 = 12'h000;
					end
				end
				else begin
					enb = 0;
					addr = addr;
					colour1 = 12'h000;
				end
			end
			else begin
				addr = 16'hffff;
				enb = 0;
				colour1 = 12'h000;
			end
		end
	end
	assign vgaRed[3:0] = colour1[11:8];
	assign vgaGreen[3:0] = colour1[7:4];
	assign vgaBlue[3:0] = colour1[3:0];
	assign Hsync = !(x_counter < ta);
	assign Vsync = !(y_counter < to);
endmodule
