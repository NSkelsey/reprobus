#!/bin/bash

echo 'Backing up homedir'

set -x

fname=crit_files_"$(date +%Y%m%d)".tar.gz
SDIR=/home/nskelsey/projects/reprobus

#SIZE=`du -c --files0-from=<(tr '\n' '\0' < $SDIR/target_files.txt) | awk 'END{print $1}'`
# pv -p -s ${SIZE} 
SIZE=3619584

echo "About to create archive of $SIZE"

tar -hac -T $SDIR/target_files.txt | pv -t -b -a -r | gzip -c > /backup/tars/$fname

#tar -hazcf /backup/tars/$fname -T $SDIR/target_files.txt

echo 'Created backup'
ls -alh /backup/tars/$fname
sha256sum /backup/tars/$fname

# Observations. . . bzip is quiet slow. The last run on 2.9 GB took 20m. Gzip pushes at 4.41 MiB/s
