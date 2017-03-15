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
  dockerComposeVersion='1.11.2';
  which docker-compose &>/dev/null || ( echo "Installing Docker Compose ${dockerComposeVersion} onto machine..." && sudo curl -L "https://github.com/docker/compose/releases/download/${dockerComposeVersion}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose &>/dev/null && sudo chmod +x /usr/local/bin/docker-compose );
  grep -q -F 'cd /home/ubuntu/shared' /home/ubuntu/.bashrc || echo 'cd /home/ubuntu/shared' >> /home/ubuntu/.bashrc;
  echo 'provisioning complete';
PROVISION

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.hostname = "dandocker"
  for i in 9900..9920
    config.vm.network :forwarded_port, guest: i, host: i
  end
  for j in [51108, 51109, 52922, 52923, 54101, 54102, 53192, 53193]
    config.vm.network :forwarded_port, guest: j, host: j
  end
  config.vm.synced_folder "shared/", "/home/ubuntu/shared"
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
