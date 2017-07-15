#Changing the hostname
sudo hostname graphitemc
cp -p /etc/hostname /etc/hostname_orignal
>/etc/hostname
echo "graphitemc" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>/etc/hosts
echo "127.0.1.1     graphitemc">>/etc/hosts
echo "172.31.40.135     riemanna">>/etc/hosts
echo "172.31.36.247     riemannmc">>/etc/hosts
echo "172.31.42.123     logstasha">>/etc/hosts
echo "172.31.39.166     graphitea">>/etc/hosts

#Graphite Installation
sudo apt-get update
echo "graphite-carbon graphite-carbon/postrm_remove_databases boolean false" | sudo debconf-set-selections
sudo apt-get -y install graphite-carbon

#Installing Graphite API
#This API facilitates graphana connection to graphite.

#adding repository APT key
curl https://packagecloud.io/gpg.key | sudo apt-key add -

#add APT repository listing
sudo sh -c "echo deb https://packagecloud.io/exoscale/community/ubuntu/ trusty main > /etc/apt/sources.list.d/exoscale_community.list"

#installing apt-transport package and updating
sudo apt-get install apt-transport-https
sudo apt-get update

#Installing graphite api package
sudo apt-get -y install graphite-api

#Installing Grafana

#add repository listing
sudo sh -c "echo deb https://packagecloud.io/grafana/stable/debian/ wheezy main > /etc/apt/sources.list.d/packagecloud_grafana.list"

#add package key
curl https://packagecloud.io/gpg.key | sudo apt-key add -

#update repository and install grafana
sudo apt-get update
sudo apt-get install -y apt-transport-https grafana


#Configuration begins from here.

#Get the carbon.conf file
cd /etc/carbon
mv carbon.conf carbon.conf_orignal
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-MC/carbon.conf


#Service Management for carbon-cache and carbon-init.

#Get the init script for carbon-cache
cd /tmp
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-MC/carbon-cache-ubuntu.init

#Copy and change permissions
sudo cp /tmp/carbon-cache-ubuntu.init /etc/init.d/carbon-cache
sudo chmod 0755 /etc/init.d/carbon-cache

#Enable the daemon
sudo update-rc.d carbon-cache defaults

#Configure init script for carbon.relay
cd /tmp
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-MC/carbon-relay-ubuntu.init
sudo cp /tmp/carbon-relay-ubuntu.init /etc/init.d/carbon-relay
sudo chmod 0755 /etc/init.d/carbon-relay
sudo update-rc.d carbon-relay defaults

#Configure carbon 
cd /etc/default/
mv graphite-carbon graphite-carbon_orignal
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-MC/graphite-carbon

##Start carbon relay and carbon-cache
sudo service carbon-relay start
sudo service carbon-cache start


##Check log files
#/var/log/carbon/console.log



#Configuring Graphite API
#The config file is /etc/graphite-api.yaml

#get the graphite-api.yaml file file
cd /etc
mv graphite-api.yaml graphite-api.yaml_orignal
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Graphite-MC/graphite-api.yaml

#create some files
sudo touch /var/lib/graphite/api_search_index
sudo chown _graphite:_graphite /var/lib/graphite/api_search_index

#Service Management for graphite-api
#Start with the below command and it runs on port 8888
sudo service graphite-api start
#Warning There is a minor bug in the init script of the 1.0.1 release of the Graphite API. On line 47 of the init script at /etc/init.d/graphite-api you may need to change the variable $PID_FILE to $PIDFILE . This is fixed in later releases.


#Testing the Graphite-API - include screenshot
#Open the URL to test it
#http://graphitemc:8888/render?target=test

#Start Grafana service
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

#sudo dpkg-reconfigure tzdata

#Select none of the above and press Enter


#Select UTC and press enter

#Or on ubuntu 14 and later - use
#timedatectl set-timezone Etc/UTC

#Installing NTP on ubuntu
#sudo apt-get -y install ntp

#Perform a sync

#sudo ntpdate -s ntp.ubuntu.com

##Check status of NTP service on both ubuntu and redhat
#sudo ntpq -p

