#!/bin/sh
export GPU_MAX_HEAP_SIZE=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

./ethdcrminer64 -epool eth-eu1.nanopool.org:9999 -ewal 0xe6185b158d7a99cde1f32f4a2eae572264b05a2f/test_farm/kardapolov@gmail.com -mode 1 -wd 0
