# 🚀 Day 02 — Create a Temporary User with Expiry Date

## 📘 Task Description
As part of the temporary assignment to the **Nautilus project**, a developer named **mark** requires access for a limited duration.  
To ensure proper access management, a temporary user account with an expiry date must be created.

### 🎯 Objective
Create a user named **`mark`** on **App Server 2** in the **Stratos Datacenter**,  
and set the **expiry date to `2023-12-07`**.  
Ensure the username is **lowercase**, following standard naming conventions.

---

## 🧰 Steps Followed

 1️⃣ SSH into App Server 2
      
    ssh steve@stapp02

2️⃣ Switch to the root user (if required)
    
    sudo su -

3️⃣ Create the user mark with an expiry date
   
    sudo useradd -m -e 2023-12-07 mark

4️⃣ Set password for the user (optional)

    sudo passwd mark

5️⃣ Verify the user’s expiry information
   
    sudo chage -l mark


✅ VERIFICATION OUTPUT

Example result:

Last password change                                    : Nov 05, 2025

Password expires                                        : never

Account expires                                         : Dec 07, 2023

Minimum number of days between password change          : 0

Maximum number of days between password change          : 99999

Number of days of warning before password expires       : 7

THIS CONFIRMS:

a. User mark exists

b. Account is temporary

c. Expiry date is set to December 7, 2023


💡 LEARNINGS 

a. The -e flag in useradd allows setting an account expiry date.

b. Temporary users are useful for contractors, developers, or short-term project roles.

c. The chage command helps verify and manage password/account expiry details.

d. Always maintain lowercase usernames for consistency and automation compatibility.