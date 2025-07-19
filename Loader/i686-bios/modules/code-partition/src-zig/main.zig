// SPDX-License-Identifier: MPL-2.0

/// This function must be the topmost code in 'main.zig'!
export fn selvaboot_main(disk_identifier: u32) callconv(.c) noreturn {
    assembly.asm_set_ds(0x3800);
    assembly.asm_reset_display(3);
    assembly.asm_set_background(0x40);
    assembly.asm_write_text(
        &"SelvaBoot"[0],
        3,
        1,
        0x0f,
    );
    const boot_disk = Disk.init(@intCast(disk_identifier)) catch {
        while (true) {}
    };

    var partition_index: usize = 0;
    while (partition_index < 4) {
        if (boot_disk.partitions[partition_index] == null) {
            partition_index += 1;
            continue;
        }
        // If this is a FAT12 partition (partition ID: 1)
        if (boot_disk.partitions[partition_index].?.type == 1) {}
        partition_index += 1;
    }

    while (true) {}
}

const assembly = @import("assembly.zig");
const Disk = @import("Disk.zig");
const Partition = @import("Partition.zig");
