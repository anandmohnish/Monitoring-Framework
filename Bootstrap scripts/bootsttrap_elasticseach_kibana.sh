#Changing the hostname
sudo hostname logstasha 
cp -p /etc/hostname /etc/hostname_orignal
>>/etc/hostname
echo "logstasha" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>>/etc/hosts
echo "127.0.1.1     logstasha" >/etc/hosts


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
#Make changes to network.host after config is done.
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
