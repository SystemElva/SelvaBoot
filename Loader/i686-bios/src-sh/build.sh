#!/bin/bash

cd "$(dirname "$0")"/.. || exit
I686_PATH=$(pwd)

BOOTSECTOR_OBJECTS="$I686_PATH/.build/modules/bootsector"
CODE_PARTITION_OBJECTS="$I686_PATH/.build/modules/code-partition"
BOOTFS_PARTITION="$I686_PATH/.build/modules/bootfs/"

BOOTSECTOR_SOURCES="$I686_PATH/modules/bootsector/src-asm"
CODE_PARTITION="$I686_PATH/modules/code-partition"

OUTPUT_DIRECTORY=$I686_PATH/.out

EXECUTION_TIME=$(date "+%Y-%m-%d.%H-%M-%S")

COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

if [[ ! -f $BOOTFS_PARTITION/fat12.img ]];
then
    printf "%sINFO: Didn't find an boot-fs. Creating one!%s\n" "$COLOR_YELLOW" "$COLOR_RESET"
    "$I686_PATH"/src-sh/makefs.sh
fi

# Create the objects folder, in case it hasn't been created before
mkdir -p "$BOOTSECTOR_OBJECTS"
mkdir -p "$CODE_PARTITION_OBJECTS"
mkdir -p "$OUTPUT_DIRECTORY"

# Make sure that no old object-files are in the objects-folder
rm -f "$BOOTSECTOR_OBJECTS"/*.o
rm -f "$CODE_PARTITION_OBJECTS"/*.o

nasm -o "$BOOTSECTOR_OBJECTS"/object.bin \
    "$BOOTSECTOR_SOURCES"/bootsector.asm \
    -i "$BOOTSECTOR_SOURCES"



cd $I686_PATH/.build/modules/code-partition
nasm \
    $CODE_PARTITION/src-asm/main.asm \
    -f elf32 \
    -o assembly.o

zig build-obj \
    "$CODE_PARTITION/src-zig/main.zig" \
    -target x86-freestanding-code16 \
    -T $CODE_PARTITION/linker.ld \
    -O ReleaseSmall \

ld \
    main.o assembly.o \
    --script $CODE_PARTITION/linker.ld \
    -m elf_i386 \
    --oformat elf32-i386 \
    -o linked.o

objcopy --remove-section .eh_frame --output-target binary linked.o object.bin

OUTPUT_FILE="$OUTPUT_DIRECTORY"/elvaboot-$EXECUTION_TIME.img

HD_DISKETTE_BYTES=$((2880*512)) # 2880 sectors of 512 bytes each
truncate "$OUTPUT_FILE" --size=$HD_DISKETTE_BYTES

dd status=none conv=notrunc cbs=512 if="$BOOTSECTOR_OBJECTS"/object.bin of="$OUTPUT_FILE"
dd status=none conv=notrunc cbs=512 if="$CODE_PARTITION_OBJECTS"/object.bin of="$OUTPUT_FILE" seek=1
dd status=none conv=notrunc cbs=512 if="$BOOTFS_PARTITION"/fat12.img of="$OUTPUT_FILE" seek=64
