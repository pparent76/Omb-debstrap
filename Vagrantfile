Vagrant.configure("2") do |config|
  config.vm.box = "debian/jessie64"
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get -y upgrade
    cd /vagrant/
    DEBIAN_FRONTEND=noninteractive ./main.sh
  SHELL
end
