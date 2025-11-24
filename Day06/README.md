📅 Day 06 – Cron Job Setup on Nautilus App Servers
Objective

The Nautilus system admins team wants to test automated task scheduling before deploying production scripts across all app servers. The goal for today is to install and enable the cron service, then schedule a sample cron job for the root user.

✅ Task Summary
1. Install cronie on all Nautilus app servers

cronie provides the crond service used for running scheduled jobs.

sudo yum install -y cronie

2. Enable and start the crond service
sudo systemctl enable crond
sudo systemctl start crond


Verify the service is running:

sudo systemctl status crond

3. Add a cron job for the root user

Switch to root:

sudo su -


Open root’s crontab:

crontab -e


Add the following job to run every 5 minutes:

*/5 * * * * echo hello > /tmp/cron_text


This cron job writes the word hello to /tmp/cron_text every 5 minutes.

4. Verify the cron job

List root’s cron entries:

crontab -l


After ~5 minutes, confirm cron output:

cat /tmp/cron_text


Expected output:

hello

📝 Outcome

cronie installed and crond service enabled on all app servers

A scheduled task executes every 5 minutes for the root user

Cron functionality successfully validated