# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-vbguest")
  puts
  warn "OOPS! vbguest plugin is not installed"
  puts
  warn "Run the following to install:"
  abort "vagrant plugin install vagrant-vbguest"
end
unless Vagrant.has_plugin?("vagrant-proxyconf")
  puts
  warn "OOPS! proxyconf plugin is not installed"
  puts
  warn "Run the following to install:"
  abort "vagrant plugin install vagrant-proxyconf"
end

$provision = <<PROVISION
  # sudo apt-get install -y curl;
  # curl -s -L https://get.docker.com/ | sudo bash;
  sudo gpasswd -a vagrant docker;
  sudo sed -i '/DOCKER_OPTS=/c\DOCKER_OPTS="$DOCKER_OPTS --insecure-registry=10.20.2.139:5000"' /etc/default/docker;
  sudo service docker restart;
  dockerComposeVersion='1.6.2';
  which docker-compose &>/dev/null || ( echo "Installing Docker Compose ${dockerComposeVersion} onto machine..." && sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/${dockerComposeVersion}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose' &>/dev/null && sudo chmod +x /usr/local/bin/docker-compose );
  grep -q -F 'cd /vagrant' /home/vagrant/.bashrc || echo 'cd /vagrant' >> /home/vagrant/.bashrc;
  echo 'provisioning complete';
PROVISION

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "dandocker"
  config.vm.network :forwarded_port, host: 9010, guest: 80
  config.vm.network :forwarded_port, host: 9100, guest: 9100
  config.vm.network :forwarded_port, host: 8843, guest: 8843
  config.vm.network :forwarded_port, host: 5432, guest: 5432
  config.proxy.http     = ENV['HTTP_PROXY']
  config.proxy.https    = ENV['HTTPS_PROXY']
  config.proxy.no_proxy = ENV['NO_PROXY']

  config.vm.provider "virtualbox" do |vb|
    vb.name = "dandocker"
    vb.memory = 4096
    vb.cpus = 2
  end

  config.vm.provision "docker" do |d|
    # installs docker
  end

  config.vm.provision :shell do |sh|
    sh.privileged = false
    sh.inline = $provision
  end

  config.vm.provision :shell do |sh|
    sh.privileged = true
    sh.path = "autoPull.sh"
  end

end
