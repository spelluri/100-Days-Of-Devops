📅 Day 10 – Official Website Backup Task (Stratos DC)

Objective
The Nautilus production support team requires a backup solution for the official website running on App Server 3.

The backup must:

a. Create an archive of /var/www/html/official
b. Store the backup locally in /backup
c.Copy the backup to the Nautilus Backup Server /backup directory
d.Run without prompting for a password
e.Be executable by the respective system user (e.g., tony)
f.Avoid using sudo in the automation

✅ Prerequisites

1. Zip package installed on App Server 3:

sudo yum install -y zip


2. Directories created with proper permissions:

sudo mkdir -p /scripts /backup
sudo chown tony:tony /scripts /backup   # adjust user as needed


3. Password-less SSH access from App Server 3 user to Nautilus Backup Server:

ssh-keygen -t rsa -b 4096 -C "backup-server-key"  # generate key if not already in app server
ssh-copy-id -i ~/.ssh/id_rsa.pub backup@nastrbk01 # copy key to backup server from app server.

✅ Task Execution

Place the prepared backup script in /scripts directory on App Server 3.

Ensure the script is executable:

chmod +x /scripts/official_backup.sh


Run the script to perform the backup:

/scripts/official_backup.sh


Verify backups:

Locally on App Server 3:

ls -l /backup/


On Nautilus Backup Server:

ssh backup@nastrbk01 ls -l /backup/

📝 Outcome

Backup archive is created and stored locally

Backup successfully copied to the Nautilus Backup Server

Script executes without requiring passwords

Ready for automation (e.g., via cron)

