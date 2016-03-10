# vagrant-docker-skelly

The [Vagrantfile](https://www.vagrantup.com) spins up an Ubuntu box with [Docker](https://www.docker.com) and [Docker Compose](https://docs.docker.com/compose/) installed.

A few docker images are pulled during provisioning for demo purposes via an external script.

The images are pulled from the public docker registry and an insecure docker registry.

## NOTES

* The Vagrant plugin vagrant-proxyconf sets the proxy for docker by updating */etc/default/docker* automatically based on Windows http_proxy environment variables.

* The insecure docker registry is registered via an inline provisioning script which adds an entry to */etc/default/docker*.
