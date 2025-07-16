/// This function must be the topmost code in 'main.zig'!
export fn selvaboot_main() callconv(.c) noreturn {
    asm_write_text(
        &"Message from the bootloader's Zig part"[0],
        12,
        21,
        0x4f,
    );

    while (true) {}
}

extern fn asm_write_text(
    string: *const u8,
    start_line: u32,
    start_cell: u32,
    color_codes: u16,
) callconv(.c) void;
