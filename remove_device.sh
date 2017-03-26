#!/bin/bash

echo 'Removing /dev/sda1'

set -x
set -e

umount /backup
lvchange -a n xbackup/simplebackup
lvchange -a n xbackup/testvg-snap

vgchange -a n xbackup

cryptsetup luksClose wdElements

echo 'The block device /dev/sda should be removable'

lsblk
