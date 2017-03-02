# vagrant-docker-skelly

The [Vagrantfile](Vagrantfile) spins up an Ubuntu box with [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose) installed.

A few docker images are pulled during provisioning for demo purposes via an [external script](autoPull.sh).

The images are pulled from the public docker registry.

## NOTES

The Vagrant plugin vagrant-proxyconf sets the proxy for docker by updating */etc/default/docker* automatically based on Windows http_proxy environment variables.

## GO GO GO

```docker
git clone git@github.com:danday74/vagrant-docker-skelly.git
cd vagrant-docker-skelly
vagrant up # takes approx 5 mins to create VM
vagrant ssh
docker -v
docker-compose -v
```

The [Vagrantfile](Vagrantfile) defines which ports are exposed, which folders are shared, etc.
