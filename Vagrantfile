
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  centos = false

  if centos
    config.vm.box = 'CentOS-6.4-x86_64-v20130427'
    config.vm.box_url = 'http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-x86_64-v20130427.box'
  else
    config.vm.box = "ubuntu12-latest"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  end

  config.vm.hostname = "foreman.cloudcomp.dev"

  config.vm.network :private_network, ip: "192.168.100.51"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  if centos
    config.vm.provision :shell, :path => "setup_foreman_cos.sh"
  else
    config.vm.provision :shell, :path => "setup_foreman_ubu.sh"
  end

end