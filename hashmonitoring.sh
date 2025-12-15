#!/bin/bash
file="/etc/passwd"
old_hash="/tmp/passwd.hash"
new_hash=$(sha256sum $file | awk '{print $1}')
if [ ! -f $old_hash ]; then
 echo $new_hash > $old_hash
 exit
fi
saved_hash=$(cat $old_hash)
if [ "$new_hash" != "$saved_hash" ]; then
 echo "[ALERT] $file has been modified!"
else
 echo "No changes detected."
fi
