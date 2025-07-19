; SPDX-License-Identifier: MPL-2.0

global asm_set_ss
global asm_set_ds
global asm_set_es
global asm_set_fs
global asm_set_gs

global asm_get_ss
global asm_get_ds
global asm_get_es
global asm_get_fs
global asm_get_gs



asm_set_ss:
    push ebx
    mov ebx, [esp + 0x08]
    mov ss, ebx
    pop ebx
    ret

asm_set_ds:
    push ebx
    mov ebx, [esp + 0x08]
    mov ds, ebx
    pop ebx
    ret

asm_set_es:
    push ebx
    mov ebx, [esp + 0x08]
    mov es, ebx
    pop ebx
    ret

asm_set_fs:
    push ebx
    mov ebx, [esp + 0x08]
    mov fs, ebx
    pop ebx
    ret

asm_set_gs:
    push ebx
    mov ebx, [esp + 0x08]
    mov gs, ebx
    pop ebx
    ret



asm_get_ss:
    mov eax, ss
    ret

asm_get_ds:
    mov eax, ds
    ret

asm_get_es:
    mov eax, es
    ret

asm_get_fs:
    mov eax, ds
    ret

asm_get_gs:
    mov eax, gs
    ret
