📅 Day 08 – Installing Ansible 4.8.0 on Jump Host (Stratos DC Task)

Objective
The Nautilus DevOps team decided to begin using Ansible for automation and configuration management.
To start experimenting, the jump host will be configured as the Ansible Controller by installing Ansible 4.8.0 using pip3, ensuring the binary is accessible system-wide for all users.

🚀 Task Overview

Install Ansible version 4.8.0 using pip3 (not yum).

Ensure the ansible binary is globally available for all system users.

Validate the installation.

✅ 1. Install pip3 (if not already installed)

Check if pip3 exists:

pip3 --version

If missing:

sudo yum install -y python3-pip

✅ 2. Install Ansible 4.8.0 using pip3

   sudo pip3 install ansible==4.8.0

  This installs Ansible globally under /usr/local/bin by default.

✅ 3. Verify Installation
    ansible --version


Expected output should show:

ansible 4.8.0

ansible [core 2.11.x]

🔧 4. Ensure Ansible is Available for All Users

If ansible is not found for some users, ensure /usr/local/bin is in the global PATH:

Add global PATH entry
echo 'export PATH=$PATH:/usr/local/bin' | sudo tee /etc/profile.d/ansible.sh


Make it executable:

sudo chmod +x /etc/profile.d/ansible.sh


Reload system profile:

source /etc/profile

🧪 5. Test From Another User (Optional)
su - someuser
ansible --version


You should still see Ansible 4.8.0.

📝 Outcome

Ansible 4.8.0 successfully installed via pip3

Binary globally accessible to all system users

Jump host ready to act as the Ansible Controller