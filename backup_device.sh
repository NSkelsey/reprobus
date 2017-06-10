#!/bin/bash

echo 'Backing up homedir'

set -x

fname=crit_files_"$(date +%Y%m%d)".tar.gz
SDIR=/home/nskelsey/projects/reprobus

SIZE=`du -c --files0-from=<(tr '\n' '\0' < $SDIR/target_files.txt) | awk 'END{print $1}'`
# pv -p -s ${SIZE} 
#SIZE=3619584

echo "About to create archive of $SIZE"

tar -hac -T $SDIR/target_files.txt | pv -t -b -a -r | gzip -c > /backup/tars/$fname

#tar -hazcf /backup/tars/$fname -T $SDIR/target_files.txt

echo 'Created backup'
ls -alh /backup/tars/$fname

echo 'Writing checksum to disk'
sha256sum /backup/tars/$fname | tee -a $SDIR/shas.txt
