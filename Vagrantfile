# -*- mode: ruby -*-
# vi: set ft=ruby :

# http://stackoverflow.com/questions/23926945/specify-headless-or-gui-from-command-line
def gui_enabled?
  !ENV.fetch('GUI', '').empty?
end

Vagrant.configure(2) do |config|
  config.vm.define "ckad" do |machine|
    machine.vm.box = "ubuntu/bionic64"
    machine.vm.box_url = machine.vm.box
    # ingress http on the k8s master
    machine.vm.network "forwarded_port", guest: 80, host: 8080
    # ingress https on the k8s master
    machine.vm.network "forwarded_port", guest: 443, host: 8443
    machine.vm.provider "virtualbox" do |p|
      p.memory = 6144
      p.cpus = 2
      p.gui = gui_enabled?
      # https://github.com/hashicorp/vagrant/issues/9524
      p.customize ["modifyvm", :id, "--audio", "none"]
    end
  end
  # .ssh ownership
  $direnv_hook_bash = <<SCRIPT
USER=$1
echo 'eval "$(direnv hook bash)"' >> /home/$USER/.bashrc
SCRIPT
  config.vm.define "ckad" do |machine|
    machine.vm.provision :shell, :inline => "hostname ckad", run: "always"
    machine.vm.provision :shell, :inline => "export TERM=xterm-color", run: "always"
    machine.vm.provision :shell, :inline => "hostnamectl set-hostname ckad"
    machine.vm.provision :shell, :inline => "apt-get update"
    machine.vm.provision :shell, :inline => 'dd if=/dev/zero of=/swapfile bs=1M count=1024'
    machine.vm.provision :shell, :inline => 'chmod 0600 /swapfile'
    machine.vm.provision :shell, :inline => '/sbin/mkswap /swapfile'
    machine.vm.provision :shell, :inline => '/sbin/swapon /swapfile'
    machine.vm.provision :shell, :inline => 'echo /swapfile none swap sw 0 0 >> /etc/fstab'
    machine.vm.provision :shell, :inline => 'sudo su - vagrant -c "bash /vagrant/scripts/01-install-tools.sh"'
    machine.vm.provision :shell, :inline => 'sudo su - vagrant -c "bash /vagrant/scripts/10-install-docker.sh"'
    machine.vm.provision :shell, :inline => 'sudo su - vagrant -c "bash /vagrant/scripts/11-test-docker.sh"'
    machine.vm.provision :shell, :inline => 'sudo su - vagrant -c "bash /vagrant/scripts/13-install-go.sh"'
    machine.vm.provision :shell, :inline => 'sudo su - vagrant -c "bash /vagrant/scripts/14-test-go.sh"'
    machine.vm.provision 'shell' do |s|
      s.inline = $direnv_hook_bash
      s.args   = ['vagrant']
    end
  end
end
