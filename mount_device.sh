#!/bin/bash

WAITTIME=60

echo 'Mounting /dev/sda1'

set +x

cryptsetup luksOpen /dev/sda1 wdElements
# prompted for password

pvdisplay
vgdisplay
lvdisplay

file /dev/xbackup/simplebackup
echo 'Sleeping for $WAITTIME seconds to let system warmup'
sleep $WAITTIME
lvdisplay
mount /dev/xbackup/simplebackup /backup

lsblk

ls -lah /backup
