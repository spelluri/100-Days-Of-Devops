# 🚀 Day 05 – SELinux Configuration on App Server 1  
**Challenge:** KodeKloud Engineer Task – SELinux Security Setup

## 🔐 Problem Statement
Following a security audit, the xFusionCorp Industries security team decided to strengthen server and application security using **SELinux**.  

For **App Server 1**, the following requirements were provided:

- Install all required SELinux packages.
- Permanently disable SELinux for now (it will be re-enabled later).
- Do **not** reboot the server (a maintenance reboot is already scheduled).
- Ignore the live SELinux status; only the **post-reboot** state matters.

---

## 🧠 Objective
- Work with SELinux packages and system security modules.
- Configure SELinux to be **disabled on next boot**.
- Understand SELinux runtime vs. persistent configuration.

---

## 🛠️ Steps Performed

### 1️⃣ SSH into App Server 1
ssh tony@stapp01

2️⃣ Install SELinux packages

sudo yum install -y selinux-policy selinux-policy-targeted policycoreutils policycoreutils-python
sudo yum install -y libselinux-utils

3️⃣ Permanently disable SELinux
Edit the config file:
sudo vi /etc/selinux/config
Update the line:
From:
ini
Copy code
SELINUX=enforcing

To:
ini
Copy code
SELINUX=disabled
Save and exit.

4️⃣ No reboot required
The task explicitly states not to reboot.
SELinux will be disabled after tonight’s scheduled maintenance reboot.

5️⃣ Ignore current live SELinux status
getenforce
may still show:
nginx
Enforcing
or
nginx
Permissive
This is expected.
Only the post-reboot status matters.

✅ Result
SELinux packages installed successfully.

SELinux configured to be disabled on next boot.

Server is left running without manual reboot as requested.

📚 What I Learned

✔ How to install SELinux packages on RHEL/CentOS
✔ Difference between runtime SELinux mode and persistent configuration
✔ How /etc/selinux/config controls next-boot state
✔ Why security teams disable SELinux temporarily before tuning policies.