/*********************************************************************************
 *
 * This file is part of the N64 RGB/YPbPr DAC project.
 *
 * Copyright (C) 2016-2018 by Peter Bartmann <borti4938@gmx.de>
 *
 * N64 RGB/YPbPr DAC is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 *********************************************************************************
 *
 * config.h
 *
 *  Created on: 11.01.2018
 *      Author: Peter Bartmann
 *
 ********************************************************************************/

#ifndef CONFIG_H_
#define CONFIG_H_


#include "alt_types.h"
#include "altera_avalon_pio_regs.h"
#include "system.h"


typedef enum {
  VIDEO = 0,
  IMAGE,
  MISC,
  MENU
} cfg_word_type_t;

#define NUM_CFG_WORDS 4

typedef struct {
  const cfg_word_type_t cfg_word_type;
  const alt_u8          cfg_word_mask;
  alt_u8                cfg_word_val;
  alt_u8                cfg_ref_word_val;
} cfg_word_t;

typedef struct {
  cfg_word_t* cfg_word_def[NUM_CFG_WORDS];
} configuration_t;

typedef enum {
  FLAG,
  VALUE
} config_type_t;

typedef struct {
  alt_u8 setflag_mask;
  alt_u8 clrflag_mask;
} config_flag_t;

typedef struct {
  alt_u8 max_value;
  alt_u8 getvalue_mask;
} config_value_t;

typedef struct {
  cfg_word_t          *cfg_word;
  const alt_u8        cfg_word_offset;
  const config_type_t cfg_type;
  union {
    const config_flag_t  flag_masks;
    const config_value_t value_details;
  };
  const char*         *value_string;
} config_t;

#define CFG_VERSION_INVALID 100

// the overall masks
#define CFG_VIDEO_GETALL_MASK 0x33
#define CFG_IMAGE_GETALL_MASK 0xF3
#define CFG_MISC_GETALL_MASK  0x1F
#define CFG_MENU_GETALL_MASK  0x08

#define CFG_GETALL_MASK       ((CFG_VIDEO_GETALL_MASK << (8*VIDEO)) | \
                               (CFG_IMAGE_GETALL_MASK << (8*IMAGE)) | \
                               (CFG_MISC_GETALL_MASK  << (8*MISC) ) | \
                               (CFG_MENU_GETALL_MASK  << (8*MENU) )   )

// video
#define CFG_LINEX2_OFFSET   5
#define CFG_480IBOB_OFFSET  4
#define CFG_VFORMAT_OFFSET  0
  #define CFG_YPBPR_OFFSET    1
  #define CFG_RGSB_OFFSET     0

#define CFG_LINEX2_GETMASK        (1<<CFG_LINEX2_OFFSET)
#define CFG_LINEX2_SETMASK        (1<<CFG_LINEX2_OFFSET)
#define CFG_LINEX2_CLRMASK        (CFG_VIDEO_GETALL_MASK & ~CFG_LINEX2_SETMASK)
#define CFG_480IBOB_GETMASK       (1<<CFG_480IBOB_OFFSET)
#define CFG_480IBOB_SETMASK       (1<<CFG_480IBOB_OFFSET)
#define CFG_480IBOB_CLRMASK       (CFG_VIDEO_GETALL_MASK & ~CFG_480IBOB_SETMASK)
#define CFG_VFORMAT_GETMASK       (3<<CFG_VFORMAT_OFFSET)
#define CFG_VFORMAT_RSTMASK       (CFG_VIDEO_GETALL_MASK & ~CFG_VFORMAT_GETMASK)
#define CFG_VFORMAT_CLRMASK       (CFG_VIDEO_GETALL_MASK & ~CFG_VFORMAT_GETMASK)
  #define CFG_YPBPR_GETMASK         (1<<CFG_YPBPR_OFFSET)
  #define CFG_YPBPR_SETMASK         (1<<CFG_YPBPR_OFFSET)
  #define CFG_YPBPR_CLRMASK         (CFG_VIDEO_GETALL_MASK & ~CFG_YPBPR_SETMASK)
  #define CFG_RGSB_GETMASK          (1<<CFG_RGSB_OFFSET)
  #define CFG_RGSB_SETMASK          (1<<CFG_RGSB_OFFSET)
  #define CFG_RGSB_CLRMASK          (CFG_GETALL_MASK & ~CFG_RGSB_SETMASK)

// image
#define CFG_GAMMA_OFFSET  4
#define CFG_SLSTR_OFFSET  0
  #define CFG_SLMSB_OFFSET  1
  #define CFG_SLLSB_OFFSET  0

#define CFG_GAMMA_GETMASK         (0xF<<CFG_GAMMA_OFFSET)
  #define CFG_GAMMASEL_RSTMASK      (CFG_IMAGE_GETALL_MASK & ~CFG_GAMMA_GETMASK)
#define CFG_GAMMA_CLRMASK         (CFG_IMAGE_GETALL_MASK & ~CFG_GAMMA_GETMASK)
#define CFG_SLSTR_GETMASK         (0xF<<CFG_SLSTR_OFFSET)
  #define CFG_SLSTR_RSTMASK         (CFG_IMAGE_GETALL_MASK & ~CFG_SLSTR_GETMASK)
#define CFG_SLSTR_CLRMASK         (CFG_IMAGE_GETALL_MASK & ~CFG_SLSTR_GETMASK)

// misc
#define CFG_USEIGR_OFFSET         4
#define CFG_QUICKCHANGE_OFFSET    2
  #define CFG_QU15BITMODE_OFFSET    3
  #define CFG_QUDEBLUR_OFFSET       2
#define CFG_DEBLUR_OFFSET         1
#define CFG_15BITMODE_OFFSET      0

#define CFG_USEIGR_GETMASK      (1<<CFG_USEIGR_OFFSET)
#define CFG_USEIGR_SETMASK      (1<<CFG_USEIGR_OFFSET)
#define CFG_USEIGR_CLRMASK      (CFG_MISC_GETALL_MASK & ~CFG_USEIGR_SETMASK)
#define CFG_QUICKCHANGE_GETMASK (0x3<<CFG_QUICKCHANGE_OFFSET)
  #define CFG_QUICKCHANGE_RSTMASK (CFG_MISC_GETALL_MASK & ~CFG_QUICKCHANGE_GETMASK)
  #define CFG_QUDEBLUR_SETMASK    (1<<CFG_QUDEBLUR_OFFSET)
  #define CFG_QUDEBLUR_GETMASK    (1<<CFG_QUDEBLUR_OFFSET)
  #define CFG_QUDEBLUR_CLRMASK    (CFG_MISC_GETALL_MASK & ~CFG_QUDEBLUR_SETMASK)
  #define CFG_QU15BITMODE_SETMASK (1<<CFG_QU15BITMODE_OFFSET)
  #define CFG_QU15BITMODE_GETMASK (1<<CFG_QU15BITMODE_OFFSET)
  #define CFG_QU15BITMODE_CLRMASK (CFG_MISC_GETALL_MASK & ~CFG_QU15BITMODE_SETMASK)
#define CFG_DEBLUR_GETMASK        (3<<CFG_DEBLUR_OFFSET)
  #define CFG_DEBLUR_RSTMASK        (CFG_MISC_GETALL_MASK & ~CFG_DEBLUR_GETMASK)
  #define CFG_DEBLUR_AUTO_SETMASK   (CFG_MISC_GETALL_MASK & (0<<CFG_DEBLUR_OFFSET))
  #define CFG_DEBLUR_ON_SETMASK     (CFG_MISC_GETALL_MASK & (1<<CFG_DEBLUR_OFFSET))
  #define CFG_DEBLUR_OFF_SETMASK    (CFG_MISC_GETALL_MASK & (2<<CFG_DEBLUR_OFFSET))
#define CFG_DEBLUR_CLRMASK        (CFG_MISC_GETALL_MASK & ~CFG_DEBLUR_GETMASK)
#define CFG_15BITMODE_GETMASK     (1<<CFG_15BITMODE_OFFSET)
#define CFG_15BITMODE_SETMASK     (1<<CFG_15BITMODE_OFFSET)
#define CFG_15BITMODE_CLRMASK     (CFG_MISC_GETALL_MASK & ~CFG_15BITMODE_SETMASK)

// menu
#define CFG_SHOWOSD_OFFSET  3

#define CFG_SHOWOSD_GETMASK       (1<<CFG_SHOWOSD_OFFSET)
#define CFG_SHOWOSD_SETMASK       (1<<CFG_SHOWOSD_OFFSET)
#define CFG_SHOWOSD_CLRMASK       (CFG_MENU_GETALL_MASK & ~CFG_SHOWOSD_SETMASK)

// some max values
#define CFG_QUICKCHANGE_MAX_VALUE 3
#define CFG_GAMMA_MAX_VALUE       8
#define CFG_SLSTR_MAX_VALUE       3
#define CFG_VFORMAT_MAX_VALUE     2
#define CFG_DEBLUR_MAX_VALUE      2

// some default values
#define CFG_GAMMA_DEFAULTVAL      5
#define CFG_GAMMA_DEFAULT_SETMASK (CFG_GAMMA_DEFAULTVAL<<CFG_GAMMA_OFFSET)


// now the N64 default
#define N64_MISC_CLR_MASK  (CFG_USEIGR_CLRMASK      & CFG_QUDEBLUR_CLRMASK & \
                            CFG_QU15BITMODE_CLRMASK & CFG_DEBLUR_CLRMASK   & \
                            CFG_15BITMODE_CLRMASK   )
#define N64_IMAGE_CLR_MASK (CFG_GAMMA_CLRMASK       & CFG_SLSTR_CLRMASK    )
#define N64_VIDEO_CLR_MASK (CFG_LINEX2_CLRMASK      & CFG_480IBOB_CLRMASK  )

#define N64_DEFAULT_MISC_CFG  (CFG_MISC_GETALL_MASK  & CFG_DEBLUR_OFF_SETMASK    )
#define N64_DEFAULT_IMAGE_CFG (CFG_IMAGE_GETALL_MASK & CFG_GAMMA_DEFAULT_SETMASK & CFG_SLSTR_CLRMASK)
#define N64_DEFAULT_VIDEO_CFG (CFG_VIDEO_GETALL_MASK & 0x00                      )

// the jumper
#define JUMPER_GETALL_MASK  0x3F

#define JUMPER_SLSTR_OFFSET     2
#define JUMPER_SLSTR_BACKSHIFT  (JUMPER_SLSTR_OFFSET-CFG_SLSTR_OFFSET)

#define JUMPER_IMAGECLR_MASK        N64_IMAGE_CLR_MASK
#define JUMPER_ICFG_GETALL_MASK     (3<<JUMPER_SLSTR_OFFSET)
#define JUMPER_ICFG_SLSTR_GETMASK   JUMPER_ICFG_GETALL_MASK

#define JUMPER_VIDEOCLR_MASK        (N64_VIDEO_CLR_MASK & CFG_VFORMAT_CLRMASK)
#define JUMPER_VCFG_GETALL_MASK     CFG_VIDEO_GETALL_MASK
#define JUMPER_VCFG_LINEX2_GETMASK  (1<<CFG_LINEX2_OFFSET)
#define JUMPER_VCFG_480IBOB_GETMASK (1<<CFG_480IBOB_OFFSET)
#define JUMPER_VCFG_YPBPR_GETMASK   (1<<CFG_YPBPR_OFFSET)
#define JUMPER_VCFG_RGSB_GETMASK    (1<<CFG_RGSB_OFFSET)



inline void cfg_toggle_flag(config_t* cfg_data)
  {  if (cfg_data->cfg_type == FLAG) cfg_data->cfg_word->cfg_word_val ^= cfg_data->flag_masks.setflag_mask;  };
inline void cfg_set_flag(config_t* cfg_data)
  {  if (cfg_data->cfg_type == FLAG) cfg_data->cfg_word->cfg_word_val |= cfg_data->flag_masks.setflag_mask;  };
inline void cfg_clear_flag(config_t* cfg_data)
  {  if (cfg_data->cfg_type == FLAG) cfg_data->cfg_word->cfg_word_val &= cfg_data->flag_masks.clrflag_mask;  };
void cfg_inc_value(config_t* cfg_data);
void cfg_dec_value(config_t* cfg_data);
alt_u8 cfg_get_value(config_t* cfg_data,alt_u8 get_reference);
void cfg_set_value(config_t* cfg_data, alt_u8 value);
int cfg_save_to_flash(configuration_t* sysconfig);
int cfg_load_from_flash(configuration_t* sysconfig);
int cfg_load_n64defaults(configuration_t* sysconfig);
int cfg_load_jumperset(configuration_t* sysconfig);
void cfg_apply_to_logic(configuration_t* sysconfig);
inline alt_u32 cfg_get_from_logic()
  {  return IORD_ALTERA_AVALON_PIO_DATA(CFG_SET_OUT_BASE) & CFG_GETALL_MASK;  };
inline alt_u8 cfg_get_jumper()
  {  return (IORD_ALTERA_AVALON_PIO_DATA(JUMPER_CFG_SET_IN_BASE) & JUMPER_GETALL_MASK);  };
void cfg_clear_words(configuration_t* sysconfig);
void cfg_load_from_ios(configuration_t* sysconfig);
void cfg_update_reference(configuration_t* sysconfig);

#endif /* CONFIG_H_ */