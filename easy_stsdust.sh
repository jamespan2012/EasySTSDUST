#!/bin/bash
yum install -y iptables-services
yum install -y wget
systemctl stop firewalld
systemctl disable firewalld
systemctl start iptables
systemctl enable iptables
echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf
echo 1 > /proc/sys/net/ipv4/ip_forward
sysctl -p
iptables -F
iptables -t nat -F
iptables -t raw -F
iptables -t mangle -F
service iptables save
wget -O natcfg.sh https://raw.githubusercontent.com/stsdust/iptablesUtils/master/natcfg_modified.sh && bash natcfg.sh