#!/bin/bash

# Các biến môi trường
BACKUP_DIR=/backups
DATABASE_NAME=tp_db
USER_NAME=tp_user
PASSWORD=tp_password
HOST=postgres

# Ngày và giờ hiện tại
DATE=$(date +\%Y-\%m-\%d_\%H-\%M-\%S)

# Tên file backup
BACKUP_FILE=${BACKUP_DIR}/backup_${DATABASE_NAME}_${DATE}.sql

# Tạo thư mục backup nếu chưa tồn tại
mkdir -p ${BACKUP_DIR}

# Thực hiện backup
PGPASSWORD=${PASSWORD} pg_dump -U ${USER_NAME} -h ${HOST} ${DATABASE_NAME} > ${BACKUP_FILE}

# Xóa các file backup cũ hơn 7 ngày
find ${BACKUP_DIR} -type f -name "*.sql" -mtime +7 -exec rm {} \;
