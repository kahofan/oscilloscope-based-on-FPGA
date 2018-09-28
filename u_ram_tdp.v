`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/08 13:28:47
// Design Name: 
// Module Name: u_ram_tdp
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


module u_ram_tdp(
    input clk,
    input wea,
    input [15:0]ramaddra,
    input [15:0]ramdina,
    input enb,
    input [15:0]ramaddrb,
    output [15:0]ramdouta,
    output [15:0]ramdoutb
    );
    blk_mem_gen_0 uut_ram(
    .clka(clk),
    .ena(1),
    .wea(wea),
    .addra(ramaddra),
    .dina(ramdina),
    .douta(ramdouta),
    .clkb(clk),
    .enb(enb),
    .web(0),
    .addrb(ramaddrb),
    .dinb(0),
    .doutb(ramdoutb)
    );
endmodule
