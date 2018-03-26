#Usage below.
#Before running, change the permission on the files.
#Execute chmod 755 bootstrap_elasticsearch-1.sh
#Run the script by typing sh -x bootstrap_elasticsearch-1.sh
#Reboot the host after installation is done.
#!/bin/bash
#Stop executing if error occurs
set -e
#Verbose output
set -v

#Changing the hostname
sudo hostname esa1
cp -p /etc/hostname /etc/hostname_orignal
>/etc/hostname
echo "esa1" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>/etc/hosts
echo "127.0.1.1     esa1">>/etc/hosts
echo "172.31.40.135     riemanna">>/etc/hosts
echo "172.31.36.247     riemannmc">>/etc/hosts
echo "172.31.42.123     logstasha">>/etc/hosts
echo "172.31.39.166     graphitea">>/etc/hosts
echo "172.31.9.100      hosta">>/etc/hosts

#Installing Elasticsearch
sudo apt-get -y install default-jre
wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo sh -c "echo deb http://packages.elastic.co/elasticsearch/2.x/debian stable main > /etc/apt/sources.list.d/elasticsearch.list"
sudo apt-get update
sudo apt-get -y install elasticsearch
sudo /usr/share/elasticsearch/bin/plugin install mobz/elasticsearch-head

#Configuring and enabling cluster for elasticsearch
#Change network.host value in elasticsearch.yml file, it should be the private IP of the host.
cd /etc/elasticsearch/
sudo mv elasticsearch.yml elasticsearch.yml_old
sudo wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Elastic-Search-Kibana-config/elasticsearch-esa1.yml
sudo mv elasticsearch-esa1.yml* elasticsearch.yml

echo "All Done!"
