# 🚀 Day 04 – Grant Executable Permissions to a Script  
**Challenge:** KodeKloud Engineer Task – Linux Permissions

## 🔐 Problem Statement
The xFusionCorp Industries sysadmin team has created a new backup automation script named **xfusioncorp.sh**.  
Although the script has been distributed to all application servers, it is **not executable on App Server 3**.

My task was to:

- Grant executable permissions to `/tmp/xfusioncorp.sh`  
- Ensure **all users** can execute the script  

---

## 🧠 Objective
- Understand file permission attributes in Linux  
- Modify permissions using `chmod`  
- Ensure script execution rights for everyone  

---

## 🛠️ Steps Performed

### 1️⃣ SSH into App Server 3
```bash
ssh banner@stapp03

2️⃣ Confirm the script exists
    ls -l /tmp/xfusioncorp.sh

3️⃣ Grant executable permissions for all users
To allow everyone to execute the script:
sudo chmod 755 /tmp/xfusioncorp.sh

4️⃣ Verify the new permissions

ls -l /tmp/xfusioncorp.sh

Expected output:
-rwxr-xr-x 1 root root ... xfusioncorp.sh
This means:

rwx → owner can read, write, execute

r-x → group can read and execute

r-x → others can read and execute

✅ Result
The script /tmp/xfusioncorp.sh is now executable by any user on App Server 3.
This fulfills the requirement for running automated backup processes across the environment.

📚 What I Learned
✔ Understanding Linux permission bits
✔ How to use numeric and symbolic modes in chmod
✔ Importance of file permissions in multi-user environments
✔ Validating permission changes using ls -l