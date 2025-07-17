
global asm_load_sector

; asm_read_sector:
;   Read a sector at a given logical block address (LBA).
;
; Arguments (3):
;   [FURTHEST FROM EBP]
;     2.  ptr32<[512]u8>                output_buffer
;     1.  u32                           sector_index
;     0.  u32                           disk_id             (only lower byte used)
;   [NEAREST TO EBP]
;
; Return Value:
;   N/A
asm_load_sector:
.prolog:
    push ebp
    mov ebp, esp

    pushad
    sub     esp,                16
    mov     esi,                esp

.read_sector:
    ; Get sector index LBA
    mov     eax,                [ebp + 0x0c]

    ; Split Memory Buffer into segment and offset
    mov     ecx,                [ebp + 0x08]
    mov     edx,                ecx

    and     cx,                 0x0f
    shr     edx,                4

    mov     ebx,                ss
    shl     ebx,                4
    add     esi,                ebx

    ; Prepare disk address packet
    mov     [esi],           word 0x10       ; Length of DAP
    mov     [esi + 0x02],    word 0x01       ; Number of sectors
    mov     [esi + 0x04],    cx              ; Memory Buffer Offset
    mov     [esi + 0x06],    dx              ; Memory Buffer Segment
    mov     [esi + 0x08],    eax             ; Lower part of LBA
    mov     [esi + 0x0c],    dword 0         ; Upper part of LBA (unused)

    mov     dl,                 [ebp + 0x10]

    ; Call the interrupt
    mov     ah,                 0x42
    int     0x13

.epilog:
    add     esp,                16
    popad

    mov esp, ebp
    pop ebp
    ret
