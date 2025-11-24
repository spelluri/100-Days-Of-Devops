#!/bin/bash

#Variables
echo "Archiving Backup Of Files"
source_dir='/var/www/html/news'
backup_dir='/backup'
backup_server_user='clint'
backup_server_ip='172.16.238.16'
zipfile_location='/backup/xfusioncorp_news.zip'

# Check if source directory exists
if [ ! -d "$source_dir" ]; then
    echo "Error: Source directory $source_dir does not exist"
    exit 1
fi

# Zip the file
zip -r $backup_dir/xfusioncorp_news.zip  $source_dir
if [ $? -eq 0 ]; then
    echo "Zip File Created successfully"
else
    echo "Error: Zip File Creation Failed"
    exit 1
fi

#Copy created archive file to Nautilus Backup Server.
scp $zipfile_location $backup_server_user@$backup_server_ip:/backup
if [ $? -eq 0 ]; then
    echo "Backup completed successfully"
else
    echo "Error: Failed to copy to backup server"
    exit 1
fi