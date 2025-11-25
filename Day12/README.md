Day12 : Apache Port Conflict Resolution - Stratos Datacenter
Problem Statement
Apache service on app server is not reachable on the configured port from the jump host. Investigation reveals that another service (e.g., sendmail) is already using the required port, preventing Apache from binding to it.
Environment Details

Jump Host: Accessible with user thor
App Server: stapp01 (or stapp02, stapp03)
App Server User: tony (or steve, banner) with sudo privileges
Apache Port: Custom port (e.g., 5003)
Test Command: curl http://stapp01:5003 from jump host

Issue Overview
This task involves a port conflict scenario where:

Apache needs to listen on a specific port (5003)
Another service (sendmail) is already occupying that port
Apache cannot start on the required port due to the conflict
Firewall may also be blocking the port

Initial Diagnosis
Step 1: Test Connectivity from Jump Host
bash# From jump host (as thor user)
curl http://stapp01:5003
# Expected error: Connection refused, timeout, or "No route to host"

# Try telnet to check port accessibility
telnet stapp01 5003

# Alternative with netcat
nc -zv stapp01 5003

Step 2: SSH to App Server
bash# From jump host
ssh tony@stapp01
# Enter password when prompted
Detailed Troubleshooting Steps

Step 3: Check Apache Service Status
bash# Check if Apache (httpd) is running
sudo systemctl status httpd
# Check which port Apache is configured to use
sudo grep "^Listen" /etc/httpd/conf/httpd.conf

Step 4: Identify Port Usage (Critical Step)
bash
# Check what's currently using port 5003
sudo netstat -tulpn | grep 5003

# Check all ports Apache is using
sudo netstat -tulpn | grep httpd
Example output showing the conflict:
tcp        0      0 127.0.0.1:5003          0.0.0.0:*               LISTEN      492/sendmail: accep
☝️ This shows sendmail is using port 5003, not Apache!

Step 5: Check All Listening Services
bash# List which service is  listening on port 5003
sudo netstat -tulpn | grep 5003

# Check sendmail status
sudo systemctl status sendmail
Solution Steps
Fix 1: Stop the Conflicting Service (Sendmail)
Since Apache needs port 5003, we must free it up:
bash# Stop sendmail service
sudo systemctl stop sendmail

# Verify sendmail is stopped
sudo systemctl status sendmail

# Disable sendmail from auto-starting (optional but recommended)
sudo systemctl disable sendmail

# Verify port 5003 is now free
sudo netstat -tulpn | grep 5003
# Should return nothing (port is free)
Fix 2: Configure Apache to Listen on Port 5003
bash# Check current Apache Listen configuration
sudo grep "^Listen" /etc/httpd/conf/httpd.conf

# Change Apache to listen on port 5003
sudo sed -i 's/^Listen .*/Listen 5003/' /etc/httpd/conf/httpd.conf

# Verify the change
sudo grep "^Listen" /etc/httpd/conf/httpd.conf
# Should output: Listen 5003

# Test Apache configuration syntax
sudo httpd -t
# Should output: Syntax OK

# Alternative manual editing
sudo vi /etc/httpd/conf/httpd.conf
# Find the line starting with "Listen" and change it to:
# Listen 5003
Fix 3: Start/Restart Apache Service
bash# Start Apache if it's not running
sudo systemctl start httpd

# Or restart Apache if it's already running
sudo systemctl restart httpd

# Enable Apache to start on boot
sudo systemctl enable httpd

# Verify Apache is running
sudo systemctl status httpd

# Verify Apache is now listening on port 5003
sudo netstat -tulpn | grep 5003
# Should now show httpd process, not sendmail
Expected output after fix:
tcp6       0      0 :::5003                 :::*                    LISTEN      1234/httpd
Fix 4: Test Local Connectivity
bash# Test from the app server itself
curl http://localhost:5003
curl http://127.0.0.1:5003
curl http://stapp01:5003

# Should return HTML content from Apache
Fix 5: Configure Firewall (iptables)
If local curl works but jump host still can't connect, it's a firewall issue:
bash# Check current iptables rules
sudo iptables -L INPUT -n -v

# Add rule to allow port 5003
sudo iptables -I INPUT -p tcp --dport 5003 -j ACCEPT

# Verify the rule was added
sudo iptables -L INPUT -n -v | grep 5003

# Save the rules (for persistence after reboot)
sudo service iptables save
# or
sudo iptables-save | sudo tee /etc/sysconfig/iptables

# Verify firewall rule
sudo iptables -S | grep 5003

Step 8: Final Test from Jump Host
bash# From jump host (as thor user)
curl http://stapp01:5003
# Should return HTML content - SUCCESS! ✅


Common Port Conflicts
ServiceDefault PortCommon Conflictssendmail25, 587May bind to custom ports like 5003httpd (Apache)80, 443Conflicts when custom port is occupiedpostfix25May conflict with sendmailnginx80, 443Conflicts with Apache on same porttomcat8080May use custom ports
Troubleshooting Decision Tree
Is Apache reachable from jump host?
│
├─ NO → SSH to app server
│       │
│       ├─ Check: sudo netstat -tulpn | grep <PORT>
│       │
│       ├─ Is another service using the port?
│       │  │
│       │  ├─ YES → Stop that service
│       │  │        └─ sudo systemctl stop <service>
│       │  │
│       │  └─ NO → Is Apache configured for correct port?
│       │          │
│       │          ├─ NO → Fix Apache config
│       │          │       └─ Edit httpd.conf Listen directive
│       │          │
│       │          └─ YES → Is Apache running?
│       │                   │
│       │                   ├─ NO → Start Apache
│       │                   │       └─ sudo systemctl start httpd
│       │                   │
│       │                   └─ YES → Check firewall
│       │                           └─ Add iptables rule
│       │
│       └─ Test from jump host
│
└─ YES → Task complete! ✅
Important Notes
⚠️ Do NOT modify the index.html file - This will cause task failure
⚠️ Port Conflict Priority - Always check what's using the port before configuring Apache
⚠️ Service Dependencies - Stopping sendmail may affect mail functionality (usually not needed in this environment)
⚠️ Security - Only open the specific required port, don't disable entire firewall
⚠️ Persistence - Disable conflicting services to prevent them from starting on reboot
Common Errors and Solutions
Error 1: "Address already in use"
Error message:
(98)Address already in use: AH00072: make_sock: could not bind to address [::]:5003
Solution:
bash# Find what's using the port
sudo netstat -tulpn | grep 5003
# Stop the conflicting service
sudo systemctl stop <conflicting_service>
Error 2: "Connection refused"
Symptom: curl: (7) Failed to connect to stapp01 port 5003: Connection refused
Solution:

Apache is not running → sudo systemctl start httpd
Apache not listening on port → Fix httpd.conf

Error 3: "No route to host"
Symptom: curl: (7) Failed to connect to stapp01 port 5003: No route to host
Solution:
bash# Add firewall rule
sudo iptables -I INPUT -p tcp --dport 5003 -j ACCEPT
Error 4: "Permission denied" (SELinux)
Check logs:
bashsudo tail -f /var/log/httpd/error_log
sudo ausearch -m avc -ts recent
Solution:
bashsudo semanage port -a -t http_port_t -p tcp 5003
Diagnostic Commands Reference
Port and Service Checks
bash# Check what's using a specific port
sudo netstat -tulpn | grep <PORT>
sudo ss -tulpn | grep <PORT>
sudo lsof -i :<PORT>

# Check all listening ports
sudo netstat -tulpn
sudo ss -tulpn

# Check specific service status
sudo systemctl status <service>

# List all running services
sudo systemctl list-units --type=service --state=running
Apache-Specific Commands
bash# Check Apache status
sudo systemctl status httpd

# Test Apache configuration
sudo httpd -t
sudo apachectl configtest

# Check Apache version
httpd -v

# View Apache error logs
sudo tail -f /var/log/httpd/error_log

# View Apache access logs
sudo tail -f /var/log/httpd/access_log

# Check Apache modules
httpd -M

# Find Apache config files
sudo find /etc/httpd -name "*.conf"
Firewall Commands
bash# List all iptables rules
sudo iptables -L -n -v
sudo iptables -S

# Check specific port in iptables
sudo iptables -L INPUT -n -v | grep <PORT>

# Add rule to allow port
sudo iptables -I INPUT -p tcp --dport <PORT> -j ACCEPT

# Delete specific rule
sudo iptables -D INPUT -p tcp --dport <PORT> -j ACCEPT

# Save iptables rules
sudo service iptables save
sudo iptables-save | sudo tee /etc/sysconfig/iptables
Process Management
bash# Find process by port
sudo lsof -i :<PORT>

# Find process by name
ps aux | grep <service>

# Kill process by PID
sudo kill -9 <PID>

# Stop service gracefully
sudo systemctl stop <service>
Success Criteria Checklist

 Identified the service causing port conflict (sendmail on port 5003)
 Stopped the conflicting service (sendmail)
 Configured Apache to listen on port 5003
 Apache service is running
 Apache is listening on port 5003 (verified with netstat)
 Local connectivity works (curl from app server)
 Firewall rule added for port 5003
 curl http://stapp01:5003 from jump host returns HTML content
 No security settings compromised
 index.html file remains unchanged

Testing Checklist
bash# On app server (stapp01)
□ sudo systemctl status sendmail    # Should be inactive
□ sudo systemctl status httpd        # Should be active (running)
□ sudo netstat -tulpn | grep 5003    # Should show httpd, not sendmail
□ curl http://localhost:5003         # Should return HTML
□ sudo iptables -L INPUT -n -v | grep 5003  # Should show ACCEPT rule

# From jump host
□ curl http://stapp01:5003           # Should return HTML (SUCCESS!)
□ telnet stapp01 5003                # Should connect
