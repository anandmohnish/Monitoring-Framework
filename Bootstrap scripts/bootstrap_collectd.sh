#Usage below.
#Before running, change the permission on the files.
#Execute chmod 755 bootstrap_graphite_grafana_MC.sh
#Run the script by typing sh -x bootstrap_graphite_grafana_MC.sh
#Reboot the host after installation is done.
#!/bin/bash
#Changing the hostname
sudo hostname hosta
cp -p /etc/hostname /etc/hostname_orignal
>/etc/hostname
echo "hosta" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>/etc/hosts
echo "127.0.1.1     hosta">>/etc/hosts
echo "172.31.40.135     riemanna">>/etc/hosts
echo "172.31.36.247     riemannmc">>/etc/hosts
echo "172.31.42.123     logstasha">>/etc/hosts
echo "172.31.39.166     graphitea">>/etc/hosts
echo "172.31.9.100      hosta">>/etc/hosts

#Installing collectd
sudo add-apt-repository ppa:collectd/collectd-5.5 -y

#Update and Install collectd
sudo apt-get update
sudo apt-get -y install collectd

#Test collectd
#collectd -h


#create a directory
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

#Enabling and running collectd
sudo update-rc.d collectd defaults
sudo service collectd start


##Check log files
#/var/log/collectd.log
#Also check riemann log files now
#/var/log/riemann/riemann.log