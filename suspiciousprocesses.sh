#!/bin/bash
echo "Suspicious processes:"
ps aux | egrep "nc|netcat|ncat|cryptominer|xmrig"
