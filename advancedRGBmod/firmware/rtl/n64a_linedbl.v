//////////////////////////////////////////////////////////////////////////////////
// Company:  Circuit-Board.de
// Engineer: borti4938
//
// Module Name:    n64a_linedbl
// Project Name:   N64 Advanced RGB Mod
// Target Devices: Max10, Cyclone IV and Cyclone 10 LP devices
// Tool versions:  Altera Quartus Prime
// Description:    simple line-multiplying
//
// Dependencies: vh/n64a_params.vh
//               ip/ram2port_0.qip
//
// Revision: 1.1
// Features: linebuffer for - NTSC 240p -> 480p rate conversion
//                          - PAL  288p -> 576p rate conversion
//           injection of scanlines on demand in three selectable intensities
//
///////////////////////////////////////////////////////////////////////////////////////////


module n64a_linedbl(
  nCLK_4x,

  vinfo_dbl,

  vdata_i,
  vdata_o
);

`include "vh/n64a_params.vh"

localparam ram_depth = 11; // plus 1 due to oversampling

input nCLK_4x;

input [4:0] vinfo_dbl; // [nLinedbl,SL_str (2bits),PAL,interlaced]

input  [`vdata_i_full] vdata_i;
output [`vdata_o_full] vdata_o;


// pre-assignments

wire nVS_i = vdata_i[3*color_width_i+3];
wire nHS_i = vdata_i[3*color_width_i+1];

wire [color_width_i-1:0] R_i = vdata_i[`vdata_i_r];
wire [color_width_i-1:0] G_i = vdata_i[`vdata_i_g];
wire [color_width_i-1:0] B_i = vdata_i[`vdata_i_b];

reg               [3:0] S_o;
reg [color_width_o-1:0]    R_o;
reg [color_width_o-1:0]    G_o;
reg [color_width_o-1:0]    B_o;


// start of rtl

reg div_2x = 1'b0;

always @(negedge nCLK_4x) begin
  div_2x <= ~div_2x;
end

reg                 wrline = 1'b0;
reg [ram_depth-1:0] wraddr = {ram_depth{1'b0}};

wire wren = ~&{wraddr[ram_depth-1],wraddr[ram_depth-2],wraddr[ram_depth-5]};

reg [ram_depth-1:0] line_width[0:1];
initial begin
   line_width[1] = {ram_depth{1'b0}};
   line_width[0] = {ram_depth{1'b0}};
end

wire valid_line = &wraddr[ram_depth-1:ram_depth-2]; // hopefully enough for evaluation

reg           [1:0] rdrun    = 2'b00;
reg                 rdcnt    = 1'b0;
reg                 rdline   = 1'b0;
reg [ram_depth-1:0] rdaddr   = {ram_depth{1'b0}};

reg  nVS_i_buf = 1'b0;
reg  nHS_i_buf = 1'b0;


reg [1:0] newFrame       = 2'b0;
reg [1:0] start_reading_proc = 2'b00;


always @(negedge nCLK_4x) begin
  if (~div_2x) begin
    if (nVS_i_buf & ~nVS_i) begin
      newFrame[0] <= ~newFrame[1];
      if (&{nHS_i_buf,~nHS_i,wren,valid_line})
        start_reading_proc[0] <= ~start_reading_proc[1];  // trigger start reading
    end

    if (nHS_i_buf & ~nHS_i) begin // negedge nHSYNC -> reset wraddr and toggle wrline
      line_width[wrline] <= wraddr[ram_depth-1:0];

      wraddr <= {ram_depth{1'b0}};
      wrline <= ~wrline;
    end else if (wren) begin
      wraddr <= wraddr + 1'b1;
    end

    nVS_i_buf <= nVS_i;
    nHS_i_buf <= nHS_i;
  end
end

//wire pal_mode = vinfo_dbl[1];
//wire [ram_depth-1:0] line_width = pal_mode ? 11'd1588 : 11'd1546;

always @(negedge nCLK_4x) begin
  if (rdrun[1]) begin
    if (rdaddr == line_width[rdline]) begin
      rdaddr   <= {ram_depth{1'b0}};
      if (rdcnt)
//        rdline <= ~rdline;
        rdline <= ~wrline;
      rdcnt <= ~rdcnt;
    end else begin
      rdaddr <= rdaddr + 1'b1;
    end
    if (~wren || &{nHS_i_buf,~nHS_i,~valid_line}) begin
      rdrun <= 2'b00;
    end
  end else if (rdrun[0] && wraddr[3]) begin
    rdrun[1] <= 1'b1;
    rdcnt    <= 1'b0;
    rdline   <= ~wrline;
    rdaddr   <= {ram_depth{1'b0}};
  end else if (^start_reading_proc) begin
    rdrun[0] <= 1'b1;
  end

  start_reading_proc[1] <= start_reading_proc[0];
end

wire               [3:0] S_buf;
wire [color_width_i-1:0]    R_buf, G_buf, B_buf;

ram2port_0 videobuffer(
  .clock(~nCLK_4x),
  .data({R_i,G_i,B_i}),
  .rdaddress({rdline,rdaddr}),
  .wraddress({wrline,wraddr}),
  .wren(&{wren,~div_2x}),
  .q({R_buf,G_buf,B_buf})
);


wire       nHS_WIDTH = rdaddr[7];    // HSYNC width (effectively 64 pixel)
wire [1:0] nVS_WIDTH = 2'd3;         // three lines for VSYNC
wire   CS_post_VSYNC = &rdaddr[7:6];


reg        rdcnt_buf = 1'b0;
reg [1:0] nVS_cnt = 2'b0;

wire [1:0] SL_str = vinfo_dbl[3:2];
wire nENABLE_linedbl = vinfo_dbl[4] | ~rdrun[1];

always @(negedge nCLK_4x) begin

  if (rdcnt_buf ^ rdcnt) begin
    S_o[0] <= 1'b0;
    S_o[1] <= 1'b0;
    S_o[2] <= 1'b1; // dummy

    if (|nVS_cnt) begin
      nVS_cnt <= nVS_cnt - 1'b1;
      S_o[0]  <= 1'b1;
    end

    if (^newFrame) begin
      nVS_cnt  <= nVS_WIDTH;
      S_o[3]   <= 1'b0;
      newFrame[1] <= newFrame[0];
    end
  end else begin
    if (nHS_WIDTH) begin
      S_o[0] <= 1'b1;
      S_o[1] <= 1'b1;
      if (~S_o[3])
        S_o[0] <= 1'b0;
    end

    if ((~|nVS_cnt) && (CS_post_VSYNC)) begin
      S_o[0] <= 1'b1;
      S_o[3] <= 1'b1;
    end
  end

    rdcnt_buf <= rdcnt;

    if (rdcnt) begin
      case (SL_str)
        2'b11: begin
          R_o <= {R_buf,1'b0};
          G_o <= {G_buf,1'b0};
          B_o <= {B_buf,1'b0};
        end
        2'b10: begin
          R_o <= {1'b0,R_buf[color_width_i-1:0]} + {2'b00,R_buf[color_width_i-1:1]};
          G_o <= {1'b0,G_buf[color_width_i-1:0]} + {2'b00,G_buf[color_width_i-1:1]};
          B_o <= {1'b0,B_buf[color_width_i-1:0]} + {2'b00,B_buf[color_width_i-1:1]};
        end
        2'b01: begin
          R_o <= {1'b0,R_buf[color_width_i-1:0]};
          G_o <= {1'b0,G_buf[color_width_i-1:0]};
          B_o <= {1'b0,B_buf[color_width_i-1:0]};
        end
        2'b00: begin
          R_o <= {color_width_o{1'b0}};
          G_o <= {color_width_o{1'b0}};
          B_o <= {color_width_o{1'b0}};
        end
      endcase
    end else begin
      R_o <= {R_buf,1'b0};
      G_o <= {G_buf,1'b0};
      B_o <= {B_buf,1'b0};
    end

  if (nENABLE_linedbl) begin
    S_o <= vdata_i[`vdata_i_s];
    R_o <= {R_i,1'b0};
    G_o <= {G_i,1'b0};
    B_o <= {B_i,1'b0};
  end
end


// post-assignment

assign vdata_o = {S_o,R_o,G_o,B_o};

endmodule 