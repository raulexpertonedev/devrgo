Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/focal64"
  config.vm.hostname = "devrgo"
  config.vm.network "private_network", ip: "192.168.33.20"
  config.vm.provider "virtualbox" do |vb|
    # vb.gui = true
    vb.memory = "2048"    
  end
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook ="provisioning/playbook.yml"
  end
end