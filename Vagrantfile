# -*- mode: ruby -*-
# vi: set ft=ruby :

masterIP = "192.168.1.20"
masterFQDN = "testMaster"
agentIP = "192.168.1.21"
agentFQDN = "testAgent"

Vagrant.configure("2") do |config|

    config.vm.box = "chad-thompson/ubuntu-trusty64-gui"
    config.vm.synced_folder "shared", "/tmp/shared"
	
	config.vm.define "master" do |master|
		master.vm.network :public_network, ip: masterIP
		master.vm.hostname = masterFQDN
		master.vm.provision :shell, path: "master_bootstrap.sh" 
		master.vm.synced_folder "shared_master", "/tmp/shared"
		
		master.vm.provider :virtualbox do |masterVM|
			masterVM.gui = true
			masterVM.name = "master"
			masterVM.memory = 4096
			masterVM.cpus = 2
		end
	end    
    
	config.vm.define "agent" do |agent|
		agent.vm.network :public_network, ip: agentIP
		agent.vm.hostname = agentFQDN
		agent.vm.provision :shell, path: "agent_bootstrap.sh", env: {"masterFQDN" => masterFQDN, "masterIP" => masterIP}
		agent.vm.synced_folder "shared_agent", "/tmp/shared"
		
		agent.vm.provider :virtualbox do |agentVM| 
			agentVM.gui = true
			agentVM.name = "agent"
			agentVM.memory = 4096
			agentVM.cpus = 2
		end
	end  
end
