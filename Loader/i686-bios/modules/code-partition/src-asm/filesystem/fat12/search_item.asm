
; fat12_search_item:
;   Get the first cluster of an item at an arbitrary nesting level in
;   the folder structure. It is found by its path encoded in UTF-8.
;
; Arguments(2):
;
;   [FURTHEST FROM EBP]
;
;       1.  ptr<char>                           path
;               Path encoded in UTF-8 telling the item of which the first
;               cluster's physical offset should be found.
;
;       0.  ptr32<Fat12Filesystem>              filesystem
;
;               
;               
;
;   [NEAREST TO EBP]
;
; Return Value:
;       0.  uint32                              cluster_offset
;
fat12_search_item:
.prolog:
    pushad
    sub esp, 256

.search_in_root:
    ; @todo

.epilog:
    add esp, 256
    popad
    ret



; fat12_search_item_in_subfolder:
;   Searches an item in a folder that is not the root folder. To search
;   an item starting at the root folder, 'fat12_search_item' should be
;   used. This function needs a regular, cluster-chained folder.
;
; Arguments(
;
;   [FURTHEST FROM EBP]
;
;       2.  ptr<char>                           item_name
;             Name of the item of which to get the first cluster
;
;       1.  u32                                 physical_cluster_offset
;             Physical offset of the first cluster of the folder's
;             cluster chain, as measured in clusters.
;
;
;       0.  ptr<Fat12Filesystem>                filesystem
;
;   [NEAREST TO EBP]
;
;
; Return Value:
;       0.  uint32                              cluster_offset
;
fat12_search_item_in_subfolder:
.prolog:
    pushad
    sub esp, 256

.search_in_root:
    ; @todo

.epilog:
    add esp, 256
    popad
    ret



; fat12_search_item_using_folder_walker:
;   
;   
;
; Arguments(
fat12_search_item_using_folder_walker:
.prolog:
    pushad
    sub esp, 256

.search_in_root:
    ; @todo

.epilog:
    add esp, 256
    popad
    ret
