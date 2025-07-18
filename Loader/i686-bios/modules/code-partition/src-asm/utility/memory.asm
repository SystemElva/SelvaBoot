; SPDX-License-Identifier: MPL-2.0

;global memcpy
global memset

memset:
.prolog:
    push    ebp
    mov     ebp,                esp
    pushad

.setup_filler_loop:
    mov     ebx,                [ebp + 0x08]
    mov     edx,                ebx
    add     edx,                [ebp + 0x10]
    mov     al,                 [ebp + 0x0c]

.filler_loop:
    mov     [ebx],              al

    inc     ebx
    cmp     ebx,                edx
    jb      .filler_loop

.epilog:
    popad
    mov     esp,                ebp
    pop     ebp
    ret

