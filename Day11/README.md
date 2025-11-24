📅 Day 11 – Tomcat Deployment for Java Application (Stratos DC Task)
Objective

The Nautilus application development team completed a beta version of a Java-based application.
The task is to deploy the application on App Server 2 using Tomcat, with the application accessible via a custom port (3004) and deployed directly as the base URL.

🚀 Task Overview

Install Tomcat server on App Server 2

Configure Tomcat to run on port 3004

Deploy ROOT.war file located on Jump Host /tmp

Verify the application is accessible at:

curl http://stapp02:3004

✅ Step 1: Install Tomcat

Ensure Java is installed:

java -version


Install Tomcat (for example, Tomcat 9) using yum or tarball:

sudo yum install -y tomcat
# Or for manual installation using tarball:
# wget https://downloads.apache.org/tomcat/tomcat-9/v9.0.xx/bin/apache-tomcat-9.0.xx.tar.gz
# tar -xzf apache-tomcat-9.0.xx.tar.gz -C /opt/

✅ Step 2: Configure Tomcat to Run on Port 3004

Edit server.xml (usually in /etc/tomcat/server.xml or /opt/tomcat/conf/server.xml):

<Connector port="3004" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />


Restart Tomcat service to apply changes:

sudo systemctl restart tomcat
sudo systemctl enable tomcat

✅ Step 3: Deploy the Application

Copy ROOT.war from Jump Host to Tomcat webapps directory on App Server 2:

scp user@jump_host:/tmp/ROOT.war /var/lib/tomcat/webapps/


Ensure correct ownership:

sudo chown tomcat:tomcat /var/lib/tomcat/webapps/ROOT.war


Tomcat will automatically deploy the ROOT.war as the base application.

✅ Step 4: Verify Deployment

Check Tomcat service status:

systemctl status tomcat


Test the application via curl:

curl http://stapp02:3004


You should see the HTML content of the deployed application.

Optional: Open in browser: http://stapp02:3004

📝 Outcome

Tomcat installed and configured on port 3004

ROOT.war deployed as base URL application

Application accessible via http://stapp02:3004

Service configured to start automatically on reboot