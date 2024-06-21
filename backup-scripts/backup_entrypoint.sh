#!/bin/bash

# Cài đặt cron
apt-get update && apt-get install -y cron postgresql-client

# Tạo cron job
echo "0 2 * * * /scripts/backup.sh" > /etc/cron.d/backup-cron

# Đảm bảo rằng cron chạy trong foreground
cron -f
