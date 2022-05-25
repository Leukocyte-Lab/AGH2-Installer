#!/bin/sh

vim-cmd vmsvc/getallvms | grep "AGH-" | awk '{ print "vim-cmd vmsvc/power.off " $1 }' | sh && \
vim-cmd vmsvc/getallvms | grep "AGH-" | awk '{ print "vim-cmd vmsvc/unregister " $1 }' | sh

sleep 10

vim-cmd vmsvc/getallvms

sleep 10

cp "/vmfs/volumes/$DATASTORE/packer_cache/*.iso" /tmp && \
rm -rf "/vmfs/volumes/$DATASTORE/AGH-*" && \
rm -rf "/vmfs/volumes/$DATASTORE/packer_cache/" && \
mkdir -p "/vmfs/volumes/$DATASTORE/packer_cache/" && \
cp "/tmp/*.iso /vmfs/volumes/$DATASTORE/packer_cache"
