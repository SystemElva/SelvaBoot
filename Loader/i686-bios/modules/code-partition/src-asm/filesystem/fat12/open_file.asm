
; fat12_open_file:
;   
;
; Arguments (3):
;
;   [FURTHEST FROM EBP]
;
;     2.  ptr32<char>                           path
;
;
;     1.  ptr32<Fat12File>                      file_buffer
;
;             
;             
;
;     0.  ptr32>Fat12Filesystem>                filesystem
;
;             
;             
;
;   [NEAREST TO EBP]
;
; Return Value:
;   N/A
fat12_open_file:
.prolog:
    pushad
    sub     esp,                64

.search_file:
    mov     eax,                [ebp - 4]
    mov     ebx,                [ebp - 12]

    push    ebp
    mov     ebp,                esp
    push    eax
    push    ebx
    push    esp
    call    fat12_search_item
    mov     esp,                ebp
    pop     ebp

.epilog:
    add     esp,                64
    popad
    ret
