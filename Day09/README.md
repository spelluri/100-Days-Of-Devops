📅 Day 09 – Fixing MariaDB Service on Database Server (Stratos DC Task)

Objective
The Nautilus application in Stratos DC was unable to connect to the database because the MariaDB service was down.
The goal of this task is to troubleshoot and fix MariaDB so that the application can connect successfully.

🚨 Issue Identified

MariaDB service failed to start:

Make sure the /var/lib/mysql is empty before running mariadb-prepare-db-dir.
The /var/lib/mysql directory was missing, preventing database initialization.

✅ Step 1: Create MySQL Data Directory
sudo mkdir -p /var/lib/mysql
sudo chown mysql:mysql /var/lib/mysql
sudo chmod 700 /var/lib/mysql


Ensures the directory exists.

Sets correct ownership (mysql:mysql) and permissions (700).

✅ Step 2: Initialize the MariaDB Database
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql


Initializes the database for MariaDB 10.5+

If mariadb-install-db is not available, use:

sudo mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

✅ Step 3: Start and Enable MariaDB Service
sudo systemctl start mariadb
sudo systemctl enable mariadb


Starts the service immediately.

Ensures it starts automatically on boot.

✅ Step 4: Verify MariaDB Service
systemctl status mariadb


Expected output:

Active: active (running)


📝 Outcome

/var/lib/mysql created and initialized

MariaDB service is running successfully

Nautilus application can now connect to the database