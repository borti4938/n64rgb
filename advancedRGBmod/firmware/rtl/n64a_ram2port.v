//////////////////////////////////////////////////////////////////////////////////
//
// This file is part of the N64 RGB/YPbPr DAC project.
//
// Copyright (C) 2016-2018 by Peter Bartmann <borti4938@gmx.de>
//
// N64 RGB/YPbPr DAC is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
//
//////////////////////////////////////////////////////////////////////////////////
//
// Company:  Circuit-Board.de
// Engineer: borti4938
//
// Module Name:    n64a_ram2port
// Project Name:   N64 Advanced RGB/YPbPr DAC Mod
// Target Devices: Max10, Cyclone IV and Cyclone 10 LP devices
// Tool versions:  Altera Quartus Prime
// Description:    simple line-multiplying
//
// Revision: 1.1
// Features: ip independent implementation of a ram (two port)
//
//////////////////////////////////////////////////////////////////////////////////


module n64a_ram2port(
  wrCLK,
  wren,
  wrpage,
  wraddr,
  wrdata,
  
  rdCLK,
  rden,
  rdpage,
  rdaddr,
  rddata
);

parameter num_of_pages = 1;
parameter pagesize = 1024;
parameter data_width = 32;

`define PAGE_WIDTH  $clog2(num_of_pages)
`define ADDR_WIDTH  $clog2(pagesize)
`define MEM_SPACE   num_of_pages*pagesize
`define MEM_WIDTH   $clog2(`MEM_SPACE)

input                   wrCLK;
input                   wren;
input [`PAGE_WIDTH-1:0] wrpage;
input [`ADDR_WIDTH-1:0] wraddr;
input [ data_width-1:0] wrdata;

input                        rdCLK;
input                        rden;
input      [`PAGE_WIDTH-1:0] rdpage;
input      [`ADDR_WIDTH-1:0] rdaddr;
output reg [ data_width-1:0] rddata;


reg [data_width-1:0] data_buf[0:`MEM_SPACE-1];

reg                    wren_r = 1'b0;
reg [`MEM_WIDTH-1:0]  wrmem_r = {`MEM_WIDTH{1'b0}};
reg [data_width-1:0] wrdata_r = {data_width{1'b0}};

generate if ((num_of_pages != 2**`PAGE_WIDTH) && (pagesize != 2**`ADDR_WIDTH))
  always @(posedge wrCLK)
    if ((wrpage < num_of_pages) && (wraddr < pagesize))
      wren_r <= wren;
    else
      wren_r <= 1'b0;  // do not write to invalid input pages or addresses
else if (num_of_pages != 2**`PAGE_WIDTH)
  always @(posedge wrCLK)
    if (wrpage < num_of_pages)
      wren_r <= wren;
    else
      wren_r <= 1'b0;  // do not write to invalid input pages or addresses
else if (pagesize != 2**`ADDR_WIDTH)
  always @(posedge wrCLK)
    if (wraddr < pagesize)
      wren_r <= wren;
    else
      wren_r <= 1'b0;  // do not write to invalid input pages or addresses

else
  always @(posedge wrCLK)
    wren_r <= wren;
endgenerate

generate if (pagesize != 2**`ADDR_WIDTH) begin
  wire [31:0] wrpageoffset = (pagesize * wrpage);

  always @(posedge wrCLK)
    wrmem_r  <= wrpageoffset[`MEM_WIDTH-1:0] + wraddr;
end else
  always @(posedge wrCLK)
    wrmem_r  <= {wrpage,wraddr};
endgenerate

always @(posedge wrCLK) begin
  wrdata_r <= wrdata;
  if (wren_r)
    data_buf[wrmem_r] <= wrdata_r;
end


reg                   rden_r = 1'b0;
reg [`MEM_WIDTH-1:0] rdmem_r = {`MEM_WIDTH{1'b0}};

generate if ((num_of_pages != 2**`PAGE_WIDTH) && (pagesize != 2**`ADDR_WIDTH))
  always @(posedge wrCLK)
    if ((rdpage < num_of_pages) && (rdaddr < pagesize))
      rden_r <= rden;
    else
      rden_r <= 1'b0;  // do not read from invalid input pages or addresses
else if (num_of_pages != 2**`PAGE_WIDTH)
  always @(posedge wrCLK)
    if (rdpage < num_of_pages)
      rden_r <= rden;
    else
      rden_r <= 1'b0;  // do not write to invalid input pages or addresses
else if (pagesize != 2**`ADDR_WIDTH)
  always @(posedge wrCLK)
    if ((rdpage < num_of_pages) && (rdaddr < pagesize))
      rden_r <= rden;
    else
      rden_r <= 1'b0;  // do not read from invalid input pages or addresses
else
  always @(posedge wrCLK)
    rden_r <= rden;
endgenerate


generate if (pagesize != 2**`ADDR_WIDTH) begin
  wire [31:0] rdpageoffset = (pagesize * wrpage);

  always @(posedge wrCLK)
    rdmem_r <= rdpageoffset[`MEM_WIDTH-1:0] + rdaddr;
end else
  always @(posedge wrCLK)
    rdmem_r  <= {rdpage,rdaddr};
endgenerate

always @(posedge rdCLK) begin
  if (rden_r) begin
      rddata <= data_buf[rdmem_r];
  end
end

endmodule
