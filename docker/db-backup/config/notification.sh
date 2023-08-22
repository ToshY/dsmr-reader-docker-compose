#!/bin/bash

# #### Example Post Script
# #### $1=EXIT_CODE (After running backup routine)
# #### $2=DB_TYPE (Type of Backup)
# #### $3=DB_HOST (Backup Host)
# #### #4=DB_NAME (Name of Database backed up
# #### $5=BACKUP START TIME (Seconds since Epoch)
# #### $6=BACKUP FINISH TIME (Seconds since Epoch)
# #### $7=BACKUP TOTAL TIME (Seconds between Start and Finish)
# #### $8=BACKUP FILENAME (Filename)
# #### $9=BACKUP FILESIZE
# #### $10=HASH (If CHECKSUM enabled)

DB_CURRENT_FILE=${DB_DUMP_TARGET}/${8}
DB_SPECIFIC_DIRECTORY=${DB_DUMP_TARGET}/${4}
if [ ! -d "$DB_SPECIFIC_DIRECTORY" ]; then
  echo "Creating directory: $DB_SPECIFIC_DIRECTORY"
  mkdir -p "$DB_SPECIFIC_DIRECTORY"
fi

# Move file to directory named after DB
if [ -f "$DB_CURRENT_FILE" ]; then
  echo "Moving backup file from '$DB_CURRENT_FILE' to '$DB_SPECIFIC_DIRECTORY/${8}'."
  mv $DB_CURRENT_FILE $DB_SPECIFIC_DIRECTORY/${8}
fi

# Rotate backups
/usr/bin/rotate-backups --daily=4 --weekly=7 --monthly=4 --yearly=always --syslog=0 --prefer-recent --use-sudo --verbose "$DB_SPECIFIC_DIRECTORY"

# Sync AWS if applicable
if [ "${SYNC_S3}" = true ]; then
  echo "Syncing AWS backups to target bucket: 'aws s3 sync $DB_SPECIFIC_DIRECTORY ${EXTRA_S3_BUCKET}/${4} --endpoint-url ${EXTRA_S3_ENDPOINT_URL} --delete.'"
  /usr/bin/aws s3 sync $DB_SPECIFIC_DIRECTORY ${EXTRA_S3_BUCKET}/${4} --endpoint-url ${EXTRA_S3_ENDPOINT_URL} --delete
fi

# Send notification if applicable
if [ "${SEND_NOTIFICATION}" = true ]; then
  /usr/bin/discord/discord.sh --webhook-url="${DISCORD_WEBHOOK}" --title "${DISCORD_MESSAGE_TITLE} | ${4^}" --description "${DISCORD_MESSAGE_DESCRIPTION}" --color "0x${DISCORD_MESSAGE_HEX_COLOR}" --timestamp
fi
