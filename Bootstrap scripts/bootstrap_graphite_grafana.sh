#Changing the hostname
sudo hostname graphitea 
cp -p /etc/hostname /etc/hostname_orignal
>>/etc/hostname
echo "graphitea" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>>/etc/hosts
echo "127.0.1.1     graphitea" >/etc/hosts
echo "172.31.40.135     riemanna" >/etc/hosts
echo "172.31.36.247     riemannmc" >/etc/hosts
echo "172.31.42.123     logstasha" >/etc/hosts

#Graphite Installation on Ubuntu :

sudo apt-get update
sudo apt-get -y install graphite-carbon

#Installing Graphite API-
#This API allows that graphana can connect to graphite.
 
#add repository APT key

curl https://packagecloud.io/gpg.key | sudo apt-key add -
  
#add APT repository listing
  
sudo sh -c "echo deb https://packagecloud.io/exoscale/community/ubuntu/ trusty main > /etc/apt/sources.list.d/exoscale_community.list"

#installing apt-transport package and updating
sudo apt-get install apt-transport-https
sudo apt-get update

#install graphite api package
sudo apt-get install graphite-api

#Installing Grafana
#add repository listing
sudo sh -c "echo deb https://packagecloud.io/grafana/stable/debian/ wheezy main > /etc/apt/sources.list.d/packagecloud_grafana.list"
#add package key
curl https://packagecloud.io/gpg.key | sudo apt-key add -
#update repository and install grafana
sudo apt-get update
sudo apt-get install -y apt-transport-https grafana
##Configuration Begins - include carbon.config from here


#put below config on carbon.config
##Instead od doing this, you can also wget from your git repo
cd /etc/carbon
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-A/carbon.config


#Configuring metric retentition for Carbon
#Was nothing to be done here


#Service Management - include carbon-cache-ubuntu.init and carbon-relay-ubuntu.init from here

##On Ubuntu

#download the init script for carbon-cache
cd /tmp
wget https://raw.githubusercontent.com/jamtur01/aom-code/master/4/graphite/carbon-cache-ubuntu.init

#Copy and change permissions
sudo cp /tmp/carbon-cache-ubuntu.init /etc/init.d/carbon-cache 
sudo chmod 0755 /etc/init.d/carbon-cache

#Enable the daemon
sudo update-rc.d carbon-cache defaults

#Configure init script for carbon.relay
cd /tmp
wget https://raw.githubusercontent.com/jamtur01/aom-code/master/4/graphite/carbon-relay-ubuntu.init 
sudo cp /tmp/carbon-relay-ubuntu.init /etc/init.d/carbon-relay
sudo chmod 0755 /etc/init.d/carbon-relay
sudo update-rc.d carbon-relay defaults

#Configure carbon 
cd /etc/default/
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-A/graphite-carbon

##Start carbon relay and carbon-cache
sudo service carbon-relay start
sudo service carbon-cache start


##Check log files

#/var/log/carbon/console.log



#Configuring Graphite API - include graphite-api.yaml from here

#The config file is /etc/graphite-api.yaml

#On Ubuntu and RedHat put the below config -
#search_index: /var/lib/graphite/api_search_index
#finders: - graphite_api.finders.whisper.WhisperFinder functions: - graphite_api.functions.SeriesFunctions - graphite_api.functions.PieFunctions whisper: directories: - /var/lib/graphite/whisper carbon: hosts: - 127.0.0.1: 7012 - 127.0.0.1: 7022 timeout: 1 retry_delay: 15 carbon_prefix: carbon replication_factor: 1 time_zone: UTC

##use wget and get the file
cd /etc
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-A/graphite-api.yaml

#create some files
sudo touch /var/lib/graphite/api_search_index
sudo chown _graphite:_graphite /var/lib/graphite/api_search_index

#Service Management -

#On Ubuntu start with - runs on port 8888
sudo service graphite-api start
#Warning There is a minor bug in the init script of the 1.0.1 release of the Graphite API. On line 47 of the init script at /etc/init.d/graphite-api you may need to change the variable $PID_FILE to $PIDFILE . This is fixed in later releases.


#Testing the Graphite-API - include screenshot

Open the URL to test it
http://graphitea:8888/render?target=test

###Configuring Grafana

#Start Grafana service - both ubuntu and redhat 
#service runs on port 3000
sudo service grafana-server start

#Open Grafana from browser and setup datasource


##Config Riemann for Graphite - include riemann.config from here and graphite.clj

#Create Graphite plugin in examplecome/etc folder in Riemann-A
##Make some changes to riemann.config to include the graphite.clj
##reload riemann
#sudo service riemann reload

#check log files
#/var/log/riemann/riemann.log
#/var/log/carbon/creates.log

#check whisper files
#/var/lib/graphite/whisper/


##Time Zones

sudo dpkg-reconfigure tzdata

Select none of the above and press Enter


Select UTC and press enter

Or on ubuntu 14 and later - use
timedatectl set-timezone Etc/UTC

#Installing NTP on ubuntu
sudo apt-get -y install ntp

#Perform a sync

sudo ntpdate -s ntp.ubuntu.com

##Check status of NTP service on both ubuntu and redhat
sudo ntpq -p

