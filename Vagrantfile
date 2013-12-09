# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

VM_BOX = "saucy64"
VM_BOX_URL = "https://dl.dropboxusercontent.com/u/6154794/Vagrant/saucy64.box"
VM_IP_ADDRESS = "192.168.33.11"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = VM_BOX
  config.vm.box_url = VM_BOX_URL
  config.vm.network :private_network, ip: VM_IP_ADDRESS
  config.ssh.forward_agent = true
  config.vm.synced_folder ".", "/vagrant", id: "vagrant-root"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
  end

end
