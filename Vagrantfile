# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "geerlingguy/centos7"

  # Override the SSH port to something not 22, forward HTTP
  config.ssh.port = 2222
  config.vm.network 'forwarded_port', guest: 80, host: 8888

  # Give the VM lots of RAM and a pair of CPUs
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--ioapic', 'on']

    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.synced_folder "downloads", "/opt/downloads"
  config.vm.synced_folder "yum-cache", "/var/cache/yum"
end
