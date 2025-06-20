#!/usr//bin/env bash

INVOCATION_PATH=$(pwd)
cd $(dirname $0)/..
I686_PATH=$(pwd)
cd $INVOCATION_PATH

# 32 MiB
((MEMORY_SIZE=2**25))

if [[ ! -e "$I686_PATH/qmp.socket" ]];
then
    echo "error: failed dumping to missing unix socket 'qmp.socket'"
    exit 1
fi

echo "dump-guest-memory $I686_PATH/memory.dump 0x0000 $MEMORY_SIZE" \
    | qmp-shell --hmp qmp.socket >/dev/null 2>&1

echo "memory read --outfile lower-memory.bin 0x00000 --binary $MEMORY_SIZE" \
    | lldb "$I686_PATH/memory.dump" >/dev/null 2>&1

echo "memory read --outfile upper-memory.bin 0xc0000 --binary $MEMORY_SIZE" \
    | lldb "$I686_PATH/memory.dump" >/dev/null 2>&1


truncate memory.bin --size $MEMORY_SIZE

dd if=lower-memory.bin of=memory.bin ibs=512  conv=notrunc >/dev/null 2>&1
dd if=upper-memory.bin of=memory.bin ibs=512 seek=600 conv=notrunc >/dev/null 2>&1

rm lower-memory.bin
rm upper-memory.bin
rm -f memory.dump
