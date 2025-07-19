// SPDX-License-Identifier: MPL-2.0

const Disk = @import("Disk.zig");

const Partition = @This();

type: u64,
offset: u64,
length: u64,

pub fn loadFromBuffer(
    master_boot_record: *const [512]u8,
    partition_index: u32,
) !Partition {
    const start_offset: u32 = 446 + partition_index * 16;
    const mbr_u32: *const []u32 = @alignCast(@ptrCast(&master_boot_record[start_offset]));

    return .{
        .type = master_boot_record[start_offset + 4],
        .offset = mbr_u32.*[2],
        .length = mbr_u32.*[3],
    };
}

pub fn loadSectorToDs(
    self: *Partition,
    disk: *Disk,
    output_buffer: *[512]u8,
    offset: u64,
) Disk.DiskError!void {
    if (offset > self.length) {
        return Disk.DiskError.SectorIndexTooHigh;
    }

    try disk.loadSectorToDs(
        output_buffer,
        offset,
    );
}

pub fn loadSectorToEs(
    self: *Partition,
    disk: *Disk,
    output_buffer: *[512]u8,
    offset: u64,
) Disk.DiskError!void {
    if (offset > self.length) {
        return Disk.DiskError.SectorIndexTooHigh;
    }

    try disk.loadSectorToEs(
        output_buffer,
        offset,
    );
}

pub fn loadSectorToFs(
    self: *Partition,
    disk: *Disk,
    output_buffer: *[512]u8,
    offset: u64,
) Disk.DiskError!void {
    if (offset > self.length) {
        return Disk.DiskError.SectorIndexTooHigh;
    }

    try disk.loadSectorToFs(
        output_buffer,
        offset,
    );
}

pub fn loadSectorToGs(
    self: *Partition,
    disk: *Disk,
    output_buffer: *[512]u8,
    offset: u64,
) Disk.DiskError!void {
    if (offset > self.length) {
        return Disk.DiskError.SectorIndexTooHigh;
    }

    try disk.loadSectorToGs(
        output_buffer,
        offset,
    );
}
