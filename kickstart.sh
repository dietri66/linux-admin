#!/bin/bash

#Commence the update process
sudo apt-get update

sudo apt-get -y  upgrade


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
