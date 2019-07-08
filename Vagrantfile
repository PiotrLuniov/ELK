
Vagrant.configure("2") do |config|

  config.vm.define "tomcat01" do |tomcat01|
    tomcat01.vm.box = "sbeliakou/centos"
    tomcat01.vm.hostname = "tomcat01"
    tomcat01.vm.network "private_network", ip:"172.33.33.100"
    tomcat01.vm.provision "shell", path:"tomcat01.sh"
    tomcat01.vm.provider "virtualbox" do |vb|
      vb.name = "tomcat01"
      vb.memory = "2048"
    end
  end

  config.vm.define "ek01" do |ek01|
  ek01.vm.box = "sbeliakou/centos"
  ek01.vm.hostname = "ek01"
  ek01.vm.network "private_network", ip:"172.33.33.200"
  ek01.vm.provision "shell", path:"ek01.sh"
  ek01.vm.provider "virtualbox" do |vb|
    vb.name = "ek01"
    vb.memory = "2048"
    end
  end
end
