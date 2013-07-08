#!/bin/bash

echo "deb http://deb.theforeman.org/ precise stable" > /etc/apt/sources.list.d/foreman.list
wget -q http://deb.theforeman.org/foreman.asc -O- | apt-key add -
apt-get update 
apt-get upgrade -y
apt-get dist-upgrade -y
apt-get install -y foreman-installer

cat > /usr/share/foreman-installer/foreman_installer/answers.yaml << EOF
foreman: true
foreman:
  authentication: false
  ssl: false
  organizations_enabled: true
  locations_enabled: true
puppet: true
puppet:
  version: latest
puppetmaster: true
puppetmaster:
  git_repo: false
foreman_proxy: true
foreman_proxy:
  tftp_servername: 192.168.100.51
  dhcp: true
  dhcp_interface: eth1
  dhcp_gateway: 192.168.100.2
  dhcp_range: 192.168.100.50 192.168.100.250
  dhcp_nameservers: 192.168.100.51
  dns: true
  dns_interface: eth1
  dns_reverse: 100.168.192.in-addr.arpa
  dns_server: 127.0.0.1
  dns_forwarders: ['8.8.8.8']
EOF

echo include foreman_installer | puppet apply --modulepath /usr/share/foreman-installer -v

# install foreman-fog foreman-console
# create location
# create organisation
# create domain
# import subnets
