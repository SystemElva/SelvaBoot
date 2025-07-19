// SPDX-License-Identifier: MPL-2.0

const assembly = @import("assembly.zig");
const Disk = @This();

disk_identifier: u8,
partitions: [4]?Partition,

pub const DiskError = error{
    SectorIndexTooHigh,
    SectorLoadFailure,
};

pub fn init(disk_identifier: u8) !Disk {
    var disk = Disk{
        .disk_identifier = disk_identifier,
        .partitions = .{null} ** 4,
    };

    var master_boot_record: [512]u8 = .{0} ** 512;
    try disk.loadSectorToFs(
        &master_boot_record,
        0,
    );

    var partition_index: usize = 0;
    while (partition_index < 4) {
        disk.partitions[partition_index] = try Partition.loadFromBuffer(
            &master_boot_record,
            partition_index,
        );
        partition_index += 1;
    }
    return disk;
}

pub fn loadSectorToDs(
    self: *Disk,
    buffer: *[512]u8,
    lba: u32,
) DiskError!void {
    if (assembly.asm_load_sector_to_ds(
        buffer,
        lba,
        self.disk_identifier,
    ) < 0) {
        return DiskError.SectorLoadFailure;
    }
}

pub fn loadSectorToEs(
    self: *Disk,
    buffer: *[512]u8,
    lba: u32,
) DiskError!void {
    const ds_pointer = assembly.asm_get_ds();
    defer assembly.asm_set_ds(ds_pointer);

    const es_pointer = assembly.asm_get_es();
    assembly.asm_set_es(es_pointer);

    try self.loadSectorToDs(buffer, lba);
}

pub fn loadSectorToFs(
    self: *Disk,
    buffer: *[512]u8,
    lba: u32,
) DiskError!void {
    const ds_pointer = assembly.asm_get_ds();
    defer assembly.asm_set_ds(ds_pointer);

    const fs_pointer = assembly.asm_get_fs();
    assembly.asm_set_fs(fs_pointer);

    try self.loadSectorToDs(buffer, lba);
}

pub fn loadSectorToGs(
    self: *Disk,
    buffer: *[512]u8,
    lba: u32,
) DiskError!void {
    const ds_pointer = assembly.asm_get_ds();
    defer assembly.asm_set_ds(ds_pointer);

    const gs_pointer = assembly.asm_get_gs();
    assembly.asm_set_gs(gs_pointer);

    try self.loadSectorToDs(buffer, lba);
}

const Partition = @import("Partition.zig");
