#!/bin/bash

echo "deb http://deb.theforeman.org/ precise stable" > /etc/apt/sources.list.d/foreman.list
wget -q http://deb.theforeman.org/foreman.asc -O- | apt-key add -
apt-get update 
apt-get upgrade -y
# apt-get dist-upgrade -y
apt-get install -y foreman-installer

cat > /usr/share/foreman-installer/foreman_installer/answers.yaml << EOF
foreman:
  authentication: false
  ssl: false
  organizations_enabled: true
  locations_enabled: true
puppet:
  version: latest
puppetmaster:
  git_repo: false
foreman_proxy:
  tftp_servername: 192.168.100.51
  dhcp: true
  dhcp_interface: eth1
  dhcp_gateway: 192.168.100.51
  dhcp_range: 192.168.100.50 192.168.100.250
  dhcp_nameservers: 192.168.100.51
  dns: true
  dns_interface: eth1
  dns_reverse: 100.168.192.in-addr.arpa
  dns_server: 127.0.0.1
  dns_forwarders: ['8.8.8.8']
EOF

echo include foreman_installer | puppet apply --modulepath /usr/share/foreman-installer -v

apt-get install foreman-compute foreman-fog

# PUB=eth0
# PRIV=eth1
# /sbin/iptables --table nat --append POSTROUTING --out-interface $PUB -j MASQUERADE
# /sbin/iptables --append FORWARD --in-interface $PRIV -j ACCEPT
# sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/' /etc/sysctl.conf
# sysctl -p

# create location
# create organisation
# create domain
# import subnets
# edit /etc/default/foreman