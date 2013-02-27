#!/bin/bash

#Commence the update process
sudo apt-get update

#Ask whether or not to remove all packages
function remove_packages {
	dpkg --clear-selections
	apt-get dselect-upgrade
	#List of essential packages that need to be reinstalled (according to Ubuntu)
	apt-get install apt ubuntu-keyring libapt-pkg4.12 libstdc++6 gnupg base-files bash
	#List of other useful packages to reinstall
	apt-get install openssh-server
}
function upgrade_packages {
	sudo apt-get -y  upgrade
}
echo -n "Remove all packages? (Y or N): "
	read -e answer
	if [ "$answer" == "Y" ]; then
		remove_packages
	fi
	if [ "$answer" != "Y" ]; then
		upgrade_packages
	fi

#Banner Used for SSH Login 
sudo touch /etc/banner

cat <<EOF >/etc/banner

*****************************************
**      AUTHORIZED USERS ONLY          **
*****************************************
EOF

#Disallow Root Login and Change Default SSH Port
sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' sshd_config
sudo sed -i 's/Port 22/Port 22984/' sshd_config
sudo service ssh restart
