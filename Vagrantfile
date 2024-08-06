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

  config.vm.provision "shell", inline: <<-SHELL
    # Update package list and install necessary packages
    sudo apt-get update

    # Install Docker
    sudo apt-get install -y docker.io
    sudo systemctl start docker
    sudo systemctl enable docker

    # Install Nginx
    sudo apt-get install -y nginx
    sudo systemctl start nginx
    sudo systemctl enable nginx

    # Install Jenkins
    # Add the Jenkins Debian repository
    sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
    https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

    echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
    https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
    /etc/apt/sources.list.d/jenkins.list > /dev/null

    # Update package list again
    sudo apt-get update

    # Install Jenkins
    sudo apt-get install -y fontconfig openjdk-17-jre
    sudo apt-get install -y jenkins
    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    # Print completion message
    echo "Docker, Nginx, and Jenkins have been installed and started."
  SHELL
end
