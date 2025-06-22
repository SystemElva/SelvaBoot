# FAT12 Terminology | ElvaBoot i686

This file documents the terminology used for the FAT12 driver internal
to ElvaBoot i686. It is not the exact same as the official terminology
that FAT12 uses.

## File Allocation Table

### Physical Cluster Offset

The offset of a  cluster within the table, measured  in entries of 1.5
bytes each. This is distinct from  the logical cluster index, which is
the index of an entry in the singly linked list of a cluster chain.

### Logical Cluster Index

The index of a cluster within the singly linked list cluster chain, as
counted starting  from zero. If,  for example, the  first cluster in a
chain points to the physical  cluster offset 15, the logical  index of
that cluster is still 1 (because it starts from zero and is the second
entry when starting from one).
