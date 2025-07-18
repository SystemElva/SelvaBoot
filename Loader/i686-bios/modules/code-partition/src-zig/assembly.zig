// SPDX-License-Identifier: MPL-2.0

pub extern fn asm_load_sector(
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

// memory

pub extern fn memset(
    region: *anyopaque,
    byte: u8,
    len_region: u32,
) callconv(.c) void;
