
struc       Fat12ClusterChainWalker

    .fn_load                    resd 1
    .first_cluster              resd 1
    .cluster_table_index        resd 1
    .chain_item_index           resd 1
    .filesystem                 resd 1
    .reader_buffer              resd 1

endstruc



; fat12_walk_cluster_chain:
;   Walks a cluster chain to the 'logical_index' index from the
;   given chain's start. A chain walker can be created using
;   'fat12_new_cluster_chain_walker'.
;
; Arguments (2):
;
;   [FURTHEST FROM EBP]
;
;     1.  int32                                 logical_index
;               The number of jumps in the singly linked FAT from
;               the start of the chain to the entry that should be
;               found. The found entry's offset in the table will
;               be returned, given in entries (each one has 12 bits).
;
;     0.  ptr32<Fat12ClusterChainWalker>        walker
;               
;
;   [NEAREST TO EBP]
;
; Return Value:
;   - [EAX]:    cluster_index
;
fat12_walk_cluster_chain:
.prolog:
    pushad
    sub esp, 64
    mov esi, esp

.initialize_loop:
    ;

.epilog:
    add esp, 64
    popad
    ret
