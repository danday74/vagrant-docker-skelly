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
  sudo gpasswd -a vagrant docker; # sudo usermod -aG docker vagrant;
  dockerComposeVersion='1.11.1';
  which docker-compose &>/dev/null || ( echo "Installing Docker Compose ${dockerComposeVersion} onto machine..." && sudo sh -c 'curl -L https://github.com/docker/compose/releases/download/${dockerComposeVersion}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose' &>/dev/null && sudo chmod +x /usr/local/bin/docker-compose );
  grep -q -F 'cd /vagrant' /home/vagrant/.bashrc || echo 'cd /vagrant' >> /home/vagrant/.bashrc;
  echo 'provisioning complete';
PROVISION

Vagrant.configure("2") do |config|
  # config.vm.box = "ubuntu/trusty64"
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "dandocker"
  for i in 9900..9920
    config.vm.network :forwarded_port, guest: i, host: i
  end  
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
