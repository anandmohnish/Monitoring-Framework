##Chapter 5

#Installing collectd on Ubuntu
sudo add-apt-repository ppa:collectd/collectd-5.5

#Update and Install collectd
sudo apt-get update
sudo apt-get -y install collectd

#Test collectd
#collectd -h


###Configuring collectd
#collectd is managed via a config file, located at 
#/etc/collectd/collectd.conf on Ubuntu. 


##Place our config file

#On Ubuntu
#cd /tmp
#wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/collectd.conf

#sudo cp /tmp/collectd.conf /etc/collectd/collectd.conf

#check and create directory - was required only on ubuntu
sudo mkdir /etc/collectd.d

##Configuring the plugins for collectd

#wget the various plugins from Github
cd /tmp
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/collectd.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/cpu.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/df.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/memory.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/processes.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/swap.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/load.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/protocols.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/config%20files/interface.conf
wget https://github.com/anandmohnish/Monitoring-Framework/blob/master/Configuration%20Files/Collectd/config%20files/write_riemann.conf


#copy theplugin conf files to the specified direcotries
#sudo rm /tmp/collectd.conf
sudo cp /tmp/*.conf /etc/collectd.d/

##Writing to Riemann
#cd /tmp
#wget https://raw.githubusercontent.com/turnbullpress/aom-code/master/5-6/collectd/collectd.d/write_riemann.conf
##Change hostname inside this file
#sudo cp /tmp/write_riemann.conf /etc/collectd.d/write_riemann.conf

#wget https://raw.githubusercontent.com/turnbullpress/aom-code/master/5-6/collectd/collectd.d/carbon.conf


#Enabling and running collectd

#On Ubuntu
sudo update-rc.d collectd defaults
sudo service collectd start

##Check log files
#/var/log/collectd.log

#Also check riemann log files now
#/var/log/riemann/riemann.log

#Sending our collectd events to Graphite
#use the tagged stream - add changes in riemann.conf

#...
#(tagged "collectd" graph)

#check carbon for incoming collectd metrics
#/var/log/carbon/creates.log


#Add some chnages to have simple metrics naming pattern

#On Riemann
#cd /etc/riemann/examplecom/etc
#sudo wget https://raw.githubusercontent.com/turnbullpress/aom-code/master/5-6/riemann/examplecom/etc/collectd.clj

#include changes in riemann.config

#remove - (tagged "collectd" graph) and  add
#(require '[examplecom.etc.collectd :refer :all])

#...

#(tagged "collectd"
#(smap rewrite-service graph))


