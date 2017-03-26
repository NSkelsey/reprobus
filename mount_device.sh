#!/bin/bash

echo 'Mounting /dev/sda1'

set +x

cryptsetup luksOpen /dev/sda1 wdElements
# prompted for password

pvdisplay
vgdisplay

file /dev/xbackup/simplebackup
sleep 20
mount /dev/xbackup/simplebackup /backup

lsblk

ls -lah /backup
