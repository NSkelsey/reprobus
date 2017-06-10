#!/bin/bash

echo 'Mounting /dev/sda1'

set +x

# prompted for password
cryptsetup luksOpen /dev/sda1 wdElements

pvdisplay
vgdisplay
lvdisplay

echo "Waiting for disk warmup"
while [ ! -L '/dev/xbackup/simplebackup' ]; do
  printf '. '
  sleep 1
done
echo 'Mounting /backup'
file /dev/xbackup/simplebackup

lvdisplay
mount /dev/xbackup/simplebackup /backup

lsblk

ls -lah /backup
