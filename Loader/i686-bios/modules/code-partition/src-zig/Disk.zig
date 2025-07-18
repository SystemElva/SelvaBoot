// SPDX-License-Identifier: MPL-2.0

const assembly = @import("assembly.zig");
const Disk = @This();

disk_identifier: u8,
partitions: [4]?Partition,

fn_load_sector: (*const fn (
    self: *Disk,
    output_buffer: *[512]u8,
    offset: u32,
) DiskError!void),

pub const DiskError = error{
    SectorIndexTooHigh,
    SectorLoadFailure,
};

pub fn init(disk_identifier: u8) !Disk {
    var disk = Disk{
        .disk_identifier = disk_identifier,
        .fn_load_sector = loadSector,
        .partitions = .{null} ** 4,
    };

    var master_boot_record: [512]u8 = .{0} ** 512;
    try disk.loadSector(
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

pub fn loadSector(
    self: *Disk,
    output_buffer: *[512]u8,
    sector_index: u32,
) DiskError!void {
    if (assembly.asm_load_sector(
        output_buffer,
        sector_index,
        self.disk_identifier,
    ) < 0) {
        return DiskError.SectorLoadFailure;
    }
}

const Partition = @import("Partition.zig");
