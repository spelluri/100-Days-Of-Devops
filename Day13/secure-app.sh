#!/bin/bash

#Variables
LBR_IP="172.16.238.14"
PORT="8089"

#1. Install iptables and dependencies.
echo "Installing iptables...."
sudo yum install iptables-services -y

#2.Start iptables service.
sudo systemctl start iptables
sudo systemctl enable iptables

#3. Flush existing rules.
sudo iptables -F

#4.Allow LBR host to access port.
echo "Allowing LBR host $LBR_IP access to $PORT ..."
sudo iptables -A INPUT -p tcp -s $LBR_IP --dport $PORT -j ACCEPT

#5.Block everyone else on port.
echo "Blocking all other hosts on port $PORT..."
sudo iptables -A INPUT -p tcp --dport $PORT -j DROP

#6. Save iptables rules.
sudo service iptables save

#7. Restart iptables service.
sudo systemctl restart iptables

#8. Display iptables rules.
echo "Current iptables rules:"
sudo iptables -L -v -n