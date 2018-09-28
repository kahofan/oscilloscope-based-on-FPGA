`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/09 23:41:17
// Design Name: 
// Module Name: wavegenerator
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


module wavegenerator(
	input DCLK,
	input divclk,
	input [7:0]sw,
	input RESET,
	output [15:0]addr,
	output reg [15:0]color,
	output reg wea,
	input [15:0]MEASURED_TEMP,
	input [15:0]MEASURED_VCCINT,
	input [15:0]MEASURED_VCCBRAM,
	input [15:0]MEASURED_AUX6,
	input [15:0]MEASURED_AUX7,
	input [15:0]MEASURED_AUX14,
	input [15:0]MEASURED_AUX15
    );
	reg [7:0]wave[0:299];
	reg [7:0]npv;
	reg [8:0]row, col;
	reg [3:0]cnt = 0;
	reg [9:0]divcnt = 0;
	initial begin
		row = 0;
		col = 0;
		color = 0;
		wea = 0;
	end
	assign addr = row * 300 + col;
	always@(negedge DCLK) begin
		if(cnt == 12) begin
			cnt = cnt;
		end
		else begin
			if(cnt == 6) begin
				wea = 1;
			end
			else begin
				wea = wea;
			end
			cnt = cnt + 1;
		end
	end
	always@(negedge DCLK) begin
		if(RESET) begin
			color = 0;
			row = 0;
			col = 0;
		end
		else begin
			if(cnt == 12) begin
				if(col == 299) begin
					col = 0;
					if(row == 199) begin
						row = 0;
					end
					else begin
						row = row + 1;
					end
				end
				else begin
					col = col + 1;
				end
			end
			if(wave[col] == row) begin
				color = 12'h00f;
			end
			else begin
				if((row == 190) || (row == 62)) begin
					color = 12'h0f0;
				end
				else begin
					color = 12'hfff;
				end
			end
		end
	end
	always@(posedge divclk) begin
		if(divcnt == 300) begin
			divcnt <= divcnt;
		end
		else begin
			divcnt <= divcnt + 1;
		end
		casex(sw[7:0])
			8'b0000_0001: begin
				npv = MEASURED_TEMP[15:9];
			end
			8'b0000_001X: begin
				npv = MEASURED_VCCINT[15:9];
			end
			8'b0000_01XX: begin
				npv = MEASURED_VCCBRAM[15:9];
			end
			8'b0000_1XXX: begin
				npv = MEASURED_AUX6[15:9];
			end
			8'b0001_XXXX: begin
				npv = MEASURED_AUX7[15:9];
			end
			8'b001X_XXXX: begin
				npv = MEASURED_AUX14[15:9];
			end
			8'b01XX_XXXX: begin
				npv = MEASURED_AUX15[15:9];
			end
			default: begin
				npv = 0;
			end
		endcase
		npv = 190 - npv;
		if(divcnt <= 299) begin
			wave[divcnt] <= npv;
		end
		else begin
			wave[0] <= wave[1];
			wave[1] <= wave[2];
			wave[2] <= wave[3];
			wave[3] <= wave[4];
			wave[4] <= wave[5];
			wave[5] <= wave[6];
			wave[6] <= wave[7];
			wave[7] <= wave[8];
			wave[8] <= wave[9];
			wave[9] <= wave[10];
			wave[10] <= wave[11];
			wave[11] <= wave[12];
			wave[12] <= wave[13];
			wave[13] <= wave[14];
			wave[14] <= wave[15];
			wave[15] <= wave[16];
			wave[16] <= wave[17];
			wave[17] <= wave[18];
			wave[18] <= wave[19];
			wave[19] <= wave[20];
			wave[20] <= wave[21];
			wave[21] <= wave[22];
			wave[22] <= wave[23];
			wave[23] <= wave[24];
			wave[24] <= wave[25];
			wave[25] <= wave[26];
			wave[26] <= wave[27];
			wave[27] <= wave[28];
			wave[28] <= wave[29];
			wave[29] <= wave[30];
			wave[30] <= wave[31];
			wave[31] <= wave[32];
			wave[32] <= wave[33];
			wave[33] <= wave[34];
			wave[34] <= wave[35];
			wave[35] <= wave[36];
			wave[36] <= wave[37];
			wave[37] <= wave[38];
			wave[38] <= wave[39];
			wave[39] <= wave[40];
			wave[40] <= wave[41];
			wave[41] <= wave[42];
			wave[42] <= wave[43];
			wave[43] <= wave[44];
			wave[44] <= wave[45];
			wave[45] <= wave[46];
			wave[46] <= wave[47];
			wave[47] <= wave[48];
			wave[48] <= wave[49];
			wave[49] <= wave[50];
			wave[50] <= wave[51];
			wave[51] <= wave[52];
			wave[52] <= wave[53];
			wave[53] <= wave[54];
			wave[54] <= wave[55];
			wave[55] <= wave[56];
			wave[56] <= wave[57];
			wave[57] <= wave[58];
			wave[58] <= wave[59];
			wave[59] <= wave[60];
			wave[60] <= wave[61];
			wave[61] <= wave[62];
			wave[62] <= wave[63];
			wave[63] <= wave[64];
			wave[64] <= wave[65];
			wave[65] <= wave[66];
			wave[66] <= wave[67];
			wave[67] <= wave[68];
			wave[68] <= wave[69];
			wave[69] <= wave[70];
			wave[70] <= wave[71];
			wave[71] <= wave[72];
			wave[72] <= wave[73];
			wave[73] <= wave[74];
			wave[74] <= wave[75];
			wave[75] <= wave[76];
			wave[76] <= wave[77];
			wave[77] <= wave[78];
			wave[78] <= wave[79];
			wave[79] <= wave[80];
			wave[80] <= wave[81];
			wave[81] <= wave[82];
			wave[82] <= wave[83];
			wave[83] <= wave[84];
			wave[84] <= wave[85];
			wave[85] <= wave[86];
			wave[86] <= wave[87];
			wave[87] <= wave[88];
			wave[88] <= wave[89];
			wave[89] <= wave[90];
			wave[90] <= wave[91];
			wave[91] <= wave[92];
			wave[92] <= wave[93];
			wave[93] <= wave[94];
			wave[94] <= wave[95];
			wave[95] <= wave[96];
			wave[96] <= wave[97];
			wave[97] <= wave[98];
			wave[98] <= wave[99];
			wave[99] <= wave[100];
			wave[100] <= wave[101];
			wave[101] <= wave[102];
			wave[102] <= wave[103];
			wave[103] <= wave[104];
			wave[104] <= wave[105];
			wave[105] <= wave[106];
			wave[106] <= wave[107];
			wave[107] <= wave[108];
			wave[108] <= wave[109];
			wave[109] <= wave[110];
			wave[110] <= wave[111];
			wave[111] <= wave[112];
			wave[112] <= wave[113];
			wave[113] <= wave[114];
			wave[114] <= wave[115];
			wave[115] <= wave[116];
			wave[116] <= wave[117];
			wave[117] <= wave[118];
			wave[118] <= wave[119];
			wave[119] <= wave[120];
			wave[120] <= wave[121];
			wave[121] <= wave[122];
			wave[122] <= wave[123];
			wave[123] <= wave[124];
			wave[124] <= wave[125];
			wave[125] <= wave[126];
			wave[126] <= wave[127];
			wave[127] <= wave[128];
			wave[128] <= wave[129];
			wave[129] <= wave[130];
			wave[130] <= wave[131];
			wave[131] <= wave[132];
			wave[132] <= wave[133];
			wave[133] <= wave[134];
			wave[134] <= wave[135];
			wave[135] <= wave[136];
			wave[136] <= wave[137];
			wave[137] <= wave[138];
			wave[138] <= wave[139];
			wave[139] <= wave[140];
			wave[140] <= wave[141];
			wave[141] <= wave[142];
			wave[142] <= wave[143];
			wave[143] <= wave[144];
			wave[144] <= wave[145];
			wave[145] <= wave[146];
			wave[146] <= wave[147];
			wave[147] <= wave[148];
			wave[148] <= wave[149];
			wave[149] <= wave[150];
			wave[150] <= wave[151];
			wave[151] <= wave[152];
			wave[152] <= wave[153];
			wave[153] <= wave[154];
			wave[154] <= wave[155];
			wave[155] <= wave[156];
			wave[156] <= wave[157];
			wave[157] <= wave[158];
			wave[158] <= wave[159];
			wave[159] <= wave[160];
			wave[160] <= wave[161];
			wave[161] <= wave[162];
			wave[162] <= wave[163];
			wave[163] <= wave[164];
			wave[164] <= wave[165];
			wave[165] <= wave[166];
			wave[166] <= wave[167];
			wave[167] <= wave[168];
			wave[168] <= wave[169];
			wave[169] <= wave[170];
			wave[170] <= wave[171];
			wave[171] <= wave[172];
			wave[172] <= wave[173];
			wave[173] <= wave[174];
			wave[174] <= wave[175];
			wave[175] <= wave[176];
			wave[176] <= wave[177];
			wave[177] <= wave[178];
			wave[178] <= wave[179];
			wave[179] <= wave[180];
			wave[180] <= wave[181];
			wave[181] <= wave[182];
			wave[182] <= wave[183];
			wave[183] <= wave[184];
			wave[184] <= wave[185];
			wave[185] <= wave[186];
			wave[186] <= wave[187];
			wave[187] <= wave[188];
			wave[188] <= wave[189];
			wave[189] <= wave[190];
			wave[190] <= wave[191];
			wave[191] <= wave[192];
			wave[192] <= wave[193];
			wave[193] <= wave[194];
			wave[194] <= wave[195];
			wave[195] <= wave[196];
			wave[196] <= wave[197];
			wave[197] <= wave[198];
			wave[198] <= wave[199];
			wave[199] <= wave[200];
			wave[200] <= wave[201];
			wave[201] <= wave[202];
			wave[202] <= wave[203];
			wave[203] <= wave[204];
			wave[204] <= wave[205];
			wave[205] <= wave[206];
			wave[206] <= wave[207];
			wave[207] <= wave[208];
			wave[208] <= wave[209];
			wave[209] <= wave[210];
			wave[210] <= wave[211];
			wave[211] <= wave[212];
			wave[212] <= wave[213];
			wave[213] <= wave[214];
			wave[214] <= wave[215];
			wave[215] <= wave[216];
			wave[216] <= wave[217];
			wave[217] <= wave[218];
			wave[218] <= wave[219];
			wave[219] <= wave[220];
			wave[220] <= wave[221];
			wave[221] <= wave[222];
			wave[222] <= wave[223];
			wave[223] <= wave[224];
			wave[224] <= wave[225];
			wave[225] <= wave[226];
			wave[226] <= wave[227];
			wave[227] <= wave[228];
			wave[228] <= wave[229];
			wave[229] <= wave[230];
			wave[230] <= wave[231];
			wave[231] <= wave[232];
			wave[232] <= wave[233];
			wave[233] <= wave[234];
			wave[234] <= wave[235];
			wave[235] <= wave[236];
			wave[236] <= wave[237];
			wave[237] <= wave[238];
			wave[238] <= wave[239];
			wave[239] <= wave[240];
			wave[240] <= wave[241];
			wave[241] <= wave[242];
			wave[242] <= wave[243];
			wave[243] <= wave[244];
			wave[244] <= wave[245];
			wave[245] <= wave[246];
			wave[246] <= wave[247];
			wave[247] <= wave[248];
			wave[248] <= wave[249];
			wave[249] <= wave[250];
			wave[250] <= wave[251];
			wave[251] <= wave[252];
			wave[252] <= wave[253];
			wave[253] <= wave[254];
			wave[254] <= wave[255];
			wave[255] <= wave[256];
			wave[256] <= wave[257];
			wave[257] <= wave[258];
			wave[258] <= wave[259];
			wave[259] <= wave[260];
			wave[260] <= wave[261];
			wave[261] <= wave[262];
			wave[262] <= wave[263];
			wave[263] <= wave[264];
			wave[264] <= wave[265];
			wave[265] <= wave[266];
			wave[266] <= wave[267];
			wave[267] <= wave[268];
			wave[268] <= wave[269];
			wave[269] <= wave[270];
			wave[270] <= wave[271];
			wave[271] <= wave[272];
			wave[272] <= wave[273];
			wave[273] <= wave[274];
			wave[274] <= wave[275];
			wave[275] <= wave[276];
			wave[276] <= wave[277];
			wave[277] <= wave[278];
			wave[278] <= wave[279];
			wave[279] <= wave[280];
			wave[280] <= wave[281];
			wave[281] <= wave[282];
			wave[282] <= wave[283];
			wave[283] <= wave[284];
			wave[284] <= wave[285];
			wave[285] <= wave[286];
			wave[286] <= wave[287];
			wave[287] <= wave[288];
			wave[288] <= wave[289];
			wave[289] <= wave[290];
			wave[290] <= wave[291];
			wave[291] <= wave[292];
			wave[292] <= wave[293];
			wave[293] <= wave[294];
			wave[294] <= wave[295];
			wave[295] <= wave[296];
			wave[296] <= wave[297];
			wave[297] <= wave[298];
			wave[298] <= wave[299];
			wave[299] <= npv;
		end
	end
endmodule
