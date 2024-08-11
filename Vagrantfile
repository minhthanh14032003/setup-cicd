Vagrant.configure("2") do |config|
  config.vm.box = "starboard/ubuntu-arm64-20.04.5"
  config.vm.box_version = "20221120.20.40.0"
  config.vm.box_download_insecure = true
  config.vm.provider "vmware_desktop" do |vm|
      vm.ssh_info_public = true
      # vm.gui = true
      vm.linked_clone = false
      vm.vmx["ethernet0.virtualdev"] = "vmxnet3"
      vm.memory = "2048"
      vm.cpus = "4"
  end

  # Forward port from host to guest
  config.vm.network "forwarded_port", guest: 80, host: 8080
  
  # Set static IP
  config.vm.network "private_network", ip: "192.168.56.101"
  


  config.vm.provision "shell", path: "provision.sh"
end
