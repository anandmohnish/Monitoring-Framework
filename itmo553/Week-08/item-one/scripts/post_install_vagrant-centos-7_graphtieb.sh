#!/bin/bash 
set -e
set -v


# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/init-users
sudo cat /etc/sudoers.d/init-users

# Install Elrepo - The Community Enterprise Linux Repository (ELRepo) - http://elrepo.org/tiki/tiki-index.php
sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
sudo yum install -y epel-release # https://wiki.centos.org/AdditionalResources/Repositories



#Change Hostname
sudo hostnamectl set-hostname graphiteb

# Install base dependencies -  Centos 7 mininal needs the EPEL repo in the line above and the package daemonize
sudo yum update -y
sudo yum install -y wget git gcc

# Installing vagrant keys
wget --no-check-certificate 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub'
sudo mkdir -p /home/vagrant/.ssh
sudo chown -R vagrant:vagrant /home/vagrant/.ssh
cat ./vagrant.pub >> /home/vagrant/.ssh/authorized_keys

# Making changes to host file.
sudo mkdir -p /data
#chown www-data:www-data /data
sudo chmod 777 /data
cd /data
rm -fr *
wget https://raw.githubusercontent.com/illinoistech-itm/manand1/master/itmo553/Data/hosts.graphiteb?token=AX6eC8YTme_k-UuDMWi1ZYPR8yC2wR2bks5Y1uP3wA%3D%3D 
cat hosts.graphiteb* >hosts.graphiteb
sudo mv /etc/hosts /etc/hosts.backup
sudo cp /data/hosts.graphiteb /etc/hosts
sudo chown root:root /etc/hosts
sudo chmod 644 /etc/hosts
#sudo chown vagrant:vagrant ~/.ssh/authorized_keys

echo "All Done!"
