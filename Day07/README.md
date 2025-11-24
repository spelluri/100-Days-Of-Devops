📅 Day 07 – Password-less SSH Setup for Automation (Stratos DC Task)

Objective

The system admins team of xFusionCorp Industries needs automation scripts on the jump host to access all application servers without requiring manual password entry.
To achieve this, we must configure password-less SSH access from the thor user on the jump host to the respective sudo users on each app server.

🚀 Task Overview

Establish key-based authentication:

Jump Host User	Target Server	Sudo User
thor	           stapp01	     tony
thor	           stapp02	     steve
thor	           stapp03	     banner

This ensures that automation scripts can run seamlessly across the infrastructure.

✅ 1. Switch to thor on Jump Host
sudo su - thor

✅ 2. Generate SSH Key Pair

If not already generated:

ssh-keygen -t rsa -b 4096 -C "app-server-key"


Press Enter for all prompts to create a password-less key:

Files created:

~/.ssh/id_rsa
~/.ssh/id_rsa.pub

✅ 3. Copy Public Key to All App Servers
App Server 1
ssh-copy-id  -i ~/.ssh/id_rsa.pub tony@stapp01

App Server 2
ssh-copy-id -i ~/.ssh/id_rsa.pub steve@stapp02

App Server 3
ssh-copy-id -i ~/.ssh/id_rsa.pub banner@stapp03


Each command will prompt for the respective user’s password one last time.

✅ 4. Verify Password-less SSH
App Server 1
ssh tony@stapp01

App Server 2
ssh steve@stapp02

App Server 3
ssh banner@stapp03


You should now be able to log in without any password prompts.

🔐 Permission Validation

Ensure permissions are correct on each app server:

chmod 700 ~/.ssh
chmod 600 ~/.ssh/authorized_keys

📝 Outcome

Password-less SSH from thor → tony/steve/banner established.

Automation scripts on the jump host can now run seamlessly across all app servers.

Secure and efficient remote execution is now enabled in the Stratos DC environment.
