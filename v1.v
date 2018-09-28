`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/07 16:39:05
// Design Name: 
// Module Name: v1
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


module v1(
	input clk,//
	input vauxp6, vauxn6,
	input vauxp7, vauxn7,
	input vauxp14, vauxn14,
	input vauxp15, vauxn15,
	input rst,//
	input [7:0]sw,//
	output Hsync,//
	output Vsync,//
	output [3:0]vgaRed,//
	output [3:0]vgaGreen,//
	output [3:0]vgaBlue//
    );
	wire [15:0]MEASURED_TEMP;
	wire [15:0]MEASURED_VCCINT;
	wire [15:0]MEASURED_VCCBRAM;
	wire [15:0]MEASURED_AUX6, MEASURED_AUX7, MEASURED_AUX14, MEASURED_AUX15;
	wire [15:0]addr;
	wire [15:0]addrb;
	wire [15:0]color;
	wire [11:0]colorvga;
	wire wea;
	reg divclk1khz = 0;
	reg [31:0]divclk1khz_cnt = 0;
	always@(posedge clk) begin
		if(divclk1khz_cnt == 25000) begin
			divclk1khz = ~divclk1khz;
			divclk1khz_cnt = 0;
		end
		else begin
			divclk1khz_cnt = divclk1khz_cnt + 1'b1;
		end
	end
	wire clk_vga;
	clk_wiz_0 vgaclk(
	.clk_in1(clk),
	.clk_vga(clk_vga)
	);
	ila_0 u_ila1(
	.clk(clk),
	.probe0(colorvga),
	.probe1(addrb),
	.probe2(MEASURED_TEMP[15:4]),
	.probe3(enb),
	.probe4(wea)
	);
	v_xadc1_0 myxadc(
	.DCLK(clk),//50mhz
	.RESET(rst),
	.VAUXP6(vauxp6),
	.VAUXN6(vauxn6),
	.VAUXP7(vauxp7),
	.VAUXN7(vauxn7),
	.VAUXP14(vauxp14),
	.VAUXN14(vauxn14),
	.VAUXP15(vauxp15),
	.VAUXN15(vauxn15),
	.MEASURED_TEMP(MEASURED_TEMP),
	.MEASURED_VCCINT(MEASURED_VCCINT),
	.MEASURED_VCCBRAM(MEASURED_VCCBRAM),
	.MEASURED_AUX6(MEASURED_AUX6),
	.MEASURED_AUX7(MEASURED_AUX7),
	.MEASURED_AUX14(MEASURED_AUX14),
	.MEASURED_AUX15(MEASURED_AUX15)
	);
	wavegenerator wg(
	.DCLK(clk),//50mhz
	.divclk(divclk1khz),//1000hz!!
	.sw(sw),
	.RESET(rst),
	.MEASURED_TEMP(MEASURED_TEMP),
	.MEASURED_VCCINT(MEASURED_VCCINT),
	.MEASURED_VCCBRAM(MEASURED_VCCBRAM),
	.MEASURED_AUX6(MEASURED_AUX6),
	.MEASURED_AUX7(MEASURED_AUX7),
	.MEASURED_AUX14(MEASURED_AUX14),
	.MEASURED_AUX15(MEASURED_AUX15),
	.addr(addr),
	.color(color),
	.wea(wea)
	);
	u_ram_tdp ram(
	.clk(clk),
	.wea(wea),
	.ramaddra(addr),
	.ramdina(color),
	.enb(enb),
	.ramaddrb(addrb),
	.ramdouta(),
	.ramdoutb(colorvga)
	);
	v_vga myvga(
	.clk_vga(clk_vga),
	.colour(colorvga),
	.Hsync(Hsync),
	.Vsync(Vsync),
	.vgaRed(vgaRed),
	.vgaGreen(vgaGreen),
	.vgaBlue(vgaBlue),
	.addr(addrb),
	.enb(enb)
	);
endmodule
