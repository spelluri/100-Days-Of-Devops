# 🚀 Day 01 — Create a User with Non-Interactive Shell

## 📘 Task Description
To accommodate the backup agent tool's specifications, the system admin team at **xFusionCorp Industries** requires the creation of a user with a non-interactive shell.

### 🎯 Objective
Create a user named **`james`** with a **non-interactive shell** on **App Server 3**.

---

## 🧰 Steps Followed

   1️⃣ SSH into App Server 3
        ssh tony@stapp03
   2️⃣ Create the user james with a non-interactive shell
        sudo useradd -m -s /sbin/nologin james
   3️⃣ Verify user creation
        grep james /etc/passwd

✅ Verification Output
Example result:

james:x:1003:1003::/home/james:/sbin/nologin

This confirms:

User james exists

A home directory /home/james was created

Shell is /sbin/nologin (non-interactive)

💡 Learnings

The /sbin/nologin shell prevents the user from logging into the system interactively.

Such accounts are used for system processes, backup agents, or automated tasks that need an identity but not a login shell.

Verifying /etc/passwd entries is a reliable way to confirm user shell configurations.


