#!/bin/bash
set -e

sudo apt install ufw
#IPV6=yes
#sudo nano /etc/default/ufw

sudo ufw default deny incoming
sudo ufw default allow outgoing

sudo ufw allow ssh
sudo ufw allow 22
sudo ufw allow 2222
sudo ufw allow 80
sudo ufw allow 443

#My TEST virtual Web server 
sudo ufw allow 8080
sudo ufw allow 8081
sudo ufw allow 8082
sudo ufw allow 8083
sudo ufw allow 8084

##Specific Port Ranges
#sudo ufw allow 6000:6007/tcp
##Specific IP Addresses
#sudo ufw allow from 203.0.113.4
#sudo ufw allow from 203.0.113.4 to any port 22
##Subnets
#sudo ufw allow from 203.0.113.0/24
#sudo ufw allow from 203.0.113.0/24 to any port 22


##Connections to a Specific Network Interface
#ip addr
#2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
#    link/ether 74:d4:35:f7:0a:f6 brd ff:ff:ff:ff:ff:ff
#    inet 192.168.10.209/24 brd 192.168.10.255 scope global dynamic noprefixroute eno1
#       valid_lft 32167sec preferred_lft 32167sec
#    inet6 fe80::1040:f1b4:4144:3edf/64 scope link noprefixroute 
#       valid_lft forever preferred_lft forever

#sudo ufw allow in on eth0 to any port 80

sudo ufw enable


##Denying Connections
#sudo ufw deny http
#sudo ufw deny from 203.0.113.4




sudo ufw status numbered

