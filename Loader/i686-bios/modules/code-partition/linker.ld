BOOTLOADER_ADDRESS = 0xa000;

SECTIONS {
    . = BOOTLOADER_ADDRESS;

    .text :
    {
        *(.text*)
    }

    /DISCARD/ :
    {
        *(.eh_frame*)
    }
}
