#!/bin/bash
limit=5
for ip in $(grep "Failed password" /var/log/auth.log | awk '{print $11}' | sort | uniq); do
 count=$(grep -c $ip /var/log/auth.log)
 if [ $count -gt $limit ]; then
 echo "Blocking IP $ip after $count failed attempts"
 sudo iptables -A INPUT -s $ip -j DROP
 fi
done
