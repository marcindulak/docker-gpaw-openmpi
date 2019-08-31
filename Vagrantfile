# -*- mode: ruby -*-
# vi: set ft=ruby :

# http://stackoverflow.com/questions/23926945/specify-headless-or-gui-from-command-line
def gui_enabled?
  !ENV.fetch('GUI', '').empty?
end

Vagrant.configure(2) do |config|
  config.vm.define "windows" do |machine|
    machine.vm.box = "gusztavvargadr/docker-windows"
    machine.vm.box_url = machine.vm.box
    machine.vm.provider "virtualbox" do |p|
      p.memory = 1536  # Windows is greedy
      p.cpus = 1
      p.gui = gui_enabled?
    end
    machine.ssh.shell = "powershell"
  end
  config.vm.define "windows" do |machine|
    # install chocolatey
    machine.vm.provision :shell, :inline => 'powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString(\'https://chocolatey.org/install.ps1\'))"'
  end
end
