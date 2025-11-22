⭐ Day 03 – Disable Direct Root SSH Login (KodeKloud – 100 Days of DevOps)
# 🚀 Day 03 – Disable Direct Root SSH Login  
**Challenge:** KodeKloud Engineer Task – Security Hardening (SSH)

## 🔐 Problem Statement
Following recent security audits, the **xFusionCorp Industries** security team has introduced tighter security controls within the **Stratos Datacenter**.  
One of the new requirements is to **disable direct SSH login for the root user** on all application servers.

My task was to implement these changes across all app servers.

---

## 🧠 Objective
- Disable direct root login via SSH.
- Ensure only non-root users can SSH and then escalate privileges using sudo.
- Apply configuration on **all app servers** (e.g., stapp01, stapp02, stapp03).

---

## 🛠️ Steps Performed

### 1️⃣ Connect to each app server
```bash
ssh tony@stapp01
ssh steve@stapp02
ssh banner@stapp03

2️⃣ Open SSH config file
sudo vi /etc/ssh/sshd_config

3️⃣ Locate and modify the following directive:

Change this (or uncomment it if commented):

PermitRootLogin yes

To:

PermitRootLogin no

4️⃣ Restart SSH service
sudo systemctl restart sshd


Verify service:

sudo systemctl status sshd

5️⃣ Validate configuration
sudo sshd -t


If no output appears → configuration is correct.

6️⃣ Test root login

Attempt direct login:

ssh root@stapp01


Expected:

Permission denied


This confirms root login is successfully blocked.

✅ Result

Direct SSH login for root is now disabled on all app servers in the Stratos Datacenter.
Only non-root users can log in and escalate privileges securely using sudo.

📚 What I Learned

✔ Importance of disabling root SSH login as a security best practice.
✔ How SSH daemon configuration works (/etc/ssh/sshd_config).
✔ Validating SSH configurations with sshd -t.
✔ Restarting and checking system services using systemctl.
✔ How production environments enforce strict access controls.

🎉 Day 03 Complete!

Continuing my 100 Days of DevOps journey with KodeKloud, focusing on real-world tasks and production-like troubleshooting.