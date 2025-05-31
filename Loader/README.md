# Loader Sources

The sources of  the SystemElva bootloader. It searches  the disk for a
FAT filesystem that contains the kernel, loads the kernel and gives it
some basic information about the system as arguments.

## Project Structure

The root  directory contains the folders for the different  bootloader
distributions (i686-bios, x86-64-bios, x86_64-uefi, aarch64, riscv-64,
et cetera).

Within each of those distributions folders (of which the *i686* is the
only one  planned for the near future), there always are the following
folder items:

- `.build/` (internal)  
    Intermediate files used in the build process.

- `.out/` (internal)  
    Contains the finished build results, test executables and, in a
    sub-directory, memory dumps.

- `assets/` (optional)  
    Contains asset files for the scripts and for the build process.

- `modules/` (source code)  
    Contains the  source code  of the  distribution. The  modules  are
    hard-coded; adding a new one involves modifying the build scripts.
    Each module contains a source folder named as `src-$LANGUAGE`, for
    example  `src-asm/`, `src-zig/`, `src-c/` or for  C header  files:
    `inc-c`.  Furthermore,  the module  may  include  the  development
    documentation in a folder called `docs/`.

- `src-sh/` (optional)  
    If the  build process  is more  involved, justifying a  split into
    more than one file, this folder contains those shell scripts.

- `do.sh`  
    Main script  for building / running the bootloader and dumping the
    memory of an instance emulated by QEMU at that moment.
