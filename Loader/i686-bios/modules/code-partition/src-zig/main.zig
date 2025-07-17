/// This function must be the topmost code in 'main.zig'!
export fn selvaboot_main(disk_identifier: u32) callconv(.c) noreturn {
    asm_reset_display(3);

    asm_load_sector(
        @ptrFromInt(0x7e00),
        @as(u32, 0),
        disk_identifier,
    );
    asm_set_background(0x40);

    asm_write_text(
        &"Message from the bootloader's Zig part"[0],
        12,
        21,
        0x4f,
    );

    while (true) {}
}

extern fn asm_load_sector(
    output_buffer: *anyopaque,
    sector_index: u32,
    disk_identifier: u32,
) callconv(.c) void;

extern fn asm_reset_display(
    display_mode: u32,
) callconv(.c) void;

extern fn asm_write_text(
    string: *const u8,
    start_line: u32,
    start_cell: u32,
    color_codes: u32,
) callconv(.c) void;

extern fn asm_set_background(
    color: u16,
) callconv(.c) void;
