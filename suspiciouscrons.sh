#!/bin/bash
echo "Suspicious cron jobs:"
grep -v "#" /etc/crontab | grep -v "root" | grep -v "normal_expected_job"
