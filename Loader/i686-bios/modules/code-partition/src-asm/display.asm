; SPDX-License-Identifier: MPL-2.0

global asm_set_background
global asm_reset_display
global asm_write_text

FOREGROUND_BLACK         equ 0x00
FOREGROUND_BLUE          equ 0x01
FOREGROUND_GREEN         equ 0x02
FOREGROUND_CYAN          equ 0x03
FOREGROUND_RED           equ 0x04
FOREGROUND_MAGENTA       equ 0x05
FOREGROUND_BROWN         equ 0x06
FOREGROUND_LIGHT_GRAY    equ 0x07
FOREGROUND_DARK_GRAY     equ 0x08
FOREGROUND_LIGHT_BLUE    equ 0x09
FOREGROUND_LIGHT_GREEN   equ 0x0a
FOREGROUND_LIGHY_CYAN    equ 0x0b
FOREGROUND_LIGHT_RED     equ 0x0c
FOREGROUND_LIGHT_MAGENTA equ 0x0d
FOREGROUND_YELLOW        equ 0x0e
FOREGROUND_WHITE         equ 0x0f

BACKGROUND_BLACK         equ 0x00
BACKGROUND_BLUE          equ 0x10
BACKGROUND_GREEN         equ 0x20
BACKGROUND_CYAN          equ 0x30
BACKGROUND_RED           equ 0x40
BACKGROUND_MAGENTA       equ 0x50
BACKGROUND_BROWN         equ 0x60
BACKGROUND_LIGHT_GRAY    equ 0x70
BACKGROUND_DARK_GRAY     equ 0x80
BACKGROUND_LIGHT_BLUE    equ 0x90
BACKGROUND_LIGHT_GREEN   equ 0xa0
BACKGROUND_LIGHY_CYAN    equ 0xb0
BACKGROUND_LIGHT_RED     equ 0xc0
BACKGROUND_LIGHT_MAGENTA equ 0xd0
BACKGROUND_YELLOW        equ 0xe0
BACKGROUND_WHITE         equ 0xf0



asm_set_background:
.prolog:
    push ebp
    mov ebp, esp
    pushad

.set_background:
    mov ah, 0x0b
    mov bh, 0x00
    mov bl, [ebp + 0x08]
    shr bl, 4 ; Convert the BACKGROUND constant-value to a FOREGROUND one
    int 0x10

.epilog:
    popad

    mov esp, ebp
    pop ebp
    ret



asm_reset_display:
.prolog:
    push ebp
    mov ebp, esp
    pushad

.reset_display:
    mov ah, 0x00
    mov al, [ebp + 0x08]
    int 0x10

.epilog:
    popad

    mov esp, ebp
    pop ebp
    ret



asm_write_text:
.prolog:
    push ebp
    mov ebp, esp

    pushad

.setup_character_loop:
    xor edi, edi

.character_loop:
    ; Check for primary exit condition (NUL character)
    mov ebx, [ebp + 0x08]
    add ebx, edi
    mov cl, [ebx]
    cmp cl, 0
    je .epilog

    ; Move Cursor
    mov ah, 0x02            ; Interrupt Function (move cursor)
    mov bh, 0               ; Display Page
    mov dx, [ebp + 0x10]       ; Start Column
    add dx, di
    mov dh, [ebp + 0x0c]      ; Line
    int 0x10

    ; Check for secondary exit condition (line end reached)
    cmp dl, 80
    jae .epilog

    ; Display the character
    mov ah, 0x09
    mov al, cl
    mov bh, 0
    mov bl, [ebp + 0x14]
    mov cx, 1
    int 0x10

    inc edi
    jmp .character_loop

.epilog:
    popad

    mov esp, ebp
    pop ebp
    ret
