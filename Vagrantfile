# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.7.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "bento/centos-7.2"

  config.ssh.insert_key = false
  config.vm.network 'forwarded_port', guest: 80, host: 8888

  # Give the VM lots of RAM and a pair of CPUs
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '2048']
    vb.customize ['modifyvm', :id, '--cpus', '2']
    vb.customize ['modifyvm', :id, '--ioapic', 'on']

    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "deploy/site.yml"

    ansible.groups = {
      "webservers" => ["default"],
      "dbserver" => ["default"],
      "solrserver" => ["default"]
    }
  end

  config.vm.synced_folder "downloads", "/opt/downloads"
end
