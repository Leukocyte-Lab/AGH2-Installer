#!/bin/sh

echo "Current VM(s) on ESXi Host" && \
vim-cmd vmsvc/getallvms

sleep 1

echo "Power Off existed VM..." && \
vim-cmd vmsvc/getallvms | grep "AGH-" | awk '{ print "vim-cmd vmsvc/power.off " $1 }' | sh && \
echo "Unregister existed VM..." && \
vim-cmd vmsvc/getallvms | grep "AGH-" | awk '{ print "vim-cmd vmsvc/unregister " $1 }' | sh

sleep 1

echo "Current VM(s) on ESXi Host" && \
vim-cmd vmsvc/getallvms

sleep 1

echo "Delete existed VM file in datastore..." && \
rm -rf "/vmfs/volumes/$DATASTORE/AGH-*"

sleep 1

if [ -d "/vmfs/volumes/$DATASTORE/packer_cache/" ]; then
  echo "Backup ISO image..."
  cp -a "/vmfs/volumes/$DATASTORE/packer_cache/*.iso" /tmp 2>/dev/null || :
  echo "Cleanup Packer cache..."
  rm -rf "/vmfs/volumes/$DATASTORE/packer_cache/"
  echo "Restore ISO image..."
  mkdir -p "/vmfs/volumes/$DATASTORE/packer_cache/"
  cp -a "/tmp/*.iso" "/vmfs/volumes/$DATASTORE/packer_cache" 2>/dev/null || :
fi
