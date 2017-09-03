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
sudo hostname logstasha
cp -p /etc/hostname /etc/hostname_orignal
>/etc/hostname
echo "logstasha" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>/etc/hosts
echo "127.0.1.1     logstasha">>/etc/hosts
echo "172.31.40.135     riemanna">>/etc/hosts
echo "172.31.36.247     riemannmc">>/etc/hosts
echo "172.31.42.123     logstasha">>/etc/hosts
echo "172.31.39.166     graphitea">>/etc/hosts
echo "172.31.9.100      hosta">>/etc/hosts

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
#Make changes to elasticsearch.url after config is done.
sudo wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Logstash-A/kibana.yml
sudo mv kibana.yml* kibana.yml
cd /opt/kibana/config/
sudo mv kibana.yml kibana.yml_orignal
sudo cp /tmp/kibana.yml .
sudo chmod 755 /opt/kibana/config/kibana.yml

#Restart Kibana
#sudo service kibana start

#Placing logstash configfile
cd /etc/logstash/conf.d/
sudo wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Logstash-A/logstash.conf
