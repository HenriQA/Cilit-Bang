#!/bin/bash

#Install packages
sudo apt-get update
sudo apt-get -y install openssh-server openssh-client
sudo ufw disable
sudo apt-get -y install puppetmaster puppet

#Edit /etc/hosts
fqdn=$(facter fqdn)
ip=$(facter ipaddress_eth1)
sudo sed -i "1s/^/$ip $fqdn puppetmaster\n/" /etc/hosts
sudo sed -i "1s/^/127.0.0.1 $fqdn puppetmaster\n/" /etc/hosts

#Move modules to /usr/share/puppet/modules/
sudo cp -r /tmp/shared/modules/* /usr/share/puppet/modules/

#Setup secure autosigning
sudo cp /tmp/shared/autosign/autosign /usr/local/bin
sudo echo "autosign = /usr/local/bin/autosign" >> /etc/puppet/puppet.conf
sudo chmod a+x /usr/local/bin/autosign
