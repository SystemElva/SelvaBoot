; SPDX-License-Identifier: MPL-2.0

section .text
bits 16

global asm_write_text

; write_text:
;   Put a NUL-terminated character string onto the display
;   using the BIOS functions at INT 0x10.
;
; Arguments:
;   [FURTHEST FROM EBP]
;     3.  U32       color_codes (Only lower 8 bits used)
;     2.  U32       start_cell
;     1.  U32       start_line
;     0.  Ptr32     string
;  [NEAREST TO EBP]
;
; Return Value:
;   N/A
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

%include "disk.asm"
%include "display.asm"
%include "utility/memory.asm"

