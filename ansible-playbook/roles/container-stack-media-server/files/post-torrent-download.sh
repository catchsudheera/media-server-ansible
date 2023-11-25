#!/bin/bash


function log () {
    logger -t "post-torrent-download" "$1"
}

DOWNLOAD_PATH="${TR_TORRENT_DIR}/${TR_TORRENT_NAME}"
if [ $DOWNLOAD_PATH = "/" ]; then
   log "Incorrect path : / . Exiting.."
   exit 1
fi

log "Processing : $DOWNLOAD_PATH"
ls $DOWNLOAD_PATH/*.rar 1>/dev/null 2>/dev/null || (log "No rar file found in $DOWNLOAD_PATH. Exiting" && exit 0)

FILE_COUNT=$(ls -1 "$DOWNLOAD_PATH" | wc -l)
log "Found $FILE_COUNT files in $TR_TORRENT_DIR"

COMPLETED=0
find "$DOWNLOAD_PATH" -name "*.rar" -execdir 7z e "{}" \; && log "Extracted using 7z: $DOWNLOAD_PATH" && COMPLETED=1

FILE_COUNT_AFTER_7Z=$(ls -1 "$DOWNLOAD_PATH" | wc -l)
log "Found $FILE_COUNT_AFTER_7Z files after 7z extraction"

if [ "$FILE_COUNT" -eq "$FILE_COUNT_AFTER_7Z" ]; then
  echo "Rar extraction with 7z failed, retrying with unrar";
  COMPLETED=0
fi

if [ "$COMPLETED" -eq "0" ]; then
  find "$DOWNLOAD_PATH" -name "*.rar" -execdir unrar e "{}" \; && log "Extracted using unrar: $DOWNLOAD_PATH" && COMPLETED=1
fi

if [ "$COMPLETED" -eq "0" ]; then
  log "Extract unsuccessful : $DOWNLOAD_PATH"
fi
