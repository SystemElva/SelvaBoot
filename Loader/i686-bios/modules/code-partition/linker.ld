BOOTLOADER_ADDRESS = 0;

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
