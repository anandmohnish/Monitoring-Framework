#Usage below.
#Before running, change the permission on the files.
#Execute chmod 755 bootstrap_collectd_docker.sh
#Run the script by typing sh -x bootstrap_collectd_docker.sh
#Reboot the host after installation is done.
#!/bin/bash
#Changing the hostname
sudo hostname dockera
cp -p /etc/hostname /etc/hostname_orignal
>/etc/hostname
echo "hosta" >/etc/hostname
cp -p /etc/hosts /etc/hosts_orignal
>/etc/hosts
echo "127.0.1.1     dockera">>/etc/hosts
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

#Installing unzip package
sudo apt-get install unzip

#Install pip
sudo apt-get install python-pip -y

#Installing Docker
sudo apt-get install docker-ce -y

#Test collectd
#collectd -h

#create a directory
sudo mkdir /etc/collectd.d

##Configuring the plugins for collectd
#wget the various plugins from Github
cd /tmp
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/collectd.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/cpu.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/df.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/memory.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/processes.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/swap.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/load.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/protocols.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/interface.conf
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Collectd/collectd-config-files/write_riemann.conf


#copy theplugin conf files to the specified direcotries
#sudo rm /tmp/collectd.conf
sudo mv /etc/collectd/collectd.conf /etc/collectd/collectd.conf_orignal
sudo cp /tmp/collectd.conf /etc/collectd/
sudo rm /tmp/collectd.conf
sudo cp /tmp/*.conf /etc/collectd.d/

#Enabling and running collectd
sudo update-rc.d collectd defaults
sudo service collectd start


##Check log files
#/var/log/collectd.log
#Also check riemann log files now
#/var/log/riemann/riemann.log


#Downloading Docker collectd plugin - 7.3
cd /usr/lib/collectd/
sudo wget https://github.com/jamtur01/docker-collectd-plugin/archive/master.zip

#Unzip - 7.4
sudo unzip master.zip

#Rename the Docker collectd plugin directory - 7.5
sudo mv docker-collectd-plugin-master docker
sudo rm master.zip

#Installing some additional python libraries - 7.6
cd /usr/lib/collectd/docker
sudo pip install -r requirements.txt

#Configuration - the docker plugin for collectd - 7.7
cd /etc/collectd.d/
wget https://raw.githubusercontent.com/anandmohnish/Monitoring-Framework/master/Configuration%20Files/Docker/docker.conf
#sudo touch /etc/collectd.d/docker.conf

#Adding a label at runtime - 7.24
# sudo docker run --name daemon_dave --label com.example. application="tornado" -d run

#creating a Redis container with label
#sudo docker run --name redis --label com.example.application="tornado" -d redis

#Inspecting the redis container
#sudo docker inspect -f "{{json .Config.Labels }}" redis{"com.example.application":"tornado"}

#wget collectd.clj for riemann
