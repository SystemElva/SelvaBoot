// SPDX-License-Identifier: MPL-2.0

pub extern fn asm_load_sector_to_ds(
    output_buffer: *anyopaque,
    sector_index: u32,
    disk_identifier: u32,
) callconv(.c) u32;

pub extern fn asm_reset_display(
    display_mode: u32,
) callconv(.c) void;

pub extern fn asm_write_text(
    string: *const u8,
    start_line: u32,
    start_cell: u32,
    color_codes: u32,
) callconv(.c) void;

pub extern fn asm_set_background(
    color: u16,
) callconv(.c) void;

// Segment Register Setters

pub extern fn asm_set_ss(
    value: u32,
) callconv(.c) void;

pub extern fn asm_set_ds(
    value: u32,
) callconv(.c) void;

pub extern fn asm_set_es(
    value: u32,
) callconv(.c) void;

pub extern fn asm_set_fs(
    value: u32,
) callconv(.c) void;

pub extern fn asm_set_gs(
    value: u32,
) callconv(.c) void;

// Segment Register Getters

pub extern fn asm_get_ss() callconv(.c) u32;

pub extern fn asm_get_ds() callconv(.c) u32;

pub extern fn asm_get_es() callconv(.c) u32;

pub extern fn asm_get_fs() callconv(.c) u32;

pub extern fn asm_get_gs() callconv(.c) u32;

// Memory Basics

pub extern fn memset(
    region: *anyopaque,
    byte: u8,
    len_region: u32,
) callconv(.c) void;
