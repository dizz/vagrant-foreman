
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu12-latest"
  #config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.hostname = "foreman.cloudcomp.dev"

  config.vm.network :private_network, ip: "192.168.100.51"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  config.vm.provision :shell, :path => "setup_foreman.sh"

end