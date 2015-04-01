# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos-6.5-x86_64"
  config.vm.box_url = "https://www.hpc.jcu.edu.au/boxes/centos-6.5-x86_64.box"

  #Re-build the Shibboleth SP with FastCGI support
  config.vm.provision :shell, :path => "rebuild.sh"
  config.vm.provision :shell, :path => "copy-rpms-out.sh"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "8"]
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end

end
