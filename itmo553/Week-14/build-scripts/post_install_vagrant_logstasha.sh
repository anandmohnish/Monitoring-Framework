#!/bin/bash 
set -e
set -v


# http://superuser.com/questions/196848/how-do-i-create-an-administrator-user-on-ubuntu
# http://unix.stackexchange.com/questions/1416/redirecting-stdout-to-a-file-you-dont-have-write-permission-on
# This line assumes the user you created in the preseed directory is vagrant
echo "vagrant ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/init-users
sudo cat /etc/sudoers.d/init-users


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
sudo wget https://raw.githubusercontent.com/illinoistech-itm/manand1/master/itmo553/Week-14/Data/host-files/hosts-logstasha?token=AX6eCxib35WfVJBb_Vxs90J6IPAGfrs5ks5ZAQ7XwA%3D%3D
cat hosts-logstasha* >hosts.logstasha
sudo mv /etc/hosts /etc/hosts.backup
sudo cp /data/hosts.logstasha /etc/hosts
sudo chown root:root /etc/hosts
sudo chmod 644 /etc/hosts
sudo chown vagrant:vagrant ~/.ssh/authorized_keys

#Installing Logstash
sudo apt-get -y install default-jre
#sudo yum install java-1.7.0-openjdk
sudo wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo echo "deb http://packages.elastic.co/logstash/2.2/debian stable main" | sudo tee -a /etc/apt/sources.list.d/logstash.list
sudo apt-get update
sudo apt-get install logstash --allow-unauthenticated
#sudo useradd -G adm logstash

#Installing Kibana on logstash
sudo sh -c "echo 'deb http://packages.elastic.co/kibana/4.4/debian stable main' > /etc/apt/sources.list.d/kibana.list"
sudo apt-get update
sudo apt-get install kibana --allow-unauthenticated
sudo update-rc.d kibana defaults 95 10

#Kibana config file - holds changes to Elasticsearch host in kibana.yml
cd /tmp
sudo wget https://raw.githubusercontent.com/illinoistech-itm/manand1/master/itmo553/Week-14/Data/kibana.yml?token=AX6eC8IzgnbW8V_Ryck6J1uG1Y12Zk1Qks5ZAUUIwA%3D%3D
sudo mv kibana.yml* kibana.yml
cd /opt/kibana/config/
sudo mv kibana.yml kibana.yml_orignal
sudo cp /tmp/kibana.yml .
sudo chmod 755 /opt/kibana/config/kibana.yml

#Restart Kibana
#sudo service kibana start

#Placing logstash configfile
cd /etc/logstash/conf.d/
sudo wget https://raw.githubusercontent.com/turnbullpress/aom-code/master/8/logstash/logstash.conf


echo "All Done!"
