#!/bin/bash
# full system backup

# Backup destination
backdest=/

# Labels for backup name
host=${HOSTNAME}
date=$(date "+%F")
backupfile="$backdest/$host-$date.tar.gz"

# Exclude file location
script=${0##*/} # Program name from filename
exclude_file="$script-exclude.txt"

# Check if chrooted prompt.
echo -n "First chroot from a LiveCD.  Are you ready to backup? (y/n): "
read executeback

# Check if exclude file exists
if [ ! -f $exclude_file ]; then
  echo -n "No exclude file exists, continue? (y/n): "
  read continue
  if [ $continue == "n" ]; then exit; fi
fi

if [ $executeback = "y" ]; then
  # -p and --xattrs store all permissions and extended attributes. 
  # Without both of these, many programs will stop working!
  # It is safe to remove the verbose (-v) flag. If you are using a 
  # slow terminal, this can greatly speed up the backup process.
  tar --exclude-from=$exclude_file --xattrs -czpvf $backupfile /
fi