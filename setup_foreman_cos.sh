#!/bin/bash

yum update -y --exclude=kernel*
yum -y install http://yum.theforeman.org/releases/1.2/el6/x86_64/foreman-release.rpm
yum -y install foreman-installer

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
# edit /etc/default/foreman