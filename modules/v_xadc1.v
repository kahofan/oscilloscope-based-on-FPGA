`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/08 22:55:47
// Design Name: 
// Module Name: v_xadc1
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


module v_xadc1(
	input DCLK,
	input RESET,
	input VAUXP6, VAUXN6,
	input VAUXP7, VAUXN7,
	input VAUXP14, VAUXN14,
	input VAUXP15, VAUXN15,
	output reg [15:0]MEASURED_TEMP, MEASURED_VCCINT,
	output reg [15:0]MEASURED_VCCBRAM,
	output reg [15:0]MEASURED_AUX6, MEASURED_AUX7,
	output reg [15:0]MEASURED_AUX14, MEASURED_AUX15
);
	wire [4:0]CHANNEL;
	wire OT;
	wire XADC_EOC;
	wire XADC_EOS;
	wire busy;
	wire [4:0]channel;
	wire drdy;
	reg [6:0]daddr;
	reg [15:0]di_drp;
	wire [15:0]do_drp;
	wire [15:0]aux_channel_p;
	wire [15:0]aux_channel_n;
	reg [1:0]den_reg;
	reg [1:0]dwe_reg;
	reg [7:0]state;
	reg r_reset = 0;
	parameter init_read = 8'h00,
		read_waitdrdy = 8'h01,
		write_waitdrdy = 8'h03,
		read_reg00 = 8'h04,
		reg00_waitdrdy = 8'h05,
		read_reg01 = 8'h06,
		reg01_waitdrdy = 8'h07,
		read_reg02 = 8'h08,
		reg02_waitdrdy = 8'h09,
		read_reg03 = 8'h0a,
		reg03_waitdrdy = 8'h0b,
		read_reg04 = 8'h0c,
		reg04_waitdrdy = 8'h0d,
		read_reg05 = 8'h0e,
		reg05_waitdrdy = 8'h0f,
		read_reg06 = 8'h10,
		reg06_waitdrdy = 8'h11,
		read_reg07 = 8'h12,
		reg07_waitdrdy = 8'h13,
		read_reg08 = 8'h14,
		reg08_waitdrdy = 8'h15,
		read_reg09 = 8'h16,
		reg09_waitdrdy = 8'h17,
		read_reg0a = 8'h18,
		reg0a_waitdrdy = 8'h19,
		read_reg0b = 8'h1a,
		reg0b_waitdrdy = 8'h1b,
		read_reg0c = 8'h1c,
		reg0c_waitdrdy = 8'h1d,
		read_reg0d = 8'h1e,
		reg0d_waitdrdy = 8'h1f,
		read_reg0e = 8'h20,
		reg0e_waitdrdy = 8'h21,
		read_reg0f = 8'h22,
		reg0f_waitdrdy = 8'h23,
		read_reg10 = 8'h24,
		reg10_waitdrdy = 8'h25,
		read_reg11 = 8'h26,
		reg11_waitdrdy = 8'h27,
		read_reg12 = 8'h28,
		reg12_waitdrdy = 8'h29,
		read_reg13 = 8'h2a,
		reg13_waitdrdy = 8'h2b,
		read_reg14 = 8'h2c,
		reg14_waitdrdy = 8'h2d,
		read_reg15 = 8'h2e,
		reg15_waitdrdy = 8'h2f,
		read_reg16 = 8'h30,
		reg16_waitdrdy = 8'h31,
		read_reg17 = 8'h32,
		reg17_waitdrdy = 8'h33,
		read_reg18 = 8'h34,
		reg18_waitdrdy = 8'h35,
		read_reg19 = 8'h36,
		reg19_waitdrdy = 8'h37,
		read_reg1a = 8'h38,
		reg1a_waitdrdy = 8'h39,
		read_reg1b = 8'h3a,
		reg1b_waitdrdy = 8'h3b,
		read_reg1c = 8'h3c,
		reg1c_waitdrdy = 8'h3d,
		read_reg1d = 8'h3e,
		reg1d_waitdrdy = 8'h3f,
		read_reg1e = 8'h40,
		reg1e_waitdrdy = 8'h41,
		read_reg1f = 8'h42,
		reg1f_waitdrdy = 8'h43,
		read_reg20 = 8'h44,
		reg20_waitdrdy = 8'h45,
		read_reg21 = 8'h46,
		reg21_waitdrdy = 8'h47,
		read_reg22 = 8'h48,
		reg22_waitdrdy = 8'h49,
		read_reg23 = 8'h4a,
		reg23_waitdrdy = 8'h4b,
		read_reg24 = 8'h4c,
		reg24_waitdrdy = 8'h4d,
		read_reg25 = 8'h4e,
		reg25_waitdrdy = 8'h4f,
		read_reg26 = 8'h50,
		reg26_waitdrdy = 8'h51,
		read_reg27 = 8'h52,
		reg27_waitdrdy = 8'h53,
		read_reg28 = 8'h54,
		reg28_waitdrdy = 8'h55,
		read_reg29 = 8'h56,
		reg29_waitdrdy = 8'h57,
		read_reg2a = 8'h58,
		reg2a_waitdrdy = 8'h59,
		read_reg2b = 8'h5a,
		reg2b_waitdrdy = 8'h5b,
		read_reg2c = 8'h5c,
		reg2c_waitdrdy = 8'h5d,
		read_reg2d = 8'h5e,
		reg2d_waitdrdy = 8'h5f,
		read_reg2e = 8'h60,
		reg2e_waitdrdy = 8'h61,
		read_reg2f = 8'h62,
		reg2f_waitdrdy = 8'h63,
		read_reg30 = 8'h64,
		reg30_waitdrdy = 8'h65,
		read_reg31 = 8'h66,
		reg31_waitdrdy = 8'h67,
		read_reg32 = 8'h68,
		reg32_waitdrdy = 8'h69,
		read_reg33 = 8'h6a,
		reg33_waitdrdy = 8'h6b,
		read_reg34 = 8'h6c,
		reg34_waitdrdy = 8'h6d,
		read_reg35 = 8'h6e,
		reg35_waitdrdy = 8'h6f,
		read_reg36 = 8'h70,
		reg36_waitdrdy = 8'h71,
		read_reg37 = 8'h72,
		reg37_waitdrdy = 8'h73,
		read_reg38 = 8'h74,
		reg38_waitdrdy = 8'h75,
		read_reg39 = 8'h76,
		reg39_waitdrdy = 8'h77,
		read_reg3a = 8'h78,
		reg3a_waitdrdy = 8'h79,
		read_reg3b = 8'h7a,
		reg3b_waitdrdy = 8'h7b,
		read_reg3c = 8'h7c,
		reg3c_waitdrdy = 8'h7d,
		read_reg3d = 8'h7e,
		reg3d_waitdrdy = 8'h7f,
		read_reg3e = 8'h80,
		reg3e_waitdrdy = 8'h81,
		read_reg3f = 8'h82,
		reg3f_waitdrdy = 8'h83;
		initial begin
			state = init_read;
		end
	xadc_wiz_0 xadc1(
		.daddr_in(daddr),
		.dclk_in(DCLK),
		.den_in(den_reg),
		.di_in(di_drp),
		.dwe_in(dwe_reg),
		.reset_in(RESET),
		.vauxp6(VAUXP6),
		.vauxn6(VAUXN6),
		.vauxn7(VAUXN7),
		.vauxp7(VAUXP7),
		.vauxn14(VAUXN14),
		.vauxp14(VAUXP14),
		.vauxn15(VAUXN15),
		.vauxp15(VAUXP15),
		.busy_out(busy),
		.channel_out(channel),
		.do_out(do_drp),
		.drdy_out(drdy),
		.eoc_out(XADC_EOC),
		.eos_out(XADC_EOS),
		.vp_in(),
		.vn_in()
	);
	always@(posedge DCLK) begin
		if(RESET) begin
			state = init_read;
			den_reg = 0;
			dwe_reg = 0;
			di_drp = 16'h0000;
		end
		else begin
			case(state)
				init_read: begin
					daddr = 7'h40;
					den_reg = 2'h2;
					if(busy == 0) begin
						state <= read_waitdrdy;
					end
				end
				read_waitdrdy: begin
					if(drdy == 1) begin
						di_drp = do_drp & 16'h03_FF;
						daddr = 7'h40;
						den_reg = 2'h2;
						dwe_reg = 2'h2;
						state = write_waitdrdy;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				write_waitdrdy: begin
					if(drdy == 1) begin
						state = read_reg00;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg00: begin
					daddr = 7'h00;
					den_reg = 2'h2;
					if(XADC_EOS == 1) begin
						state <= reg00_waitdrdy;
					end
				end
				reg00_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_TEMP = do_drp;
						state <= read_reg01;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg01: begin
					daddr = 7'h01;
					den_reg = 2'h2;
					state <= reg01_waitdrdy;
				end
				reg01_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_VCCINT = do_drp;
						state <= read_reg06;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg06: begin
					daddr = 7'h06;
					den_reg = 2'h2;
					state <= reg06_waitdrdy;
				end
				reg06_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_VCCBRAM = do_drp;
						state <= read_reg16;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg16: begin
					daddr = 7'h16;
					den_reg = 2'h2;
					state <= reg16_waitdrdy;
				end
				reg16_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_AUX6 = do_drp;
						state <= read_reg17;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg17: begin
					daddr = 7'h17;
					den_reg = 2'h2;
					state <= reg17_waitdrdy;
				end
				reg17_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_AUX7 = do_drp;
						state <= read_reg1e;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg1e: begin
					daddr = 7'h1e;
					den_reg = 2'h2;
					state <= reg1e_waitdrdy;
				end
				reg1e_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_AUX14 = do_drp;
						state <= read_reg1f;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
				read_reg1f: begin
					daddr = 7'h1f;
					den_reg = 2'h2;
					state <= reg1f_waitdrdy;
				end
				reg1f_waitdrdy: begin
					if(drdy == 1) begin
						MEASURED_AUX15 = do_drp;
						state <= read_reg00;
						daddr = 7'h00;
					end
					else begin
						den_reg = {1'b0, den_reg[1]};
						dwe_reg = {1'b0, dwe_reg[1]};
						state = state;
					end
				end
			endcase
		end
	end
endmodule
