$sudovagrant = <<SCRIPT
usermod -aG sudo vagrant
SCRIPT

$installansible = <<SCRIPT
sudo apt-get update
sudo apt-get install -y software-properties-common 
sudo apt-add-repository ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible
SCRIPT

$installdocker = <<SCRIPT
sudo apt-get update
sudo apt-get install -y docker.io
SCRIPT

$installkubes = <<SCRIPT
sudo apt-get update
sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo mv /vagrant/kuberepo /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo service kubelet restart
SCRIPT

$createcluster = <<SCRIPT
ansible-playbook -i /vagrant/kube-cluster/hosts /vagrant/kube-cluster/initial.yml
ansible-playbook -i /vagrant/kube-cluster/hosts /vagrant/kube-cluster/master.yml
ansible-playbook -i /vagrant/kube-cluster/hosts /vagrant/kube-cluster/workers.yml
SCRIPT

Vagrant.configure("2") do |config|

 config.vm.provider "virtualbox" do |v|
    v.linked_clone = true
    v.customize ["modifyvm", :id, "--memory", "1024", "--cpus", "1"]
 end

 config.vm.define "manager" do |mg|
   mg.vm.box = "ubuntu/xenial64"
   mg.vm.hostname = "manager"
   mg.vm.network :private_network, ip: "192.168.10.10"
   mg.vm.provision "shell" do |sh|
			sh.inline = <<-SHELL
				sudo apt-get update
				sudo apt-get install -y python
				sudo cp /vagrant/sshd_config /etc/ssh/sshd_config
				sudo systemctl restart ssh
			SHELL
   end
   mg.vm.provision "shell", inline: $sudovagrant
   mg.vm.provision "shell", inline: $installansible
   mg.vm.provision "shell", inline: $installdocker 
   mg.vm.provision "shell", inline: $installkubes
   mg.vm.provision "shell", inline: $createcluster
   mg.vm.provider "virtualbox" do |pmv|
      pmv.memory = 2048
      pmv.cpus = 2
   end
 end
 
 config.vm.define "worker-1" do |w1|
   w1.vm.box = "ubuntu/xenial64"
   w1.vm.hostname = "worker-1"
   w1.vm.network :private_network, ip: "192.168.10.20"
   w1.vm.provision "shell" do |sh|
			sh.inline = <<-SHELL
				sudo apt-get update
				sudo apt-get install -y python
				sudo cp /vagrant/sshd_config /etc/ssh/sshd_config
				sudo service restart ssh
			SHELL
   end
   w1.vm.provision "shell", inline: $sudovagrant 
   w1.vm.provision "shell", inline: $installdocker 
   w1.vm.provision "shell", inline: $installkubes
 end

 config.vm.define "worker-2" do |w2|
   w2.vm.box = "ubuntu/xenial64"
   w2.vm.hostname = "worker-2"
   w2.vm.network :private_network, ip: "192.168.10.30"
   w2.vm.provision "shell" do |sh|
			sh.inline = <<-SHELL
				sudo apt-get update
				sudo apt-get install -y python
				sudo cp /vagrant/sshd_config /etc/ssh/sshd_config
				sudo service restart ssh
			SHELL
   end
   w2.vm.provision "shell", inline: $sudovagrant 
   w2.vm.provision "shell", inline: $installdocker 
   w2.vm.provision "shell", inline: $installkubes
 end

 config.vm.define "worker-3" do |w3|
   w3.vm.box = "ubuntu/xenial64"
   w3.vm.hostname = "worker-3"
   w3.vm.network :private_network, ip: "192.168.10.40"
   w3.vm.provision "shell" do |sh|
			sh.inline = <<-SHELL
				sudo apt-get update
				sudo apt-get install -y python
				sudo cp /vagrant/sshd_config /etc/ssh/sshd_config
				sudo service restart ssh
			SHELL
   end
   w3.vm.provision "shell", inline: $sudovagrant 
   w3.vm.provision "shell", inline: $installdocker 
   w3.vm.provision "shell", inline: $installkubes
 end

end