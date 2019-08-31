# -*- mode: ruby -*-
# vi: set ft=ruby :

# Note that docker-desktop does not support running inside a nested virtualization, like this hyper-v ontop of kvm
# "Docker Desktop is not supported in nested virtualization scenarios. It might work in some cases, and not in others"
# https://docs.docker.com/docker-for-windows/troubleshoot/#running-docker-desktop-in-nested-virtualization-scenarios
# If docker-desktop fails to start with "Timed out waiting for the lifecycle-server to start"
# modify "lifecycleTimeoutSeconds": from 180 to e.g. 300 in C:\Users\vagrant\AppData\Roaming\Docker\settings.json
# Logs are in in C:\Users\vagrant\AppData\Local\Docker\log.txt
# Note that a different version of docker-desktop may start just fine https://github.com/docker/for-win/issues/4393

# https://github.com/vagrant-libvirt/vagrant-libvirt#installation
# apt-get build-dep ruby-libvirt -y
# apt-get install qemu libvirt-bin ebtables dnsmasq-base -y
# apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev -y
# https://app.vagrantup.com/peru/boxes/windows-10-enterprise-x64-eval
# vagrant plugin install vagrant-libvirt
# VAGRANT_DEFAULT_PROVIDER=libvirt vagrant up

Vagrant.configure(2) do |config|
  config.vm.define 'windows' do |machine|
    machine.vm.box = 'peru/windows-10-enterprise-x64-eval'
    machine.vm.box_url = machine.vm.box
    machine.vm.provider 'libvirt' do |p|
      p.memory = 2048  # Windows is greedy
      p.cpus = 1
      p.nested = true
    end
    machine.ssh.shell = 'powershell'
  end
  config.vm.define 'windows' do |machine|
    # install chocolatey
    # the lines below fail https://github.com/ruzickap/packer-templates/issues/27
    machine.vm.provision :shell, privileged: 'true', powershell_elevated_interactive: 'true', :inline => 'powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString(\'https://chocolatey.org/install.ps1\'))"'
    machine.vm.provision :shell, privileged: 'true', powershell_elevated_interactive: 'true', :inline => 'choco install -y docker-desktop --version 2.1.1.0-edge'
    machine.vm.provision :shell, privileged: 'true', powershell_elevated_interactive: 'true', :inline => 'choco install -y docker-compose'
    machine.vm.provision :shell, privileged: 'true', powershell_elevated_interactive: 'true', :inline => 'restart-computer -force'
  end
end
